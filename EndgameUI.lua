local A = AscensionPTBR
if not A then return end

local function Enabled()
    if A.IsFeatureEnabled then return A.IsFeatureEnabled("endgameUI", true) end
    return not AscensionPTBRDB or AscensionPTBRDB.endgameUI ~= false
end

local function Visible(frame)
    if not frame then return false end
    if frame.IsVisible then
        local ok, shown = pcall(frame.IsVisible, frame)
        if ok then return shown and true or false end
    end
    if frame.IsShown then
        local ok, shown = pcall(frame.IsShown, frame)
        if ok then return shown and true or false end
    end
    return true
end

local function After(key, delay, fn)
    local runtime = A.Runtime
    if runtime and runtime.After then
        return runtime.After(key, delay or 0, fn)
    end
    if type(fn) == "function" then fn() end
end

local busy = setmetatable({}, { __mode = "k" })
local ownText = setmetatable({}, { __mode = "k" })
local textHooked = setmetatable({}, { __mode = "k" })
local widgetHooked = setmetatable({}, { __mode = "k" })
local rootHooked = setmetatable({}, { __mode = "k" })
local roots = setmetatable({}, { __mode = "k" })
local togglesHooked = {}

local function ReadText(obj)
    if not (obj and obj.GetText) then return nil end
    local ok, value = pcall(obj.GetText, obj)
    if ok and type(value) == "string" and value ~= "" then return value end
end

local STRONG_MARKERS = {
    ["Mythic+ Dungeons"] = true, ["Masmorras Mítico+"] = true,
    ["Ember Court"] = true, ["Corte das Brasas"] = true,
    ["Dungeons & Raids"] = true, ["Masmorras e Raides"] = true,
    ["Dungeon Finder"] = true, ["Localizador de Masmorras"] = true,
    ["The Manastorm"] = true, ["Manastorm"] = true, ["Tormenta de Mana"] = true,
    ["Raid Trials"] = true, ["Provas de Raide"] = true,
    ["Prestige Mode"] = true, ["Modo Prestígio"] = true,
    ["World Bosses"] = true, ["Chefes Mundiais"] = true,
    ["Mystic Enchanting"] = true, ["Encantamento Místico"] = true,
    ["High-Risk Mode"] = true, ["Modo de Alto Risco"] = true,
    ["Hero's Call Board"] = true, ["Quadro de Chamado do Herói"] = true,
    ["World Events"] = true, ["Eventos Mundiais"] = true,
    ["Glory System"] = true, ["Sistema de Glória"] = true,
    ["Arena (Solo Queue)"] = true, ["Arena (Fila solo)"] = true,
    ["Arena (Group Queue)"] = true, ["Arena (Fila em Grupo)"] = true,
}

local MEDIUM_MARKERS = {
    ["Best run for this affix set"] = true, ["Melhor tempo com este conjunto de afixos"] = true,
    ["Creature Affix"] = true, ["Afixo de Criatura"] = true,
    ["Champion Affix"] = true, ["Afixo de Campeão"] = true,
    ["Rare Armor Cache"] = true, ["Baú de Armadura Rara"] = true,
    ["Potential Rewards"] = true, ["Recompensas possíveis"] = true,
    ["Active Manastorm Spells"] = true, ["Feitiços Ativos da Tormenta de Mana"] = true,
    ["Prestigious Cache"] = true, ["Baú Prestigioso"] = true,
    ["Bloodforged Gear"] = true, ["Equipamento Forjado em Sangue"] = true,
    ["Arena Rating"] = true, ["Índice de Arena"] = true,
    ["Glory Points"] = true, ["Pontos de Glória"] = true,
}

