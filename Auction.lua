local A = AscensionPTBR or {}
AscensionPTBR = A

-- O cliente do Ascension roda em enUS. A interface pode mostrar o item em ptBR,
-- mas a busca do leilao ainda usa o nome original do item.
-- Aqui a consulta e ajustada sem trocar o texto que o jogador digitou no campo.

local reverseIndex
local searchKeys
local slowExactCache = {}
local originalQueryAuctionItems
local hookInstalled = false
local pendingQuery
local unpackArgs = unpack or table.unpack

local accentMap = {
    ["Á"]="A", ["À"]="A", ["Â"]="A", ["Ã"]="A", ["Ä"]="A",
    ["á"]="a", ["à"]="a", ["â"]="a", ["ã"]="a", ["ä"]="a",
    ["É"]="E", ["È"]="E", ["Ê"]="E", ["Ë"]="E",
    ["é"]="e", ["è"]="e", ["ê"]="e", ["ë"]="e",
    ["Í"]="I", ["Ì"]="I", ["Î"]="I", ["Ï"]="I",
    ["í"]="i", ["ì"]="i", ["î"]="i", ["ï"]="i",
    ["Ó"]="O", ["Ò"]="O", ["Ô"]="O", ["Õ"]="O", ["Ö"]="O",
    ["ó"]="o", ["ò"]="o", ["ô"]="o", ["õ"]="o", ["ö"]="o",
    ["Ú"]="U", ["Ù"]="U", ["Û"]="U", ["Ü"]="U",
    ["ú"]="u", ["ù"]="u", ["û"]="u", ["ü"]="u",
    ["Ç"]="C", ["ç"]="c", ["Ñ"]="N", ["ñ"]="n",
}

local function Compact(text)
    if type(text) ~= "string" then return nil end
    text = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    text = text:gsub("“", '"'):gsub("”", '"')
    text = text:gsub("‘", "'"):gsub("’", "'")
    text = text:gsub("–", "-"):gsub("—", "-")
    text = text:match("^%s*(.-)%s*$") or ""
    text = text:gsub("%s+", " ")
    return text
end

local function Normalize(text)
    text = Compact(text)
    if not text or text == "" then return nil end
    for from, to in pairs(accentMap) do
        text = text:gsub(from, to)
    end
    return string.lower(text)
end

local function RawKey(text)
    text = Compact(text)
    if not text or text == "" then return nil end
    return string.lower(text)
end

