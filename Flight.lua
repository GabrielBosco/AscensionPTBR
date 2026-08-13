-- Tradução leve do mapa de voo. O nome do destino vem da API de táxi em inglês,
-- então traduzimos só o texto exibido pelos botões/tooltip e deixamos a API intacta.

local AES = AscensionPTBR or {}
AscensionPTBR = AES

local cache = {}
local hookedButtons = setmetatable({}, { __mode = "k" })
local hookedRoots = setmetatable({}, { __mode = "k" })
local inTextHook = false

-- Alguns TaxiNodes usam nomes mais curtos que os nomes de área do cliente.
local aliases = {
    ["Stormwind"] = "Ventobravo",
    ["Elwynn"] = "Floresta de Elwynn",
    ["Shattrath"] = "Shattrath",
    ["Silvermoon"] = "Luaprata",
    ["The Exodar"] = "Exodar",
}

local suffixes = {
    " City", " Forest", " Mountains", " Highlands", " Tundra",
}

local function Enabled()
    return not AscensionPTBRDB or AscensionPTBRDB.ui ~= false
end

local function Trim(text)
    return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function TranslatePart(text)
    if type(text) ~= "string" or text == "" then return nil end

    local translated = aliases[text]
        or (AES.AreaNames and AES.AreaNames[text])
    if translated then return translated end

    -- Ex.: "Stormwind" -> "Stormwind City", "Elwynn" -> "Elwynn Forest".
    if AES.AreaNames then
        for i = 1, #suffixes do
            translated = AES.AreaNames[text .. suffixes[i]]
            if translated then return translated end
        end
    end

    -- Pontos custom do Ascension às vezes já existem em outras tabelas da interface.
    -- Só usa mapa exato; não tenta traduzir palavra por palavra em runtime.
    if AES.TranslateStaticText then
        translated = AES.TranslateStaticText(text)
        if translated and translated ~= text then return translated end
    end
    return nil
end

local function TranslateTaxiText(text)
    if type(text) ~= "string" or text == "" then return nil end

    local cached = cache[text]
    if cached ~= nil then return cached ~= false and cached or nil end

    local translated = AES.TranslateAreaText and AES.TranslateAreaText(text)
    if translated and translated ~= text then
        cache[text] = translated
        return translated
    end

    translated = TranslatePart(text)
    if translated and translated ~= text then
        cache[text] = translated
        return translated
    end

    -- TaxiNodes normalmente vêm como "Ponto, Zona". Traduzimos cada lado sem
    -- tocar em custo, tipo do nó ou qualquer dado usado para escolher a rota.
    local left, sep, right = text:match("^(.-)(,%s*)(.+)$")
    if not left then
        left, sep, right = text:match("^(.-)(%s+%-%s+)(.+)$")
    end
    if not left then
        left, sep, right = text:match("^(.-)(%s+%-%>%s+)(.+)$")
    end

    if left and right then
        local leftRaw, rightRaw = Trim(left), Trim(right)
        local leftPT = TranslatePart(leftRaw) or leftRaw
        local rightPT = TranslatePart(rightRaw) or rightRaw
        if leftPT ~= leftRaw or rightPT ~= rightRaw then
            translated = leftPT .. sep .. rightPT
            cache[text] = translated
            return translated
        end
    end

    cache[text] = false
    return nil
end
AES.TranslateTaxiText = TranslateTaxiText

local function TranslateTooltip()
    if not Enabled() then return end
    local fs = _G.GameTooltipTextLeft1
    local text = fs and fs.GetText and fs:GetText()
    local translated = text and TranslateTaxiText(text)
    if translated and translated ~= text then
        pcall(fs.SetText, fs, translated)
        if GameTooltip and GameTooltip.Show then pcall(GameTooltip.Show, GameTooltip) end
    end
end

local function HookTaxiButton(button)
    if not (button and button.HookScript) or hookedButtons[button] then return end
    hookedButtons[button] = true
    pcall(button.HookScript, button, "OnEnter", TranslateTooltip)
end

local function HookFontString(fs)
    if not (fs and fs.SetText) or hookedButtons[fs] then return end
    hookedButtons[fs] = true

    if fs.GetText then
        local text = fs:GetText()
        local translated = text and TranslateTaxiText(text)
        if translated and translated ~= text then pcall(fs.SetText, fs, translated) end
    end

    pcall(hooksecurefunc, fs, "SetText", function(self)
        if inTextHook or not Enabled() then return end
        local text = self.GetText and self:GetText()
        local translated = text and TranslateTaxiText(text)
        if translated and translated ~= text then
            inTextHook = true
            pcall(self.SetText, self, translated)
            inTextHook = false
        end
    end)
end

local function Walk(root, depth, seen)
    if not root then return end
    depth = depth or 0
    if depth > 8 then return end
    seen = seen or {}
    if seen[root] then return end
    seen[root] = true

    if root.IsObjectType and root:IsObjectType("FontString") then
        HookFontString(root)
        return
    end

    if root.GetRegions then
        local ok, regions = pcall(function() return { root:GetRegions() } end)
        if ok then
            for i = 1, #regions do
                local region = regions[i]
                if region and region.IsObjectType and region:IsObjectType("FontString") then
                    HookFontString(region)
                end
            end
        end
    end

    if root.GetChildren then
        local ok, children = pcall(function() return { root:GetChildren() } end)
        if ok then
            for i = 1, #children do Walk(children[i], depth + 1, seen) end
        end
    end
end

local function ApplyTaxiUI()
    if not Enabled() then return end

    local count = 0
    if type(NumTaxiNodes) == "function" then
        local ok, value = pcall(NumTaxiNodes)
        if ok then count = tonumber(value) or 0 end
    end
    if type(NUM_TAXI_BUTTONS) == "number" and NUM_TAXI_BUTTONS > count then
        count = NUM_TAXI_BUTTONS
    end
    if count < 32 then count = 32 end

    for i = 1, count do
        HookTaxiButton(_G["TaxiButton" .. i])
    end

    for _, name in ipairs({
        "TaxiFrame", "TaxiMap", "FlightMapFrame", "FlightMapCanvas",
        "AscensionTaxiFrame", "AscensionFlightMapFrame",
    }) do
        local root = _G[name]
        if root then
            pcall(Walk, root, 0, {})
            if root.HookScript and not hookedRoots[root] then
                hookedRoots[root] = true
                pcall(root.HookScript, root, "OnShow", function(self)
                    pcall(Walk, self, 0, {})
                end)
            end
        end
    end
end
AES.ApplyTaxiTranslations = ApplyTaxiUI

local eventFrame = CreateFrame("Frame")
for _, event in ipairs({ "PLAYER_LOGIN", "TAXIMAP_OPENED", "ADDON_LOADED" }) do
    pcall(eventFrame.RegisterEvent, eventFrame, event)
end

eventFrame:SetScript("OnEvent", function(_, event, addon)
    if event == "ADDON_LOADED" then
        if type(addon) ~= "string" then return end
        local relevant = addon == "AscensionPTBR"
            or addon == "Blizzard_TaxiUI"
            or addon:find("Ascension", 1, true)
        if not relevant then return end
    end

    pcall(ApplyTaxiUI)
    -- TAXIMAP_OPENED pode chegar antes de todos os botões terminarem o update.
    if AES.Runtime and AES.Runtime.After then
        AES.Runtime.After("flight-map-ptbr", 0.05, ApplyTaxiUI)
    end
end)
