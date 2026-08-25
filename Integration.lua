-- Integrações que precisam conversar com outras telas/addons sem mexer em clique protegido.

local A = AscensionPTBR or {}
AscensionPTBR = A
A.IntegrationV1 = true

local function DB()
    return AscensionPTBRDB
end

local function Feature(key, fallback)
    if A.IsFeatureEnabled then return A.IsFeatureEnabled(key, fallback) end
    local db = DB()
    local value = db and db[key]
    if value == nil then value = fallback end
    return value ~= false
end

local function RuntimeAfter(key, delay, fn)
    if A.Runtime and A.Runtime.After then
        A.Runtime.After(key, delay, fn)
    elseif C_Timer and C_Timer.After then
        C_Timer.After(delay, fn)
    else
        pcall(fn)
    end
end

local function Visible(frame)
    if not (frame and frame.IsShown) then return false end
    local ok, shown = pcall(frame.IsShown, frame)
    return ok and shown and true or false
end

-- O C fica por conta do CharacterUI. Isto aqui só segura chamadas antigas que ainda chegam por este arquivo.
A.TranslateDynamicRoots = function()
    if A.RefreshCharacterUI then
        A.RefreshCharacterUI()
        return true
    end
    return false
end

-- Saque: só desenha o nome traduzido por cima. Clique e funções do loot ficam intactos.
local lootOverlays = {}
local function EnsureLootOverlay(index, button)
    if not Feature("lootOverlay", true) then return nil end
    local overlay = lootOverlays[index]
    if overlay then return overlay end
    if not (CreateFrame and UIParent and button) then return nil end
    if InCombatLockdown and InCombatLockdown() then return nil end

    overlay = CreateFrame("Frame", nil, UIParent)
    overlay:EnableMouse(false)
    if overlay.SetFrameStrata then pcall(overlay.SetFrameStrata, overlay, "DIALOG") end
    overlay:ClearAllPoints()
    overlay:SetPoint("TOPLEFT", button, "TOPLEFT", 37, -2)
    overlay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -4, 2)

    local bg = overlay:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints(overlay)
    if bg.SetTexture then pcall(bg.SetTexture, bg, 0.045, 0.045, 0.055, 0.96) end
    overlay.bg = bg

    local text = overlay:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    text:SetPoint("LEFT", overlay, "LEFT", 2, 0)
    text:SetPoint("RIGHT", overlay, "RIGHT", -2, 0)
    text:SetJustifyH("LEFT")
    text:SetWordWrap(false)
    overlay.text = text
    overlay:Hide()
    lootOverlays[index] = overlay
    return overlay
end

local function HideLootOverlays()
    for _, overlay in pairs(lootOverlays) do
        if overlay and overlay.Hide then overlay:Hide() end
    end
end
A.HideLootOverlays = HideLootOverlays

local function LootSlotIndex(buttonIndex, button)
    local direct = button and tonumber(button.slot)
    if direct and direct > 0 then return direct end
    local perPage = tonumber(LOOTFRAME_NUMBUTTONS) or 4
    local page = LootFrame and tonumber(LootFrame.page) or 1
    if not page or page < 1 then page = 1 end
    return (page - 1) * perPage + buttonIndex
end

local function UpdateLootOverlays()
    local db = DB()
    if not (db and db.items and Feature("lootOverlay", true) and LootFrame and Visible(LootFrame)) then
        HideLootOverlays()
        return
    end

    local perPage = tonumber(LOOTFRAME_NUMBUTTONS) or 4
    for i = 1, perPage do
        local button = _G["LootButton" .. i]
        local overlay = button and EnsureLootOverlay(i, button)
        local slot = button and LootSlotIndex(i, button)
        local shown = button and Visible(button)
        local link
        if shown and slot and type(GetLootSlotLink) == "function" then
            local ok, value = pcall(GetLootSlotLink, slot)
            if ok then link = value end
        end

        if overlay and shown and type(link) == "string" then
            local itemID = tonumber(link:match("item:(%-?%d+)"))
            local pt = itemID and A.ItemName and A.ItemName[itemID]
            local quality
            if type(GetLootSlotInfo) == "function" then
                local ok, texture, englishName, count, q = pcall(GetLootSlotInfo, slot)
                if ok then
                    quality = q
                    if not pt and type(englishName) == "string" and A.TranslateItemNameText then
                        pt = A.TranslateItemNameText(englishName, link, itemID)
                    end
                end
            end
            if pt and pt ~= "" then
                overlay:ClearAllPoints()
                overlay:SetPoint("TOPLEFT", button, "TOPLEFT", 37, -2)
                overlay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -4, 2)
                overlay.text:SetText(pt)
                local c = quality and ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[quality]
                if c then overlay.text:SetTextColor(c.r or 1, c.g or 1, c.b or 1, 1)
                else overlay.text:SetTextColor(1, 1, 1, 1) end
                overlay:Show()
            else
                overlay:Hide()
            end
        elseif overlay then
            overlay:Hide()
        end
    end
end
A.UpdateLootOverlays = UpdateLootOverlays

local function QueueLootUpdate()
    if not Feature("lootOverlay", true) then
        HideLootOverlays()
        return
    end
    UpdateLootOverlays()
    RuntimeAfter("aptbr-loot-overlay", 0.03, UpdateLootOverlays)
end

-- Gossip / mobs / raids -------------------------------------------------------------
local function TranslateWorldMessage(msg)
    if type(msg) ~= "string" or msg == "" then return nil end
    local pt
    if A.GossipLookup then
        local ok, value = pcall(A.GossipLookup, msg)
        if ok and type(value) == "string" and value ~= msg then pt = value end
    end
    if not pt and A.TranslateStaticText then
        local ok, value = pcall(A.TranslateStaticText, msg)
        if ok and type(value) == "string" and value ~= msg then pt = value end
    end
    if not pt then
        pt = (A.ServerUI and A.ServerUI[msg])
            or (A.CustomUI and A.CustomUI[msg])
            or (A.UnitNameEN2ES and A.UnitNameEN2ES[msg])
    end
    return pt