local function MarkerScore(text)
    if type(text) ~= "string" or text == "" then return 0 end
    if STRONG_MARKERS[text] then return 4 end
    if MEDIUM_MARKERS[text] then return 3 end

    if text:match("^Unlocks at [Ll]evel %d+$") or text:match("^Desbloqueia no nível %d+$") then return 2 end
    if text:match("^World Boss:") or text:match("^Chefe Mundial:") then return 3 end
    if text:match("^Mythic%+ Dungeons %d+$") or text:match("^Masmorras Míticas%+ %d+$") then return 3 end
    if text:match("^Raid Trial %d+$") or text:match("^Prova de Raide %d+$") then return 3 end

    local affixType = text:match("%((.-) Affix%)$")
    if affixType == "Creature" or affixType == "Boss" or affixType == "Player" or affixType == "Environmental" or affixType == "Champion" then return 2 end
    if text:match("%(Mythic %d+%+?%)$") then return 1 end
    return 0
end

local function TranslateText(text)
    if not Enabled() or type(text) ~= "string" or text == "" then return nil end
    if A.TranslateEndgameText then
        local ok, value = pcall(A.TranslateEndgameText, text)
        if ok and type(value) == "string" and value ~= "" and value ~= text then return value end
    end
    if A.TranslateStaticText then
        local ok, value = pcall(A.TranslateStaticText, text)
        if ok and type(value) == "string" and value ~= "" and value ~= text then return value end
    end
end

local function TranslateObject(obj)
    if not Enabled() or not (obj and obj.GetText and obj.SetText) or busy[obj] then return 0 end
    if obj.IsObjectType then
        local okEdit, isEdit = pcall(obj.IsObjectType, obj, "EditBox")
        if okEdit and isEdit then return 0 end
    end
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
        pcall(hooksecurefunc, obj, "SetText", function(self) TranslateObject(self) end)
        if obj.SetFormattedText then
            pcall(hooksecurefunc, obj, "SetFormattedText", function(self) TranslateObject(self) end)
        end
    end
    TranslateObject(obj)
end

local RefreshRoot

local function HookWidget(widget, root)
    if not (widget and widget.HookScript) or widgetHooked[widget] then return end
    local objectType = widget.GetObjectType and widget:GetObjectType()
    if objectType ~= "Button" and objectType ~= "ScrollFrame" and objectType ~= "Slider" then return end
    widgetHooked[widget] = true
    if objectType == "Button" then
        pcall(widget.HookScript, widget, "OnClick", function() After("aptbr-endgame-click", 0.03, function() RefreshRoot(root) end) end)
    elseif objectType == "ScrollFrame" then
        pcall(widget.HookScript, widget, "OnVerticalScroll", function() After("aptbr-endgame-scroll", 0.04, function() RefreshRoot(root) end) end)
    elseif objectType == "Slider" then
        pcall(widget.HookScript, widget, "OnValueChanged", function() After("aptbr-endgame-slider", 0.04, function() RefreshRoot(root) end) end)
    end
end

local function Walk(root, maxNodes, translate)
    if not root then return 0, 0, 0 end
    local queue, head, visited, changed, score = { root }, 1, 0, 0, 0
    local seenObjects = {}
    local limit = maxNodes or 700

    local function VisitText(obj)
        if not obj or seenObjects[obj] then return end
        seenObjects[obj] = true
        local before = ReadText(obj)
        if before then score = score + MarkerScore(before) end
        if translate then
            HookText(obj)
            local after = ReadText(obj)
            if before and after and before ~= after then changed = changed + 1 end
        end
    end

    while queue[head] and visited < limit do
        local node = queue[head]
        head = head + 1
        visited = visited + 1

        VisitText(node)
        if translate then HookWidget(node, root) end

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
    return changed, score, visited
end

local function Probe(root, maxNodes)
    local _, score = Walk(root, maxNodes or 320, false)
    return score or 0
end

local ENDGAME_NAME_MARKERS = {
    "mythic", "embercourt", "ember_court", "manastorm",
    "dungeonfinder", "dungeon_finder", "lfdparent", "pveframe",
    "prestige", "raidtrial", "raid_trial", "callboard", "call_board",
    "mysticenchant", "mystic_enchant", "worldboss", "world_boss",
    "highrisk", "high_risk", "riskmode", "risk_mode",
    "worldevent", "world_event", "gloryframe", "glory_frame",
    "arenaframe", "arena_frame", "pvpframe", "pvp_frame",
    "battlegroundframe", "battleground_frame",
}

