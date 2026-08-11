-- AscensionPTBR Runtime
-- Infraestrutura leve compartilhada para timers curtos e padrões de tooltip.
-- Mantida fora do Core.lua para reduzir complexidade e o número de locais
-- ativos no chunk principal do Lua 5.1.

local AES = AscensionPTBR or {}
AscensionPTBR = AES

AES.Runtime = AES.Runtime or {}
AES.Perf = AES.Perf or {}

local Runtime = AES.Runtime
local Perf = AES.Perf

-- ---------------------------------------------------------------------------
-- Scheduler compartilhado
-- ---------------------------------------------------------------------------
-- O cliente 3.3.5a não possui C_Timer.After. Antes, várias partes do addon
-- criavam seu próprio Frame + OnUpdate apenas para esperar alguns milissegundos.
-- Este scheduler concentra esses atrasos em um único OnUpdate e só fica ativo
-- enquanto existem tarefas pendentes.

Runtime.tasks = Runtime.tasks or {}
Runtime.clock = Runtime.clock or 0
Runtime.frame = Runtime.frame or CreateFrame("Frame")

local function ReportError(err)
    if geterrorhandler then
        local handler = geterrorhandler()
        if handler then handler(err) end
    end
end

local function HasTasks()
    return next(Runtime.tasks) ~= nil
end

local function EnableDriver()
    if Runtime.frame:GetScript("OnUpdate") then return end
    Runtime.frame:SetScript("OnUpdate", Runtime.OnUpdate)
end

function Runtime.Cancel(key)
    if key ~= nil then Runtime.tasks[key] = nil end
    if not HasTasks() then Runtime.frame:SetScript("OnUpdate", nil) end
end

function Runtime.After(key, delay, callback)
    if key == nil or type(callback) ~= "function" then return end
    Runtime.tasks[key] = {
        due = Runtime.clock + (tonumber(delay) or 0),
        callback = callback,
        interval = nil,
        remaining = 1,
    }
    EnableDriver()
end

function Runtime.Repeat(key, firstDelay, interval, count, callback)
    if key == nil or type(callback) ~= "function" then return end
    count = tonumber(count) or 1
    if count < 1 then
        Runtime.Cancel(key)
        return
    end
    Runtime.tasks[key] = {
        due = Runtime.clock + (tonumber(firstDelay) or 0),
        callback = callback,
        interval = tonumber(interval) or 0,
        remaining = count,
    }
    EnableDriver()
end

function Runtime.OnUpdate(self, dt)
    Runtime.clock = Runtime.clock + (dt or 0)
    local now = Runtime.clock

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

            -- O callback pode cancelar ou substituir a própria chave. Nesse
            -- caso, não sobrescrevemos a nova tarefa com o estado antigo.
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

    if not HasTasks() then self:SetScript("OnUpdate", nil) end
end

-- ---------------------------------------------------------------------------
-- Cache/indexação dos padrões de tooltip
-- ---------------------------------------------------------------------------
-- LinePatterns possui centenas de expressões. Em cache miss, o Core antigo
-- percorria todas elas. Aqui os padrões são separados pelo primeiro caractere
-- esperado, reduzindo bastante o conjunto testado na maioria dos tooltips.

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

    -- Capturas numéricas são muito comuns nos tooltips: mana, dano, alcance,
    -- atributos, recargas etc.
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
