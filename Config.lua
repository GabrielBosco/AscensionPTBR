
local ADDON_NAME = ...
local A = AscensionPTBR
local DEFAULTS = A.FeatureDefaults or {}

local function DB()
    AscensionPTBRDB = AscensionPTBRDB or {}
    return AscensionPTBRDB
end

local function CurrentValue(key)
    if A.GetSetting then return A.GetSetting(key, DEFAULTS[key]) end
    local value = DB()[key]
    if value == nil then value = DEFAULTS[key] end
    return value
end

local function Clamp(value, minimum, maximum)
    value = tonumber(value) or minimum
    if value < minimum then return minimum end
    if value > maximum then return maximum end
    return value
end

local function SetBackdrop(frame, r, g, b, a, br, bg, bb, ba)
    if not (frame and frame.SetBackdrop) then return end
    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    if frame.SetBackdropColor then frame:SetBackdropColor(r, g, b, a) end
    if frame.SetBackdropBorderColor then frame:SetBackdropBorderColor(br, bg, bb, ba) end
end

local pending = {}
local controls = {}
local dirty = false

local DEPENDENCY_PARENTS = {
    items = true, units = true, quests = true, durabilityWidget = true, durabilityWarningEnabled = true,
}

local TRANSLATION_KEYS = {
    "spells", "items", "auctionSearchPTBR", "flavor", "units", "worldNpcNames", "gossip", "achievements",
    "patterns", "ui", "maps", "endgameUI", "chat", "errores", "quests", "dailyQuests", "raidTranslation",
    "characterUI", "dynamicUI",
}

local PRESETS = {
    completo = {
        spells=true, items=true, auctionSearchPTBR=true, flavor=true, units=true, worldNpcNames=true, gossip=true, achievements=true,
        patterns=true, ui=true, maps=true, endgameUI=true, chat=true, errores=true, quests=true, dailyQuests=true,
        raidTranslation=true, characterUI=true, dynamicUI=true, voice=true, durabilityWidget=true,
        unitFrameNumbers=true, lootOverlay=true, dragonUICompat=true, detailsCompat=true,
        durabilityHudHideAtFull=false, durabilityWarningEnabled=true, durabilityWarningSound=true,
        durabilityWarningChat=true, durabilityWarningThreshold=50, durabilityUpdateInterval=1,
    },
    equilibrado = {
        spells=true, items=true, auctionSearchPTBR=true, flavor=true, units=true, worldNpcNames=true, gossip=true, achievements=true,
        patterns=true, ui=true, maps=true, endgameUI=true, chat=true, errores=true, quests=true, dailyQuests=true,
        raidTranslation=true, characterUI=true, dynamicUI=true, voice=true, durabilityWidget=true,
        unitFrameNumbers=true, lootOverlay=true, dragonUICompat=true, detailsCompat=true,
        durabilityHudHideAtFull=true, durabilityWarningEnabled=true, durabilityWarningSound=true,
        durabilityWarningChat=true, durabilityWarningThreshold=50, durabilityUpdateInterval=2,
    },
    desempenho = {
        spells=true, items=true, auctionSearchPTBR=true, flavor=true, units=true, worldNpcNames=false, gossip=true, achievements=true,
        patterns=false, ui=true, maps=true, endgameUI=true, chat=true, errores=true, quests=true, dailyQuests=false,
        raidTranslation=true, characterUI=true, dynamicUI=false, voice=false, durabilityWidget=false,
        unitFrameNumbers=false, lootOverlay=false, dragonUICompat=false, detailsCompat=true,
        durabilityHudHideAtFull=true, durabilityWarningEnabled=true, durabilityWarningSound=false,
        durabilityWarningChat=false, durabilityWarningThreshold=40, durabilityUpdateInterval=5,
    },
}

local refreshing = false
local activePage = 1

local function CopyCurrentToPending()
    pending = {}
    for key, defaultValue in pairs(DEFAULTS) do
        local value = CurrentValue(key)
        if value == nil then value = defaultValue end
        pending[key] = value
    end
end

local function PendingValue(key)
    local value = pending[key]
    if value == nil then value = DEFAULTS[key] end
    return value
end

local function ValuesEqual(a, b)
    if type(a) == "number" or type(b) == "number" then
        return tonumber(a) == tonumber(b)
    end
    return a == b
end

local configFrame
local statusText
local saveButton
local applyButton

