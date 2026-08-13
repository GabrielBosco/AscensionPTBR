AscensionPTBR = AscensionPTBR or {}

local A = AscensionPTBR
local G = _G

local function questsEnabled()
    local db = rawget(G, "AscensionPTBRDB")
    return db == nil or db.quests ~= false
end

local function uiEnabled()
    local db = rawget(G, "AscensionPTBRDB")
    return db == nil or db.ui ~= false
end

local function renderQuest(text)
    if type(text) ~= "string" or text == "" then return text end
    if A.QuestRenderPT then
        local ok, value = pcall(A.QuestRenderPT, text)
        if ok and type(value) == "string" then return value end
    end
    local out = text:gsub("\\n", "\n")
    out = out:gsub("|n", "\n")
    return out
end

local function exactMapText(text)
    if type(text) ~= "string" or text == "" then return nil end

    local value = (A.AreaNames and A.AreaNames[text])
        or (A.MapLabels and A.MapLabels[text])
        or (A.ChatExact and A.ChatExact[text])
        or (A.ServerUI and A.ServerUI[text])
        or (A.CustomUI and A.CustomUI[text])
        or (A.UIStringsByEN and A.UIStringsByEN[text])
        or (A.UnitSubEN2PT and A.UnitSubEN2PT[text])
    if value and value ~= false and value ~= text then return value end
    return nil
end

local function translateMapText(text)
    if type(text) ~= "string" or text == "" then return nil end

    local direct = exactMapText(text)
    if direct then return direct end

    local color, inner, reset = text:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
    if inner then
        local translated = exactMapText(inner)
        if translated then return color .. translated .. reset end
    end

    local area, levels = text:match("^(.-)(%s+%(%d+[%d%s%-–—]*%))$")
    if area then
        local translated = exactMapText(area)
        if translated then return translated .. levels end
    end

    local first, rest = text:match("^([^\n]+)(\n.+)$")
    if first then
        local translated = exactMapText(first)
        if translated then return translated .. rest end
    end

    -- Descrições de POI às vezes já existem nas tabelas gerais da interface.
    if A.TranslateStaticText then
        local ok, translated = pcall(A.TranslateStaticText, text)
        if ok and type(translated) == "string" and translated ~= text then
            return translated
        end
    end

    return nil
end
A.TranslateMapText = translateMapText

local function setTranslated(fs)
    if not (fs and fs.GetText and fs.SetText) then return false end
    local ok, shown = pcall(fs.GetText, fs)
    if not ok or type(shown) ~= "string" or shown == "" then return false end
    local translated = translateMapText(shown)
    if translated and translated ~= shown then
        pcall(fs.SetText, fs, translated)
        return true
    end
    return false
end

local MAP_FONTSTRINGS = {
    "WorldMapFrameAreaLabel", "WorldMapFrameAreaDescription",
    "WorldMapFrameTitleText", "WorldMapZoneInfo", "WorldMapZoneText",
    "WorldMapZoneDropDownText", "WorldMapContinentDropDownText",
    "WorldMapLevelDropDownText", "WorldMapZoneMinimapDropDownText",
    "QuestMapFrameTitleText", "AscensionMapZoneText", "AscensionWorldMapZoneText",
}

local function patchKnownMapText()
    if not uiEnabled() then return end
    for i = 1, #MAP_FONTSTRINGS do
        setTranslated(G[MAP_FONTSTRINGS[i]])
    end
end

local function patchClassicPOIs()
    if not uiEnabled() then return end
    local count = tonumber(rawget(G, "NUM_WORLDMAP_POIS")) or 0
    if count <= 0 then count = 128 end
    for i = 1, count do
        local poi = G["WorldMapFramePOI" .. i]
        if poi then
            if type(poi.name) == "string" then
                local translated = translateMapText(poi.name)
                if translated then poi.name = translated end
            end
            if type(poi.description) == "string" then
                local translated = translateMapText(poi.description)
                if translated then poi.description = translated end
            end
        elseif i > 32 and count == 128 then
            break
        end
    end

    local map = G.WorldMapFrame
    if map and type(map.areaName) == "string" then
        local translated = translateMapText(map.areaName)
        if translated then map.areaName = translated end
    end
    patchKnownMapText()
end