local function NameLooksEndgame(name)
    if type(name) ~= "string" or name == "" then return false end
    local lower = name:lower()
    for i = 1, #ENDGAME_NAME_MARKERS do
        if lower:find(ENDGAME_NAME_MARKERS[i], 1, true) then return true end
    end
    return false
end

local function CandidateName(root)
    if not root then return false end
    local name = root.GetName and root:GetName()
    return NameLooksEndgame(name)
end

local function IsEndgameRoot(root)
    if not root then return false end
    if CandidateName(root) then return true end
    return Probe(root, 360) >= 3
end

RefreshRoot = function(root)
    if not Enabled() or not root or not Visible(root) then return 0 end
    local changed = Walk(root, 850, true)
    return changed or 0
end

local function HookRoot(root)
    if not root then return false end
    roots[root] = true
    if rootHooked[root] then return true end
    rootHooked[root] = true
    if root.HookScript then
        pcall(root.HookScript, root, "OnShow", function(self)
            if not Enabled() then return end
            After("aptbr-endgame-show", 0, function() RefreshRoot(self) end)
            After("aptbr-endgame-populate", 0.08, function() RefreshRoot(self) end)
            After("aptbr-endgame-late", 0.20, function() RefreshRoot(self) end)
        end)
    end
    return true
end

local KNOWN_ROOTS = {
    -- Mítico+ / progressão
    "MythicPlusFrame", "MythicDungeonsFrame", "MythicDungeonFrame", "MythicFrame",
    "AscensionMythicPlusFrame", "AscensionMythicDungeonFrame", "MythicKeystoneFrame",
    "MythicDungeonUI", "MythicPlusWindow", "MythicDungeonWindow",
    "EmberCourtFrame", "AscensionEmberCourtFrame", "EmberCourtWindow",
    "AscensionEmberCourtWindow", "EmberCourtUI",

    -- Localizador / Tormenta de Mana
    "PVEFrame", "LFDParentFrame", "LFDQueueFrame", "DungeonFinderFrame",
    "AscensionDungeonFinderFrame", "ManastormFrame", "TheManastormFrame",
    "AscensionManastormFrame", "ManastormWindow", "ManastormUI",

    -- Outros sistemas endgame
    "PrestigeFrame", "AscensionPrestigeFrame", "PrestigeWindow",
    "RaidTrialFrame", "RaidTrialsFrame", "AscensionRaidTrialFrame", "RaidTrialUI",
    "CallBoardFrame", "CallboardFrame", "AscensionCallBoardFrame",
    "MysticEnchantFrame", "MysticEnchantingFrame", "AscensionMysticEnchantFrame",
    "WorldBossFrame", "WorldBossUI", "AscensionWorldBossFrame",
    "WorldEventFrame", "WorldEventsFrame", "AscensionWorldEventFrame",
    "GloryFrame", "GlorySystemFrame", "AscensionGloryFrame",
    "HighRiskFrame", "RiskModeFrame", "PvPRulesetFrame",

    -- Arena / progressão JxJ
    "PVPFrame", "PVPParentFrame", "ArenaFrame", "ArenaQueueFrame",
    "AscensionArenaFrame", "ArenaWindow", "BattlegroundFrame",
}

local function HookKnownRoots()
    for i = 1, #KNOWN_ROOTS do
        local root = _G[KNOWN_ROOTS[i]]
        if root then HookRoot(root) end
    end

end

local function DiscoverFrames()
    HookKnownRoots()
    local found = 0
    for _ in pairs(roots) do found = found + 1 end
    return found
end