local function UpdateDirtyState()
    local hasChanges = false
    for key in pairs(DEFAULTS) do
        if not ValuesEqual(PendingValue(key), CurrentValue(key)) then
            hasChanges = true
            break
        end
    end
    dirty = hasChanges

    if statusText then
        if dirty then
            statusText:SetText("Tem mudanças esperando para aplicar")
            statusText:SetTextColor(1.00, 0.74, 0.20)
        else
            statusText:SetText("Tudo salvo")
            statusText:SetTextColor(0.35, 0.95, 0.58)
        end
    end
    if saveButton and saveButton.Enable then
        if dirty then saveButton:Enable() else saveButton:Disable() end
    end
    if applyButton and applyButton.Enable then
        if dirty then applyButton:Enable() else applyButton:Disable() end
    end
end

local function RefreshControls()
    refreshing = true
    for i = 1, #controls do
        local control = controls[i]
        if control and control.Refresh then control:Refresh() end
    end
    refreshing = false
    UpdateDirtyState()
end

local function SetPending(key, value)
    pending[key] = value
    if refreshing then return end
    if DEPENDENCY_PARENTS[key] then
        RefreshControls()
    else
        UpdateDirtyState()
    end
end

local function DependencyMet(item)
    local depends = item and item.depends
    if not depends then return true end
    if type(depends) == "table" then
        for i = 1, #depends do
            if PendingValue(depends[i]) == false then return false end
        end
        return true
    end
    return PendingValue(depends) ~= false
end

local function ApplyPreset(name)
    local preset = PRESETS[name]
    if not preset then return end
    for key, value in pairs(preset) do
        if DEFAULTS[key] ~= nil then pending[key] = value end
    end
    RefreshControls()
end

local function SetTranslationGroups(enabled)
    for i = 1, #TRANSLATION_KEYS do
        local key = TRANSLATION_KEYS[i]
        if DEFAULTS[key] ~= nil then pending[key] = enabled and true or false end
    end
    RefreshControls()
end

local WORLD_KEYS = {
    units = true, worldNpcNames = true, dragonUICompat = true,
}
local CHARACTER_KEYS = {
    characterUI = true, dynamicUI = true, ui = true, patterns = true, unitFrameNumbers = true,
}
local DURABILITY_KEYS = {
    durabilityWidget = true, durabilityHudLocked = true, durabilityHudShowWorst = true,
    durabilityHudHideAtFull = true, durabilityWarningEnabled = true, durabilityWarningSound = true,
    durabilityWarningChat = true, durabilityWarningThreshold = true, durabilityUpdateInterval = true,
    durabilityHudScale = true, durabilityHudOpacity = true,
}
local DAILY_KEYS = { quests = true, dailyQuests = true }
local MAP_KEYS = { maps = true, quests = true }
local INTEGRATION_KEYS = {
    detailsCompat = true, lootOverlay = true, unitFrameNumbers = true, dragonUICompat = true,
    items = true, gossip = true, raidTranslation = true, ui = true,
}

local function AnyChanged(changed, set)
    for key in pairs(set) do
        if changed[key] then return true end
    end
    return false
end

local function ApplyRuntime(changed)
    if changed.chat and A.SetChatEnabled then pcall(A.SetChatEnabled, CurrentValue("chat") ~= false) end
    if changed.errores and A.SetErrorsEnabled then pcall(A.SetErrorsEnabled, CurrentValue("errores") ~= false) end
    if changed.voice and A.SetVoiceEnabled then pcall(A.SetVoiceEnabled, CurrentValue("voice") ~= false) end

    local runtime = A.Runtime
    if runtime and runtime.RefreshModule then
        if AnyChanged(changed, WORLD_KEYS) then runtime.RefreshModule("world-names", "settings") end
        if AnyChanged(changed, CHARACTER_KEYS) then runtime.RefreshModule("character-ui", "settings") end
        if AnyChanged(changed, DAILY_KEYS) then runtime.RefreshModule("daily-quests", "settings") end
        if AnyChanged(changed, MAP_KEYS) then
            if runtime.RefreshModule then pcall(runtime.RefreshModule, "map-ui", "settings") end
            if A.RefreshMapUI then pcall(A.RefreshMapUI, "settings") end
        end
        if AnyChanged(changed, INTEGRATION_KEYS) then runtime.RefreshModule("integration-ui", "settings") end
    else
        if AnyChanged(changed, WORLD_KEYS) and A.ApplyWorldNpcNameplates then pcall(A.ApplyWorldNpcNameplates) end
        if AnyChanged(changed, CHARACTER_KEYS) and A.RefreshCharacterUI then pcall(A.RefreshCharacterUI) end
        if AnyChanged(changed, DAILY_KEYS) and A.RefreshDailyQuests then pcall(A.RefreshDailyQuests, "settings") end
        if AnyChanged(changed, MAP_KEYS) and A.RefreshMapUI then pcall(A.RefreshMapUI, "settings") end
        if AnyChanged(changed, INTEGRATION_KEYS) and A.RefreshIntegrationUI then pcall(A.RefreshIntegrationUI) end
    end

    if changed.endgameUI and A.RefreshEndgameUI then
        pcall(A.RefreshEndgameUI, "settings")
    end

    if AnyChanged(changed, DURABILITY_KEYS) and A.RefreshDurabilityWidget then
        pcall(A.RefreshDurabilityWidget)
    end
