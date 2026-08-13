local AES = AscensionPTBR
AES.ChatExact = AES.ChatExact or {}
AES.ChatPatterns = AES.ChatPatterns or {}

AES.ChatExact["If you find yourself stuck and unable to move, please try the auto-unstuck feature prior to petitioning a GM. In most cases, this should solve the problem. Activating the auto-unstuck command will first attempt to use your hearthstone to port you back to your inn. If this is not possible, it will attempt to nudge your character out of position.\n\nPlease note this option can only be used every 5 minutes. Using the auto-unstuck option will log your character and location so that we can verify and fix the location in the future."] =
    "Se você ficar preso e não conseguir se mover, use a ferramenta de desbloqueio automático antes de recorrer a um MJ. Isso resolve o problema na maioria dos casos. O comando tentará primeiro usar sua Pedra de Regresso para levar você à estalagem; se isso não for possível, tentará mover seu personagem para fora do local.\n\nEsta opção só pode ser usada a cada 5 minutos. O uso será registrado com o personagem e o local para que o problema possa ser verificado e corrigido."

-- Só eventos gerados pelo jogo. Chat de jogadores fica completamente fora do tradutor.
local EVENTS = {
    "CHAT_MSG_SYSTEM", "CHAT_MSG_LOOT", "CHAT_MSG_MONEY",
    "CHAT_MSG_SKILL", "CHAT_MSG_COMBAT_XP_GAIN", "CHAT_MSG_COMBAT_HONOR_GAIN",
    "CHAT_MSG_COMBAT_FACTION_CHANGE", "CHAT_MSG_ACHIEVEMENT", "CHAT_MSG_GUILD_ACHIEVEMENT",
}

local CACHE_LIMIT = 2048
local messageCache = {}
local messageCacheCount = 0
local linkCache = {}
local linkCacheCount = 0

local function CachePut(cache, key, value, isMessage)
    if cache[key] == nil then
        if isMessage then
            messageCacheCount = messageCacheCount + 1
            if messageCacheCount > CACHE_LIMIT then
                wipe(messageCache)
                messageCacheCount = 1
            end
        else
            linkCacheCount = linkCacheCount + 1
            if linkCacheCount > CACHE_LIMIT then
                wipe(linkCache)
                linkCacheCount = 1
            end
        end
    end
    cache[key] = value
end

local function GuardedByID(ptTable, enTable, id, shown)
    if not ptTable then return nil end
    local pt = ptTable[id]
    if type(pt) ~= "string" or pt == "" or pt == shown then return nil end
    local en = enTable and enTable[id]
    if en == nil or en == shown then return pt end
    return nil
end

local function TranslateItemLabel(id, shown)
    id = tonumber(id)
    if not id then return nil end
    return GuardedByID(AES.ItemName, AES.ItemNameEN, id, shown)
end

local function TranslateAchievementLabel(id, shown)
    id = tonumber(id)
    if id then
        local pt = GuardedByID(AES.AchName, AES.AchNameEN, id, shown)
        if pt then return pt end
    end
    local pt = AES.AchNameEN2ES and AES.AchNameEN2ES[shown]
    if type(pt) == "string" and pt ~= "" and pt ~= shown then return pt end
    return nil
end

local function TranslateQuestLabel(id, shown)
    id = tonumber(id)
    if id then
        local pt = GuardedByID(AES.QuestTitle, AES.QuestTitleEN, id, shown)
        if pt then return pt end
    end
    local pt = AES.QuestTitleEN2ES and AES.QuestTitleEN2ES[shown]
    if type(pt) == "string" and pt ~= "" and pt ~= shown then return pt end
    return nil
end

local function TranslateSpellLabel(id, shown)
    local pt = AES.SpellNameEN2ES and AES.SpellNameEN2ES[shown]
    if type(pt) == "string" and pt ~= "" and pt ~= shown then return pt end

    -- Alguns links custom trazem nome diferente da tabela. Consulta o ID uma vez e
    -- deixa o resultado entrar no cache da mensagem/link, sem custo recorrente.
    id = tonumber(id)
    if id and GetSpellInfo then
        local ok, name = pcall(GetSpellInfo, id)
        if ok and type(name) == "string" then
            pt = AES.SpellNameEN2ES and AES.SpellNameEN2ES[name]
            if type(pt) == "string" and pt ~= "" and (shown == name or shown == "") then
                return pt
            end
        end
    end
    return nil