local function patchDropdownButtons()
    if not uiEnabled() then return end
    for level = 1, 2 do
        for i = 1, 64 do
            local button = G["DropDownList" .. level .. "Button" .. i]
            if button and button.GetText and button.SetText and (not button.IsShown or button:IsShown()) then
                local ok, shown = pcall(button.GetText, button)
                if ok and type(shown) == "string" and shown ~= "" then
                    local translated = translateMapText(shown)
                    if translated then pcall(button.SetText, button, translated) end
                end
            end
        end
    end
    patchKnownMapText()
end

local function resolveQuestID(questFrame, questLogIndex)
    local id = questFrame and tonumber(questFrame.questId) or nil
    local index = tonumber(questLogIndex) or (questFrame and tonumber(questFrame.questLogIndex)) or nil
    if (not id or id == 0) and index and G.GetQuestLogTitle then
        local ok, _, _, _, _, _, _, _, _, questID = pcall(G.GetQuestLogTitle, index)
        if ok then id = tonumber(questID) end
    end
    if (not id or id == 0) and G.GetQuestLogSelection and G.GetQuestLogTitle then
        local selected = tonumber(G.GetQuestLogSelection())
        if selected and selected > 0 then
            local ok, _, _, _, _, _, _, _, _, questID = pcall(G.GetQuestLogTitle, selected)
            if ok then id = tonumber(questID) end
        end
    end
    return id, index
end

local function setQuestField(name, value)
    local fs = G[name]
    if not (fs and fs.SetText and type(value) == "string" and value ~= "") then return end
    pcall(fs.SetText, fs, renderQuest(value))
end

local function translateObjectiveLines()
    if not (questsEnabled() and A.TranslateQuestUIText) then return end
    local maxObjectives = tonumber(rawget(G, "MAX_OBJECTIVES")) or 20
    for i = 1, maxObjectives do
        local fs = G["QuestInfoObjective" .. i]
        if fs and fs.GetText and fs.SetText and (not fs.IsShown or fs:IsShown()) then
            local ok, shown = pcall(fs.GetText, fs)
            if ok and type(shown) == "string" and shown ~= "" then
                local translated = A.TranslateQuestUIText(shown)
                if translated and translated ~= shown then pcall(fs.SetText, fs, translated) end
            end
        end
    end
end

local function applyQuestToMap(questFrame, questLogIndex)
    if not questsEnabled() then return end
    local id, index = resolveQuestID(questFrame, questLogIndex)
    if not id then return end

    local qd = A.QuestData and A.QuestData[id]
    if not qd then return end

    local title = A.QuestTitle and A.QuestTitle[id]
    if title and G.QuestInfoTitleHeader and G.QuestInfoTitleHeader.GetText then
        local shown = G.QuestInfoTitleHeader:GetText() or ""
        local suffix = shown:match("(%s+%-%s+%b())$") or ""
        pcall(G.QuestInfoTitleHeader.SetText, G.QuestInfoTitleHeader, renderQuest(title) .. suffix)
    end

    setQuestField("QuestInfoObjectivesText", qd.o)
    setQuestField("QuestInfoDescriptionText", qd.d)

    -- A lista à esquerda e o painel à direita passam a usar o mesmo ID da quest.
    if questFrame then
        if questFrame.title and questFrame.title.SetText and title then
            pcall(questFrame.title.SetText, questFrame.title, renderQuest(title))
        end
        if questFrame.objectives and questFrame.objectives.GetText and questFrame.objectives.SetText then
            local shown = questFrame.objectives:GetText()
            local translated = shown and A.TranslateQuestUIText and A.TranslateQuestUIText(shown)
            if translated then pcall(questFrame.objectives.SetText, questFrame.objectives, translated) end
        end
    end

    translateObjectiveLines()
    if A.TranslateQuestInfo then pcall(A.TranslateQuestInfo) end

    -- O mapa do Ascension reaproveita QuestInfo e alguns widgets são atualizados logo depois.
    -- Um único passe curto evita texto antigo sem usar OnUpdate.
    if A.Runtime and A.Runtime.After then
        A.Runtime.After("map-quest-sync-" .. tostring(id), 0.06, function()
            if not questsEnabled() then return end

            -- A seleção do mapa também seleciona a mesma entrada no Quest Log.
            -- Conferir o ID atual evita que um passe atrasado sobrescreva outra quest.
            local selectedId
            if G.GetQuestLogSelection and G.GetQuestLogTitle then
                local selectedIndex = tonumber(G.GetQuestLogSelection())
                if selectedIndex and selectedIndex > 0 then
                    local ok, _, _, _, _, _, _, _, _, questID = pcall(G.GetQuestLogTitle, selectedIndex)
                    if ok then selectedId = tonumber(questID) end
                end
            end
            if selectedId and selectedId ~= id then return end

            local data = A.QuestData and A.QuestData[id]
            if not data then return end
            local questTitle = A.QuestTitle and A.QuestTitle[id]
            if questTitle and G.QuestInfoTitleHeader and G.QuestInfoTitleHeader.GetText then
                local shown = G.QuestInfoTitleHeader:GetText() or ""
                local suffix = shown:match("(%s+%-%s+%b())$") or ""
                pcall(G.QuestInfoTitleHeader.SetText, G.QuestInfoTitleHeader, renderQuest(questTitle) .. suffix)
            end
            setQuestField("QuestInfoObjectivesText", data.o)
            setQuestField("QuestInfoDescriptionText", data.d)
            translateObjectiveLines()
        end)
    end
