AscensionPTBR = AscensionPTBR or {}

-- Quadro de Chamados/diárias. Aqui o foco é custo baixo: um passeio curto ao abrir,
-- um repasse atrasado e hooks somente nos textos que realmente precisaram tradução.
local A = AscensionPTBR
local Runtime = A.Runtime

local roots = {}
local rootSet = setmetatable({}, { __mode = "k" })
local hookedRoots = setmetatable({}, { __mode = "k" })
local walkQueued = setmetatable({}, { __mode = "k" })
local textHooked = setmetatable({}, { __mode = "k" })
local textBusy = setmetatable({}, { __mode = "k" })
local lastSeen = setmetatable({}, { __mode = "k" })
local stableOverlays = setmetatable({}, { __mode = "k" })
local stableHooked = setmetatable({}, { __mode = "k" })
local stableActive = setmetatable({}, { __mode = "k" })

local STABLE_LABELS = {
    ["Rewards"] = "Recompensas",
    ["Reward"] = "Recompensa",
    ["Recompensas"] = "Recompensas",
    ["Recompensa"] = "Recompensa",
}

local function Enabled()
    local quests = A.IsFeatureEnabled and A.IsFeatureEnabled("quests", true)
        or not (AscensionPTBRDB and AscensionPTBRDB.quests == false)
    local daily = A.IsFeatureEnabled and A.IsFeatureEnabled("dailyQuests", true)
        or not (AscensionPTBRDB and AscensionPTBRDB.dailyQuests == false)
    return quests and daily
end

local function IsShown(obj)
    if not obj then return false end
    if obj.IsShown then
        local ok, shown = pcall(obj.IsShown, obj)
        if ok then return shown and true or false end
    end
    if obj.IsVisible then
        local ok, shown = pcall(obj.IsVisible, obj)
        if ok then return shown and true or false end
    end
    return true
end

local function TranslateEmbedded(text)
    if type(text) ~= "string" or text == "" then return nil end
    local out = text
    local changed = false
    local replacements = {
        { "[KEYWORD:Call Board]", "[KEYWORD:Quadro de Chamados]" },
        { "[KEYWORD:Daily Quests]", "[KEYWORD:Missões Diárias]" },
        { "[KEYWORD:Weekly Quests]", "[KEYWORD:Missões Semanais]" },
        { "Call Board Quests", "Missões do Quadro de Chamados" },
        { "Callboard Quests", "Missões do Quadro de Chamados" },
        { "Daily Quests", "Missões Diárias" },
        { "Daily Quest", "Missão Diária" },
        { "Weekly Quests", "Missões Semanais" },
        { "Weekly Quest", "Missão Semanal" },
        { "Call Board", "Quadro de Chamados" },
        { "Callboard", "Quadro de Chamados" },
    }
    for i = 1, #replacements do
        local before = out
        local pattern = replacements[i][1]:gsub("(%W)", "%%%1")
        out = out:gsub(pattern, replacements[i][2])
        if out ~= before then changed = true end
    end
    return changed and out or nil
end

local function TranslateText(text)
    if type(text) ~= "string" or text == "" then return nil end

    local pt = A.TranslateDailyQuestText and A.TranslateDailyQuestText(text)
    if pt and pt ~= text then return pt end

    pt = A.ServerUI and A.ServerUI[text]
    if pt and pt ~= text then return pt end

    pt = A.TranslateQuestUIText and A.TranslateQuestUIText(text)
    if pt and pt ~= text then return pt end

    pt = A.TranslateStaticText and A.TranslateStaticText(text)
    if pt and pt ~= text then return pt end

    return TranslateEmbedded(text)
end
A.TranslateDailyQuestFrameText = TranslateText

local function CopyFontOnce(source, target)
    if not (source and target) then return end
    if source.GetFontObject and target.SetFontObject then
        local ok, fontObject = pcall(source.GetFontObject, source)
        if ok and fontObject then pcall(target.SetFontObject, target, fontObject) end
    end
    if source.GetFont and target.SetFont then
        local ok, font, size, flags = pcall(source.GetFont, source)
        if ok and font then pcall(target.SetFont, target, font, size, flags) end
    end
    if source.GetJustifyH and target.SetJustifyH then
        local ok, value = pcall(source.GetJustifyH, source)
        if ok and value then pcall(target.SetJustifyH, target, value) end
    end
    if source.GetJustifyV and target.SetJustifyV then
        local ok, value = pcall(source.GetJustifyV, source)
        if ok and value then pcall(target.SetJustifyV, target, value) end
    end
    if source.GetTextColor and target.SetTextColor then
        local ok, r, g, b, a = pcall(source.GetTextColor, source)
        if ok and type(r) == "number" then pcall(target.SetTextColor, target, r, g, b, a or 1) end
    end
