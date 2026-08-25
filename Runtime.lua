-- Coisas compartilhadas que não precisam ficar entupindo o Core.lua.

local AES = AscensionPTBR or {}
AscensionPTBR = AES

AES.Runtime = AES.Runtime or {}
AES.Perf = AES.Perf or {}
AES.Diagnostics = AES.Diagnostics or {}

local Runtime = AES.Runtime
local Perf = AES.Perf
local Diagnostics = AES.Diagnostics


-- Um scheduler só. Nada de criar OnUpdate novo pra cada coisinha.
Runtime.tasks = Runtime.tasks or {}
Runtime.clock = Runtime.clock or 0
Runtime.frame = Runtime.frame or CreateFrame("Frame")

local function ReportError(err)
    Diagnostics.runtimeErrorCount = (Diagnostics.runtimeErrorCount or 0) + 1
    Diagnostics.lastRuntimeError = tostring(err or "erro desconhecido")
    Diagnostics.lastRuntimeErrorAt = time and time() or 0
    if geterrorhandler then
        local handler = geterrorhandler()
        if handler then handler(err) end
    end
end

local function HasTasks()
    return next(Runtime.tasks) ~= nil
end

local function RecomputeNextDue()
    local nextDue
    for _, task in pairs(Runtime.tasks) do
        local due = task and task.due
        if type(due) == "number" and (not nextDue or due < nextDue) then
            nextDue = due
        end
    end
    Runtime.nextDue = nextDue
    return nextDue
end

local function EnableDriver()
    if Runtime.frame:GetScript("OnUpdate") then return end
    Runtime.frame:SetScript("OnUpdate", Runtime.OnUpdate)
end

function Runtime.Cancel(key)
    if key ~= nil then Runtime.tasks[key] = nil end
    if not HasTasks() then
        Runtime.nextDue = nil
        Runtime.frame:SetScript("OnUpdate", nil)
    else
        RecomputeNextDue()
    end
end

function Runtime.After(key, delay, callback)
    if key == nil or type(callback) ~= "function" then return end
    local due = Runtime.clock + (tonumber(delay) or 0)
    Runtime.tasks[key] = {
        due = due,
        callback = callback,
        interval = nil,
        remaining = 1,
    }
    if not Runtime.nextDue or due < Runtime.nextDue then Runtime.nextDue = due end
    EnableDriver()
end

function Runtime.Repeat(key, firstDelay, interval, count, callback)
    if key == nil or type(callback) ~= "function" then return end
    count = tonumber(count) or 1
    if count < 1 then
        Runtime.Cancel(key)
        return
    end
    local due = Runtime.clock + (tonumber(firstDelay) or 0)
    Runtime.tasks[key] = {
        due = due,
        callback = callback,
        interval = tonumber(interval) or 0,
        remaining = count,
    }
    if not Runtime.nextDue or due < Runtime.nextDue then Runtime.nextDue = due end
    EnableDriver()
end

function Runtime.OnUpdate(self, dt)
    Runtime.clock = Runtime.clock + (dt or 0)
    local now = Runtime.clock

    -- Sem tarefa vencida, não fica passeando pela lista à toa.
    if Runtime.nextDue and now < Runtime.nextDue then return end

    for key, task in pairs(Runtime.tasks) do
        if task and now >= task.due then
            local keep = true
            local ok, result = pcall(task.callback)
            if not ok then
                keep = false
                ReportError(result)
            elseif result == false then
                keep = false
            end

            -- Se o callback mexeu na própria task, não pisa por cima dela.
            if Runtime.tasks[key] == task then
                task.remaining = (task.remaining or 1) - 1
                if keep and task.remaining > 0 and task.interval then
                    task.due = now + task.interval
                else
                    Runtime.tasks[key] = nil
                end
            end
        end
    end

    if not HasTasks() then
        Runtime.nextDue = nil
        self:SetScript("OnUpdate", nil)
    else
        RecomputeNextDue()
    end
end


-- Cada tela cuida da sua parte. Aqui só juntamos os pedidos de refresh pra uma não atropelar a outra.
Runtime.modules = Runtime.modules or {}
Runtime.moduleOrder = Runtime.moduleOrder or {}