end

local function ReplaceLinkLabel(msg, pattern, resolver)
    return (msg:gsub(pattern, function(pre, id, shown, post)
        local pt = resolver(id, shown)
        if pt then return pre .. pt .. post end
        return pre .. shown .. post
    end))
end

local function ReplaceNameOnlyLink(msg, pattern)
    return (msg:gsub(pattern, function(pre, shown, post)
        local pt = AES.SpellNameEN2ES and AES.SpellNameEN2ES[shown]
        if type(pt) == "string" and pt ~= "" and pt ~= shown then
            return pre .. pt .. post
        end
        return pre .. shown .. post
    end))
end

local function TranslateLinks(msg)
    local cached = linkCache[msg]
    if cached ~= nil then
        return cached == false and msg or cached
    end

    local out = msg
    out = ReplaceLinkLabel(out, "(|Hitem:(%-?%d+)[^|]*|h%[)(.-)(%]|h)", TranslateItemLabel)
    out = ReplaceLinkLabel(out, "(|Hachievement:(%d+)[^|]*|h%[)(.-)(%]|h)", TranslateAchievementLabel)
    out = ReplaceLinkLabel(out, "(|Hquest:(%d+)[^|]*|h%[)(.-)(%]|h)", TranslateQuestLabel)
    out = ReplaceLinkLabel(out, "(|Hspell:(%d+)[^|]*|h%[)(.-)(%]|h)", TranslateSpellLabel)
    out = ReplaceNameOnlyLink(out, "(|Htalent:[^|]*|h%[)(.-)(%]|h)")
    out = ReplaceNameOnlyLink(out, "(|Henchant:[^|]*|h%[)(.-)(%]|h)")

    CachePut(linkCache, msg, out ~= msg and out or false, false)
    return out
end

local function SafeReplace(msg, pattern, replacement)
    local ok, out = pcall(string.gsub, msg, pattern, replacement)
    if ok then return out end
    return nil
end

local function TranslateChat(msg)
    local pt = AES.ChatExact[msg]
    if pt then return pt end
    local first = msg:match("^(%S+)")
    for _, bucket in ipairs({ first and AES.ChatPatterns[first], AES.ChatPatterns["*"] }) do
        if bucket then
            for _, p in ipairs(bucket) do
                if msg:match(p[1]) then
                    local out = SafeReplace(msg, p[1], p[2])
                    if out then return out end
                end
            end
        end
    end
    return msg
end

AES.TranslateSystemText = TranslateChat

local function TranslateChatStrict(msg)
    local pt = AES.ChatExact[msg]
    if pt then return pt end
    local first = msg:match("^(%S+)")
    local bucket = first and AES.ChatPatterns[first]
    if bucket then
        for _, p in ipairs(bucket) do
            if msg:match(p[1]) then
                local out = SafeReplace(msg, p[1], p[2])
                if out then return out end
            end
        end
    end
    return msg
end
AES.TranslateSystemTextStrict = TranslateChatStrict
AES.TranslateChatLinks = TranslateLinks

local function Filter(self, event, msg, ...)
    if not (AscensionPTBRDB and AscensionPTBRDB.chat) or type(msg) ~= "string" then
        return false
    end

    local key = tostring(event) .. "\031" .. msg
    local cached = messageCache[key]
    if cached ~= nil then
        if cached == false then return false end
        return false, cached, ...
    end

    local out = TranslateChat(msg)
    out = TranslateLinks(out)

    CachePut(messageCache, key, out ~= msg and out or false, true)
    if out ~= msg then return false, out, ... end
    return false
end

local registered = false

function AES.SetChatEnabled(on)
    if AscensionPTBRDB then AscensionPTBRDB.chat = on end
    if on and not registered and ChatFrame_AddMessageEventFilter then
        for _, ev in ipairs(EVENTS) do
            pcall(ChatFrame_AddMessageEventFilter, ev, Filter)
        end
        registered = true
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, arg1)
    if arg1 ~= "AscensionPTBR" then return end
    self:UnregisterEvent("ADDON_LOADED")
    AscensionPTBRDB = AscensionPTBRDB or {}
    if AscensionPTBRDB.chat == nil then AscensionPTBRDB.chat = true end
    if AscensionPTBRDB.chat then AES.SetChatEnabled(true) end
end)