end

local function StableOverlay(obj, pt)
    if not (obj and obj.IsObjectType and obj:IsObjectType("FontString")) then return false end

    local overlay = stableOverlays[obj]
    if not overlay then
        local parent = obj.GetParent and obj:GetParent()
        if not (parent and parent.CreateFontString) then return false end
        local ok, created = pcall(parent.CreateFontString, parent, nil, "OVERLAY")
        if not ok or not created then return false end
        overlay = created
        stableOverlays[obj] = overlay
        CopyFontOnce(obj, overlay)
        if overlay.SetAllPoints then pcall(overlay.SetAllPoints, overlay, obj) end
        if overlay.SetWordWrap and obj.GetWordWrap then
            local okw, wrap = pcall(obj.GetWordWrap, obj)
            if okw then pcall(overlay.SetWordWrap, overlay, wrap) end
        end
    end

    if stableActive[obj] == pt then return true end
    stableActive[obj] = pt
    pcall(overlay.SetText, overlay, pt)
    if obj.SetAlpha then pcall(obj.SetAlpha, obj, 0) end
    if overlay.Show then pcall(overlay.Show, overlay) end
    return true
end

local function ClearStableOverlay(obj)
    if not stableActive[obj] then return end
    stableActive[obj] = nil
    local overlay = stableOverlays[obj]
    if overlay and overlay.Hide then pcall(overlay.Hide, overlay) end
    if obj and obj.SetAlpha then pcall(obj.SetAlpha, obj, 1) end
end

local function UpdateStableLabel(obj)
    if not Enabled() or not (obj and obj.GetText) then return false end
    local ok, text = pcall(obj.GetText, obj)
    if not ok or type(text) ~= "string" then return false end
    local pt = STABLE_LABELS[text]
    if pt then return StableOverlay(obj, pt) end
    ClearStableOverlay(obj)
    return false
end

local function HookStableLabel(obj)
    if stableHooked[obj] or not (obj and obj.GetText and hooksecurefunc) then return end
    stableHooked[obj] = true
    for _, method in ipairs({ "SetText", "SetFormattedText" }) do
        if obj[method] then
            pcall(hooksecurefunc, obj, method, function(self)
                if textBusy[self] then return end
                UpdateStableLabel(self)
            end)
        end
    end
end

local function HookTranslatedObject(obj)
    if textHooked[obj] or not (obj and obj.GetText and hooksecurefunc) then return end
    textHooked[obj] = true

    for _, method in ipairs({ "SetText", "SetFormattedText" }) do
        if obj[method] then
            pcall(hooksecurefunc, obj, method, function(self)
                if textBusy[self] or not Enabled() then return end
                local ok, text = pcall(self.GetText, self)
                if not ok or type(text) ~= "string" or text == "" then return end

                if STABLE_LABELS[text] then
                    HookStableLabel(self)
                    UpdateStableLabel(self)
                    lastSeen[self] = text
                    return
                end

                if lastSeen[self] == text then return end
                lastSeen[self] = text
                local pt = TranslateText(text)
                if pt and pt ~= text then
                    textBusy[self] = true
                    lastSeen[self] = pt
                    pcall(self.SetText, self, pt)
                    textBusy[self] = nil
                end
            end)
        end
    end
end

local function ApplyText(obj)
    if not Enabled() or not (obj and obj.GetText and obj.SetText) then return false end
    local ok, text = pcall(obj.GetText, obj)
    if not ok or type(text) ~= "string" or text == "" then return false end

    if STABLE_LABELS[text] then
        HookStableLabel(obj)
        UpdateStableLabel(obj)
        return true
    end

    if lastSeen[obj] == text then return false end
    lastSeen[obj] = text

    local pt = TranslateText(text)
    if not pt or pt == text then return false end

    HookTranslatedObject(obj)
    textBusy[obj] = true
    lastSeen[obj] = pt
    pcall(obj.SetText, obj, pt)
    textBusy[obj] = nil
    return true