end
A.TranslateWorldMessage = TranslateWorldMessage

local function WorldMessageFilter(_, _, msg, ...)
    local db = DB()
    if not db or not Feature("raidTranslation", true) or type(msg) ~= "string" then return false end
    local pt = TranslateWorldMessage(msg)
    if pt and pt ~= msg then return false, pt, ... end
    return false
end

local MONSTER_EVENTS = {
    "CHAT_MSG_MONSTER_SAY", "CHAT_MSG_MONSTER_YELL",
    "CHAT_MSG_MONSTER_WHISPER", "CHAT_MSG_MONSTER_EMOTE",
    "CHAT_MSG_RAID_BOSS_EMOTE", "CHAT_MSG_RAID_BOSS_WHISPER",
}

-- Esta caminhada de frames fica só no Gossip. O C tem caminho próprio.
local translatedVisibleRegion = setmetatable({}, { __mode = "k" })
local translatingVisibleRegion = setmetatable({}, { __mode = "k" })

local function TranslateVisibleRegion(region)
    if not (region and region.GetText and region.SetText) then return end
    if region.IsObjectType then
        local okEdit, isEdit = pcall(region.IsObjectType, region, "EditBox")
        if okEdit and isEdit then return end
    end
    if translatingVisibleRegion[region] then return end
    local ok, text = pcall(region.GetText, region)
    if not ok or type(text) ~= "string" or text == "" then return end

    -- O passe tardio do Gossip pode encontrar a própria tradução novamente.
    -- Não deixa o resultado voltar para o dicionário e acumular prefixos/letras.
    if translatedVisibleRegion[region] == text then return end
    translatedVisibleRegion[region] = nil

    local pt = TranslateWorldMessage(text)
    if pt and pt ~= text then
        translatingVisibleRegion[region] = true
        translatedVisibleRegion[region] = pt
        local wrote = pcall(region.SetText, region, pt)
        if not wrote then translatedVisibleRegion[region] = nil end
        translatingVisibleRegion[region] = nil
    end
end

local function WalkVisibleText(root, depth)
    if not root or not Visible(root) then return end
    depth = depth or 0
    if depth > 8 then return end

    -- Alguns painéis custom do Ascension usam Button/SimpleHTML como o próprio
    -- objeto de texto, não um FontString em GetRegions().
    TranslateVisibleRegion(root)

    if root.GetFontString then
        local okfs, fs = pcall(root.GetFontString, root)
        if okfs and fs then TranslateVisibleRegion(fs) end
    end
    if root.GetRegions then
        local ok, regions = pcall(function() return { root:GetRegions() } end)
        if ok then
            for _, region in ipairs(regions) do TranslateVisibleRegion(region) end
        end
    end
    if root.GetChildren then
        local ok, children = pcall(function() return { root:GetChildren() } end)
        if ok then
            for _, child in ipairs(children) do
                if Visible(child) then WalkVisibleText(child, depth + 1) end
            end
        end
    end
end

local function TranslateGossipVisual()
    local db = DB()
    if not (db and db.gossip) then return end

    -- O clique direito no NPC pode abrir dois caminhos diferentes no cliente
    -- 3.3.5/Ascension: GossipFrame ou o painel de saudacao do QuestFrame.
    -- Traduzimos apenas essas raizes conhecidas, sem EnumerateFrames/scan global.
    if A.TranslateGossipGreeting then pcall(A.TranslateGossipGreeting) end

    local walked = {}
    local function walk(root)
        if not (root and Visible(root)) or walked[root] then return end
        walked[root] = true
        pcall(WalkVisibleText, root, 0)
    end

    if _G.GossipFrame and Visible(_G.GossipFrame) then
        walk(_G.GossipFrame)
    else
        walk(_G.GossipFrameGreetingPanel)
    end

    if _G.QuestFrameGreetingPanel and Visible(_G.QuestFrameGreetingPanel) then
        walk(_G.QuestFrameGreetingPanel)
    else
        walk(_G.QuestGreetingScrollChildFrame)
    end

    -- Alguns builds deixam o texto fora da raiz esperada, mas mantem os
    -- FontStrings globais classicos. Traduz o objeto diretamente e sobe apenas
    -- ate o pai imediato; nada de varrer UIParent ou a interface inteira.
    for _, name in ipairs({
        "GossipGreetingText", "GreetingText", "QuestGreetingText",
        "GossipFrameNpcNameText", "QuestFrameNpcNameText",
    }) do
        local region = _G[name]
        if region then
            pcall(TranslateVisibleRegion, region)
            if region.GetParent then
                local ok, parent = pcall(region.GetParent, region)
                if ok and parent then walk(parent) end
            end
        end
    end
end

-- Compatibilidade pontual ----------------------------------------------------------
-- Details antigo quebra se uma classe custom não tiver cor. Preenchemos só o que estiver faltando.
local COA_CLASS_KEYS = {
    "BARBARIAN", "WITCHDOCTOR", "WITCHHUNTER", "FELSWORN", "STORMBRINGER",
    "KNIGHTOFXOROTH", "GUARDIAN", "TEMPLAR", "BLOODMAGE", "RANGER",
    "CHRONOMANCER", "NECROMANCER", "PYROMANCER", "CULTIST", "STARCALLER",
    "SUNCLERIC", "TINKER", "VENOMANCER", "REAPER", "PRIMALIST", "RUNEMASTER",
}

