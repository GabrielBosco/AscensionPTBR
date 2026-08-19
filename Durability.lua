local A = AscensionPTBR

local function Feature(key, fallback)
    if A.IsFeatureEnabled then return A.IsFeatureEnabled(key, fallback) end
    local db = AscensionPTBRDB
    local value = db and db[key]
    if value == nil then value = fallback end
    return value ~= false
end

local function Setting(key, fallback)
    if A.GetSetting then return A.GetSetting(key, fallback) end
    local db = AscensionPTBRDB
    local value = db and db[key]
    if value == nil then value = fallback end
    return value
end

local function DB()
    AscensionPTBRDB = AscensionPTBRDB or {}
    return AscensionPTBRDB
end

local SLOT_NAMES = {
    [1] = "Cabeça", [2] = "Pescoço", [3] = "Ombros", [4] = "Camisa",
    [5] = "Peito", [6] = "Cintura", [7] = "Pernas", [8] = "Pés",
    [9] = "Pulsos", [10] = "Mãos", [11] = "Anel 1", [12] = "Anel 2",
    [13] = "Berloque 1", [14] = "Berloque 2", [15] = "Costas",
    [16] = "Mão principal", [17] = "Mão secundária", [18] = "À distância",
    [19] = "Tabardo",
}

local DEFAULT_POINT = "BOTTOMRIGHT"
local DEFAULT_RELATIVE_POINT = "BOTTOMRIGHT"
local DEFAULT_X = -250
local DEFAULT_Y = 185

local hud
local lastSnapshot
local lastRows = {}
local elapsedSinceCheck = 0
local durabilityWarningArmed = true

local function Clamp(value, minimum, maximum)
    value = tonumber(value) or minimum
    if value < minimum then return minimum end
    if value > maximum then return maximum end
    return value
end

local function PercentColor(percent)
    percent = tonumber(percent) or 100
    if percent <= 20 then return 1.00, 0.20, 0.16 end
    if percent <= 40 then return 1.00, 0.48, 0.14 end
    if percent <= 65 then return 1.00, 0.82, 0.20 end
    return 0.30, 1.00, 0.55
end

local function ReadDurability()
    local totalCurrent, totalMaximum = 0, 0
    local worstName, worstPercent
    local broken = 0
    local rows = {}

    if type(GetInventoryItemDurability) ~= "function" then
        return 100, nil, nil, 0, rows
    end

    for slot = 1, 19 do
        local ok, current, maximum = pcall(GetInventoryItemDurability, slot)
        current, maximum = tonumber(current), tonumber(maximum)
        if ok and current and maximum and maximum > 0 then
            local percent = math.floor((current / maximum) * 100 + 0.5)
            totalCurrent = totalCurrent + current
            totalMaximum = totalMaximum + maximum
            rows[#rows + 1] = {
                slot = slot,
                name = SLOT_NAMES[slot] or ("Espaço " .. slot),
                current = current,
                maximum = maximum,
                percent = percent,
            }
            if percent <= 0 then broken = broken + 1 end
            if not worstPercent or percent < worstPercent then
                worstPercent = percent
                worstName = SLOT_NAMES[slot] or ("Espaço " .. slot)
            end
        end
    end

    table.sort(rows, function(a, b)
        if a.percent == b.percent then return a.slot < b.slot end
        return a.percent < b.percent
    end)

    local totalPercent = totalMaximum > 0 and math.floor((totalCurrent / totalMaximum) * 100 + 0.5) or 100
    return totalPercent, worstName, worstPercent, broken, rows
end