end
A.ApplyQuestToWorldMap = applyQuestToMap

local function patchQuestList()
    if not questsEnabled() then return end
    local missing = 0
    for i = 1, 128 do
        local frame = G["WorldMapQuestFrame" .. i]
        if not frame then
            missing = missing + 1
            if i > 32 and missing > 8 then break end
        else
            missing = 0
            local id = tonumber(frame.questId)
            local title = id and A.QuestTitle and A.QuestTitle[id]
            if title and frame.title and frame.title.SetText then
                pcall(frame.title.SetText, frame.title, renderQuest(title))
            end
            if frame.objectives and frame.objectives.GetText and frame.objectives.SetText and A.TranslateQuestUIText then
                local ok, shown = pcall(frame.objectives.GetText, frame.objectives)
                if ok and type(shown) == "string" and shown ~= "" then
                    local translated = A.TranslateQuestUIText(shown)
                    if translated then pcall(frame.objectives.SetText, frame.objectives, translated) end
                end
            end
        end
    end

    local selected = G.WORLDMAP_SETTINGS and G.WORLDMAP_SETTINGS.selectedQuest
    if selected then applyQuestToMap(selected, selected.questLogIndex) end
end

-- Alguns POIs do Ascension usam pins próprios, não os WorldMapFramePOI clássicos.
-- Este passe só olha FontStrings enquanto o mapa está aberto e só troca textos que
-- existem nas tabelas específicas de mapa/zona. Não toca em quests nem em tooltips
-- fora do World Map.
local function translateExactMapFontString(fs)
    if not (fs and fs.GetText and fs.SetText) then return false end
    local ok, shown = pcall(fs.GetText, fs)
    if not ok or type(shown) ~= "string" or shown == "" then return false end

    local translated = exactMapText(shown)
    if not translated then
        local color, inner, reset = shown:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
        if inner then
            local innerTranslated = exactMapText(inner)
            if innerTranslated then translated = color .. innerTranslated .. reset end
        end
    end
    if translated and translated ~= shown then
        pcall(fs.SetText, fs, translated)
        return true
    end
    return false
end