local function RefreshAll()
    if not Enabled() then return 0 end
    HookKnownRoots()
    local changed = 0
    for root in pairs(roots) do
        if Visible(root) and IsEndgameRoot(root) then
            changed = changed + (RefreshRoot(root) or 0)
        end
    end
    return changed
end
A.RefreshEndgameUI = RefreshAll

local function HandlePanel(frame)
    if not Enabled() or not frame then return end
    if CandidateName(frame) or Probe(frame, 260) >= 3 then
        HookRoot(frame)
        RefreshRoot(frame)
        After("aptbr-endgame-panel", 0.08, function() RefreshRoot(frame) end)
    end
end

local function InstallHooks()
    if not hooksecurefunc then return end
    if not togglesHooked.ShowUIPanel and type(_G.ShowUIPanel) == "function" then
        if pcall(hooksecurefunc, "ShowUIPanel", function(frame) HandlePanel(frame) end) then togglesHooked.ShowUIPanel = true end
    end
    if not togglesHooked.ToggleFrame and type(_G.ToggleFrame) == "function" then
        if pcall(hooksecurefunc, "ToggleFrame", function(frame) HandlePanel(frame) end) then togglesHooked.ToggleFrame = true end
    end

    local names = {
        "ToggleMythicPlusFrame", "MythicPlusFrame_Toggle", "ToggleMythicDungeonFrame",
        "AscensionMythicPlus_Toggle", "ToggleEmberCourtFrame", "EmberCourtFrame_Toggle",
        "AscensionEmberCourt_Toggle",
        "PVEFrame_ToggleFrame", "ToggleLFDParentFrame", "LFDParentFrame_Toggle",
        "ToggleDungeonFinder", "DungeonFinder_Toggle",
        "ToggleManastormFrame", "ManastormFrame_Toggle", "AscensionManastorm_Toggle",
        "TogglePrestigeFrame", "PrestigeFrame_Toggle",
        "ToggleRaidTrialFrame", "RaidTrialFrame_Toggle", "ToggleRaidTrialsFrame",
        "ToggleCallBoardFrame", "CallBoardFrame_Toggle",
        "ToggleMysticEnchantFrame", "MysticEnchantFrame_Toggle",
        "ToggleWorldBossFrame", "WorldBossFrame_Toggle",
        "ToggleWorldEventFrame", "WorldEventFrame_Toggle",
        "ToggleGloryFrame", "GloryFrame_Toggle",
        "ToggleRiskModeFrame", "RiskModeFrame_Toggle",
        "PVPFrame_ToggleFrame", "TogglePVPFrame", "ToggleArenaFrame",
        "ArenaFrame_Toggle", "ToggleArenaQueueFrame",
    }
    for i = 1, #names do
        local name = names[i]
        if not togglesHooked[name] and type(_G[name]) == "function" then
            if pcall(hooksecurefunc, name, function()
                After("aptbr-endgame-toggle", 0.03, RefreshAll)
                After("aptbr-endgame-toggle-late", 0.12, RefreshAll)
            end) then togglesHooked[name] = true end
        end
    end
end

local ev = CreateFrame("Frame")
ev:RegisterEvent("PLAYER_ENTERING_WORLD")
ev:RegisterEvent("ADDON_LOADED")
ev:SetScript("OnEvent", function(_, event, addonName)
    InstallHooks()
    if event == "PLAYER_ENTERING_WORLD" then
        HookKnownRoots()
        After("aptbr-endgame-discover", 1.0, DiscoverFrames)
    else
        HookKnownRoots()
        if type(addonName) == "string" and NameLooksEndgame(addonName) then
            HookKnownRoots()
        end
    end
end)

InstallHooks()
HookKnownRoots()

SLASH_APTBRENDGAME1 = "/aptbrendgame"
SlashCmdList["APTBRENDGAME"] = function()
    local found = DiscoverFrames()
    local changed = RefreshAll()
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage(string.format(
            "|cff33ff99AscensionPTBR|r Endgame: telas=%d textos=%d",
            tonumber(found) or 0, tonumber(changed) or 0))
    end
end