local DETAILS_BASE_COLOR_KEYS = {
    "UNKNOW", "UNKNOWN", "PET", "ENEMY", "NEUTRAL", "ARENA_GREEN", "ARENA_YELLOW",
}

local detailsInjected = {}
local detailsColorTable
local detailsOriginalColorMeta
local detailsFallbackColorMeta
local DETAILS_FALLBACK_COLOR = { 0.70, 0.72, 0.78, 1 }

local function RemoveDetailsClassColors()
    local colors = detailsColorTable
    if type(colors) == "table" then
        for key, value in pairs(detailsInjected) do
            if rawget(colors, key) == value then rawset(colors, key, nil) end
        end
        if detailsFallbackColorMeta and getmetatable(colors) == detailsFallbackColorMeta then
            pcall(setmetatable, colors, detailsOriginalColorMeta)
        end
    end
    detailsInjected = {}
    detailsColorTable = nil
    detailsOriginalColorMeta = nil
    detailsFallbackColorMeta = nil
end

local function ColorComponents(source)
    if type(source) ~= "table" then return nil end
    local r = tonumber(source.r or source[1])
    local g = tonumber(source.g or source[2])
    local b = tonumber(source.b or source[3])
    local a = tonumber(source.a or source[4]) or 1
    if not (r and g and b) then return nil end
    return r, g, b, a
end

local function AddDetailsColor(colors, key, source)
    if type(colors) ~= "table" or type(key) ~= "string" or key == "" or rawget(colors, key) ~= nil then return end
    source = source
        or (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[key])
        or (RAID_CLASS_COLORS and RAID_CLASS_COLORS[key])
    local r, g, b, a = ColorComponents(source)
    if not r then r, g, b, a = 0.70, 0.72, 0.78, 1 end
    local value = { r, g, b, a }
    rawset(colors, key, value)
    detailsInjected[key] = value
end

local function AddDetailsColorAliases(colors, key, source)
    if type(key) ~= "string" or key == "" then return end
    local compact = key:gsub("[%s_%-']", "")
    local upper = key:upper()
    local title = key:sub(1, 1):upper() .. key:sub(2):lower()
    AddDetailsColor(colors, key, source)
    AddDetailsColor(colors, upper, source)
    AddDetailsColor(colors, compact, source)
    AddDetailsColor(colors, compact:upper(), source)
    AddDetailsColor(colors, title, source)
end

local function InstallDetailsColorFallback(colors)
    if type(colors) ~= "table" then return false end
    if detailsFallbackColorMeta and getmetatable(colors) == detailsFallbackColorMeta then return true end

    detailsOriginalColorMeta = getmetatable(colors)
    local originalMeta = detailsOriginalColorMeta
    local originalIndex = type(originalMeta) == "table" and originalMeta.__index or nil
    local meta = {}
    if type(originalMeta) == "table" then
        for key, value in pairs(originalMeta) do meta[key] = value end
    end

    meta.__index = function(tbl, key)
        local value
        if type(originalIndex) == "function" then
            local ok, result = pcall(originalIndex, tbl, key)
            if ok then value = result end
        elseif type(originalIndex) == "table" then
            value = originalIndex[key]
        end
        if value ~= nil then return value end

        -- Details antigo possui caminhos de GetBarColor que fazem unpack direto da
        -- tabela de classe do ator/dono. No CoA podem aparecer classes customizadas
        -- antes de o Details conhecê-las; devolver uma cor válida é mais seguro que
        -- substituir a função inteira do addon.
        return rawget(tbl, "UNKNOW") or rawget(tbl, "UNKNOWN") or DETAILS_FALLBACK_COLOR
    end

    local ok = pcall(setmetatable, colors, meta)
    if ok then
        detailsFallbackColorMeta = meta
        return true
    end
    detailsOriginalColorMeta = nil
    return false
end

local function EnsureDetailsClassColors()
    if not Feature("detailsCompat", true) then
        RemoveDetailsClassColors()
        return false
    end
    local details = _G.Details or _G._detalhes
    local colors = details and details.class_colors
    if type(colors) ~= "table" then return false end
    if detailsColorTable and detailsColorTable ~= colors then RemoveDetailsClassColors() end
    detailsColorTable = colors

    -- Preserva tudo que o próprio cliente/Ascension já registrou nas tabelas globais.
    -- Importamos separadamente porque ipairs para no primeiro nil; alguns builds do
    -- cliente não expõem CUSTOM_CLASS_COLORS (ou carregam essa tabela mais tarde).
    local function ImportSourceTable(sourceTable)
        if type(sourceTable) ~= "table" then return end
        for key, source in pairs(sourceTable) do
            if type(key) == "string" then AddDetailsColorAliases(colors, key, source) end
        end
    end
    ImportSourceTable(RAID_CLASS_COLORS)
    ImportSourceTable(CUSTOM_CLASS_COLORS)

    for _, key in ipairs(COA_CLASS_KEYS) do
        AddDetailsColorAliases(colors, key)
    end
    for _, key in ipairs(DETAILS_BASE_COLOR_KEYS) do
        AddDetailsColor(colors, key)
    end

    -- UnitClass no Ascension pode devolver o nome localizado e o token da classe.
    -- Registramos os dois formatos porque versões antigas do Details nem sempre
    -- normalizam actor.classe da mesma maneira.
    if UnitClass then
        local ok, localized, token = pcall(UnitClass, "player")
        if ok then
            if type(token) == "string" then AddDetailsColorAliases(colors, token) end
            if type(localized) == "string" then
                local source = type(token) == "string" and rawget(colors, token) or nil
                AddDetailsColorAliases(colors, localized, source)
            end
        end
    end

    InstallDetailsColorFallback(colors)
    return true
end
A.EnsureDetailsClassColors = EnsureDetailsClassColors

