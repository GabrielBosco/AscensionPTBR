local AES = AscensionPTBR or {}
AscensionPTBR = AES

local function TalentEnabled()
    local d = AscensionPTBRDB
    return not d or d.spells ~= false
end

-- Camada dedicada às árvores de classe, especialização e raça do CoA.
-- O painel do Ascension redesenha nomes e descrições depois de aberto; por
-- isso cada FontString relevante é traduzido no SetText e SetFormattedText.
local talentUIFSHooked = setmetatable({}, { __mode = "k" })
local talentUIRootHooked = setmetatable({}, { __mode = "k" })
local inTalentUIHook = false

local TALENT_UI_ROOT_NAMES = {
    "CharacterAdvancement", "CharacterAdvancementFrame",
    "AscensionCharacterAdvancement", "AscensionCharacterAdvancementFrame",
    "ClassTalentFrame", "PlayerTalentFrame", "TalentFrame",
    "RaceTalentFrame", "RacialTalentFrame", "AscensionRaceTalentFrame",
    "SpecializationFrame", "AscensionSpecializationFrame",
    "MentorFrame", "MentorSpecializationFrame", "AscensionMentorFrame",
    "ConquestCharacterFrame", "CoACharacterFrame", "HeroClassFrame",
    "SkillCardsFrame", "PathToAscensionFrame",
}

local function TranslateTalentDescriptionText(text)
    return AES.TranslateDescriptionString and AES.TranslateDescriptionString(text) or nil
end

local function TranslateTalentUIText(text)
    if not TalentEnabled() or type(text) ~= "string" or text == "" then return nil end
    local exact = AES.TalentUIExact and AES.TalentUIExact[text]
    if exact and exact ~= text then return exact end
    local spell = AES.SpellNameEN2ES and AES.SpellNameEN2ES[text]
    if spell and spell ~= text then return spell end
    local static = AES.TranslateStaticText and AES.TranslateStaticText(text)
    if static and static ~= text then return static end
    return TranslateTalentDescriptionText(text)
end
AES.TranslateTalentUIText = TranslateTalentUIText

local function HookTalentUIFS(fs)
    if not (fs and fs.SetText) or talentUIFSHooked[fs] then return end
    talentUIFSHooked[fs] = true
    for _, method in ipairs({ "SetText", "SetFormattedText" }) do
        if fs[method] then
            pcall(hooksecurefunc, fs, method, function(self)
                if inTalentUIHook or not TalentEnabled() then return end
                local text = self.GetText and self:GetText()
                local pt = text and TranslateTalentUIText(text)
                if pt and pt ~= text then
                    inTalentUIHook = true
                    pcall(self.SetText, self, pt)
                    inTalentUIHook = false
                end
            end)
        end
    end
end

local function WalkTalentUI(root, depth, seen)
    if not root then return end
    depth = depth or 0
    if depth > 12 then return end
    seen = seen or {}
    if seen[root] then return end
    seen[root] = true

    if root.GetRegions then
        local ok, regions = pcall(function() return { root:GetRegions() } end)
        if ok then
            for _, region in ipairs(regions) do
                if region and region.IsObjectType and region:IsObjectType("FontString") then
                    HookTalentUIFS(region)
                    local text = region.GetText and region:GetText()
                    local pt = text and TranslateTalentUIText(text)
                    if pt and pt ~= text then pcall(region.SetText, region, pt) end
                end
            end
        end
    end
    if root.GetChildren then
        local ok, children = pcall(function() return { root:GetChildren() } end)
        if ok then
            for _, child in ipairs(children) do WalkTalentUI(child, depth + 1, seen) end
        end
    end
end

local function ApplyTalentGlobalStrings()
    for name, translated in pairs(AES.TalentUIGlobals or {}) do
        if type(rawget(_G, name)) == "string" then rawset(_G, name, translated) end
    end
end

local function HookTalentRoots()
    for _, name in ipairs(TALENT_UI_ROOT_NAMES) do
        local root = _G[name]
        if root and root.HookScript and not talentUIRootHooked[root] then
            talentUIRootHooked[root] = true
            local hookedRoot = root
            hookedRoot:HookScript("OnShow", function()
                if TalentEnabled() then pcall(WalkTalentUI, hookedRoot, 0, {}) end
            end)
        end
    end
end

local talentPassTimer
local function TranslateTalentChrome()
    if not TalentEnabled() then return end
    ApplyTalentGlobalStrings()
    HookTalentRoots()
    local seen = {}
    for _, name in ipairs(TALENT_UI_ROOT_NAMES) do
        local root = _G[name]
        if root then pcall(WalkTalentUI, root, 0, seen) end
    end
end
AES.TranslateTalentChrome = TranslateTalentChrome

local function DelayedTalentPass()
    TranslateTalentChrome()
    if not talentPassTimer then talentPassTimer = CreateFrame("Frame") end
    local elapsed, shot = 0, 0
    talentPassTimer:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + (dt or 0)
        local wait = shot == 0 and 0.03 or 0.12
        if elapsed < wait then return end
        elapsed = 0
        shot = shot + 1
        TranslateTalentChrome()
        if shot >= 2 then self:SetScript("OnUpdate", nil) end
    end)
end

local HookTalentAPIs

local talentEventFrame = CreateFrame("Frame")
for _, event in ipairs({ "ADDON_LOADED", "PLAYER_ENTERING_WORLD", "PLAYER_TALENT_UPDATE",
                          "CHARACTER_POINTS_CHANGED", "ACTIVE_TALENT_GROUP_CHANGED",
                          "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB" }) do
    pcall(talentEventFrame.RegisterEvent, talentEventFrame, event)
end
talentEventFrame:SetScript("OnEvent", function()
    HookTalentAPIs()
    DelayedTalentPass()
end)

-- APIs usadas por diferentes versões do painel customizado do Ascension.
-- Somente valores de texto retornados são alterados; IDs, números e tabelas
-- permanecem exatamente como o servidor os forneceu.
local talentAPIWrapped = setmetatable({}, { __mode = "k" })
local function PackTalentResults(...)
    return { n = select("#", ...), ... }
end
local function WrapTalentStringAPI(api, names)
    if type(api) ~= "table" then return end
    for _, fname in ipairs(names) do
        local wrapped = talentAPIWrapped[api]
        if not wrapped then wrapped = {}; talentAPIWrapped[api] = wrapped end
        local orig = api[fname]
        if type(orig) == "function" and not wrapped[fname] then
            wrapped[fname] = true
            local ok = pcall(function()
                api[fname] = function(...)
                    local values = PackTalentResults(orig(...))
                    for i = 1, values.n do
                        if type(values[i]) == "string" then
                            values[i] = TranslateTalentUIText(values[i]) or values[i]
                        end
                    end
                    return unpack(values, 1, values.n)
                end
            end)
            if not ok then wrapped[fname] = nil end
        end
    end
end
HookTalentAPIs = function()
    WrapTalentStringAPI(_G.C_CharacterAdvancement, {
        "GetEntryInfo", "GetTalentInfo", "GetTreeInfo", "GetClassInfo",
        "GetRaceInfo", "GetRacialInfo", "GetSpecializationInfo", "GetArchetypeInfo",
    })
    WrapTalentStringAPI(_G.C_Ascension, {
        "GetTalentInfo", "GetClassTalentInfo", "GetRacialTalentInfo",
        "GetSpecializationInfo", "GetMentorSpecializationInfo",
    })
end
AES.HookTalentAPIs = HookTalentAPIs
HookTalentAPIs()