local function BuildReverseIndex()
    if reverseIndex then return end

    reverseIndex = {}
    searchKeys = {}

    local ptNames = A.ItemName or {}
    local enNames = A.ItemNameEN or {}
    local rawCandidates = {}

    -- Caminho rapido: so os nomes que a base ja conhece nos dois idiomas.
    -- A tabela fica pequena e cobre a maior parte das buscas traduzidas sem custo alto.
    for itemID, ptName in pairs(ptNames) do
        local enName = enNames[itemID]
        if type(ptName) == "string" and ptName ~= ""
            and type(enName) == "string" and enName ~= ""
            and ptName ~= enName then

            local key = Normalize(ptName)
            local raw = RawKey(ptName)
            if key and key ~= "" then
                local current = reverseIndex[key]
                if current == nil then
                    reverseIndex[key] = itemID
                    searchKeys[#searchKeys + 1] = key
                elseif current ~= itemID then
                    local currentEN = enNames[current]
                    if currentEN ~= enName then
                        -- Duas IDs diferentes receberam o mesmo nome ptBR, mas apontam
                        -- para nomes originais diferentes. Nao escolhemos uma no chute.
                        reverseIndex[key] = false
                    end
                end
                if raw then rawCandidates[raw] = key end
            end
        end
    end

    -- Ha itens custom em que a propria base usada pelo servidor ja contem texto em ptBR.
    -- Se o nome digitado ja existe como nome de origem, deixamos a consulta intacta.
    for _, serverName in pairs(enNames) do
        if type(serverName) == "string" and serverName ~= "" then
            local raw = RawKey(serverName)
            local key = raw and rawCandidates[raw]
            if key then reverseIndex[key] = false end
        end
    end
end

local function FindExactItemIDSlow(text)
    local raw = RawKey(text)
    if not raw then return nil end

    local cached = slowExactCache[raw]
    if cached ~= nil then
        return cached ~= false and cached or nil
    end

    local compact = Compact(text)
    local wantedLength = compact and #compact or 0
    local found

    -- Fallback para entradas antigas em que ItemNameEN ficou igual ao ptBR.
    -- Fazemos isso apenas quando o indice rapido nao encontrou o nome e guardamos o
    -- resultado em cache, evitando varrer a base de novo para a mesma pesquisa.
    for itemID, ptName in pairs(A.ItemName or {}) do
        if type(ptName) == "string" and #ptName == wantedLength and RawKey(ptName) == raw then
            if found and found ~= itemID then
                found = false
                break
            end
            found = itemID
        end
    end

    slowExactCache[raw] = found or false
    return found ~= false and found or nil
end

local function ResolveAuctionSearchItemID(text)
    if type(text) ~= "string" or text == "" then return nil end
    if A.IsFeatureEnabled and not A.IsFeatureEnabled("auctionSearchPTBR", true) then return nil end

    local compact = Compact(text)
    local key = Normalize(compact)
    if not key or key == "" then return nil end

    BuildReverseIndex()

    local exact = reverseIndex[key]
    if type(exact) == "number" then
        return exact
    end
    if exact == false then
        return nil
    end

    -- Busca exata de seguranca para itens em que a tabela de origem antiga nao
    -- preservou corretamente o nome em ingles.
    local exactSlow = FindExactItemIDSlow(compact)
    if exactSlow then return exactSlow end

    -- Pesquisa parcial em ptBR so e convertida quando aponta para um unico item.
    -- Termos genericos continuam intactos para nao transformar uma busca ampla em
    -- um item aleatorio.
    if #key < 4 then return nil end

    local found
    for i = 1, #searchKeys do
        local ptKey = searchKeys[i]
        if ptKey:find(key, 1, true) then
            local itemID = reverseIndex[ptKey]
            if type(itemID) ~= "number" then
                return nil
            end
            if found and found ~= itemID then
                return nil
            end
            found = itemID
        end
    end
    return found
end

local function CachedServerName(itemID)
    if not itemID then return nil end

    if type(GetItemInfo) == "function" then
        local ok, name = pcall(GetItemInfo, itemID)
        if ok and type(name) == "string" and name ~= "" then
            return name
        end
    end

    local ptName = A.ItemName and A.ItemName[itemID]
    local enName = A.ItemNameEN and A.ItemNameEN[itemID]
    if type(enName) == "string" and enName ~= "" and enName ~= ptName then
        return enName
    end
    return nil
end

local waitFrame = CreateFrame("Frame")
waitFrame:Hide()
waitFrame:RegisterEvent("AUCTION_HOUSE_CLOSED")
waitFrame:SetScript("OnEvent", function()
    pendingQuery = nil
    waitFrame:Hide()
end)

local function SendPendingQuery()
    local pending = pendingQuery
    if not pending or not originalQueryAuctionItems then return end

    local serverName = CachedServerName(pending.itemID)
    if not serverName then return end

    pendingQuery = nil
    waitFrame:Hide()
    originalQueryAuctionItems(serverName, unpackArgs(pending.args, 1, pending.args.n))
    return true
end

waitFrame:SetScript("OnUpdate", function(self, elapsed)
    local pending = pendingQuery
    if not pending then
        self:Hide()
        return
    end

    pending.elapsed = (pending.elapsed or 0) + (elapsed or 0)
    pending.tick = (pending.tick or 0) + (elapsed or 0)
    if pending.tick < 0.05 then return end
    pending.tick = 0

    if SendPendingQuery() then return end

    -- Se o cache do cliente nao responder, nao deixamos a tela do leilao presa.
    if pending.elapsed >= 1.5 then
        local args = pending.args
        local originalName = pending.originalName
        pendingQuery = nil
        self:Hide()
        originalQueryAuctionItems(originalName, unpackArgs(args, 1, args.n))
    end
end)

local function QueueQueryUntilItemCached(itemID, originalName, ...)
    local args = { ... }
    args.n = select("#", ...)
    pendingQuery = {
        itemID = itemID,
        originalName = originalName,
        args = args,
        elapsed = 0,
        tick = 0,
    }

    -- A chamada tambem pede os dados ao cache do cliente quando ainda nao chegaram.
    if type(GetItemInfo) == "function" then pcall(GetItemInfo, itemID) end
    waitFrame:Show()
end

local function ResolveAuctionSearchName(text)
    local itemID = ResolveAuctionSearchItemID(text)
    if not itemID then return nil end
    return CachedServerName(itemID), itemID
end

A.ResolveAuctionSearchName = ResolveAuctionSearchName
A.ResolveAuctionSearchItemID = ResolveAuctionSearchItemID

local function QueryAuctionItemsPTBR(name, ...)
    local serverName, itemID = ResolveAuctionSearchName(name)
    if serverName then
        return originalQueryAuctionItems(serverName, ...)
    end

    if itemID then
        QueueQueryUntilItemCached(itemID, name, ...)
        return
    end

    return originalQueryAuctionItems(name, ...)
end

local function InstallAuctionSearchHook()
    if hookInstalled then return true end
    if type(_G.QueryAuctionItems) ~= "function" then return false end

    originalQueryAuctionItems = _G.QueryAuctionItems
    _G.QueryAuctionItems = QueryAuctionItemsPTBR
    hookInstalled = true
    return true
end

if not InstallAuctionSearchHook() then
    local loader = CreateFrame("Frame")
    loader:RegisterEvent("PLAYER_LOGIN")
    loader:SetScript("OnEvent", function(self)
        if InstallAuctionSearchHook() then
            self:UnregisterEvent("PLAYER_LOGIN")
        end
    end)
end