-- O Details pode refazer a tabela ao abrir o perfil. Dois passes curtos resolvem sem deixar loop rodando.
local function QueueDetailsClassColors()
    EnsureDetailsClassColors()
    RuntimeAfter("aptbr-details-colors-early", 0.05, EnsureDetailsClassColors)
    RuntimeAfter("aptbr-details-colors-late", 0.50, EnsureDetailsClassColors)
end

A.ApplyDetailsCompatibility = function()
    if Feature("detailsCompat", true) then
        QueueDetailsClassColors()
        return true
    end
    RemoveDetailsClassColors()
    return true
end

local function PrimeLootOverlays()
    if not Feature("lootOverlay", true) then
        HideLootOverlays()
        return
    end
    if InCombatLockdown and InCombatLockdown() then return end
    local perPage = tonumber(LOOTFRAME_NUMBUTTONS) or 4
    for i = 1, perPage do
        local button = _G["LootButton" .. i]
        if button then EnsureLootOverlay(i, button) end
    end
    HideLootOverlays()
end

local function HookLootUpdate()
    if A._integrationLootHooked then return end
    if hooksecurefunc and type(LootFrame_Update) == "function" then
        A._integrationLootHooked = true
        pcall(hooksecurefunc, "LootFrame_Update", QueueLootUpdate)
    end
end

A.RefreshIntegrationUI = function()
    if Feature("lootOverlay", true) then QueueLootUpdate() else HideLootOverlays() end
    A.ApplyDetailsCompatibility()
end

if A.Runtime and A.Runtime.RegisterModule then
    A.Runtime.RegisterModule("integration-ui", function()
        A.RefreshIntegrationUI()
        return true
    end)
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("LOOT_OPENED")
eventFrame:RegisterEvent("LOOT_CLOSED")
pcall(eventFrame.RegisterEvent, eventFrame, "LOOT_SLOT_CLEARED")
pcall(eventFrame.RegisterEvent, eventFrame, "LOOT_READY")
eventFrame:RegisterEvent("GOSSIP_SHOW")
eventFrame:RegisterEvent("QUEST_GREETING")
eventFrame:SetScript("OnEvent", function(_, event, arg1)
    if event == "PLAYER_ENTERING_WORLD" then
        HookLootUpdate()
        QueueDetailsClassColors()
        PrimeLootOverlays()
    elseif event == "ADDON_LOADED" then
        local addon = arg1
        if type(addon) ~= "string" then return end
        -- Outro addon pode substituir/adiar partes da interface de saque.
        RuntimeAfter("aptbr-integration-addon-loaded", 0.16, HookLootUpdate)
        if addon == "Details" then QueueDetailsClassColors() end
    elseif event == "LOOT_OPENED" or event == "LOOT_READY" then
        QueueLootUpdate()
    elseif event == "LOOT_SLOT_CLEARED" then
        QueueLootUpdate()
    elseif event == "LOOT_CLOSED" then
        HideLootOverlays()
    elseif event == "GOSSIP_SHOW" or event == "QUEST_GREETING" then
        TranslateGossipVisual()
        -- O servidor/Ascension pode preencher o pergaminho um pouco depois do
        -- evento. Dois passes curtos e direcionados sao mais baratos que scan.
        RuntimeAfter("aptbr-gossip-visual-fast", 0.03, TranslateGossipVisual)
        RuntimeAfter("aptbr-gossip-visual-late", 0.12, TranslateGossipVisual)
    end
end)

if ChatFrame_AddMessageEventFilter then
    for _, eventName in ipairs(MONSTER_EVENTS) do
        pcall(ChatFrame_AddMessageEventFilter, eventName, WorldMessageFilter)
    end
end

-- Se outro addon trocou a tela padrão, só mexemos no que ainda existir. Se não achou, segue o jogo.
HookLootUpdate()
EnsureDetailsClassColors()

