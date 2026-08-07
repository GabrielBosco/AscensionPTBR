local ADDON_NAME = ...
local AES = AscensionPTBR or {}

if not InterfaceOptions_AddCategory then return end

local DEFAULTS = {
    spells = true, items = true, flavor = true, units = true,
    quests = true, gossip = true, achievements = true,
    patterns = true, ui = true, chat = true, errores = true,
    voice = true, updateCheck = true,
}

local OPTIONS = {
    {
        title = "Conteúdo traduzido",
        items = {
            { "spells", "Feitiços, talentos e auras", "Traduz nomes, descrições e dicas de feitiços." },
            { "items", "Itens e equipamentos", "Traduz nomes, atributos e efeitos dos itens." },
            { "flavor", "Textos de ambientação", "Traduz as citações amarelas dos itens." },
            { "units", "NPCs e criaturas", "Traduz nomes conhecidos sem alterar nomes de jogadores." },
            { "quests", "Missões", "Traduz títulos, objetivos, descrições, progresso e conclusão." },
            { "gossip", "Diálogos de NPCs", "Traduz conversas, saudações e balões." },
            { "achievements", "Conquistas", "Traduz títulos, descrições e recompensas." },
        },
    },
    {
        title = "Interface e sistema",
        items = {
            { "patterns", "Tooltips dinâmicos", "Traduz custos, alcance, atributos e efeitos variáveis." },
            { "ui", "Interface e menus", "Algumas alterações exigem /reload." },
            { "chat", "Mensagens do chat", "Traduz saque, experiência e mensagens do sistema." },
            { "errores", "Mensagens de erro", "Traduz os avisos exibidos no centro da tela." },
            { "voice", "Vozes de erro em ptBR", "Substitui as falas de erro originais pelas vozes ptBR." },
            { "updateCheck", "Detectar novas versões", "Consulta versões anunciadas por membros do grupo e da guilda." },
        },
    },
}

local function DB()
    AscensionPTBRDB = AscensionPTBRDB or {}
    return AscensionPTBRDB
end

local function ApplySetting(key, enabled)
    local db = DB()
    db[key] = enabled and true or false
    if key == "chat" and AES.SetChatEnabled then
        AES.SetChatEnabled(enabled)
    elseif key == "errores" and AES.SetErrorsEnabled then
        AES.SetErrorsEnabled(enabled)
    elseif key == "voice" and AES.SetVoiceEnabled then
        AES.SetVoiceEnabled(enabled)
    end
end

local function ApplyDefaults(enabled)
    for key in pairs(DEFAULTS) do
        ApplySetting(key, enabled == nil and DEFAULTS[key] or enabled)
    end
end

local panel = CreateFrame("Frame", "AscensionPTBROptionsPanel", UIParent)
panel.name = "AscensionPTBR"

local bg = panel:CreateTexture(nil, "BACKGROUND")
bg:SetPoint("TOPLEFT", 8, -8)
bg:SetPoint("BOTTOMRIGHT", -8, 8)
bg:SetTexture(0.025, 0.035, 0.03, 0.72)

local accent = panel:CreateTexture(nil, "ARTWORK")
accent:SetPoint("TOPLEFT", 14, -14)
accent:SetWidth(5)
accent:SetHeight(54)
accent:SetTexture(0.20, 1.00, 0.60, 0.9)

local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", accent, "TOPRIGHT", 10, -2)
title:SetText("AscensionPTBR")
title:SetTextColor(0.20, 1.00, 0.60)

local subtitle = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
subtitle:SetText("Personalize o que será exibido em Português do Brasil.")
subtitle:SetTextColor(0.82, 0.82, 0.82)

local version = panel:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
version:SetPoint("TOPRIGHT", -20, -22)
version:SetText("Versão " .. ((GetAddOnMetadata and GetAddOnMetadata(ADDON_NAME or "AscensionPTBR", "Version")) or ""))

local checks = {}

local function CreateSection(section, column)
    local x = column == 1 and 26 or 338
    local header = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    header:SetPoint("TOPLEFT", x, -92)
    header:SetText(section.title)
    header:SetTextColor(1.00, 0.82, 0.00)

    local previous
    for index, info in ipairs(section.items) do
        local key, label, help = info[1], info[2], info[3]
        local name = "AscensionPTBROption_" .. key
        local check = CreateFrame("CheckButton", name, panel, "InterfaceOptionsCheckButtonTemplate")
        check:SetPoint("TOPLEFT", previous or header, previous and "BOTTOMLEFT" or "TOPLEFT", previous and 0 or -4, previous and -5 or -20)
        local text = _G[name .. "Text"]
        if text then
            text:SetText(label)
            text:SetWidth(260)
            text:SetJustifyH("LEFT")
        end
        check.key = key
        check.help = help
        check:SetScript("OnClick", function(self)
            ApplySetting(self.key, self:GetChecked() and true or false)
            if self.key == "ui" and DEFAULT_CHAT_FRAME then
                DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r: use /reload para reaplicar toda a interface.")
            end
        end)
        check:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(label, 1, 0.82, 0)
            GameTooltip:AddLine(self.help, 1, 1, 1, true)
            GameTooltip:Show()
        end)
        check:SetScript("OnLeave", function() GameTooltip:Hide() end)
        checks[#checks + 1] = check
        previous = check
    end
end

CreateSection(OPTIONS[1], 1)
CreateSection(OPTIONS[2], 2)

local note = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
note:SetPoint("BOTTOMLEFT", 26, 68)
note:SetWidth(590)
note:SetJustifyH("LEFT")
note:SetText("As opções ficam salvas para todos os personagens. Desative somente o conteúdo que deseja manter no idioma original.")
note:SetTextColor(0.68, 0.68, 0.68)

local function Button(name, label, x, width, click)
    local button = CreateFrame("Button", name, panel, "UIPanelButtonTemplate")
    button:SetWidth(width)
    button:SetHeight(24)
    button:SetPoint("BOTTOMLEFT", x, 28)
    button:SetText(label)
    button:SetScript("OnClick", click)
    return button
end

Button("AscensionPTBREnableAll", "Ativar tudo", 26, 112, function()
    ApplyDefaults(true)
    if panel.refresh then panel.refresh() end
end)

Button("AscensionPTBRDefaults", "Restaurar padrões", 146, 140, function()
    ApplyDefaults(nil)
    if panel.refresh then panel.refresh() end
end)

Button("AscensionPTBRCheckUpdates", "Verificar versão", 354, 132, function()
    if AES.CheckForUpdates then AES.CheckForUpdates() end
end)

Button("AscensionPTBRReload", "Recarregar interface", 494, 145, function()
    if ReloadUI then ReloadUI() end
end)

panel.refresh = function()
    local db = DB()
    for _, check in ipairs(checks) do
        local value = db[check.key]
        if value == nil then value = DEFAULTS[check.key] end
        check:SetChecked(value and true or false)
    end
end

panel.default = function()
    ApplyDefaults(nil)
    panel.refresh()
end

panel:SetScript("OnShow", panel.refresh)
InterfaceOptions_AddCategory(panel)

SLASH_ASCENSIONPTBROPTIONS1 = "/aptbropcoes"
SLASH_ASCENSIONPTBROPTIONS2 = "/aptbroptions"
SlashCmdList.ASCENSIONPTBROPTIONS = function()
    if InterfaceOptionsFrame_OpenToCategory then
        InterfaceOptionsFrame_OpenToCategory(panel)
        InterfaceOptionsFrame_OpenToCategory(panel)
    end
end

AES.OptionsPanel = panel
