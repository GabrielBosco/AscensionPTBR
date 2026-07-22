local ADDON_NAME = ...
local AES = AscensionES
AES.VoiceFiles = AES.VoiceFiles or {}

-- O caminho e montado automaticamente usando o nome real da pasta/addon.
local ADDON_PATH = "Interface\\AddOns\\" .. (type(ADDON_NAME) == "string" and ADDON_NAME or "AscensionPTBR") .. "\\"
local playerKey
local msgMap = {}
local fmtMatchers = {}
local lastPlay = 0

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

    -- Se Errors.lua ja estiver carregado, aceita tambem a mensagem traduzida.
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
    AscensionESDB = AscensionESDB or {}
    return AscensionESDB
end

local function VoiceEnabled()
    local db = EnsureDB()
    if db.voice == nil then db.voice = true end
    return db.voice
end

function AES.SetVoiceEnabled(on)
    local db = EnsureDB()
    db.voice = not not on
    if SetCVar then
        SetCVar("Sound_EnableErrorSpeech", db.voice and 0 or 1)
    end
end

local function PlayError(errType, force)
    local set = playerKey and AES.VoiceFiles[playerKey]
    local files = set and set[errType]
    if not files or #files == 0 then return false end

    local now = GetTime and GetTime() or 0
    if not force and now - lastPlay < 3 then return false end
    lastPlay = now

    PlaySoundFile(ADDON_PATH .. files[math.random(#files)])
    return true
end

local function ChatMessage(text)
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR Vozes:|r " .. text)
    end
end

SLASH_ASCENSIONPTBRVOICE1 = "/vozptbr"
SlashCmdList.ASCENSIONPTBRVOICE = function(command)
    command = string.lower((command or ""):match("^%s*(.-)%s*$") or "")

    if command == "on" or command == "ligar" then
        AES.SetVoiceEnabled(true)
        ChatMessage("ativadas.")
    elseif command == "off" or command == "desligar" then
        AES.SetVoiceEnabled(false)
        ChatMessage("desativadas.")
    elseif command == "teste" or command == "test" then
        BuildMaps()
        if not PlayError("err_nomana", true) and not PlayError("err_outofrange", true) then
            ChatMessage("nenhum arquivo de teste foi encontrado para " .. tostring(playerKey) .. ".")
        else
            ChatMessage("teste reproduzido para " .. tostring(playerKey) .. ".")
        end
    else
        ChatMessage(VoiceEnabled() and "ativadas. Use /vozptbr teste ou /vozptbr off." or "desativadas. Use /vozptbr on.")
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("UI_ERROR_MESSAGE")
frame:SetScript("OnEvent", function(self, event, arg1, arg2)
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        EnsureDB()
        BuildMaps()
        self:UnregisterEvent("ADDON_LOADED")
    elseif event == "PLAYER_LOGIN" then
        BuildMaps()
        if VoiceEnabled() and SetCVar then
            SetCVar("Sound_EnableErrorSpeech", 0)
        end
    elseif event == "UI_ERROR_MESSAGE" then
        if not VoiceEnabled() then return end

        -- 3.3.5 normalmente envia a mensagem em arg1; alguns clientes customizados usam arg2.
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
