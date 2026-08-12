local ADDON_NAME = ...
local AES = AscensionPTBR
AES.VoiceFiles = AES.VoiceFiles or {}

-- Usa o nome real da pasta. Se renomear o addon, o áudio continua achando os arquivos.
local ADDON_PATH = "Interface\\AddOns\\" .. (type(ADDON_NAME) == "string" and ADDON_NAME or "AscensionPTBR") .. "\\"
local playerKey
local msgMap = {}
local fmtMatchers = {}
local lastPlay = 0
local originalErrorSpeech

local KEY2ERR = {
    ERR_OUT_OF_MANA = "err_nomana",
    ERR_OUT_OF_RAGE = "err_norage",
    ERR_OUT_OF_ENERGY = "err_noenergy",
    ERR_SPELL_COOLDOWN = "err_spellcooldown",
    ERR_ABILITY_COOLDOWN = "err_abilitycooldown",
    ERR_ITEM_COOLDOWN = "err_itemcooldown",
    ERR_POTION_COOLDOWN = "err_potioncooldown",
    ERR_SPELL_OUT_OF_RANGE = "err_outofrange",
    ERR_OUT_OF_RANGE = "err_outofrange",
    ERR_GENERIC_NO_TARGET = "err_genericnotarget",
    ERR_NO_ATTACK_TARGET = "err_genericnotarget",
    ERR_INVALID_ATTACK_TARGET = "err_invalidattacktarget",
    ERR_LOOT_TOO_FAR = "err_loottoofar",
    ERR_NOT_ENOUGH_MONEY = "err_notenoughmoney",
    ERR_BAG_FULL = "err_bagfull",
    ERR_INV_FULL = "err_inventoryfull",
    ERR_2HANDED_EQUIPPED = "err_2h_equipped",
    ERR_2HSKILLNOTFOUND = "err_2h_skillnotfound",
    ERR_PROFICIENCY_NEEDED = "err_proficiencyneeded",
    ERR_CANT_EQUIP_EVER = "err_cantequipever",
    ERR_CANT_EQUIP_SKILL = "err_cantequipskill",
    ERR_AMMO_ONLY = "err_ammoonly",
    ERR_NO_AMMO = "err_noammo",
    ERR_NOT_EQUIPPABLE = "err_notequippable",
    ERR_ITEM_LOCKED = "err_itemlocked",
    ERR_CHEST_IN_USE = "err_chestinuse",
    ERR_ITEM_MAX_COUNT = "err_itemmaxcount",
    ERR_GROUP_FULL = "err_partyfull",
    ERR_DROP_BOUND_ITEM = "err_cantdropsoulbounditem",
    ERR_TRADE_BOUND_ITEM = "err_canttradesoulbounditem",
    ERR_LOOT_DIDNT_KILL = "err_lootdidntkill",
    ERR_NOT_A_BAG = "err_notabag",
    ERR_MUST_EQUIP_ITEM = "err_mustequipitem",
    ERR_CANT_USE_ITEM = "err_cantuseitem",
    ERR_LOOT_LOCKED = "err_cantloot",
    ERR_GUILD_PERMISSIONS = "err_guildpermissions",
}

local KEY2ERR_FMT = {
    ERR_CANT_EQUIP_LEVEL_I = "err_cantequiplevel",
    ERR_ALREADY_IN_GROUP_S = "err_alreadyingroup",
}

local function AddMessage(text, err)
    if type(text) ~= "string" or text == "" then return end
    msgMap[text] = err

    -- Errors.lua pode já ter traduzido a frase antes de chegar aqui.
    local translated = AES.ErrExact and AES.ErrExact[text]
    if type(translated) == "string" and translated ~= "" then
        msgMap[translated] = err
    end
end

local function BuildFormatPattern(text)
    local pattern = text:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
    pattern = pattern:gsub("%%%%d", "%%d+")
    pattern = pattern:gsub("%%%%s", ".+")
    return "^" .. pattern .. "$"
end

