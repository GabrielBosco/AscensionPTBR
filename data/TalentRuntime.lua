
-- Traducao da interface de talentos somente na camada visual.
-- Nao altera C_CharacterAdvancement/C_Ascension nem GlobalStrings usados pela logica do cliente.
local AES = AscensionPTBR or {}
AscensionPTBR = AES

local function TalentEnabled()
    local d = AscensionPTBRDB
    return not d or d.spells ~= false
end

local talentUIFSHooked = setmetatable({}, { __mode = "k" })
local talentUIRootHooked = setmetatable({}, { __mode = "k" })
local inTalentUIHook = false
local talentTextCache = {}
local talentTextCacheCount = 0
local TALENT_TEXT_CACHE_LIMIT = 2048

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

    local cached = talentTextCache[text]
    if cached ~= nil then return cached ~= false and cached or nil end

    local advancementID = text:match("^CharacterAdvancement ID%s+(%d+)$")
    local translated = advancementID and ("ID do Avanço do Personagem " .. advancementID)
        or (AES.TalentUIExact and AES.TalentUIExact[text])
    if not translated or translated == text then
        translated = AES.SpellNameEN2ES and AES.SpellNameEN2ES[text]
    end
    if not translated or translated == text then
        translated = AES.TranslateStaticText and AES.TranslateStaticText(text)
    end
    if not translated or translated == text then
        translated = TranslateTalentDescriptionText(text)
    end
    if translated == text then translated = nil end

    if talentTextCacheCount >= TALENT_TEXT_CACHE_LIMIT then
        talentTextCache = {}
        talentTextCacheCount = 0
    end
    talentTextCache[text] = translated or false
    talentTextCacheCount = talentTextCacheCount + 1
    return translated
end
AES.TranslateTalentUIText = TranslateTalentUIText

local function HookTalentUIFS(fs)
    if not (fs and fs.SetText) or talentUIFSHooked[fs] then return end
    talentUIFSHooked[fs] = true

    local function Refresh(self)
        if inTalentUIHook or not TalentEnabled() then return end
        local text = self.GetText and self:GetText()
        local pt = text and TranslateTalentUIText(text)
        if pt and pt ~= text then
            inTalentUIHook = true
            pcall(self.SetText, self, pt)
            inTalentUIHook = false
        end
    end

    if type(hooksecurefunc) == "function" then
        if fs.SetText then pcall(hooksecurefunc, fs, "SetText", Refresh) end
        if fs.SetFormattedText then pcall(hooksecurefunc, fs, "SetFormattedText", Refresh) end
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
            for _, child in ipairs(children) do
                WalkTalentUI(child, depth + 1, seen)
            end
        end
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

local function RootIsVisible(root)
    if not root then return false end
    if not root.IsShown then return true end
    local ok, shown = pcall(root.IsShown, root)
    return not ok or shown
end

local function TranslateTalentChrome()
    if not TalentEnabled() then return end
    HookTalentRoots()
    local seen = {}
    for _, name in ipairs(TALENT_UI_ROOT_NAMES) do
        local root = _G[name]
        if RootIsVisible(root) then
            pcall(WalkTalentUI, root, 0, seen)
        end
    end
end
AES.TranslateTalentChrome = TranslateTalentChrome

local talentPassTimer
local function DelayedTalentPass()
    TranslateTalentChrome()
    if AES.Runtime and AES.Runtime.Repeat then
        AES.Runtime.Repeat("talent-ui-refresh", 0.05, 0.16, 2, TranslateTalentChrome)
        return
    end

    if not talentPassTimer then talentPassTimer = CreateFrame("Frame") end
    local elapsed, shot = 0, 0
    talentPassTimer:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + (dt or 0)
        local wait = shot == 0 and 0.05 or 0.16
        if elapsed < wait then return end
        elapsed = 0
        shot = shot + 1
        TranslateTalentChrome()
        if shot >= 2 then self:SetScript("OnUpdate", nil) end
    end)
end

local talentEventFrame = CreateFrame("Frame")
for _, event in ipairs({
    "ADDON_LOADED",
    "PLAYER_ENTERING_WORLD",
    "PLAYER_TALENT_UPDATE",
    "CHARACTER_POINTS_CHANGED",
    "ACTIVE_TALENT_GROUP_CHANGED",
    "SPELLS_CHANGED",
    "LEARNED_SPELL_IN_TAB",
}) do
    pcall(talentEventFrame.RegisterEvent, talentEventFrame, event)
end

talentEventFrame:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if type(arg1) ~= "string" then return end
        if AES.Runtime and AES.Runtime.After then
            AES.Runtime.After("talent-ui-addon-loaded", 0.18, DelayedTalentPass)
        else
            DelayedTalentPass()
        end
        return
    end
    DelayedTalentPass()
end)