local function patchMapFrameLabels()
    if not uiEnabled() then return end
    local root = G.WorldMapFrame
    if not (root and root.IsShown and root:IsShown()) then return end

    local queue, head, visited = { root }, 1, 0
    while queue[head] and visited < 900 do
        local frame = queue[head]
        head = head + 1
        visited = visited + 1

        if frame.GetRegions then
            local regions = { frame:GetRegions() }
            for i = 1, #regions do
                local region = regions[i]
                if region and region.GetObjectType and region:GetObjectType() == "FontString" then
                    translateExactMapFontString(region)
                end
            end
        end
        if frame.GetChildren then
            local children = { frame:GetChildren() }
            for i = 1, #children do
                queue[#queue + 1] = children[i]
            end
        end
    end
end

local function patchMapTooltipText()
    if not uiEnabled() then return end
    local map = G.WorldMapFrame
    if not (map and map.IsShown and map:IsShown()) then return end

    for _, prefix in ipairs({ "WorldMapTooltipTextLeft", "WorldMapTooltipTextRight", "GameTooltipTextLeft", "GameTooltipTextRight" }) do
        for i = 1, 20 do
            setTranslated(G[prefix .. i])
        end
    end
end

local function scheduleMapTooltipPatch()
    patchMapTooltipText()
    if A.Runtime and A.Runtime.After then
        A.Runtime.After("map-tooltip-ptbr", 0.02, patchMapTooltipText)
    end
end

local function hook(name, fn)
    if type(G.hooksecurefunc) == "function" and type(G[name]) == "function" then
        pcall(G.hooksecurefunc, name, fn)
        return true
    end
    return false
end

-- Só pós-processa o mapa já criado pelo cliente. Nenhuma API de mapa é sobrescrita.
hook("WorldMapFrame_Update", function()
    patchClassicPOIs()
    patchQuestList()
    patchMapFrameLabels()
end)
hook("WorldMapFrame_UpdateMap", function()
    patchClassicPOIs()
    patchQuestList()
    patchMapFrameLabels()
end)
hook("WorldMapPOI_OnEnter", function()
    patchKnownMapText()
    scheduleMapTooltipPatch()
end)
hook("WorldMapPOI_OnLeave", function()
    patchKnownMapText()
end)
hook("WorldMapFrame_SelectQuestFrame", function(questFrame)
    applyQuestToMap(questFrame, questFrame and questFrame.questLogIndex)
end)

-- O painel do mapa usa o mesmo QuestInfo.lua do diário. Esses hooks garantem que,
-- mesmo quando o Ascension redesenha a descrição depois do clique, o ID da quest
-- continue sendo a fonte da tradução exibida.
local function syncVisibleMapQuestInfo()
    if not (G.WorldMapFrame and G.WorldMapFrame.IsShown and G.WorldMapFrame:IsShown()) then return end
    local index = G.GetQuestLogSelection and tonumber(G.GetQuestLogSelection()) or nil
    if index and index > 0 then applyQuestToMap(nil, index) end
end
hook("QuestInfo_Display", syncVisibleMapQuestInfo)
hook("QuestInfo_ShowDescriptionText", syncVisibleMapQuestInfo)

hook("WorldMapFrame_DisplayQuests", patchQuestList)
hook("WorldMapFrame_UpdateQuests", patchQuestList)

for _, name in ipairs({
    "WorldMapZoneDropDown_Update", "WorldMapContinentsDropDown_Update",
    "WorldMapLevelDropDown_Update", "WorldMapZoneMinimapDropDown_Update",
    "WorldMapZoneDropDown_Initialize", "WorldMapContinentsDropDown_Initialize",
    "WorldMapLevelDropDown_Initialize", "WorldMapZoneMinimapDropDown_Initialize",
}) do
    hook(name, patchDropdownButtons)
end

if G.WorldMapTooltip and G.WorldMapTooltip.HookScript then
    pcall(G.WorldMapTooltip.HookScript, G.WorldMapTooltip, "OnShow", scheduleMapTooltipPatch)
end
if G.GameTooltip and G.GameTooltip.HookScript then
    pcall(G.GameTooltip.HookScript, G.GameTooltip, "OnShow", function()
        if G.WorldMapFrame and G.WorldMapFrame.IsShown and G.WorldMapFrame:IsShown() then
            scheduleMapTooltipPatch()
        end
    end)
end

local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("QUEST_LOG_UPDATE")
pcall(events.RegisterEvent, events, "WORLD_MAP_UPDATE")
events:SetScript("OnEvent", function(_, event)
    if event == "QUEST_LOG_UPDATE" then
        if G.WorldMapFrame and G.WorldMapFrame.IsShown and G.WorldMapFrame:IsShown() then
            patchQuestList()
        end
        return
    end
    if A.Runtime and A.Runtime.After then
        A.Runtime.After("map-ptbr-refresh", 0.05, function()
            patchClassicPOIs()
            patchQuestList()
            patchKnownMapText()
            patchMapFrameLabels()
        end)
    else
        patchClassicPOIs()
        patchQuestList()
        patchKnownMapText()
        patchMapFrameLabels()
    end
end)
