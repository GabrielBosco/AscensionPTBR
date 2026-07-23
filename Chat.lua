local AES = AscensionPTBR
AES.ChatExact = AES.ChatExact or {}
AES.ChatPatterns = AES.ChatPatterns or {}

local EVENTS = {
    "CHAT_MSG_SYSTEM", "CHAT_MSG_LOOT", "CHAT_MSG_MONEY",
    "CHAT_MSG_SKILL", "CHAT_MSG_COMBAT_XP_GAIN", "CHAT_MSG_COMBAT_HONOR_GAIN",
    "CHAT_MSG_COMBAT_FACTION_CHANGE",
}

local function TranslateLinks(msg)
    if not AES.ItemName then return msg end
    return (msg:gsub("(|Hitem:(%d+)[^|]*|h%[)(.-)(%]|h)", function(pre, id, name, post)
        id = tonumber(id)
        local es = AES.ItemName[id]
        if es then
            local guard = AES.ItemNameEN and AES.ItemNameEN[id]
            if not guard or guard == name then
                return pre .. es .. post
            end
        end
        return pre .. name .. post
    end))
end


local function SafeReplace(msg, pattern, replacement)
    local ok, out = pcall(string.gsub, msg, pattern, replacement)
    if ok then return out end
    return nil
end

local function TranslateChat(msg)
    local es = AES.ChatExact[msg]
    if es then return es end
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
    local es = AES.ChatExact[msg]
    if es then return es end
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

local function Filter(self, event, msg, ...)
    if not (AscensionPTBRDB and AscensionPTBRDB.chat) or type(msg) ~= "string" then
        return false
    end
    local out = TranslateChat(msg)
    out = TranslateLinks(out)
    if out ~= msg then
        return false, out, ...
    end
    return false
end

local registered = false

function AES.SetChatEnabled(on)
    if AscensionPTBRDB then AscensionPTBRDB.chat = on end
    if on and not registered and ChatFrame_AddMessageEventFilter then
        for _, ev in ipairs(EVENTS) do
            ChatFrame_AddMessageEventFilter(ev, Filter)
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
    if AscensionPTBRDB.chat == nil then
        AscensionPTBRDB.chat = true
    end
    if AscensionPTBRDB and AscensionPTBRDB.chat then
        AES.SetChatEnabled(true)
    end
end)