local function WarnLowDurability(totalPercent, worstName, worstPercent)
    if not Feature("durabilityWarningEnabled", true) then
        durabilityWarningArmed = true
        return
    end

    local percent = tonumber(worstPercent) or tonumber(totalPercent) or 100
    local threshold = Clamp(Setting("durabilityWarningThreshold", 50), 10, 90)
    local resetAt = math.min(100, threshold + 5)

    -- Uma pequena histerese evita spam quando a durabilidade fica oscilando
    -- exatamente no limite configurado pelo jogador.
    if percent >= resetAt then
        durabilityWarningArmed = true
        return
    end

    if percent > threshold or not durabilityWarningArmed then return end
    durabilityWarningArmed = false

    local detail
    if worstName and worstPercent then
        detail = tostring(worstName) .. " chegou a " .. tostring(worstPercent) .. "%"
    else
        detail = "seus equipamentos chegaram a " .. tostring(percent) .. "%"
    end
    local message = "Durabilidade baixa! " .. detail .. ". Repare seus equipamentos."

    -- Aviso central, barato e sem frame novo. Cai para UIErrorsFrame em clientes
    -- que não expõem RaidWarningFrame/RaidNotice_AddMessage.
    local shown = false
    if RaidWarningFrame and type(RaidNotice_AddMessage) == "function" then
        local color = ChatTypeInfo and ChatTypeInfo.RAID_WARNING or { r = 1, g = 0.25, b = 0.10 }
        shown = pcall(RaidNotice_AddMessage, RaidWarningFrame, message, color) and true or false
    end
    if not shown and UIErrorsFrame and type(UIErrorsFrame.AddMessage) == "function" then
        pcall(UIErrorsFrame.AddMessage, UIErrorsFrame, message, 1, 0.25, 0.10, 1)
    end

    if Feature("durabilityWarningChat", true) and DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r: |cffff7a33" .. message .. "|r")
    end
    if Feature("durabilityWarningSound", true) and type(PlaySound) == "function" then
        pcall(PlaySound, "RaidWarning")
    end
end

local function SavePosition(frame)
    if not frame or not frame.GetPoint then return end
    local point, _, relativePoint, x, y = frame:GetPoint(1)
    local db = DB()
    db.durabilityHudPosition = {
        point = point or DEFAULT_POINT,
        relativePoint = relativePoint or point or DEFAULT_RELATIVE_POINT,
        x = math.floor((tonumber(x) or DEFAULT_X) + 0.5),
        y = math.floor((tonumber(y) or DEFAULT_Y) + 0.5),
    }
end

local function ApplyPosition(frame)
    if not frame then return end
    local pos = DB().durabilityHudPosition
    local point = type(pos) == "table" and pos.point or DEFAULT_POINT
    local relativePoint = type(pos) == "table" and pos.relativePoint or DEFAULT_RELATIVE_POINT
    local x = type(pos) == "table" and tonumber(pos.x) or DEFAULT_X
    local y = type(pos) == "table" and tonumber(pos.y) or DEFAULT_Y
    frame:ClearAllPoints()
    frame:SetPoint(point, UIParent, relativePoint, x or DEFAULT_X, y or DEFAULT_Y)
end

local function ApplyAppearance(frame)
    if not frame then return end
    local scale = Clamp(Setting("durabilityHudScale", 100), 75, 150) / 100
    local opacity = Clamp(Setting("durabilityHudOpacity", 92), 20, 100) / 100
    frame:SetScale(scale)
    frame:SetAlpha(opacity)
    frame.__aptbrLocked = Feature("durabilityHudLocked", true)
end

local function FillTooltip(self)
    if not GameTooltip then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Durabilidade dos equipamentos", 0.30, 1.00, 0.55)

    if #lastRows == 0 then
        GameTooltip:AddLine("Nenhum item equipado usa durabilidade.", 0.82, 0.82, 0.82, true)
    else
        for i = 1, #lastRows do
            local row = lastRows[i]
            local r, g, b = PercentColor(row.percent)
            GameTooltip:AddDoubleLine(row.name, row.percent .. "%", 0.92, 0.92, 0.92, r, g, b)
        end
    end

    GameTooltip:AddLine(" ")
    if self.__aptbrLocked then
        GameTooltip:AddLine("Botão direito: destravar a HUD", 0.65, 0.72, 0.68, true)
    else
        GameTooltip:AddLine("Arraste com o botão esquerdo para mover", 0.65, 0.72, 0.68, true)
        GameTooltip:AddLine("Botão direito: travar a HUD", 0.65, 0.72, 0.68, true)
    end
    if Feature("durabilityWarningEnabled", true) then
        local threshold = Clamp(Setting("durabilityWarningThreshold", 50), 10, 90)
        GameTooltip:AddLine("Aviso na tela em " .. tostring(threshold) .. "% de durabilidade.", 0.76, 0.68, 0.40, true)
    else
        GameTooltip:AddLine("Aviso de durabilidade desativado.", 0.62, 0.66, 0.64, true)
    end
    local interval = Clamp(Setting("durabilityUpdateInterval", 1), 1, 5)
    GameTooltip:AddLine("Atualização a cada " .. tostring(interval) .. (interval == 1 and " segundo." or " segundos."), 0.55, 0.62, 0.58, true)
    GameTooltip:Show()