end

local function CommitSettings(closeAfter)
    local db = DB()
    local changed = {}
    for key in pairs(DEFAULTS) do
        local value = PendingValue(key)
        if not ValuesEqual(value, CurrentValue(key)) then changed[key] = true end
        db[key] = value
    end

    ApplyRuntime(changed)
    CopyCurrentToPending()
    RefreshControls()

    if closeAfter then
        if configFrame then configFrame:Hide() end
        if DEFAULT_CHAT_FRAME then
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r: configurações salvas. Recarregando a interface...")
        end
        if ReloadUI then
            ReloadUI()
        end
        return
    end

    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r: configurações aplicadas.")
    end
end

local function ResetPendingToDefaults()
    for key, value in pairs(DEFAULTS) do pending[key] = value end
    RefreshControls()
end

local function DiscardChanges()
    CopyCurrentToPending()
    RefreshControls()
end

local PAGE_DEFS = {
    {
        id = "geral", label = "Geral", title = "Configurações gerais",
        description = "Preferências básicas do AscensionPTBR. Use Aplicar para testar na hora ou Salvar + Reload para gravar e recarregar a interface.",
        items = {
            { "check", "authorMessage", "Crédito ao entrar", "Mostra uma linha discreta do AscensionPTBR quando você entra no jogo." },
            { "check", "updateCheck", "Avisar sobre versão nova", "Avisa quando o addon detectar uma versão mais recente anunciada no grupo ou guilda." },
            { "check", "voice", "Vozes de erro em ptBR", "Troca as falas de erro suportadas pelas vozes brasileiras que vêm com o addon." },
        },
    },
    {
        id = "perfis", label = "Perfis", title = "Perfis rápidos",
        description = "Troque várias opções de uma vez. Use Aplicar para testar ou Salvar + Reload para gravar e recarregar.",
        items = {
            { "action", "presetFull", "Completo", "Ativa todos os módulos de tradução, interface, integrações e HUD.", "Usar perfil" },
            { "action", "presetBalanced", "Equilibrado", "Mantém todos os recursos principais ativos e reduz a frequência da HUD.", "Usar perfil" },
            { "action", "presetPerformance", "Desempenho", "Mantém a tradução principal e desliga recursos dinâmicos mais pesados.", "Usar perfil" },
            { "action", "translationsOn", "Ativar traduções", "Liga novamente todos os grupos de tradução sem mexer nas opções visuais.", "Ativar" },
            { "action", "translationsOff", "Desativar traduções", "Desliga os grupos de tradução para teste ou diagnóstico.", "Desativar" },
        },
    },
    {
        id = "traducao", label = "Tradução", title = "Traduções",
        description = "Ative ou desative cada grupo de tradução. As opções são independentes e não apagam seus dados.",
        items = {
            { "check", "spells", "Feitiços, talentos e auras", "Nomes, descrições e informações das habilidades." },
            { "check", "items", "Itens e equipamentos", "Nomes, efeitos e atributos mostrados nos itens." },
            { "check", "auctionSearchPTBR", "Busca PT-BR/inglês no Leilão", "Permite pesquisar pelo nome do item em português ou inglês. Quando necessário, a consulta é enviada ao servidor usando o nome original em inglês." },
            { "check", "flavor", "Textos de ambientação", "Citações e textos de sabor dos itens.", depends = "items" },
            { "check", "units", "NPCs e criaturas", "Traduz nomes conhecidos, títulos e funções de NPCs e criaturas." },
            { "check", "worldNpcNames", "Nomes de NPCs no mundo", "Traduz NPCs quando o cliente já expõe uma placa/texto. Não ativa placas amigáveis, não mexe no V e não cria placas para jogadores aliados.", depends = "units" },
            { "check", "gossip", "Diálogos de NPC", "Saudações, opções e textos de conversa." },
            { "check", "achievements", "Conquistas", "Títulos, descrições e recompensas." },
            { "check", "patterns", "Valores dinâmicos", "Traduz linhas que mudam com dano, custo, alcance, duração e outros valores do personagem." },
            { "check", "ui", "Menus e interface (ESC)", "Traduz o menu ESC, botões e textos gerais da interface." },
            { "check", "endgameUI", "Conteúdo endgame", "Traduz HUDs custom de Mítico+, afixos, progressões, recompensas e outras telas de nível máximo do Ascension." },
            { "check", "maps", "Mapas e nomes de áreas", "Usa o mesmo nome em ptBR no mapa, minimapa e no texto que aparece ao entrar em uma área." },
            { "check", "chat", "Mensagens do chat", "Saque, experiência e mensagens de sistema suportadas." },
            { "check", "errores", "Mensagens de erro", "Avisos e erros exibidos no centro da tela." },
        },
    },
    {
        id = "personagem", label = "Personagem", title = "Personagem e HUD",
        description = "Opções da ficha do personagem e da HUD de durabilidade.",
        items = {
            { "check", "characterUI", "Perfil do personagem (C)", "Traduz a ficha, atributos e o painel completo de estatísticas do Ascension." },
            { "check", "dynamicUI", "Abas do personagem", "Traduz profissões, reputação, moedas, montarias, mascotes, livros e coleções." },
            { "check", "durabilityWidget", "HUD de durabilidade", "Mantém a durabilidade dos equipamentos visível durante o jogo." },
            { "check", "durabilityHudShowWorst", "Mostrar a peça mais gasta", "Exibe na HUD qual equipamento está com a menor durabilidade.", depends = "durabilityWidget" },
            { "check", "durabilityHudLocked", "Travar HUD de durabilidade", "Travada: não se move. Clique com o botão direito na própria HUD para travar/destravar; quando livre, arraste com o botão esquerdo.", depends = "durabilityWidget" },
            { "slider", "durabilityHudScale", "Tamanho da HUD", "Ajusta o tamanho do painel de durabilidade.", 75, 150, 5, "%", depends = "durabilityWidget" },
            { "slider", "durabilityHudOpacity", "Opacidade da HUD", "Deixa o painel mais discreto ou mais evidente.", 20, 100, 5, "%", depends = "durabilityWidget" },
            { "check", "durabilityHudHideAtFull", "Esconder em 100%", "Oculta a HUD quando todos os equipamentos estiverem com durabilidade completa.", depends = "durabilityWidget" },
            { "check", "durabilityWarningEnabled", "Aviso de durabilidade baixa", "Mostra um aviso quando a peça mais gasta atingir o limite configurado.", depends = "durabilityWidget" },
            { "check", "durabilityWarningSound", "Som no aviso", "Toca o som de aviso quando a durabilidade atingir o limite.", depends = { "durabilityWidget", "durabilityWarningEnabled" } },
            { "check", "durabilityWarningChat", "Registrar aviso no chat", "Também escreve o aviso de durabilidade no chat.", depends = { "durabilityWidget", "durabilityWarningEnabled" } },
            { "slider", "durabilityWarningThreshold", "Limite do aviso", "Escolha em qual porcentagem o aviso de durabilidade deve aparecer.", 10, 90, 5, "%", depends = { "durabilityWidget", "durabilityWarningEnabled" } },
            { "slider", "durabilityUpdateInterval", "Intervalo de atualização", "Aumente o intervalo para reduzir ainda mais o trabalho da HUD.", 1, 5, 1, "s", depends = "durabilityWidget" },
            { "action", "durabilityReset", "Reposicionar HUD", "Volta a HUD de durabilidade para a posição padrão.", "Reposicionar", depends = "durabilityWidget" },
            { "check", "unitFrameNumbers", "Números de vida e recurso", "Mostra os valores de vida, mana ou outro recurso nos quadros compatíveis." },
        },
    },
    {
        id = "missoes", label = "Missões", title = "Missões",
        description = "Controle a tradução de missões, rastreador, diárias e conteúdo de nível máximo.",
        items = {
            { "check", "quests", "Missões", "Traduz o sistema de quests, rastreador, objetivos, progresso e conclusão." },
            { "check", "dailyQuests", "Diárias e Quadro de Chamados", "Traduz o menu de missões diárias e semanais do conteúdo de nível máximo.", depends = "quests" },
            { "check", "raidTranslation", "Falas e avisos de raide", "Traduz falas, gritos, emotes e avisos de chefes que já existem na base ptBR." },
        },
    },
    {
        id = "compat", label = "Compatibilidade", title = "Outros addons",
        description = "Ajustes para manter a tradução funcionando sem substituir a interface normal de outros addons.",
        items = {
            { "check", "dragonUICompat", "DragonUI", "Mantém as placas de combate do DragonUI e aplica a tradução dos NPCs sem criar placas para jogadores aliados." },
            { "check", "detailsCompat", "Details!", "Corrige as cores das classes customizadas do CoA sem mexer no funcionamento normal do Details." },
            { "check", "lootOverlay", "Nome do saque em ptBR", "Mostra o nome traduzido na janela de saque sem mexer no clique dos itens.", depends = "items" },
        },
    },
}