function Runtime.RegisterModule(name, refresh, cleanup)
    if type(name) ~= "string" or name == "" or type(refresh) ~= "function" then return false end
    if not Runtime.modules[name] then
        Runtime.moduleOrder[#Runtime.moduleOrder + 1] = name
    end
    Runtime.modules[name] = {
        refresh = refresh,
        cleanup = type(cleanup) == "function" and cleanup or nil,
    }
    return true
end

function Runtime.RefreshModule(name, reason)
    local module = Runtime.modules[name]
    if not (module and type(module.refresh) == "function") then return false end
    local ok, result = pcall(module.refresh, reason or "manual")
    if not ok then
        ReportError(result)
        return false
    end
    return result ~= false
end

function Runtime.RefreshModules(reason, names)
    local refreshed = 0
    if type(names) == "table" then
        for i = 1, #names do
            if Runtime.RefreshModule(names[i], reason) then refreshed = refreshed + 1 end
        end
        return refreshed
    end

    for i = 1, #Runtime.moduleOrder do
        if Runtime.RefreshModule(Runtime.moduleOrder[i], reason) then refreshed = refreshed + 1 end
    end
    return refreshed
end

function Runtime.QueueModuleRefresh(reason, delay, names)
    Runtime.After("aptbr-linked-ui-refresh", delay or 0.04, function()
        Runtime.RefreshModules(reason or "queued", names)
    end)
end

AES.RefreshLinkedUI = function(reason)
    Runtime.QueueModuleRefresh(reason or "api", 0.02)
end

-- Primeiro passe quando a addon termina de carregar; outro ao entrar no mundo porque o Ascension monta tela nessa hora.
Runtime.moduleEventFrame = Runtime.moduleEventFrame or CreateFrame("Frame")
Runtime.moduleEventFrame:RegisterEvent("ADDON_LOADED")
Runtime.moduleEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
pcall(Runtime.moduleEventFrame.RegisterEvent, Runtime.moduleEventFrame, "ADDON_ACTION_BLOCKED")
pcall(Runtime.moduleEventFrame.RegisterEvent, Runtime.moduleEventFrame, "ADDON_ACTION_FORBIDDEN")
Runtime.moduleEventFrame:SetScript("OnEvent", function(_, event, arg1, arg2)
    if event == "ADDON_ACTION_BLOCKED" or event == "ADDON_ACTION_FORBIDDEN" then
        if arg1 == "AscensionPTBR" then
            Diagnostics.blockedCount = (Diagnostics.blockedCount or 0) + 1
            Diagnostics.lastBlockedEvent = event
            Diagnostics.lastBlockedFunction = tostring(arg2 or "UNKNOWN()")
            Diagnostics.lastBlockedAt = time and time() or 0
        end
        return
    end
    if event == "ADDON_LOADED" then
        if type(arg1) ~= "string" then return end
        -- Qualquer addon pode criar ou recriar frames depois do AscensionPTBR.
        -- A chave fixa do scheduler agrupa a rajada de ADDON_LOADED sem varrer a UI a cada evento.
        Runtime.QueueModuleRefresh("ADDON_LOADED:" .. arg1, arg1 == "AscensionPTBR" and 0.03 or 0.18)
        return
    end
    Runtime.QueueModuleRefresh(event, 0.12)
end)

SLASH_APTBRREFRESH1 = "/aptbrrefresh"
SlashCmdList["APTBRREFRESH"] = function()
    local count = Runtime.RefreshModules("slash")
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r: módulos sincronizados: " .. tostring(count) .. ".")
    end
end


-- Agrupa padrão pelo começo do texto. Menos regex por tooltip.
Perf.linePatternCache = Perf.linePatternCache or {}
Perf.linePatternCacheCount = Perf.linePatternCacheCount or 0
Perf.LINE_PATTERN_CACHE_LIMIT = Perf.LINE_PATTERN_CACHE_LIMIT or 4096
Perf.linePatternBuckets = nil
Perf.linePatternFallback = nil
Perf.linePatternSource = nil

local function PatternBucket(pattern)
    if type(pattern) ~= "string" then return "*" end
    local s = pattern
    if s:sub(1, 1) == "^" then s = s:sub(2) end

    if s:sub(1, 2) == "%+" then return "+" end
    if s:sub(1, 2) == "%-" then return "-" end
    if s:sub(1, 2) == "%(" then return "(" end

    -- Número aparece muito em mana, dano, alcance, recarga etc.
    if s:sub(1, 1) == "(" and s:sub(1, 18):find("%%d") then return "#" end

    local first = s:match("^([%a])")
    if first then return first:lower() end
    return "*"
end

local function TextBucket(text)
    local first = type(text) == "string" and text:sub(1, 1) or ""
    if first:match("%d") then return "#" end
    if first == "+" or first == "-" or first == "(" then return first end
    if first:match("%a") then return first:lower() end
    return "*"
end

function Perf.BuildLinePatternBuckets()
    local patterns = AES.LinePatterns or {}
    if Perf.linePatternSource == patterns and Perf.linePatternBuckets then return end

    local buckets = {}
    local fallback = {}
    for i = 1, #patterns do
        local pair = patterns[i]
        local key = pair and PatternBucket(pair[1]) or "*"
        if key == "*" then
            fallback[#fallback + 1] = i
        else
            local bucket = buckets[key]
            if not bucket then
                bucket = {}
                buckets[key] = bucket
            end
            bucket[#bucket + 1] = i
        end
    end

    Perf.linePatternBuckets = buckets
    Perf.linePatternFallback = fallback
    Perf.linePatternSource = patterns
end

local function TryPatternIndexes(text, patterns, indexes)
    if not indexes then return nil end
    for n = 1, #indexes do
        local pair = patterns[indexes[n]]
        if pair and pair[2] then
            local rep, changed = text:gsub(pair[1], pair[2])
            if changed > 0 and rep ~= text then return rep end
        end
    end
    return nil
end

function Perf.MatchDynamicLinePattern(text)
    if type(text) ~= "string" or text == "" then return nil end

    local cached = Perf.linePatternCache[text]
    if cached ~= nil then return cached ~= false and cached or nil end

    Perf.BuildLinePatternBuckets()
    local patterns = AES.LinePatterns or {}
    local key = TextBucket(text)
    local result = TryPatternIndexes(text, patterns, Perf.linePatternBuckets[key])
        or TryPatternIndexes(text, patterns, Perf.linePatternFallback)

    if Perf.linePatternCacheCount >= Perf.LINE_PATTERN_CACHE_LIMIT then
        Perf.linePatternCache = {}
        Perf.linePatternCacheCount = 0
    end
    Perf.linePatternCache[text] = result or false
    Perf.linePatternCacheCount = Perf.linePatternCacheCount + 1
    return result
end