end

local function SetBackdrop(frame)
    if not frame.SetBackdrop then return end
    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 10,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    frame:SetBackdropColor(0.025, 0.035, 0.030, 0.88)
    frame:SetBackdropBorderColor(0.18, 0.45, 0.31, 0.82)
end

local Refresh

local function EnsureHud()
    if hud then return hud end
    if not (CreateFrame and UIParent) then return nil end

    hud = CreateFrame("Frame", "AscensionPTBRDurabilityHUD", UIParent)
    hud:SetWidth(196)
    hud:SetHeight(48)
    hud:SetFrameStrata("MEDIUM")
    hud:SetClampedToScreen(true)
    hud:SetMovable(true)
    hud:EnableMouse(true)
    hud:RegisterForDrag("LeftButton")
    SetBackdrop(hud)
    ApplyPosition(hud)
    ApplyAppearance(hud)

    local accent = hud:CreateTexture(nil, "ARTWORK")
    accent:SetPoint("TOPLEFT", hud, "TOPLEFT", 5, -5)
    accent:SetPoint("BOTTOMLEFT", hud, "BOTTOMLEFT", 5, 5)
    accent:SetWidth(3)
    accent:SetTexture(0.30, 1.00, 0.55, 0.95)
    hud.accent = accent

    local title = hud:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    title:SetPoint("TOPLEFT", hud, "TOPLEFT", 14, -8)
    title:SetText("Durabilidade")
    title:SetTextColor(0.72, 0.78, 0.74)
    hud.title = title

    local value = hud:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    value:SetPoint("TOPRIGHT", hud, "TOPRIGHT", -10, -6)
    value:SetJustifyH("RIGHT")
    hud.value = value

    local detail = hud:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    detail:SetPoint("BOTTOMLEFT", hud, "BOTTOMLEFT", 14, 8)
    detail:SetPoint("BOTTOMRIGHT", hud, "BOTTOMRIGHT", -10, 8)
    detail:SetJustifyH("LEFT")
    detail:SetWordWrap(false)
    hud.detail = detail

    hud:SetScript("OnEnter", FillTooltip)
    hud:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)
    hud:SetScript("OnDragStart", function(self)
        if self.__aptbrLocked then return end
        self:StartMoving()
    end)
    hud:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        SavePosition(self)
    end)
    hud:SetScript("OnMouseUp", function(self, button)
        if button ~= "RightButton" then return end
        local locked = not Feature("durabilityHudLocked", true)
        if A.SetSetting then A.SetSetting("durabilityHudLocked", locked) else DB().durabilityHudLocked = locked end
        ApplyAppearance(self)
        if GameTooltip and GameTooltip.IsOwned and GameTooltip:IsOwned(self) then FillTooltip(self) end
        if DEFAULT_CHAT_FRAME then
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r: HUD de durabilidade " .. (locked and "travada." or "destravada; arraste para mover."))
        end
    end)

    -- Alguns forks do cliente não disparam UPDATE_INVENTORY_DURABILITY em toda perda.
    -- Este fallback roda só uma vez por segundo e só enquanto a HUD está visível.
    hud:SetScript("OnUpdate", function(self, elapsed)
        elapsedSinceCheck = elapsedSinceCheck + (tonumber(elapsed) or 0)
        local interval = Clamp(Setting("durabilityUpdateInterval", 1), 1, 5)
        if elapsedSinceCheck < interval then return end
        elapsedSinceCheck = 0
        if self:IsShown() and Refresh then Refresh(false) end
    end)

    hud:Hide()
    return hud