local function BuildMaps()
    local _, raceFile = UnitRace("player")
    local sex = UnitSex("player")
    if raceFile then
        if raceFile == "Scourge" then raceFile = "Undead" end
        playerKey = raceFile .. (sex == 3 and "Female" or "Male")
    end

    wipe(msgMap)
    for globalKey, err in pairs(KEY2ERR) do
        AddMessage(_G[globalKey], err)
    end

    wipe(fmtMatchers)
    for globalKey, err in pairs(KEY2ERR_FMT) do
        local text = _G[globalKey]
        if type(text) == "string" then
            fmtMatchers[#fmtMatchers + 1] = {BuildFormatPattern(text), err}

            local translated = AES.ErrExact and AES.ErrExact[text]
            if type(translated) == "string" then
                fmtMatchers[#fmtMatchers + 1] = {BuildFormatPattern(translated), err}
            end
        end
    end
end

local function EnsureDB()
    AscensionPTBRDB = AscensionPTBRDB or {}
    return AscensionPTBRDB
end

local function VoiceEnabled()
    local db = EnsureDB()
    if db.voice == nil then db.voice = true end
    return db.voice
end

local function ReadErrorSpeechCVar()
    if not GetCVar then return nil end
    local value = GetCVar("Sound_EnableErrorSpeech")
    if value == nil then return nil end
    return tostring(value)
end

local function ApplyVoiceCVar(enabled, recapture)
    if not SetCVar then return end

    if enabled then
        if recapture or originalErrorSpeech == nil then
            originalErrorSpeech = ReadErrorSpeechCVar()
        end
        SetCVar("Sound_EnableErrorSpeech", 0)
    else
        -- Desligou o modo ptBR? Devolve a voz padrão do cliente.
        SetCVar("Sound_EnableErrorSpeech", 1)
        originalErrorSpeech = nil
    end
end

function AES.SetVoiceEnabled(on)
    local db = EnsureDB()
    local wasEnabled = db.voice ~= false
    local enabled = not not on
    db.voice = enabled
    ApplyVoiceCVar(enabled, enabled and not wasEnabled)
end

local function PlayError(errType, force)
    local set = playerKey and AES.VoiceFiles[playerKey]
    local files = set and set[errType]
    if not files or #files == 0 then return false end

    local now = GetTime and GetTime() or 0
    if not force and now - lastPlay < 3 then return false end
    lastPlay = now

    local ok = pcall(PlaySoundFile, ADDON_PATH .. files[math.random(#files)])
    return ok
end

local function ChatMessage(text)
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR Vozes:|r " .. text)
    end
end

local function VoiceFileCount()
    local set = playerKey and AES.VoiceFiles[playerKey]
    local total = 0
    if set then
        for _, files in pairs(set) do
            if type(files) == "table" then total = total + #files end
        end
    end
    return total
end

local function PlayAnyTestVoice()
    local preferred = { "err_nomana", "err_outofrange" }
    for _, errType in ipairs(preferred) do
        if PlayError(errType, true) then return true, errType end
    end

    local set = playerKey and AES.VoiceFiles[playerKey]
    if set then
        for errType, files in pairs(set) do
            if type(files) == "table" and #files > 0 and PlayError(errType, true) then
                return true, errType
            end
        end
    end
    return false
end

function AES.VoiceCommand(command)
    command = string.lower((command or ""):match("^%s*(.-)%s*$") or "")

    if command == "on" or command == "ligar" or command == "ptbr" or command == "portugues"
        or command == "português" then
        AES.SetVoiceEnabled(true)
        ChatMessage("dublagem pt-BR ativada; falas originais em inglês desativadas.")
    elseif command == "off" or command == "desligar" or command == "ingles"
        or command == "inglês" or command == "english" or command == "original" then
        AES.SetVoiceEnabled(false)
        ChatMessage("dublagem pt-BR desativada; falas originais em inglês restauradas.")
    elseif command == "teste" or command == "test" then
        if not VoiceEnabled() then
            ChatMessage("o teste pt-BR não foi executado porque o modo inglês está ativo. Use /vozptbr ptbr.")
            return
        end
        BuildMaps()
        local played, errType = PlayAnyTestVoice()
        if not played then
            ChatMessage("nenhum arquivo de teste foi encontrado para " .. tostring(playerKey) .. ".")
        else
            ChatMessage("teste reproduzido para " .. tostring(playerKey) .. " (" .. tostring(errType) .. ").")
        end
    elseif command == "diagnostico" or command == "diagnóstico" or command == "diag" then
        BuildMaps()
        local sound = GetCVar and GetCVar("Sound_EnableAllSound") or "?"
        local errors = GetCVar and GetCVar("Sound_EnableErrorSpeech") or "?"
        ChatMessage(string.format(
            "perfil=%s; arquivos=%d; modo=%s; som=%s; Sound_EnableErrorSpeech=%s.",
            tostring(playerKey), VoiceFileCount(), VoiceEnabled() and "pt-BR" or "inglês original",
            tostring(sound), tostring(errors)))
    elseif command == "status" then
        ChatMessage(VoiceEnabled()
            and "modo atual: pt-BR. Use /vozptbr ingles para voltar às falas originais."
            or "modo atual: inglês original. Use /vozptbr ptbr para ativar a dublagem.")
    else
        ChatMessage("comandos: /vozptbr ptbr, /vozptbr ingles, /vozptbr status, /vozptbr teste e /vozptbr diagnostico.")
    end
end

SLASH_ASCENSIONPTBRVOICE1 = "/vozptbr"
SlashCmdList.ASCENSIONPTBRVOICE = function(command)
    AES.VoiceCommand(command)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("UI_ERROR_MESSAGE")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:SetScript("OnEvent", function(self, event, arg1, arg2)
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        local db = EnsureDB()
        db.voiceOriginalErrorSpeech = nil -- Limpa a configuração de versões antigas.
        BuildMaps()
        self:UnregisterEvent("ADDON_LOADED")
    elseif event == "PLAYER_LOGIN" then
        BuildMaps()
        if VoiceEnabled() then
            ApplyVoiceCVar(true, false)
        else
            ApplyVoiceCVar(false, false)
        end
    -- Não deixa CVar preso quando sair do jogo.
    elseif event == "PLAYER_LOGOUT" then
        if SetCVar then
            SetCVar("Sound_EnableErrorSpeech", 1)
            originalErrorSpeech = nil
        end
    elseif event == "UI_ERROR_MESSAGE" then
        if not VoiceEnabled() then return end

        -- 3.3.5 usa arg1; build custom às vezes manda em arg2.
        local message = type(arg1) == "string" and arg1 or (type(arg2) == "string" and arg2 or nil)
        if not message then return end

        local err = msgMap[message]
        if not err then
            for _, matcher in ipairs(fmtMatchers) do
                if message:match(matcher[1]) then
                    err = matcher[2]
                    break
                end
            end
        end
        if err then PlayError(err, false) end
    end
end)