-- Menu do ESC ----------------------------------------------------------------------
-- O CoA possui mais de uma implementação do menu e nem todas usam GameMenuFrame.
-- Detectamos a janela pelos textos exclusivos do próprio menu e fazemos o passe
-- somente quando o ESC/ToggleGameMenu é acionado. Nada de scanner em OnUpdate.
;(function()
    local MAP = {
        ["Options"] = "Opções",
        ["Help / Report Bug"] = "Ajuda / Relatar erro",
        ["Join Discord"] = "Entrar no Discord",
        ["Video"] = "Vídeo",
        ["Sound"] = "Som",
        ["Interface"] = "Interface",
        ["Key Bindings"] = "Atalhos de teclado",
        ["Quick Binding"] = "Atribuição rápida",
        ["Macros"] = "Macros",
        ["AddOns"] = "Complementos",
        ["MoveAnything!"] = "MoveAnything!",
        ["Logout"] = "Desconectar",
        ["Exit Game"] = "Sair do jogo",
        ["Close"] = "Fechar",
    }
    local MARKER = {
        ["Help / Report Bug"] = true,
        ["Join Discord"] = true,
        ["Key Bindings"] = true,
        ["Quick Binding"] = true,
        ["Exit Game"] = true,
        ["MoveAnything!"] = true,
    }
    local busy = setmetatable({}, { __mode = "k" })
    local cachedRoot
    local hookedRoots = setmetatable({}, { __mode = "k" })
    local toggleHooked = false

    local function ReadText(obj)
        if not (obj and obj.GetText) then return nil end
        local ok, text = pcall(obj.GetText, obj)
        if ok and type(text) == "string" and text ~= "" then return text end
    end

    local function ExactPT(text)
        if type(text) ~= "string" or text == "" then return nil end
        return MAP[text]
            or (A.CustomUI and A.CustomUI[text])
            or (A.ServerUI and A.ServerUI[text])
    end

    local function WriteObject(obj)
        if not (obj and obj.SetText) or busy[obj] then return 0 end
        local text = ReadText(obj)
        if not text then return 0 end
        local pt = ExactPT(text)
        if not pt or pt == text then return 0 end
        busy[obj] = true
        local ok = pcall(obj.SetText, obj, pt)
        busy[obj] = nil
        return ok and 1 or 0
    end

    local function CollectTree(root, maxNodes)
        if not root then return nil, 0 end
        local queue, head, seen, objects, markerHits = { root }, 1, 0, {}, 0
        while queue[head] and seen < (maxNodes or 260) do
            local node = queue[head]
            head = head + 1
            seen = seen + 1

            local text = ReadText(node)
            if text then
                objects[#objects + 1] = node
                if MARKER[text] then markerHits = markerHits + 1 end
            end

            if node.GetFontString then
                local ok, fs = pcall(node.GetFontString, node)
                if ok and fs then
                    local ft = ReadText(fs)
                    if ft then
                        objects[#objects + 1] = fs
                        if MARKER[ft] then markerHits = markerHits + 1 end
                    end
                end
            end

            if node.GetRegions then
                local ok, regions = pcall(function() return { node:GetRegions() } end)
                if ok and regions then
                    for i = 1, #regions do
                        local region = regions[i]
                        local rt = ReadText(region)
                        if rt then
                            objects[#objects + 1] = region
                            if MARKER[rt] then markerHits = markerHits + 1 end
                        end
                    end
                end
            end

            if node.GetChildren then
                local ok, children = pcall(function() return { node:GetChildren() } end)
                if ok and children then
                    for i = 1, #children do queue[#queue + 1] = children[i] end
                end
            end
        end
        return objects, markerHits
    end

    local function ApplyTree(root, requireMarkers)
        if not root then return 0 end
        local objects, hits = CollectTree(root, 320)
        if not objects or (requireMarkers and hits < 2) then return 0 end
        local changed = 0
        for i = 1, #objects do changed = changed + WriteObject(objects[i]) end
        return changed
    end

    local function HookRoot(root)
        if not (root and root.HookScript) or hookedRoots[root] then return end
        hookedRoots[root] = true
        pcall(root.HookScript, root, "OnShow", function()
            ApplyTree(root, false)
            RuntimeAfter("aptbr-game-menu-root", 0.05, function() ApplyTree(root, false) end)
        end)
    end

    local function FindCustomMenu()
        local known = {
            _G.GameMenuFrame,
            _G.AscensionGameMenuFrame,
            _G.AscensionGameMenu,
            _G.GameMenu,
            _G.GameMenuOptionsFrame,
        }
        for i = 1, #known do
            local root = known[i]
            if root and Visible(root) then
                local _, hits = CollectTree(root, 320)
                if hits >= 2 then return root end
            end
        end

        return nil
    end

    local function TranslateGameMenu()
        local root = cachedRoot
        if not (root and Visible(root)) then
            root = FindCustomMenu()
            if root then cachedRoot = root end
        end
        if not root then return 0 end
        HookRoot(root)
        return ApplyTree(root, false)
    end
    A.TranslateGameMenu = TranslateGameMenu

    local function QueueMenuPass()
        TranslateGameMenu()
        RuntimeAfter("aptbr-game-menu-1", 0.03, TranslateGameMenu)
        RuntimeAfter("aptbr-game-menu-2", 0.12, TranslateGameMenu)
    end

    local function InstallToggleHooks()
        if toggleHooked or not hooksecurefunc then return end
        local hooked = false
        for _, fname in ipairs({ "ToggleGameMenu", "GameMenuFrame_Toggle", "GameMenuFrame_Show" }) do
            if type(_G[fname]) == "function" then
                local ok = pcall(hooksecurefunc, fname, QueueMenuPass)
                hooked = ok or hooked
            end
        end
        toggleHooked = hooked
        if _G.GameMenuFrame then HookRoot(_G.GameMenuFrame) end
    end

    local ev = CreateFrame("Frame")
    ev:RegisterEvent("PLAYER_ENTERING_WORLD")
    ev:RegisterEvent("ADDON_LOADED")
    ev:SetScript("OnEvent", function()
        InstallToggleHooks()
        -- Addons como MoveAnything podem reconstruir o menu depois do login.
        cachedRoot = nil
    end)

    InstallToggleHooks()

    SLASH_APTBRESC1 = "/aptbresc"
    SlashCmdList["APTBRESC"] = function()
        cachedRoot = nil
        local root = FindCustomMenu()
        cachedRoot = root
        local count = root and ApplyTree(root, false) or 0
        local name = root and root.GetName and root:GetName() or "<sem nome>"
        DEFAULT_CHAT_FRAME:AddMessage(string.format(
            "|cff33ff99AscensionPTBR|r ESC: frame=%s alterados=%d", tostring(name), tonumber(count) or 0))
    end
end)()


-- Popups e avisos curtos da interface ----------------------------------------------
-- StaticPopup e o contador de logout sao pequenos, mas muitos textos sao montados
-- depois do carregamento do addon. Em vez de voltar ao scanner global (que pesava em
-- cidades), hookamos somente os FontStrings desses poucos dialogs quando eles aparecem.
;(function()
    local busy = setmetatable({}, { __mode = "k" })
    local textHooked = setmetatable({}, { __mode = "k" })
    local rootHooked = setmetatable({}, { __mode = "k" })
    local function ReadText(obj)
        if not (obj and obj.GetText) then return nil end
        local ok, text = pcall(obj.GetText, obj)
        if ok and type(text) == "string" and text ~= "" then return text end
    end

    local EXTRA = {
        ["Cancel"] = "Cancelar",
        ["Okay"] = "OK",
        ["OK"] = "OK",
        ["Yes"] = "Sim",
        ["No"] = "Não",
        ["Accept"] = "Aceitar",
        ["Decline"] = "Recusar",
        ["Ignore"] = "Ignorar",
        ["Disable"] = "Desativar",
        ["Reload UI"] = "Recarregar interface",
        ["Return to Game"] = "Voltar ao jogo",
        ["Close"] = "Fechar",
        ["Logout"] = "Desconectar",
        ["Exit Game"] = "Sair do jogo",
    }

    local function TranslateText(text)
        if type(text) ~= "string" or text == "" then return nil end
        local pt = EXTRA[text]
        if pt then return pt end
        if A.TranslateStaticText then
            local ok, value = pcall(A.TranslateStaticText, text)
            if ok and type(value) == "string" and value ~= "" and value ~= text then return value end
        end
        return (A.CustomUI and A.CustomUI[text])
            or (A.ServerUI and A.ServerUI[text])
            or (A.UIStringsByEN and A.UIStringsByEN[text])
    end

    local function RefreshText(obj)
        if not (obj and obj.SetText) or busy[obj] then return end
        local text = ReadText(obj)
        if not text then return end
        local pt = TranslateText(text)
        if not pt or pt == text then return end
        busy[obj] = true
        pcall(obj.SetText, obj, pt)
        busy[obj] = nil
    end

    local function HookText(obj)
        if not (obj and obj.SetText) then return end
        if not textHooked[obj] and hooksecurefunc then
            textHooked[obj] = true
            pcall(hooksecurefunc, obj, "SetText", function(self)
                RefreshText(self)
            end)
            if obj.SetFormattedText then
                pcall(hooksecurefunc, obj, "SetFormattedText", function(self)
                    RefreshText(self)
                end)
            end
        end
        RefreshText(obj)
    end

    local function PrepareRoot(root)
        if not root then return end
        local queue, head, seen = { root }, 1, 0
        while queue[head] and seen < 96 do
            local node = queue[head]
            head = head + 1
            seen = seen + 1

            HookText(node)
            if node.GetFontString then
                local ok, fs = pcall(node.GetFontString, node)
                if ok and fs then HookText(fs) end
            end
            if node.GetRegions then
                local ok, regions = pcall(function() return { node:GetRegions() } end)
                if ok and regions then
                    for i = 1, #regions do HookText(regions[i]) end
                end
            end
            if node.GetChildren then
                local ok, children = pcall(function() return { node:GetChildren() } end)
                if ok and children then
                    for i = 1, #children do queue[#queue + 1] = children[i] end
                end
            end
        end
    end

    local function HookRoot(root)
        if not (root and root.HookScript) or rootHooked[root] then return end
        rootHooked[root] = true
        pcall(root.HookScript, root, "OnShow", function(self)
            PrepareRoot(self)
        end)
        if Visible(root) then PrepareRoot(root) end
    end

    local function PrepareKnownPopups()
        for i = 1, 4 do
            local popup = _G["StaticPopup" .. i]
            if popup then
                HookRoot(popup)
                if Visible(popup) then PrepareRoot(popup) end
            end
        end

        -- Alguns forks do cliente usam um frame proprio para o contador de logout.
        -- Se ele existir, tratamos somente essa raiz; nenhum EnumerateFrames aqui.
        local names = { "LogoutTimerFrame", "LogoutTimer", "LogoutFrame" }
        for i = 1, #names do
            local root = _G[names[i]]
            if root then
                HookRoot(root)
                if Visible(root) then PrepareRoot(root) end
            end
        end
    end

    local function QueuePopupPass()
        PrepareKnownPopups()
        RuntimeAfter("aptbr-interface-popup", 0.02, PrepareKnownPopups)
    end

    if hooksecurefunc then
        if type(_G.StaticPopup_Show) == "function" then
            pcall(hooksecurefunc, "StaticPopup_Show", QueuePopupPass)
        end
        if type(_G.Logout) == "function" then pcall(hooksecurefunc, "Logout", QueuePopupPass) end
        if type(_G.Quit) == "function" then pcall(hooksecurefunc, "Quit", QueuePopupPass) end
    end

    PrepareKnownPopups()
    A.RefreshTransientInterface = PrepareKnownPopups
end)()


-- Provas / Trials ------------------------------------------------------------------
-- A tela de Provas do CoA e custom e recicla os cards conforme filtro/rolagem.
-- Traduzimos somente a arvore dessa janela, no OnShow/SetText/OnClick, sem OnUpdate
-- e sem scanner global durante o jogo.
;(function()
    local EXACT = {
        ["Trials"] = "Provas",
        ["Trials (J)"] = "Provas (J)",
        ["Rewards"] = "Recompensas",
        ["Challenges"] = "Desafios",
        ["Trial Architect"] = "Arquiteto de Provas",
        ["Trial Creator"] = "Criador de Provas",
        ["Gamemodes"] = "Modos de Jogo",
        ["Adventure Mode"] = "Modo Aventura",
        ["Slow and Steady"] = "Devagar e Sempre",
        ["Hardcore"] = "Modo Hardcore",
        ["Hardcore Trial"] = "Prova Hardcore",
        ["Filter"] = "Filtrar",
        ["Search"] = "Pesquisar",
        ["Locked"] = "Bloqueado",
        ["LOCKED"] = "BLOQUEADO",
        ["Active"] = "Ativa",
        ["Inactive"] = "Inativa",
        ["Completed"] = "Concluída",
        ["Available"] = "Disponível",
    }

    local MARKERS = {
        ["Trials"] = true, ["Provas"] = true,
        ["Rewards"] = true, ["Recompensas"] = true,
        ["Challenges"] = true, ["Desafios"] = true,
        ["Trial Architect"] = true, ["Arquiteto de Provas"] = true,
        ["Trial Creator"] = true, ["Criador de Provas"] = true,
        ["Gamemodes"] = true, ["Modos de Jogo"] = true,
        ["Adventure Mode"] = true, ["Modo Aventura"] = true,
        ["Slow and Steady"] = true, ["Devagar e Sempre"] = true,
    }

    local busy = setmetatable({}, { __mode = "k" })
    local ownText = setmetatable({}, { __mode = "k" })
    local textHooked = setmetatable({}, { __mode = "k" })
    local widgetHooked = setmetatable({}, { __mode = "k" })
    local rootHooked = setmetatable({}, { __mode = "k" })
    local cachedRoot
    local togglesHooked = {}

    local function ReadText(obj)
        if not (obj and obj.GetText) then return nil end
        local ok, value = pcall(obj.GetText, obj)
        if ok and type(value) == "string" and value ~= "" then return value end
    end

    local function TranslateText(text)
        if type(text) ~= "string" or text == "" then return nil end
        local pt = EXACT[text]
            or (A.ServerUI and A.ServerUI[text])
            or (A.CustomUI and A.CustomUI[text])
            or (A.UIStringsByEN and A.UIStringsByEN[text])
        if pt and pt ~= text then return pt end

        -- Titulos de cards compostos. Traduzimos so o prefixo conhecido e
        -- deixamos nomes proprios intactos quando nao houver mapa para o sufixo.
        local suffix = text:match("^Hardcore %- (.+)$")
        if suffix then
            local ptSuffix = EXACT[suffix]
                or (A.ServerUI and A.ServerUI[suffix])
                or (A.CustomUI and A.CustomUI[suffix])
                or suffix
            return "Modo Hardcore - " .. ptSuffix
        end

        suffix = text:match("^Hardcore Duo %- (.+)$")
        if suffix then
            local ptSuffix = (A.ServerUI and A.ServerUI[suffix]) or suffix
            return "Dupla Hardcore - " .. ptSuffix
        end

        suffix = text:match("^Hardcore Trio %- (.+)$")
        if suffix then
            local ptSuffix = (A.ServerUI and A.ServerUI[suffix]) or suffix
            return "Trio Hardcore - " .. ptSuffix
        end

        suffix = text:match("^Prestige %- (.+)$")
        if suffix then
            local ptSuffix = (A.ServerUI and A.ServerUI[suffix]) or suffix
            return "Prestígio - " .. ptSuffix
        end

        if A.TranslateStaticText then
            local ok, value = pcall(A.TranslateStaticText, text)
            if ok and type(value) == "string" and value ~= "" and value ~= text then
                return value
            end
        end
    end

    local function TranslateObject(obj)
        if not (obj and obj.GetText and obj.SetText) or busy[obj] then return 0 end
        local text = ReadText(obj)
        if not text then return 0 end
        if ownText[obj] == text then return 0 end
        ownText[obj] = nil

        local pt = TranslateText(text)
        if not pt or pt == text then return 0 end
        busy[obj] = true
        local ok = pcall(obj.SetText, obj, pt)
        busy[obj] = nil
        if ok then
            ownText[obj] = pt
            return 1
        end
        return 0
    end

    local function HookText(obj)
        if not (obj and obj.GetText and obj.SetText) then return end
        if obj.IsObjectType then
            local okEdit, isEdit = pcall(obj.IsObjectType, obj, "EditBox")
            if okEdit and isEdit then return end
        end
        if not textHooked[obj] and hooksecurefunc then
            textHooked[obj] = true
            pcall(hooksecurefunc, obj, "SetText", function(self)
                TranslateObject(self)
            end)
            if obj.SetFormattedText then
                pcall(hooksecurefunc, obj, "SetFormattedText", function(self)
                    TranslateObject(self)
                end)
            end
        end
        TranslateObject(obj)
    end

    local QueueRefresh

    local function HookWidget(widget)
        if not (widget and widget.HookScript) or widgetHooked[widget] then return end
        local objectType = widget.GetObjectType and widget:GetObjectType()
        if objectType ~= "Button" and objectType ~= "ScrollFrame" and objectType ~= "Slider" then return end
        widgetHooked[widget] = true
        if objectType == "Button" then
            pcall(widget.HookScript, widget, "OnClick", function() QueueRefresh(0.025) end)
        elseif objectType == "ScrollFrame" then
            pcall(widget.HookScript, widget, "OnVerticalScroll", function() QueueRefresh(0.035) end)
        elseif objectType == "Slider" then
            pcall(widget.HookScript, widget, "OnValueChanged", function() QueueRefresh(0.035) end)
        end
    end

    local function Walk(root, maxNodes)
        if not root then return 0, 0 end
        local queue, head, visited, changed, markerHits = { root }, 1, 0, 0, 0
        local seenObjects = {}
        local limit = maxNodes or 600

        local function VisitText(obj)
            if not obj or seenObjects[obj] then return end
            seenObjects[obj] = true
            local before = ReadText(obj)
            if before and MARKERS[before] then markerHits = markerHits + 1 end
            HookText(obj)
            local after = ReadText(obj)
            if before and after and before ~= after then changed = changed + 1 end
        end

        while queue[head] and visited < limit do
            local node = queue[head]
            head = head + 1
            visited = visited + 1

            VisitText(node)
            HookWidget(node)

            if node.GetFontString then
                local ok, fs = pcall(node.GetFontString, node)
                if ok and fs then VisitText(fs) end
            end

            if node.GetRegions then
                local ok, regions = pcall(function() return { node:GetRegions() } end)
                if ok and regions then
                    for i = 1, #regions do VisitText(regions[i]) end
                end
            end

            if node.GetChildren then
                local ok, children = pcall(function() return { node:GetChildren() } end)
                if ok and children then
                    for i = 1, #children do queue[#queue + 1] = children[i] end
                end
            end
        end
        return changed, markerHits
    end

    local function Probe(root, maxNodes)
        if not root then return 0 end
        local queue, head, visited, hits = { root }, 1, 0, 0
        local limit = maxNodes or 260
        local seenObjects = {}

        local function ProbeText(obj)
            if not obj or seenObjects[obj] then return end
            seenObjects[obj] = true
            local text = ReadText(obj)
            if text and MARKERS[text] then hits = hits + 1 end
        end

        while queue[head] and visited < limit and hits < 3 do
            local node = queue[head]
            head = head + 1
            visited = visited + 1
            ProbeText(node)

            if node.GetFontString then
                local ok, fs = pcall(node.GetFontString, node)
                if ok and fs then ProbeText(fs) end
            end
            if node.GetRegions then
                local ok, regions = pcall(function() return { node:GetRegions() } end)
                if ok and regions then
                    for i = 1, #regions do ProbeText(regions[i]) end
                end
            end
            if node.GetChildren then
                local ok, children = pcall(function() return { node:GetChildren() } end)
                if ok and children then
                    for i = 1, #children do queue[#queue + 1] = children[i] end
                end
            end
        end
        return hits
    end

    local function IsTrialsRoot(root)
        return Probe(root, 260) >= 2
    end

    local KNOWN_ROOTS = {
        "TrialsFrame", "TrialFrame", "AscensionTrialsFrame", "AscensionTrialFrame",
        "ChallengesFrame", "AscensionChallengesFrame", "TrialListFrame",
        "TrialsWindow", "TrialWindow", "AscensionTrialsWindow",
    }

    local function FindRoot()
        if cachedRoot and Visible(cachedRoot) then return cachedRoot end

        for i = 1, #KNOWN_ROOTS do
            local root = _G[KNOWN_ROOTS[i]]
            if root and Visible(root) and IsTrialsRoot(root) then
                cachedRoot = root
                return root
            end
        end

        return nil
    end

    local function HookRoot(root)
        if not (root and root.HookScript) or rootHooked[root] then return end
        rootHooked[root] = true
        pcall(root.HookScript, root, "OnShow", function()
            RuntimeAfter("aptbr-trials-show", 0, function()
                Walk(root, 600)
            end)
            RuntimeAfter("aptbr-trials-populate", 0.08, function()
                if Visible(root) then Walk(root, 600) end
            end)
        end)
    end

    local function TranslateTrials()
        local root = FindRoot()
        if not root then return 0 end
        HookRoot(root)
        local changed = Walk(root, 600)
        return changed or 0
    end
    A.TranslateTrialsUI = TranslateTrials

    QueueRefresh = function(delay)
        RuntimeAfter("aptbr-trials-refresh", delay or 0.03, function()
            if cachedRoot and Visible(cachedRoot) then
                Walk(cachedRoot, 600)
            else
                TranslateTrials()
            end
        end)
    end

    local function HookKnownRootObjects()
        for i = 1, #KNOWN_ROOTS do
            local root = _G[KNOWN_ROOTS[i]]
            if root then HookRoot(root) end
        end
    end

    local function InstallToggleHooks()
        if not hooksecurefunc then return end
        local names = {
            "ToggleAchievementFrame", "AchievementFrame_ToggleAchievementFrame",
            "ToggleTrialsFrame", "TrialsFrame_Toggle", "ToggleTrialFrame",
            "AscensionTrials_Toggle", "ToggleChallengesFrame", "ChallengesFrame_Toggle",
        }
        for i = 1, #names do
            local name = names[i]
            if not togglesHooked[name] and type(_G[name]) == "function" then
                local ok = pcall(hooksecurefunc, name, function()
                    -- Primeiro passe logo apos o toggle; o segundo pega cards
                    -- que o Ascension popula um pouco depois.
                    TranslateTrials()
                    QueueRefresh(0.08)
                end)
                if ok then togglesHooked[name] = true end
            end
        end

        -- ShowUIPanel e um ponto barato e confiavel: so roda quando uma janela
        -- grande realmente e aberta. Fazemos apenas uma leitura curta do painel
        -- recebido; nada de enumerar a UI durante o jogo. Isso cobre builds do
        -- CoA onde a tela de Trials nao tem um nome global estavel.
        if not togglesHooked.ShowUIPanel and type(_G.ShowUIPanel) == "function" then
            local ok = pcall(hooksecurefunc, "ShowUIPanel", function(frame)
                if frame and Visible(frame) and Probe(frame, 180) >= 2 then
                    cachedRoot = frame
                    HookRoot(frame)
                    Walk(frame, 600)
                    QueueRefresh(0.08)
                end
            end)
            if ok then togglesHooked.ShowUIPanel = true end
        end

        HookKnownRootObjects()
    end

    local ev = CreateFrame("Frame")
    ev:RegisterEvent("PLAYER_ENTERING_WORLD")
    ev:RegisterEvent("ADDON_LOADED")
    ev:SetScript("OnEvent", function(_, event, addonName)
        InstallToggleHooks()
        if event == "ADDON_LOADED" and type(addonName) == "string" then
            local lower = addonName:lower()
            if lower:find("trial", 1, true) or lower:find("challenge", 1, true) then
                cachedRoot = nil
                QueueRefresh(0.05)
            end
        end
    end)

    InstallToggleHooks()

    SLASH_APTBRTRIALS1 = "/aptbrprovas"
    SlashCmdList["APTBRTRIALS"] = function()
        cachedRoot = nil
        local root = FindRoot()
        local changed = root and Walk(root, 900) or 0
        local name = root and root.GetName and root:GetName() or "<nao encontrada>"
        DEFAULT_CHAT_FRAME:AddMessage(string.format(
            "|cff33ff99AscensionPTBR|r Provas: frame=%s alterados=%d",
            tostring(name), tonumber(changed) or 0))
    end
end)()