end

Refresh = function(force)
    local frame = EnsureHud()
    if not frame then return end

    if not Feature("durabilityWidget", true) then
        frame:Hide()
        return
    end

    ApplyAppearance(frame)

    local totalPercent, worstName, worstPercent, broken, rows = ReadDurability()
    lastRows = rows
    WarnLowDurability(totalPercent, worstName, worstPercent)

    if Feature("durabilityHudHideAtFull", false) and totalPercent >= 100 and broken == 0 then
        lastSnapshot = nil
        frame:Hide()
        return
    end

    local snapshot = tostring(totalPercent) .. "|" .. tostring(worstName or "") .. "|" .. tostring(worstPercent or "") .. "|" .. tostring(broken)
    if not force and snapshot == lastSnapshot and frame:IsShown() then return end
    lastSnapshot = snapshot

    local colorPercent = worstPercent or totalPercent
    local r, g, b = PercentColor(colorPercent)
    frame.value:SetText(totalPercent .. "%")
    frame.value:SetTextColor(r, g, b)
    frame.accent:SetTexture(r, g, b, 0.95)

    if #rows == 0 then
        frame.detail:SetText("Sem itens com durabilidade")
        frame.detail:SetTextColor(0.65, 0.68, 0.66)
    elseif broken > 0 then
        frame.detail:SetText(broken == 1 and "1 item quebrado" or (broken .. " itens quebrados"))
        frame.detail:SetTextColor(1.00, 0.25, 0.20)
    elseif Feature("durabilityHudShowWorst", true) and worstName and worstPercent and worstPercent < 100 then
        local wr, wg, wb = PercentColor(worstPercent)
        frame.detail:SetText("Mais gasto: " .. worstName .. "  " .. worstPercent .. "%")
        frame.detail:SetTextColor(wr, wg, wb)
    else
        frame.detail:SetText("Equipamento em bom estado")
        frame.detail:SetTextColor(0.70, 0.78, 0.73)
    end

    frame:Show()
end

A.RefreshDurabilityWidget = function()
    lastSnapshot = nil
    Refresh(true)
end

A.ResetDurabilityHudPosition = function()
    local db = DB()
    db.durabilityHudPosition = nil
    local frame = EnsureHud()
    if frame then ApplyPosition(frame) end
    Refresh(true)
end

A.GetDurabilitySummary = ReadDurability

local events = CreateFrame("Frame")
for _, eventName in ipairs({
    "PLAYER_ENTERING_WORLD", "PLAYER_ALIVE", "PLAYER_EQUIPMENT_CHANGED",
    "UPDATE_INVENTORY_DURABILITY", "UNIT_INVENTORY_CHANGED",
}) do
    pcall(events.RegisterEvent, events, eventName)
end

events:SetScript("OnEvent", function(_, event, unit)
    if event == "UNIT_INVENTORY_CHANGED" and unit and unit ~= "player" then return end
    Refresh(true)
end)

SLASH_APTBRDURABILITY1 = "/aptbrdur"
SLASH_APTBRDURABILITY2 = "/aptbrdurability"
SlashCmdList.APTBRDURABILITY = function(msg)
    msg = tostring(msg or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
    if msg == "reset" or msg == "redefinir" then
        A.ResetDurabilityHudPosition()
        if DEFAULT_CHAT_FRAME then DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r: posição da HUD de durabilidade redefinida.") end
        return
    end
    if msg == "unlock" or msg == "destravar" then
        if A.SetSetting then A.SetSetting("durabilityHudLocked", false) else DB().durabilityHudLocked = false end
        A.RefreshDurabilityWidget()
        return
    end
    if msg == "lock" or msg == "travar" then
        if A.SetSetting then A.SetSetting("durabilityHudLocked", true) else DB().durabilityHudLocked = true end
        A.RefreshDurabilityWidget()
        return
    end
    Refresh(true)
end

Refresh(true)