end

local function Walk(root, depth, visited)
    if not root or depth > 10 then return end
    visited = visited or {}
    if visited[root] then return end
    visited[root] = true

    ApplyText(root)

    if root.GetRegions then
        local ok, regions = pcall(function() return { root:GetRegions() } end)
        if ok and regions then
            for i = 1, #regions do
                ApplyText(regions[i])
            end
        end
    end

    if root.GetChildren then
        local ok, children = pcall(function() return { root:GetChildren() } end)
        if ok and children then
            for i = 1, #children do
                Walk(children[i], depth + 1, visited)
            end
        end
    end
end

local function AddRoot(frame)
    if not frame or rootSet[frame] then return false end
    if not (frame.GetRegions or frame.GetChildren or frame.HookScript) then return false end
    rootSet[frame] = true
    roots[#roots + 1] = frame
    return true
end

local explicitRootNames = {
    "CallBoardFrame", "CallboardFrame", "CallBoard", "Callboard",
    "CallBoardWindow", "CallboardWindow", "CallBoardUI", "CallboardUI",
    "HeroesCallboard", "HeroesCallboardFrame", "HeroCallBoardFrame", "HeroCallboardFrame",
    "DailyQuestFrame", "DailyQuestsFrame", "DailyQuestMenu", "DailyQuestsMenu",
    "WeeklyQuestFrame", "WeeklyQuestsFrame", "QuestBoardFrame", "QuestBoard",
    "AscensionCallBoard", "AscensionCallBoardFrame", "AscensionCallboardFrame",
    "AscensionDailyQuestFrame", "AscensionDailyQuestsFrame", "AscensionDailyFrame",
    "PathToAscensionFrame", "PathToAscensionQuestFrame", "PathOfAscensionFrame",
}

local function QueueWalk(root)
    if not root or not IsShown(root) then return end

    Walk(root, 0, {})
    if walkQueued[root] or not (Runtime and Runtime.After) then return end
    walkQueued[root] = true
    Runtime.After("aptbr-daily-late:" .. tostring(root), 0.10, function()
        walkQueued[root] = nil
        if Enabled() and IsShown(root) then Walk(root, 0, {}) end
    end)
end

local function HookRoot(root)
    if not root or hookedRoots[root] then return end
    hookedRoots[root] = true
    if root.HookScript then
        pcall(root.HookScript, root, "OnShow", function(self)
            QueueWalk(self)
        end)
    end
end

local function DiscoverRoots()
    local added = 0
    for i = 1, #explicitRootNames do
        if AddRoot(_G[explicitRootNames[i]]) then added = added + 1 end
    end

    for i = 1, #roots do HookRoot(roots[i]) end
    return added
end

local function Refresh(reason)
    if not Enabled() then return false end
    DiscoverRoots()

    local found = false
    for i = 1, #roots do
        local root = roots[i]
        if IsShown(root) then
            QueueWalk(root)
            found = true
        end
    end
    return found or #roots > 0
end
A.RefreshDailyQuests = Refresh

if Runtime and Runtime.RegisterModule then
    Runtime.RegisterModule("daily-quests", Refresh)
end

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:SetScript("OnEvent", function(_, event, arg1)
    if not Enabled() then return end

    if event == "ADDON_LOADED" then
        local name = type(arg1) == "string" and arg1:lower() or ""
        if name:find("ascension", 1, true) or name:find("call", 1, true)
            or name:find("quest", 1, true) then
            if Runtime and Runtime.After then
                Runtime.After("aptbr-daily-addon", 0.15, function()
                    DiscoverRoots(false)
                    Refresh("daily-addon")
                end)
            else
                DiscoverRoots(false)
                Refresh("daily-addon")
            end
        end
        return
    end

    if Runtime and Runtime.After then
        Runtime.After("aptbr-daily-enter", 0.40, function()
            DiscoverRoots(false)
            Refresh("daily-enter")
        end)
    else
        DiscoverRoots(false)
        Refresh("daily-enter")
    end
end)

SLASH_APTBRDAILY1 = "/aptbrdaily"
SlashCmdList["APTBRDAILY"] = function()
    DiscoverRoots()
    Refresh("slash")
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r: Quadro de Chamados sincronizado. Frames encontrados: "
            .. tostring(#roots) .. "; buscas globais: 0.")
    end
end