local function MakeText(parent, template, text, x, y, width)
    local fs = parent:CreateFontString(nil, "ARTWORK", template)
    fs:SetPoint("TOPLEFT", x, y)
    if width then
        fs:SetWidth(width)
        fs:SetJustifyH("LEFT")
    end
    fs:SetText(text or "")
    return fs
end

local checkSerial = 0
local function CreateCheckbox(parent, item, y)
    local key, label, help = item[2], item[3], item[4]
    local row = CreateFrame("Frame", nil, parent)
    row:SetPoint("TOPLEFT", 0, y)
    row:SetPoint("TOPRIGHT", 0, y)
    row:SetHeight(36)

    checkSerial = checkSerial + 1
    local check = CreateFrame("CheckButton", "AscensionPTBROptionCheck" .. tostring(checkSerial), row, "InterfaceOptionsCheckButtonTemplate")
    check:SetPoint("LEFT", 0, 2)
    check:SetWidth(26)
    check:SetHeight(26)

    local labelText = row:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    labelText:SetPoint("TOPLEFT", check, "TOPRIGHT", 2, -1)
    labelText:SetText(label)
    labelText:SetTextColor(0.95, 0.95, 0.95)

    local helpText = row:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
    helpText:SetPoint("TOPLEFT", labelText, "BOTTOMLEFT", 0, -2)
    helpText:SetWidth(455)
    helpText:SetJustifyH("LEFT")
    helpText:SetText(help)
    helpText:SetTextColor(0.62, 0.66, 0.68)

    check:SetScript("OnClick", function(self)
        SetPending(key, self:GetChecked() and true or false)
    end)

    row.Refresh = function()
        local enabled = DependencyMet(item)
        check:SetChecked(PendingValue(key) ~= false)
        if enabled then
            if check.Enable then check:Enable() end
            labelText:SetTextColor(0.95, 0.95, 0.95)
            helpText:SetTextColor(0.62, 0.66, 0.68)
        else
            if check.Disable then check:Disable() end
            labelText:SetTextColor(0.48, 0.50, 0.49)
            helpText:SetTextColor(0.38, 0.40, 0.39)
        end
    end
    controls[#controls + 1] = row
    return y - 38
end

local sliderSerial = 0
local function CreateSlider(parent, item, y)
    local key, label, help = item[2], item[3], item[4]
    local minimum, maximum, step, suffix = item[5], item[6], item[7], item[8] or ""
    local row = CreateFrame("Frame", nil, parent)
    row:SetPoint("TOPLEFT", 0, y)
    row:SetPoint("TOPRIGHT", 0, y)
    row:SetHeight(49)

    local labelText = row:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    labelText:SetPoint("TOPLEFT", 4, -1)
    labelText:SetText(label)
    labelText:SetTextColor(0.95, 0.95, 0.95)

    local valueText = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    valueText:SetPoint("TOPRIGHT", -8, -2)
    valueText:SetTextColor(0.35, 0.95, 0.58)

    local helpText = row:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
    helpText:SetPoint("TOPLEFT", labelText, "BOTTOMLEFT", 0, -3)
    helpText:SetText(help)
    helpText:SetTextColor(0.62, 0.66, 0.68)

    sliderSerial = sliderSerial + 1
    local sliderName = "AscensionPTBROptionSlider" .. tostring(sliderSerial)
    local slider = CreateFrame("Slider", sliderName, row, "OptionsSliderTemplate")
    slider:SetPoint("RIGHT", row, "RIGHT", -10, -19)
    slider:SetWidth(210)
    slider:SetHeight(16)
    slider:SetMinMaxValues(minimum, maximum)
    slider:SetValueStep(step)

    local low = _G[sliderName .. "Low"]
    local high = _G[sliderName .. "High"]
    local text = _G[sliderName .. "Text"]
    if low then low:SetText(tostring(minimum)) end
    if high then high:SetText(tostring(maximum)) end
    if text then text:SetText("") end

    slider:SetScript("OnValueChanged", function(self, value)
        local rounded = math.floor((value / step) + 0.5) * step
        rounded = Clamp(rounded, minimum, maximum)
        valueText:SetText(tostring(rounded) .. suffix)
        if not refreshing then SetPending(key, rounded) end
    end)

    row.Refresh = function()
        local value = Clamp(PendingValue(key), minimum, maximum)
        local enabled = DependencyMet(item)
        slider:SetValue(value)
        valueText:SetText(tostring(value) .. suffix)
        if enabled then
            if slider.Enable then slider:Enable() end
            labelText:SetTextColor(0.95, 0.95, 0.95)
            helpText:SetTextColor(0.62, 0.66, 0.68)
            valueText:SetTextColor(0.35, 0.95, 0.58)
        else
            if slider.Disable then slider:Disable() end
            labelText:SetTextColor(0.48, 0.50, 0.49)
            helpText:SetTextColor(0.38, 0.40, 0.39)
            valueText:SetTextColor(0.42, 0.45, 0.43)
        end
    end
    controls[#controls + 1] = row
    return y - 50
end

local function CreateAction(parent, item, y)
    local action, label, help, buttonLabel = item[2], item[3], item[4], item[5] or "Executar"
    local row = CreateFrame("Frame", nil, parent)
    row:SetPoint("TOPLEFT", 0, y)
    row:SetPoint("TOPRIGHT", 0, y)
    row:SetHeight(44)

    local labelText = row:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    labelText:SetPoint("TOPLEFT", 4, -1)
    labelText:SetText(label)
    labelText:SetTextColor(0.95, 0.95, 0.95)

    local helpText = row:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
    helpText:SetPoint("TOPLEFT", labelText, "BOTTOMLEFT", 0, -3)
    helpText:SetWidth(345)
    helpText:SetJustifyH("LEFT")
    helpText:SetText(help)
    helpText:SetTextColor(0.62, 0.66, 0.68)

    local button = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
    button:SetWidth(112)
    button:SetHeight(22)
    button:SetPoint("RIGHT", row, "RIGHT", -8, -7)
    button:SetText(buttonLabel)
    button:SetScript("OnClick", function()
        if action == "durabilityReset" and A.ResetDurabilityHudPosition then
            pcall(A.ResetDurabilityHudPosition)
            if DEFAULT_CHAT_FRAME then
                DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r: HUD de durabilidade reposicionada.")
            end
        elseif action == "presetFull" then
            ApplyPreset("completo")
        elseif action == "presetBalanced" then
            ApplyPreset("equilibrado")
        elseif action == "presetPerformance" then
            ApplyPreset("desempenho")
        elseif action == "translationsOn" then
            SetTranslationGroups(true)
        elseif action == "translationsOff" then
            SetTranslationGroups(false)
        end
    end)

    row.Refresh = function()
        local enabled = DependencyMet(item)
        if enabled then
            if button.Enable then button:Enable() end
            labelText:SetTextColor(0.95, 0.95, 0.95)
            helpText:SetTextColor(0.62, 0.66, 0.68)
        else
            if button.Disable then button:Disable() end
            labelText:SetTextColor(0.48, 0.50, 0.49)
            helpText:SetTextColor(0.38, 0.40, 0.39)
        end
    end
    controls[#controls + 1] = row
    return y - 46
end

local function CreatePage(parent, definition)
    local page = CreateFrame("Frame", nil, parent)
    page:SetAllPoints(parent)

    local scroll = CreateFrame("ScrollFrame", nil, page, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 0, 0)
    scroll:SetPoint("BOTTOMRIGHT", -25, 0)

    local body = CreateFrame("Frame", nil, scroll)
    body:SetWidth(500)
    body:SetHeight(500)
    scroll:SetScrollChild(body)

    local title = MakeText(body, "GameFontNormalLarge", definition.title, 0, 0, 490)
    title:SetTextColor(0.27, 1.00, 0.60)

    local desc = MakeText(body, "GameFontHighlightSmall", definition.description, 0, -29, 490)
    desc:SetTextColor(0.76, 0.79, 0.80)

    local line = body:CreateTexture(nil, "ARTWORK")
    line:SetPoint("TOPLEFT", 0, -55)
    line:SetPoint("TOPRIGHT", 0, -55)
    line:SetHeight(1)
    line:SetTexture(0.20, 0.28, 0.25, 0.85)

    local y = -67
    for i = 1, #definition.items do
        local item = definition.items[i]
        if item[1] == "check" then
            y = CreateCheckbox(body, item, y)
        elseif item[1] == "slider" then
            y = CreateSlider(body, item, y)
        elseif item[1] == "action" then
            y = CreateAction(body, item, y)
        end
    end
    body:SetHeight(math.max(500, -y + 24))
    return page
end

local function BuildWindow()
    if configFrame then return configFrame end

    local frame = CreateFrame("Frame", "AscensionPTBRConfigFrame", UIParent)
    configFrame = frame
    frame:SetWidth(780)
    frame:SetHeight(660)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
    frame:SetFrameStrata("DIALOG")
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    SetBackdrop(frame, 0.035, 0.045, 0.043, 0.98, 0.18, 0.50, 0.34, 1)

    local header = CreateFrame("Frame", nil, frame)
    header:SetPoint("TOPLEFT", 8, -8)
    header:SetPoint("TOPRIGHT", -8, -8)
    header:SetHeight(68)
    SetBackdrop(header, 0.025, 0.075, 0.055, 0.96, 0.12, 0.30, 0.22, 1)

    local accent = header:CreateTexture(nil, "ARTWORK")
    accent:SetPoint("TOPLEFT", 12, -12)
    accent:SetWidth(5)
    accent:SetHeight(42)
    accent:SetTexture(0.20, 1.00, 0.60, 1)

    local title = header:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", accent, "TOPRIGHT", 10, -2)
    title:SetText("AscensionPTBR")
    title:SetTextColor(0.20, 1.00, 0.60)

    local subtitle = header:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
    subtitle:SetText("Liga, desliga e personalize cada parte. Nada muda até você aplicar.")
    subtitle:SetTextColor(0.78, 0.82, 0.80)

    local version = header:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
    version:SetPoint("RIGHT", header, "RIGHT", -46, 3)
    version:SetText("v" .. tostring((GetAddOnMetadata and GetAddOnMetadata(ADDON_NAME or "AscensionPTBR", "Version")) or "1.5.1"))

    local close = CreateFrame("Button", nil, header, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", 2, 2)
    close:SetScript("OnClick", function()
        DiscardChanges()
        frame:Hide()
    end)

    local sidebar = CreateFrame("Frame", nil, frame)
    sidebar:SetPoint("TOPLEFT", 14, -84)
    sidebar:SetPoint("BOTTOMLEFT", 14, 64)
    sidebar:SetWidth(178)
    SetBackdrop(sidebar, 0.022, 0.030, 0.029, 0.92, 0.10, 0.17, 0.15, 1)

    local sideTitle = sidebar:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
    sideTitle:SetPoint("TOPLEFT", 14, -13)
    sideTitle:SetText("SEÇÕES")
    sideTitle:SetTextColor(0.52, 0.70, 0.61)

    local content = CreateFrame("Frame", nil, frame)
    content:SetPoint("TOPLEFT", sidebar, "TOPRIGHT", 18, -4)
    content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -20, 74)

    local pages = {}
    local categoryButtons = {}

    local function ShowPage(index)
        activePage = index
        for i = 1, #pages do
            if i == index then pages[i]:Show() else pages[i]:Hide() end
            local button = categoryButtons[i]
            if button and button.bg then
                if i == index then
                    button.bg:SetTexture(0.12, 0.34, 0.24, 0.96)
                    button.text:SetTextColor(0.30, 1.00, 0.62)
                else
                    button.bg:SetTexture(0.04, 0.06, 0.055, 0.74)
                    button.text:SetTextColor(0.82, 0.84, 0.83)
                end
            end
        end
    end

    local y = -37
    for i = 1, #PAGE_DEFS do
        local index = i
        local definition = PAGE_DEFS[index]
        local button = CreateFrame("Button", nil, sidebar)
        button:SetPoint("TOPLEFT", 8, y)
        button:SetWidth(162)
        button:SetHeight(34)
        button.bg = button:CreateTexture(nil, "BACKGROUND")
        button.bg:SetAllPoints(button)
        button.bg:SetTexture(0.04, 0.06, 0.055, 0.74)
        button.text = button:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        button.text:SetPoint("LEFT", 12, 0)
        button.text:SetText(definition.label)
        button.text:SetTextColor(0.82, 0.84, 0.83)
        button:SetScript("OnEnter", function(self)
            if activePage ~= index then self.bg:SetTexture(0.075, 0.13, 0.10, 0.90) end
        end)
        button:SetScript("OnLeave", function(self)
            if activePage ~= index then self.bg:SetTexture(0.04, 0.06, 0.055, 0.74) end
        end)
        button:SetScript("OnClick", function() ShowPage(index) end)
        categoryButtons[index] = button
        y = y - 38

        pages[index] = CreatePage(content, definition)
        pages[index]:Hide()
    end

    local npcNote = sidebar:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
    npcNote:SetPoint("BOTTOMLEFT", 12, 14)
    npcNote:SetWidth(154)
    npcNote:SetJustifyH("LEFT")
    npcNote:SetText("Opções dependentes ficam apagadas quando o recurso principal está desligado.\nUse Perfis para trocar várias configurações de uma vez.")
    npcNote:SetTextColor(0.58, 0.64, 0.61)

    local footer = CreateFrame("Frame", nil, frame)
    footer:SetPoint("BOTTOMLEFT", 14, 12)
    footer:SetPoint("BOTTOMRIGHT", -14, 12)
    footer:SetHeight(44)
    SetBackdrop(footer, 0.025, 0.035, 0.033, 0.94, 0.10, 0.17, 0.15, 1)

    statusText = footer:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    statusText:SetPoint("LEFT", 12, 0)
    statusText:SetText("Tudo salvo")

    local function FooterButton(label, width, x, handler)
        local button = CreateFrame("Button", nil, footer, "UIPanelButtonTemplate")
        button:SetWidth(width)
        button:SetHeight(24)
        button:SetPoint("RIGHT", footer, "RIGHT", x, 0)
        button:SetText(label)
        button:SetScript("OnClick", handler)
        return button
    end

    saveButton = FooterButton("Salvar + Reload", 112, -8, function() CommitSettings(true) end)
    applyButton = FooterButton("Aplicar agora", 96, -126, function() CommitSettings(false) end)
    FooterButton("Restaurar", 82, -228, function() ResetPendingToDefaults() end)
    FooterButton("Descartar", 82, -316, function()
        DiscardChanges()
        frame:Hide()
    end)

    frame:SetScript("OnShow", function()
        CopyCurrentToPending()
        RefreshControls()
        ShowPage(activePage or 1)
    end)

    frame:Hide()
    if UISpecialFrames then table.insert(UISpecialFrames, "AscensionPTBRConfigFrame") end

    frame.ShowPage = ShowPage
    ShowPage(1)
    return frame
end

function A.OpenOptions(category)
    local frame = BuildWindow()
    if type(category) == "string" then
        local low = category:lower()
        for i = 1, #PAGE_DEFS do
            if PAGE_DEFS[i].id == low or PAGE_DEFS[i].label:lower() == low then
                activePage = i
                break
            end
        end
    end
    frame:Show()
    if frame.ShowPage then frame.ShowPage(activePage) end
end

-- Atalho dentro das opções do WoW. A janela principal continua sendo a /aptbr.
if InterfaceOptions_AddCategory then
    local native = CreateFrame("Frame", "AscensionPTBROptionsPanel", UIParent)
    native.name = "AscensionPTBR"

    local title = native:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -18)
    title:SetText("AscensionPTBR")
    title:SetTextColor(0.20, 1.00, 0.60)

    local desc = native:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
    desc:SetWidth(560)
    desc:SetJustifyH("LEFT")
    desc:SetText("Todas as opções do AscensionPTBR ficam em uma janela só. Abra, ajuste o que quiser e salve quando terminar.")

    local open = CreateFrame("Button", nil, native, "UIPanelButtonTemplate")
    open:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -18)
    open:SetWidth(190)
    open:SetHeight(26)
    open:SetText("Abrir opções do AscensionPTBR")
    open:SetScript("OnClick", function() A.OpenOptions() end)

    InterfaceOptions_AddCategory(native)
    A.OptionsPanel = native
end

SLASH_ASCENSIONPTBROPTIONS1 = "/aptbr"
SLASH_ASCENSIONPTBROPTIONS2 = "/aptbropcoes"
SLASH_ASCENSIONPTBROPTIONS3 = "/aptbroptions"
SlashCmdList.ASCENSIONPTBROPTIONS = function(msg)
    msg = type(msg) == "string" and msg:match("^%s*(.-)%s*$") or ""
    A.OpenOptions(msg ~= "" and msg or nil)
end
