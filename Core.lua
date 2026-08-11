local AES = AscensionPTBR or {}
AscensionPTBR = AES
AES.Perf = AES.Perf or {}

AES.SpellNameEN2ES = AES.SpellNameEN2ES or {}
AES.NameToIDs      = AES.NameToIDs or {}
AES.DescPairs      = AES.DescPairs or {}
AES.DescByID       = AES.DescByID or {}
AES.TipPairs       = AES.TipPairs or {}
AES.TipByID        = AES.TipByID or {}
AES.RankEN2ES      = AES.RankEN2ES or {}
AES.ItemName       = AES.ItemName or {}
AES.ItemNameEN     = AES.ItemNameEN or {}
AES.ItemDesc       = AES.ItemDesc or {}
AES.ItemDescEN     = AES.ItemDescEN or {}
AES.QuestTitle     = AES.QuestTitle or {}
AES.QuestTitleEN   = AES.QuestTitleEN or {}
AES.QuestData      = AES.QuestData or {}
AES.QuestObjectiveEN2PT = AES.QuestObjectiveEN2PT or {}
AES.QuestTextEN2PT = AES.QuestTextEN2PT or {}
AES.QuestTrackerNameEN2PT = {
    ["Broodwatcher Akhenat"] = "Vigia da Ninhada Akhenat",
    ["Malgorm Hollowhoof"] = "Malgorm Casco Oco",
    ["Presence of the Deceiver"] = "Presença do Enganador",
    ["Chimeric Embryo"] = "Embrião Quimérico",
    ["Bear Flank"] = "Flanco de Urso",
    ["Bear Flanks"] = "Flancos de Urso",
    ["Refreshing Spring Water"] = "Água Refrescante da Fonte",
    ["Refreshing Springwater"] = "Água Refrescante da Fonte",
    ["Goblin Spices"] = "Temperos Goblínicos",
    ["Ghost Dust"] = "Pó Fantasmagórico",
    ["Raw Spinefin Halibut"] = "Linguado Espinhacostas Cru",
    ["Large Hydra Scale"] = "Escama Grande de Hidra",
    ["Sandworm Meat"] = "Carne de Verme da Areia",
    ["Silithid Innards"] = "Vísceras de Silitídeo",
    ["Shard of Nevermelting Ice"] = "Estilhaço de Gelo que Nunca Derrete",
    ["Ice Cold Milk"] = "Leite Gelado",
    ["Sugar"] = "Açúcar",
    ["Thunderbrew Hops"] = "Lúpulos Cervaforte",
    ["Prophet's Oracular Orb"] = "Orbe Oracular do Profeta",
    ["Prophet’s Oracular Orb"] = "Orbe Oracular do Profeta",
    ["Cut of Good Meat"] = "Corte de Carne Boa",
    ["Necrotic Spore"] = "Esporo Necrótico",
    ["Necrotic Spores"] = "Esporos Necróticos",
}
AES.UnitName       = AES.UnitName or {}
AES.UnitNameEN     = AES.UnitNameEN or {}
AES.UnitSub        = AES.UnitSub or {}
AES.UnitSubEN      = AES.UnitSubEN or {}
AES.LinePatterns   = AES.LinePatterns or {}
AES.ValueWords     = AES.ValueWords or {}
AES.UIStrings      = AES.UIStrings or {}
AES.AreaNames      = AES.AreaNames or {}
AES.TalentUIExact  = AES.TalentUIExact or {}
AES.TalentUIGlobals = AES.TalentUIGlobals or {}
AES.AchName        = AES.AchName or {}
AES.AchNameEN      = AES.AchNameEN or {}
AES.AchDesc        = AES.AchDesc or {}
AES.AchDescEN      = AES.AchDescEN or {}
AES.AchReward      = AES.AchReward or {}
AES.AchRewardEN    = AES.AchRewardEN or {}

local db

local defaults = { spells = true, items = true, units = true, patterns = true, flavor = true,
                   ui = true, achievements = true, quests = true, gossip = true }

local function TranslateValue(v)
    local w = AES.ValueWords
    if w[v] then return w[v] end
    if AES.SpellNameEN2ES[v] then return AES.SpellNameEN2ES[v] end
    local num, word = v:match("^([%d%.,]+) (.+)$")
    if num and w[word] then return num .. " " .. w[word] end
    return v
end

local function ApplyTemplate(output, caps)
    return (output:gsub("{{(%d+)}}", function(n)
        local c = caps[tonumber(n)]
        if c == nil then return "" end
        return TranslateValue(c)
    end))
end

local subPatternCache = {}

local function SegmentPattern(anchored)
    local sub = subPatternCache[anchored]
    if sub == nil then
        sub = anchored
        if sub:sub(1, 1) == "^" then sub = sub:sub(2) end
        if sub:sub(-4) == "%s*$" then sub = sub:sub(1, -5) end
        subPatternCache[anchored] = sub
    end
    return sub
end

local function MatchPair(text, pair)
    local work = text
    local caps = { work:match(pair[1]) }
    if caps[1] == nil and (work:find("\r", 1, true) or work:find("|R", 1, true)) then
        work = work:gsub("\r", ""):gsub("|R", "|r")
        caps = { work:match(pair[1]) }
    end
    if caps[1] ~= nil then
        return ApplyTemplate(pair[2], caps)
    end

    local sub = SegmentPattern(pair[1])
    if #sub < 20 then return nil end
    local found = { work:find(sub) }
    local s, e = found[1], found[2]
    if not s or (e - s) < 15 then return nil end
    local segCaps = {}
    for i = 3, #found do segCaps[#segCaps + 1] = found[i] end
    if #segCaps == 0 then segCaps[1] = work:sub(s, e) end
    local translated = ApplyTemplate(pair[2], segCaps)
    return work:sub(1, s - 1) .. translated .. work:sub(e + 1)
end

local function TryPair(fs, text, pair)
    local nt = MatchPair(text, pair)
    if nt then
        pcall(fs.SetText, fs, nt)
        return true
    end
    return false
end

local function NpcIdFromGUID(guid)
    if not guid then return nil end
    if guid:find("-", 1, true) then
        local unitType, rest = strsplit("-", guid, 2)
        if unitType == "Creature" or unitType == "Vehicle" or unitType == "Pet" then
            return tonumber((select(5, strsplit("-", rest))))
        end
    elseif guid:sub(1, 2) == "0x" then
        local hex = guid:sub(3)
        if #hex == 16 and hex:match("^F1[345]") then
            return tonumber(hex:sub(5, 10), 16)
        end
    end
    return nil
end

local function TooltipLines(tip)
    local name, lines = tip:GetName(), {}
    for i = 1, tip:NumLines() do
        local L = _G[name .. "TextLeft" .. i]
        local R = _G[name .. "TextRight" .. i]
        if L and L:GetText() then lines[#lines + 1] = L end
        if R and R:GetText() then lines[#lines + 1] = R end
    end
    return lines
end

local function TryPairSet(fs, text, pairIndexes, pairsTable)
    if type(pairIndexes) == "number" then
        local pair = pairsTable[pairIndexes]
        return pair and TryPair(fs, text, pair) or false
    end
    for _, idx in ipairs(pairIndexes) do
        local pair = pairsTable[idx]
        if pair and TryPair(fs, text, pair) then return true end
    end
    return false
end

local function MatchPairSet(text, pairIndexes, pairsTable)
    if not pairIndexes then return nil end
    if type(pairIndexes) == "number" then
        local pair = pairsTable[pairIndexes]
        return pair and MatchPair(text, pair) or nil
    end
    for _, idx in ipairs(pairIndexes) do
        local pair = pairsTable[idx]
        local nt = pair and MatchPair(text, pair)
        if nt then return nt end
    end
    return nil
end

local function TranslateBodyByPairs(tip, pairIndexes, pairsTable)
    if not pairIndexes then return end
    local name = tip:GetName()
    for i = 2, tip:NumLines() do
        local fs = _G[name .. "TextLeft" .. i]
        local text = fs and fs:GetText()
        if text and #text > 3 then
            if TryPairSet(fs, text, pairIndexes, pairsTable) then return true end
        end
    end
    return false
end

local function PrefijoDe(texto, cuantas)
    local s = texto:gsub("|c%x+", ""):gsub("|r", ""):gsub("|n", " ")
    local p, n = {}, 0
    for w in s:gmatch("%a+") do
        n = n + 1
        p[n] = w:lower()
        if n == cuantas then break end
    end
    return table.concat(p, " ")
end

local function TranslateBodyByPrefix(tip)
    local name = tip:GetName()
    local hecho = false
    for i = 2, tip:NumLines() do
        local fs = _G[name .. "TextLeft" .. i]
        local text = fs and fs:GetText()
        if text and #text > 12 then

            for cuantas = 8, 3, -1 do
                local pref = PrefijoDe(text, cuantas)
                if #pref >= 8 then
                    local c = AES.DescByPrefix and AES.DescByPrefix[pref]
                    if c and TryPairSet(fs, text, c, AES.DescPairs) then
                        hecho = true
                        break
                    end
                    c = AES.TipByPrefix and AES.TipByPrefix[pref]
                    if c and TryPairSet(fs, text, c, AES.TipPairs) then
                        hecho = true
                        break
                    end
                end
            end
        end
    end
    return hecho
end
AES.TranslateBodyByPrefix = TranslateBodyByPrefix

local function TranslateSpellWord(w)
    local map = AES.SpellNameEN2ES
    return map[w] or map[w .. "s"] or (w:sub(-1) == "s" and map[w:sub(1, -2)]) or nil
end

local TranslateStaticText

-- Cache e indexação de padrões ficam em Runtime.lua.

local function MatchLinePatterns(text)
    local function apply(s)
        local exact = TranslateStaticText and TranslateStaticText(s)
        if exact then return exact end

        -- Runtime.lua fornece o caminho otimizado. Se ele nao tiver sido
        -- carregado (TOC antigo, arquivo ausente ou falha de load), usamos
        -- o caminho compatibilidade em vez de quebrar o tooltip.
        if AES.Perf and type(AES.Perf.MatchDynamicLinePattern) == "function" then
            return AES.Perf.MatchDynamicLinePattern(s)
        end

        local patterns = AES.LinePatterns or {}
        for i = 1, #patterns do
            local pair = patterns[i]
            if pair and pair[1] and pair[2] then
                local rep, changed = s:gsub(pair[1], pair[2])
                if changed > 0 and rep ~= s then return rep end
            end
        end
        return nil
    end
    local rep = apply(text)
    if rep then return rep end
    local pre, core, post = "", text, ""
    local peeling = true
    while peeling do
        peeling = false
        local sp, rest = core:match("^(%s+)(.*)$")
        if sp then pre, core, peeling = pre .. sp, rest, true end
        local c = core:match("^(|c%x%x%x%x%x%x%x%x)")
        if c then pre, core, peeling = pre .. c, core:sub(#c + 1), true end
        local body, spf = core:match("^(.-)(%s+)$")
        if spf then core, post, peeling = body, spf .. post, true end
        local bodyR = core:match("^(.-)|r$")
        if bodyR then core, post, peeling = bodyR, "|r" .. post, true end
    end
    if core ~= "" and core ~= text then
        rep = apply(core)
        if rep then return pre .. rep .. post end
    end
    return nil
end

local function TranslateMultilineText(text)
    local contexts = {}
    local lines = {}
    local touched = false
    for line in (text .. "\n"):gmatch("(.-)\n") do
        local l = line:gsub("\r", "")
        local icon, rest = l:match("^(%s*|T[^|]*|t%s*)(.+)$")
        local body = rest or l
        local pre, nm, post = body:match("^(%s*)(.-)(%s*)$")

        local c1, inner, c2 = "", nm or "", ""
        local wc1, winner, wc2 = (nm or ""):match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
        if winner then
            c1, inner, c2 = wc1, winner, wc2
        end
        local key = (inner ~= "" and AES.SpellNameEN2ES[inner]) and inner
            or (nm and AES.SpellNameEN2ES[nm]) and nm or nil
        if key then
            local es = AES.SpellNameEN2ES[key]
            if key == inner then
                l = (icon or "") .. (pre or "") .. c1 .. es .. c2 .. (post or "")
            else
                l = (icon or "") .. (pre or "") .. es .. (post or "")
            end
            touched = true
        end
        local ctxKey = (inner ~= "" and AES.NameToIDs[inner] and inner)
            or (nm and AES.NameToIDs[nm] and nm) or nil
        if ctxKey then
            contexts[#contexts + 1] = AES.NameToIDs[ctxKey]
        end

        if not key then
            local rep = MatchLinePatterns(l)
            if rep then
                l = rep
                touched = true
            end
        end
        lines[#lines + 1] = l
    end
    local joined = table.concat(lines, "\n")
    for _, ctx in ipairs(contexts) do
        for _, id in ipairs(ctx) do
            for _, pt in ipairs({ { AES.TipByID[id], AES.TipPairs }, { AES.DescByID[id], AES.DescPairs } }) do
                if pt[1] then
                    local nt = MatchPairSet(joined, pt[1], pt[2])
                    if nt then
                        joined = nt
                        touched = true
                    end
                end
            end
        end
    end
    if touched and joined ~= text then
        return joined
    end
    return nil
end

local hookedEmbedFS = setmetatable({}, { __mode = "k" })
local inEmbedHook = false
local function HookEmbedFS(fs)
    if hookedEmbedFS[fs] or not fs.SetText then return end
    hookedEmbedFS[fs] = true
    hooksecurefunc(fs, "SetText", function(self, txt)
        if inEmbedHook or not db or not db.spells then return end
        if type(txt) ~= "string" or not txt:find("\n") then return end
        local nt = TranslateMultilineText(txt)
        if nt then
            inEmbedHook = true
            pcall(self.SetText, self, nt)
            inEmbedHook = false
        end
    end)
end

local function CollectTooltipFontStrings(tip)
    local tipName = tip:GetName()
    local list, seen = {}, {}
    for i = 2, tip:NumLines() do
        local fs = _G[tipName .. "TextLeft" .. i]
        if fs then
            list[#list + 1] = fs
            seen[fs] = true
        end
    end
    local function addRegions(frame)
        if not frame or not frame.GetRegions then return end
        local ok, regions = pcall(function() return { frame:GetRegions() } end)
        if not ok then return end
        for _, r in ipairs(regions) do
            if r and not seen[r] and r.IsObjectType and r:IsObjectType("FontString") then
                local nm = r.GetName and r:GetName()
                if nm ~= tipName .. "TextLeft1" then
                    list[#list + 1] = r
                    seen[r] = true
                end
            end
        end
    end
    addRegions(tip)
    if tip.GetChildren then
        local ok, children = pcall(function() return { tip:GetChildren() } end)
        if ok then
            for _, child in ipairs(children) do
                addRegions(child)
            end
        end
    end
    return list
end

local QUEST_TOOLTIP_STATIC = {
    ["You are participating in this quest"] = "Você está participando desta missão",
    ["You are participating in this quest."] = "Você está participando desta missão.",
    ["You are not participating in this quest"] = "Você não está participando desta missão",
    ["You are not participating in this quest."] = "Você não está participando desta missão.",
    ["You do not meet the requirements for this quest"] = "Você não cumpre os requisitos desta missão",
    ["Requirements"] = "Requisitos",
    ["Requirements:"] = "Requisitos:",
}

-- Todos os pontos da interface passam pelo mesmo resolvedor de títulos.
-- O diário normalmente fornece o ID, mas NPCs e rastreadores podem fornecer
-- apenas texto formatado, como "[80] Título" ou "Título (Complete)".
local function TranslateQuestTitleText(text, depth)
    if type(text) ~= "string" or text == "" then return nil end
    depth = depth or 0
    if depth > 5 then return nil end

    local translated = AES.QuestTitleEN2ES and AES.QuestTitleEN2ES[text]
    if translated and translated ~= false then
        return AES.QuestRenderPT and AES.QuestRenderPT(translated) or translated
    end

    local function rebuild(prefix, body, suffix)
        if not body or body == "" then return nil end
        local pt = TranslateQuestTitleText(body, depth + 1)
        if pt then return (prefix or "") .. pt .. (suffix or "") end
    end

    local prefix, body, suffix = text:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
    local pt = rebuild(prefix, body, suffix)
    if pt then return pt end

    prefix, body = text:match("^(|T.-|t%s*)(.+)$")
    pt = rebuild(prefix, body, "")
    if pt then return pt end

    prefix, body, suffix = text:match("^(%s*%[%d+%+%]%s*)(.-)(%s*)$")
    pt = rebuild(prefix, body, suffix)
    if pt then return pt end

    prefix, body, suffix = text:match("^(%s*%[%d+%]%s*)(.-)(%s*)$")
    pt = rebuild(prefix, body, suffix)
    if pt then return pt end

    prefix, body, suffix = text:match("^(%s*[-•]%s*)(.-)(%s*)$")
    pt = rebuild(prefix, body, suffix)
    if pt then return pt end

    body = text:match("^(.-)%s*%([Cc]omplete%)%s*$")
    pt = body and TranslateQuestTitleText(body, depth + 1)
    if pt then return pt .. " (Concluída)" end

    body = text:match("^(.-)%s*%([Cc]ompleted%)%s*$")
    pt = body and TranslateQuestTitleText(body, depth + 1)
    if pt then return pt .. " (Concluída)" end

    body = text:match("^(.-)%s+%-%s+[Cc]omplete%s*$")
    pt = body and TranslateQuestTitleText(body, depth + 1)
    if pt then return pt .. " - Concluída" end

    body = text:match("^(.-)%s+%-%s+[Cc]ompleted%s*$")
    pt = body and TranslateQuestTitleText(body, depth + 1)
    if pt then return pt .. " - Concluída" end

    local first, rest = text:match("^([^\n]+)(\n.+)$")
    pt = first and TranslateQuestTitleText(first, depth + 1)
    if pt then return pt .. rest end
    return nil
end
AES.TranslateQuestTitleText = TranslateQuestTitleText

local function TranslateQuestTooltipText(text)
    if not (db and db.quests) or type(text) ~= "string" or text == "" then return nil end
    local function render(v)
        return AES.QuestRenderPT and AES.QuestRenderPT(v) or v
    end

    local normalizedQuestText = text:gsub("\\n", "\n"):gsub("|n", "\n")
    normalizedQuestText = normalizedQuestText:gsub("%s+", " ")
        :gsub("^%s+", ""):gsub("%s+$", "")
    local direct = (AES.QuestUIExact and AES.QuestUIExact[text])
        or QUEST_TOOLTIP_STATIC[text]
        or (AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[text])
        or (AES.QuestRuntimeTextNormalized
            and AES.QuestRuntimeTextNormalized[normalizedQuestText])
    if direct and direct ~= false then return render(direct) end

    -- Preserva códigos de cor, ícones e marcadores que o rastreador acrescenta
    -- ao texto depois de consultar o diário. A v39 tentava localizar o bloco
    -- completo e falhava porque esses adornos não existem no Quests.lua.
    local prefix, body, suffix = text:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
    if body and body ~= text then
        local translated = TranslateQuestTooltipText(body)
        if translated then return prefix .. translated .. suffix end
    end
    prefix, body = text:match("^(|T.-|t%s*)(.+)$")
    if body and body ~= text then
        local translated = TranslateQuestTooltipText(body)
        if translated then return prefix .. translated end
    end

    -- Alguns painéis do Ascension juntam título, resumo e objetivo em um único
    -- FontString. Traduz cada linha separadamente e também converte os escapes
    -- textuais que certas builds exibem literalmente.
    local multiline = text:gsub("\\n", "\n"):gsub("|n", "\n")
    if multiline:find("\n", 1, true) then
        local out, changed, pos = {}, multiline ~= text, 1
        while true do
            local nl = multiline:find("\n", pos, true)
            local line = nl and multiline:sub(pos, nl - 1) or multiline:sub(pos)
            local translated = line ~= "" and TranslateQuestTooltipText(line) or nil
            out[#out + 1] = translated or line
            if translated and translated ~= line then changed = true end
            if not nl then break end
            out[#out + 1] = "\n"
            pos = nl + 1
        end
        if changed then return table.concat(out) end
    end

    -- O Ascension gera o cabeçalho do rastreador com a quantidade em tempo real
    -- e algumas versões usam a grafia incorreta "Objetives".
    local objectiveCount = text:match("^Objectives%s*%((%d+)%)$")
        or text:match("^Objetives%s*%((%d+)%)$")
    if objectiveCount then return "Objetivos (" .. objectiveCount .. ")" end

    -- Preserva o texto do objetivo e traduz o estado de conclusão mesmo quando
    -- o cliente acrescenta o sufixo depois de consultar a base do addon.
    local completeBody = text:match("^(.-)%s*%([Cc]omplete[d]?%)%s*$")
    if completeBody and completeBody ~= "" then
        local completePT = (AES.QuestUIExact and AES.QuestUIExact[completeBody])
            or (AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[completeBody])
        if completePT and completePT ~= false then
            return render(completePT) .. " (Concluído)"
        end
    end

    -- Normaliza o lado textual dos contadores do Diário/rastreador. O servidor
    -- pode enviar o mesmo objetivo em ordens diferentes, por exemplo:
    -- "0/8 Mottled Boar slain", "Mottled Boar slain: 0/8" ou
    -- "Mottled Boar slain 0/8". O contador continua vindo do servidor.
    local function trackedBodyPT(body)
        if type(body) ~= "string" or body == "" then return nil end
        local directPT = (AES.QuestUIExact and AES.QuestUIExact[body])
            or (AES.UnitNameEN2ES and AES.UnitNameEN2ES[body])
            or (AES.ItemNameEN2ES and AES.ItemNameEN2ES[body])
            or (AES.QuestTrackerNameEN2PT and AES.QuestTrackerNameEN2PT[body])
            or (AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[body])
        if directPT and directPT ~= false then return render(directPT) end

        local unitBody = body:match("^(.-)%s+[Ss]lain$")
        local actionPT = unitBody and "abatido" or nil
        if not unitBody then unitBody = body:match("^(.-)%s+[Kk]illed$"); actionPT = unitBody and "eliminado" or nil end
        if not unitBody then unitBody = body:match("^(.-)%s+[Dd]estroyed$"); actionPT = unitBody and "destruído" or nil end
        if not unitBody then unitBody = body:match("^(.-)%s+[Rr]escued$"); actionPT = unitBody and "resgatado" or nil end
        if not unitBody then unitBody = body:match("^(.-)%s+[Ff]reed$"); actionPT = unitBody and "libertado" or nil end
        if unitBody then
            local unitPT = (AES.UnitNameEN2ES and AES.UnitNameEN2ES[unitBody])
                or (AES.QuestTrackerNameEN2PT and AES.QuestTrackerNameEN2PT[unitBody])
            if unitPT and unitPT ~= false then
                return render(unitPT) .. " " .. actionPT
            end
        end

        -- Objetivos de coleta também podem carregar um verbo após o nome do item.
        -- O nome traduzido já é suficiente no contador e evita flexão de gênero
        -- incorreta em itens como "Pearl collected" / "Supplies gathered".
        local itemBody = body:match("^(.-)%s+[Cc]ollected$")
        if not itemBody then itemBody = body:match("^(.-)%s+[Gg]athered$") end
        if not itemBody then itemBody = body:match("^(.-)%s+[Ff]ound$") end
        if not itemBody then itemBody = body:match("^(.-)%s+[Oo]btained$") end
        if not itemBody then itemBody = body:match("^(.-)%s+[Uu]sed$") end
        if itemBody then
            local itemPT = (AES.ItemNameEN2ES and AES.ItemNameEN2ES[itemBody])
                or (AES.QuestTrackerNameEN2PT and AES.QuestTrackerNameEN2PT[itemBody])
            if itemPT and itemPT ~= false then return render(itemPT) end
        end
        return nil
    end

    -- Forma "0/8 Nome".
    local progress, progressBody = text:match("^(%d+/%d+)%s+(.+)$")
    if progressBody and progressBody ~= "" then
        local progressPT = trackedBodyPT(progressBody)
        if progressPT then return progressPT .. ": " .. progress end
    end

    -- Forma "Nome: 0/8".
    local counterBody, counter = text:match("^(.-):%s*(%d+/%d+)%s*$")
    if counterBody and counterBody ~= "" then
        local counterPT = trackedBodyPT(counterBody)
        if counterPT then return counterPT .. ": " .. counter end
    end

    -- Algumas builds omitem os dois-pontos: "Nome abatido 0/8".
    local trailingBody, trailingCounter = text:match("^(.-)%s+(%d+/%d+)%s*$")
    if trailingBody and trailingBody ~= "" then
        local trailingPT = trackedBodyPT(trailingBody)
        if trailingPT then return trailingPT .. ": " .. trailingCounter end
    end

    local title = TranslateQuestTitleText(text)
    if title then return title end

    -- Mantém os marcadores do rastreador ao trocar o texto.
    local prefix, body = text:match("^(%s*[-•]%s*)(.-)%s*$")
    if body and body ~= "" then
        local translated = (AES.QuestUIExact and AES.QuestUIExact[body])
            or (AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[body])
            or (AES.QuestTextEN2PT and AES.QuestTextEN2PT[body])
            or QUEST_TOOLTIP_STATIC[body]
        if translated and translated ~= false then return prefix .. render(translated) end
        local title = TranslateQuestTitleText(body)
        if title then return prefix .. title end
    end
    return nil
end

local function TranslateTooltipLines(tip)
    if not db then return end
    local tipName = tip:GetName()
    local first = _G[tipName .. "TextLeft1"]
    local firstText = first and first:GetText()
    local firstQuestText = firstText and TranslateQuestTooltipText(firstText)
    if firstQuestText then pcall(first.SetText, first, firstQuestText) end
    local contexts = {}
    local contextIds = nil
    for _, fs in ipairs(CollectTooltipFontStrings(tip)) do
        local text = fs and fs:GetText()
        if text and text ~= "" then
            local changed = false

            local questText = TranslateQuestTooltipText(text)
            if questText then
                pcall(fs.SetText, fs, questText)
                text = questText
                changed = true
            end

            if db.spells and text:find("\n") then
                local nt = TranslateMultilineText(text)
                if nt then
                    pcall(fs.SetText, fs, nt)
                    text = nt
                    changed = false
                end
                HookEmbedFS(fs)
            end
            if db.spells then

                local icon, rest = text:match("^(|T.-|t%s*)(.+)$")
                local body = rest or text
                local pre, plainName, post = body:match("^(%s*)(.-)(%s*)$")

                local esCustom = db.ui and AES.CustomUI and plainName and AES.CustomUI[plainName]
                local esName = plainName and AES.SpellNameEN2ES[plainName]
                if esCustom then
                    pcall(fs.SetText, fs, (icon or "") .. (pre or "") .. esCustom .. (post or ""))
                    changed = true
                elseif esName then
                    pcall(fs.SetText, fs, (icon or "") .. (pre or "") .. esName .. (post or ""))
                    contextIds = AES.NameToIDs[plainName]
                    if contextIds then contexts[#contexts + 1] = contextIds end
                    changed = true
                elseif plainName and AES.NameToIDs[plainName] then
                    contextIds = AES.NameToIDs[plainName]
                    contexts[#contexts + 1] = contextIds
                end

                if not changed and db.ui then
                    local esUI = (AES.CustomUI and AES.CustomUI[text])
                        or (AES.UIStringsByEN and AES.UIStringsByEN[text])
                    if esUI then
                        fs:SetText(esUI)
                        changed = true
                    end
                end

                if not changed and #contexts > 0 then
                    for _, ctx in ipairs(contexts) do
                        for _, id in ipairs(ctx) do
                            if (AES.TipByID[id] and TryPairSet(fs, text, AES.TipByID[id], AES.TipPairs))
                                or (AES.DescByID[id] and TryPairSet(fs, text, AES.DescByID[id], AES.DescPairs)) then
                                changed = true
                                break
                            end
                        end
                        if changed then break end
                    end
                end

                -- Itens customizados nem sempre expõem GetItemSpell. Procura
                -- o efeito pelo corpo da linha, sem depender do ID do feitiço,
                -- e preserva o prefixo semântico do tooltip.
                if not changed then
                    local effectPrefix, effectBody = text:match("^(Equip:%s+)(.+)$")
                    local effectPrefixPT = "Equipar: "
                    if not effectBody then
                        effectPrefix, effectBody = text:match("^(Use:%s+)(.+)$")
                        effectPrefixPT = "Uso: "
                    end
                    if not effectBody then
                        effectPrefix, effectBody = text:match("^(Chance on hit:%s+)(.+)$")
                        effectPrefixPT = "Chance ao acertar: "
                    end
                    if effectBody then
                        local fearDuration = effectBody:match(
                            "^Chance upon dealing direct magic damage to scare a creature, causing it to run in fear for up to ([%d%.,]+) sec%.?$")
                        if fearDuration then
                            local translated = "Ao causar dano mágico direto, há uma chance de amedrontar a criatura, fazendo-a fugir por até "
                                .. fearDuration .. " s."
                            pcall(fs.SetText, fs, effectPrefixPT .. translated)
                            text = effectPrefixPT .. translated
                            changed = true
                        end
                        for wordCount = 8, 3, -1 do
                            if changed then break end
                            local bodyPrefix = PrefijoDe(effectBody, wordCount)
                            if #bodyPrefix >= 8 then
                                local candidates = AES.TipByPrefix and AES.TipByPrefix[bodyPrefix]
                                local translated = candidates and MatchPairSet(effectBody, candidates, AES.TipPairs)
                                if not translated then
                                    candidates = AES.DescByPrefix and AES.DescByPrefix[bodyPrefix]
                                    translated = candidates and MatchPairSet(effectBody, candidates, AES.DescPairs)
                                end
                                if translated then
                                    pcall(fs.SetText, fs, effectPrefixPT .. translated)
                                    text = effectPrefixPT .. translated
                                    changed = true
                                    break
                                end
                            end
                        end
                    end
                end

                if not changed and #text > 12 then
                    for cuantas = 8, 3, -1 do
                        local pref = PrefijoDe(text, cuantas)
                        if #pref >= 8 then
                            local c = AES.DescByPrefix and AES.DescByPrefix[pref]
                            if c and TryPairSet(fs, text, c, AES.DescPairs) then
                                changed = true
                                break
                            end
                            c = AES.TipByPrefix and AES.TipByPrefix[pref]
                            if c and TryPairSet(fs, text, c, AES.TipPairs) then
                                changed = true
                                break
                            end
                        end
                    end
                end
            end
            if not changed and db.patterns then
                text = fs:GetText()

                local new = text
                for _, p in ipairs(AES.AnywherePlain or {}) do
                    local s = new:find(p[1], 1, true)
                    if s then
                        new = new:sub(1, s - 1) .. p[2] .. new:sub(s + #p[1])
                    end
                end
                new = new:gsub("Drains (%d+)%% Maximum Mana", "Drena %1%% da mana máxima")
                new = new:gsub("Applies (%d+) ([%a][%a%s':]*[%a])", function(n, aura)
                    return "Aplica " .. n .. " " .. (TranslateSpellWord(aura) or aura)
                end)
                new = new:gsub("Generates (%d+) ([%a][%a%s':]*[%a])", function(n, res)
                    return "Gera " .. n .. " " .. (TranslateSpellWord(res) or res)
                end)

                new = new:gsub("Restores (%d+) health over (%d+) sec%.", "Restaura %1 de vida ao longo de %2 s.")
                new = new:gsub("Restores (%d+) mana over (%d+) sec%.", "Restaura %1 de mana ao longo de %2 s.")
                new = new:gsub("Must remain seated while eating%.", "Você precisa permanecer sentado enquanto come.")
                new = new:gsub("Must remain seated while drinking%.", "Você precisa permanecer sentado enquanto bebe.")
                new = new:gsub("If you spend at least (%d+) seconds eating you will become well fed and gain (%d+) (%a+) and (%a+) for (%d+) min%.",
                    function(s, v, st1, st2, m)
                        local SW = { Stamina = "vigor", Spirit = "espírito", Intellect = "intelecto",
                                     Strength = "força", Agility = "agilidade" }
                        return "Se você passar pelo menos " .. s .. " s comendo, ficará bem alimentado e receberá "
                            .. v .. " de " .. (SW[st1] or TranslateSpellWord(st1) or st1)
                            .. " e " .. (SW[st2] or TranslateSpellWord(st2) or st2) .. " por " .. m .. " min."
                    end)

                local function teachRepl(verb)
                    return function(thing)
                        local es = AES.SpellNameEN2ES[thing] or (AES.ItemNameEN2ES and AES.ItemNameEN2ES[thing]) or thing
                        return "Ensina você a " .. verb .. " " .. es .. "."
                    end
                end
                new = new:gsub("Teaches you how to cook a delicious (.-)%.", teachRepl("cozinhar"))
                new = new:gsub("Teaches you how to (%a+) (.-)%.", function(verb, thing)
                    local V = { cook = "cozinhar", make = "fabricar", craft = "criar",
                                brew = "preparar", sew = "costurar", smelt = "fundir",
                                forge = "forjar", mix = "misturar", create = "criar",
                                conjure = "conjurar", cut = "lapidar", inscribe = "inscrever",
                                engrave = "gravar", transmute = "transmutar", summon = "evocar" }
                    local v = V[verb]
                    if not v then return nil end
                    return teachRepl(v)(thing)
                end)

                new = new:gsub("Rank (%d+)/(%d+)", "Grau %1/%2")
                new = new:gsub("Level: (%d+)", "Nível: %1")
                new = new:gsub("Lasts (%d+) sec?,? ?stacking (%d+) times", "Dura %1 s e acumula até %2 vezes")

                new = new:gsub("(|T[^|]*|t ?)([%a][%w' %-]+)", function(icon, nm)
                    local es = AES.SpellNameEN2ES[nm] or TranslateSpellWord(nm)
                    return icon .. (es or nm)
                end)

                new = new:gsub("Usable while in (|c%x%x%x%x%x%x%x%x)(%a[%a%s']*%a)(|r)", function(c, w, r)
                    return "Pode ser usado durante " .. c .. (TranslateSpellWord(w) or w) .. r
                end)
                new = new:gsub("Usable while in (%a[%a%s']*%a)", function(w)
                    return "Pode ser usado durante " .. (TranslateSpellWord(w) or w)
                end)

                new = new:gsub("^Requires (.+)$", function(list)
                    local parts = {}
                    for raw in list:gmatch("[^,]+") do
                        local w = raw:match("^%s*(.-)%s*$")
                        local lvl = w:match("^[Ll]evel (%d+)$")

                        local base, qty = w:match("^(.-)%s*%((%d+)%)$")
                        local core = base or w
                        local es = (lvl and ("nível " .. lvl))
                            or (AES.ProfessionWords and AES.ProfessionWords[core])
                            or (AES.WeaponWords and AES.WeaponWords[core])
                            or TranslateSpellWord(core)
                            or (AES.ItemNameEN2ES and AES.ItemNameEN2ES[core])
                            or core
                        parts[#parts + 1] = es .. (qty and (" (" .. qty .. ")") or "")
                    end
                    return "Requer " .. table.concat(parts, ", ")
                end)

                do
                    local pre, preES
                    if new:sub(1, 7) == "Equip: " then
                        pre, preES = "Equip: ", "Equipar: "
                    elseif new:sub(1, 5) == "Use: " then
                        pre, preES = "Use: ", "Uso: "
                    elseif new:sub(1, 15) == "Chance on hit: " then
                        pre, preES = "Chance on hit: ", "Chance ao acertar: "
                    end
                    if pre and AES.TranslateSystemText then
                        local rest = new:sub(#pre + 1)

                        local body, cd = rest:match("^(.-)%s+(%(%d+ %a+%.? Cooldown%))$")
                        body = body or rest
                        local tr = AES.TranslateSystemText(body)
                        local cdES
                        if cd then
                            cdES = cd:gsub("%((%d+) Min Cooldown%)", "(Recarga: %1 min)")
                            cdES = cdES:gsub("%((%d+) Sec Cooldown%)", "(Recarga: %1 s)")
                            cdES = cdES:gsub("%((%d+) Hrs? Cooldown%)", "(Recarga: %1 h)")
                            cdES = cdES:gsub("%((%d+) Days? Cooldown%)", "(Recarga: %1 d)")
                        end
                        if tr ~= body or (cdES and cdES ~= cd) then
                            new = preES .. tr .. (cdES and (" " .. cdES) or "")
                        end
                    end
                end
                if new ~= text then
                    fs:SetText(new)
                    text = new
                end

                local rep = MatchLinePatterns(text)
                if rep then
                    fs:SetText(rep)
                elseif AES.TranslateSystemTextStrict and not text:find("\n") then
                    local tr = AES.TranslateSystemTextStrict(text)
                    if tr ~= text then fs:SetText(tr) end
                end
            end
        end
    end

    if db.patterns then
        for i = 1, tip:NumLines() do
            local fs = _G[tipName .. "TextRight" .. i]
            local text = fs and fs:GetText()
            if text and text ~= "" then
                local rep = MatchLinePatterns(text)
                if rep then
                    fs:SetText(rep)
                elseif AES.TranslateSystemTextStrict and not text:find("\n") then
                    local tr = AES.TranslateSystemTextStrict(text)
                    if tr ~= text then fs:SetText(tr) end
                end
            end
        end
    end
end

local ApplyLinePatterns = TranslateTooltipLines
AES.TranslateTooltipLines = TranslateTooltipLines

local function ScheduleLatePass(tip)
    if not (tip and tip.IsVisible and AES.Runtime) then return end
    AES.Runtime.After("tooltip-late-1", 0.01, function()
        if not tip:IsVisible() then return false end
        pcall(TranslateTooltipLines, tip)
    end)
    AES.Runtime.After("tooltip-late-2", 0.09, function()
        if not tip:IsVisible() then return false end
        pcall(TranslateTooltipLines, tip)
    end)
end

local reshowQueue = setmetatable({}, { __mode = "k" })
local function ReshowSoon(tip)
    if not (tip and tip.IsVisible and AES.Runtime) then return end
    reshowQueue[tip] = true
    AES.Runtime.After("tooltip-reshow", 0, function()
        AES.Perf.reshowGuard = true
        for queuedTip in pairs(reshowQueue) do
            reshowQueue[queuedTip] = nil
            local ok, vis = pcall(queuedTip.IsVisible, queuedTip)
            if ok and vis then pcall(queuedTip.Show, queuedTip) end
        end
        AES.Perf.reshowGuard = false
    end)
end

local function OnSpellTooltip(tip)
    if not db or not db.spells then return end
    local _, _, spellID = tip:GetSpell()
    local name = tip:GetName()
    local L1 = _G[name .. "TextLeft1"]
    local enName = L1 and L1:GetText()

    local esName = enName and AES.SpellNameEN2ES[enName]
    if esName then L1:SetText(esName) end

    local L2 = _G[name .. "TextLeft2"]
    local rankText = L2 and L2:GetText()
    if rankText and AES.RankEN2ES[rankText] then
        L2:SetText(AES.RankEN2ES[rankText])
    end

    if spellID and AES.DescByID[spellID] then
        TranslateBodyByPairs(tip, AES.DescByID[spellID], AES.DescPairs)
    end
    if enName and AES.NameToIDs[enName] then
        for _, id in ipairs(AES.NameToIDs[enName]) do
            if AES.DescByID[id] then
                TranslateBodyByPairs(tip, AES.DescByID[id], AES.DescPairs)
            end
            if AES.TipByID[id] then
                TranslateBodyByPairs(tip, AES.TipByID[id], AES.TipPairs)
            end
        end
    end

    pcall(TranslateBodyByPrefix, tip)

    ApplyLinePatterns(tip)
    ScheduleLatePass(tip)
    ReshowSoon(tip)
end

local function OnAuraTooltip(tip, unit, index, filter)
    if not db or not db.spells then return end
    local spellID = select(11, UnitAura(unit, index, filter))
    local name = tip:GetName()
    local L1 = _G[name .. "TextLeft1"]
    local enName = L1 and L1:GetText()
    local esName = enName and AES.SpellNameEN2ES[enName]
    if esName then L1:SetText(esName) end

    local translated = false
    if spellID and AES.TipByID[spellID] then
        translated = TranslateBodyByPairs(tip, AES.TipByID[spellID], AES.TipPairs)
    end
    if not translated and enName and AES.NameToIDs[enName] then
        for _, id in ipairs(AES.NameToIDs[enName]) do
            if AES.TipByID[id] and TranslateBodyByPairs(tip, AES.TipByID[id], AES.TipPairs) then
                break
            end
        end
    end

    ApplyLinePatterns(tip)
    ReshowSoon(tip)
end

local function OnItemTooltip(tip)
    if not db or not db.items then return end
    local _, link = tip:GetItem()
    local itemID = link and tonumber(link:match("item:(%d+)"))
    local name = tip:GetName()

    if itemID and AES.ItemName[itemID] then
        local L1 = _G[name .. "TextLeft1"]
        local text = L1 and L1:GetText()
        local guard = AES.ItemNameEN[itemID]
        if text and text ~= "" then
            if (not guard) or guard == text then
                L1:SetText(AES.ItemName[itemID])
            elseif text:sub(1, #guard) == guard then

                local suf = text:sub(#guard + 1):match("^%s+(.-)%s*$")
                local sufES = suf and AES.SuffixWords and AES.SuffixWords[suf]
                if sufES then
                    L1:SetText(AES.ItemName[itemID] .. " " .. sufES)
                end
            end
        end
    end

    if itemID and GetItemSpell then
        local spellName = GetItemSpell(itemID)
        local sIds = spellName and AES.NameToIDs[spellName]
        if sIds then
            for i = 2, tip:NumLines() do
                local fs = _G[name .. "TextLeft" .. i]
                local t = fs and fs:GetText()
                if t and (t:find("^Use: ") or t:find("^Uso: ") or t:find("^Equip: ") or t:find("^Equipar: ")) then

                    local pref, body = t:match("^(%a+:%s*)(.+)$")
                    for _, sid in ipairs(sIds) do
                        if (AES.TipByID[sid] and TryPairSet(fs, t, AES.TipByID[sid], AES.TipPairs))
                            or (AES.DescByID[sid] and TryPairSet(fs, t, AES.DescByID[sid], AES.DescPairs)) then
                            break
                        end
                        if body then
                            local nt = MatchPairSet(body, AES.TipByID[sid], AES.TipPairs)
                                or MatchPairSet(body, AES.DescByID[sid], AES.DescPairs)
                            if nt then
                                pcall(fs.SetText, fs, pref .. nt)
                                break
                            end
                        end
                    end
                    break
                end
            end
        end
    end

    if db.flavor and itemID and AES.ItemDesc[itemID] then
        for i = 2, tip:NumLines() do
            local fs = _G[name .. "TextLeft" .. i]
            local text = fs and fs:GetText()
            if text and text:sub(1, 1) == '"' then
                local en = AES.ItemDescEN[itemID]

                local okGuard = not en
                if en then
                    local a = text:gsub("%s+", " ")
                    local b = ('"' .. en .. '"'):gsub("%s+", " ")
                    okGuard = (a == b)
                end
                if okGuard then
                    fs:SetText('"' .. AES.ItemDesc[itemID] .. '"')
                end
                break
            end
        end
    end

    ApplyLinePatterns(tip)
    ScheduleLatePass(tip)
    ReshowSoon(tip)
end

local function OnUnitTooltip(tip)
    if not db then return end
    local _, unit = tip:GetUnit()
    local guid = unit and UnitGUID(unit)
    local npcID = db.units and NpcIdFromGUID(guid)
    if npcID then
        local name = tip:GetName()
        local L1 = _G[name .. "TextLeft1"]
        local text = L1 and L1:GetText()
        local guard = AES.UnitNameEN[npcID]
        if text and AES.UnitName[npcID] and (not guard or guard == text) then
            L1:SetText(AES.UnitName[npcID])
        end

        local L2 = _G[name .. "TextLeft2"]
        local t2 = L2 and L2:GetText()
        if t2 and AES.UnitSub[npcID] and not t2:match("^Level") and not t2:match("^Nível") then
            local subGuard = AES.UnitSubEN[npcID]
            if not subGuard or subGuard == t2 then
                L2:SetText(AES.UnitSub[npcID])
            end
        end
    end

    -- A segunda linha de jogadores é criada dinamicamente pelo Ascension e não
    -- passa pelas tabelas estáticas: nível + raça + classe customizada + tipo.
    if AES.TranslateUnitDescriptorText then
        local tipName = tip:GetName()
        for i = 2, tip:NumLines() do
            local fs = _G[tipName .. "TextLeft" .. i]
            local shown = fs and fs:GetText()
            local translated = shown and AES.TranslateUnitDescriptorText(shown)
            if translated and translated ~= shown then pcall(fs.SetText, fs, translated) end
        end
    end

    ApplyLinePatterns(tip)
    ReshowSoon(tip)
end

local function EscapeLuaPattern(text)
    return (text:gsub("([^%w])", "%%%1"))
end

function AES.TranslateUnitDescriptorText(text)
    if type(text) ~= "string" or text == "" then return nil end

    -- O cabeçalho do personagem e os tooltips de unidades podem usar o mesmo
    -- descritor com ou sem cores e com ou sem o sufixo "(Player)".
    local plain = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    local level, descriptor, kind = plain:match("^Level%s+(%d+)%s+(.+)%s+%(([^()]+)%)$")
    if not level then
        level, descriptor = plain:match("^Level%s+(%d+)%s+(.+)$")
    end
    if not level then return nil end

    local raceEN, racePT, classEN, classPT
    for rEN, rPT in pairs(AES.UnitDescriptorRaces or {}) do
        local prefix = rEN .. " "
        if descriptor:sub(1, #prefix) == prefix then
            raceEN, racePT = rEN, rPT
            classEN = descriptor:sub(#prefix + 1)
            classPT = (AES.UnitDescriptorClasses and AES.UnitDescriptorClasses[classEN])
                or (AES.TalentUIExact and AES.TalentUIExact[classEN]) or classEN
            break
        end
    end

    -- Algumas interfaces retornam apenas a classe ou apenas a raça.
    if not classEN then
        local c = (AES.UnitDescriptorClasses and AES.UnitDescriptorClasses[descriptor])
            or (AES.TalentUIExact and AES.TalentUIExact[descriptor])
        if c then classEN, classPT = descriptor, c end
    end
    if not raceEN and not classEN then
        local r = AES.UnitDescriptorRaces and AES.UnitDescriptorRaces[descriptor]
        if r then raceEN, racePT = descriptor, r end
    end

    local out = text
    -- Sem âncora para também funcionar quando "Level 20" estiver envolto por
    -- códigos de cor no mesmo FontString.
    out = out:gsub("Level%s+" .. level, "Nível " .. level, 1)
    if raceEN and racePT then
        out = out:gsub(EscapeLuaPattern(raceEN), racePT, 1)
    end
    if classEN and classPT then
        out = out:gsub(EscapeLuaPattern(classEN), classPT, 1)
    end
    if kind then
        local kindPT = (AES.UnitDescriptorKinds and AES.UnitDescriptorKinds[kind]) or kind
        out = out:gsub(EscapeLuaPattern(kind), kindPT, 1)
    end

    return out ~= text and out or nil
end

local function TranslateShortText(text)

    if AES.RankEN2ES[text] then return AES.RankEN2ES[text] end
    return MatchLinePatterns(text)
end

local function TranslateAscensionSpellButtons()
    local frame = AscensionSpellbookFrame
    local spells = frame and frame.Content and frame.Content.Spells
    if not spells then return end
    for i = 1, 12 do
        local b = spells["SpellButton" .. i]
        if b then
            local fs = b.SpellName
            local t = fs and fs:GetText()
            local es = t and AES.SpellNameEN2ES[t]
            if es then fs:SetText(es) end
            local sub = b.SubSpellName
            local st = sub and sub:GetText()
            if st and st ~= "" then
                local esSub = TranslateShortText(st)
                if esSub then sub:SetText(esSub) end
            end
        end
    end
end

local function HookSpellbook()

    if type(SpellButton_UpdateButton) == "function" then
        hooksecurefunc("SpellButton_UpdateButton", function(self)
            if not db or not db.spells then return end
            local nameFS = _G[self:GetName() .. "SpellName"]
            local text = nameFS and nameFS:GetText()
            local es = text and AES.SpellNameEN2ES[text]
            if es then nameFS:SetText(es) end
            local subFS = _G[self:GetName() .. "SubSpellName"]
            local sub = subFS and subFS:GetText()
            if sub and sub ~= "" then
                local esSub = TranslateShortText(sub)
                if esSub then subFS:SetText(esSub) end
            end
        end)
    end

    if AscensionSpellbookFrame and type(AscensionSpellbookFrame.UpdateSpells) == "function" then
        hooksecurefunc(AscensionSpellbookFrame, "UpdateSpells", function()
            if db and db.spells then TranslateAscensionSpellButtons() end
        end)
    end
    if AscensionSpellbookFrame and type(AscensionSpellbookFrame.UpdatePet) == "function" then
        hooksecurefunc(AscensionSpellbookFrame, "UpdatePet", function()
            if db and db.spells then TranslateAscensionSpellButtons() end
        end)
    end
end

local function ApplyUIStrings()
    return 0
end

function TranslateStaticText(t)
    local es = (AES.TalentUIExact and AES.TalentUIExact[t])
        or (AES.CharacterStatExact and AES.CharacterStatExact[t])
        or (AES.CustomUI and AES.CustomUI[t])
        or (AES.ServerUI and AES.ServerUI[t])
        or (AES.UIStringsByEN and AES.UIStringsByEN[t])
        or (AES.AreaNames and AES.AreaNames[t])
    if es then return es end

    local base, tail = t:match("^(.-)%s*(:?)%s*$")
    if base and base ~= t and base ~= "" then
        es = (AES.TalentUIExact and AES.TalentUIExact[base])
            or (AES.CharacterStatExact and AES.CharacterStatExact[base])
            or (AES.CustomUI and AES.CustomUI[base])
            or (AES.ServerUI and AES.ServerUI[base])
            or (AES.UIStringsByEN and AES.UIStringsByEN[base])
            or (AES.AreaNames and AES.AreaNames[base])
        if es then return es .. (tail or "") end
    end

    local c0, inner, r0 = t:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)%s*$")
    if inner and inner ~= "" and not inner:find("|c") then
        local es2 = (AES.TalentUIExact and AES.TalentUIExact[inner])
            or (AES.CharacterStatExact and AES.CharacterStatExact[inner])
            or (AES.CustomUI and AES.CustomUI[inner])
            or (AES.ServerUI and AES.ServerUI[inner])
            or (AES.UIStringsByEN and AES.UIStringsByEN[inner])
            or (AES.AreaNames and AES.AreaNames[inner])
        if es2 then return c0 .. es2 .. r0 end
    end

    local p1, p2 = t:match("^Page (%d+) of (%d+)$")
    if p1 then return "Página " .. p1 .. " de " .. p2 end

    if AES.ServerUINoColor and t:find("|c", 1, true) then
        local limpio = t:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
        local es3 = AES.ServerUINoColor[limpio]
        if es3 then return es3 end
    end

    if db and db.spells and AES.SpellNameEN2ES and #t >= 4 and t:match("^%u") then
        local esSpell = AES.SpellNameEN2ES[t]
        if esSpell and esSpell ~= t then return esSpell end
    end
    return nil
end


AES.TranslateStaticText = TranslateStaticText

-- Zonas e subzonas são escritas diretamente pelo FrameXML e pelo mapa do
-- Ascension. Interceptar apenas os FontStrings evita alterar o retorno das APIs
-- GetZoneText/GetSubZoneText e mantém compatibilidade com outros addons.
-- Este bloco precisa de um escopo próprio: o Lua 5.1 do cliente limita cada
-- função (inclusive o chunk principal) a 200 variáveis locais simultâneas.
do
local areaFSHooked = setmetatable({}, { __mode = "k" })
local areaRootHooked = setmetatable({}, { __mode = "k" })
local inAreaFSHook = false

local AREA_ROOT_NAMES = {
    "WorldMapFrame", "WorldMapDetailFrame", "WorldMapButton",
    "QuestMapFrame", "WorldMapQuestFrame", "MapQuestFrame", "QuestPOIFrame",
    "AscensionWorldMapFrame", "AscensionQuestMapFrame", "AscensionMapFrame",
    "MinimapCluster", "BattlefieldMinimap", "ZoneTextFrame", "SubZoneTextFrame",
}

local AREA_TEXT_NAMES = {
    "ZoneTextString", "SubZoneTextString", "MinimapZoneText",
    "WorldMapFrameAreaLabel", "WorldMapFrameAreaDescription",
    "WorldMapFrameTitleText", "WorldMapZoneInfo", "WorldMapZoneText",
    "QuestMapFrameTitleText", "AscensionMapZoneText", "AscensionWorldMapZoneText",
}

local function TranslateAreaText(text)
    if type(text) ~= "string" or text == "" or not AES.AreaNames then return nil end
    local direct = AES.AreaNames[text]
    if direct then return direct end

    local color, inner, reset = text:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
    if inner and AES.AreaNames[inner] then
        return color .. AES.AreaNames[inner] .. reset
    end

    local area, levels = text:match("^(.-)(%s+%(%d+[%d%s%-–—]*%))$")
    if area and AES.AreaNames[area] then return AES.AreaNames[area] .. levels end

    local first, rest = text:match("^([^\n]+)(\n.+)$")
    if first and AES.AreaNames[first] then return AES.AreaNames[first] .. rest end
    return nil
end
AES.TranslateAreaText = TranslateAreaText

local function HookAreaFS(fs)
    if not (fs and fs.SetText) or areaFSHooked[fs] then return end
    areaFSHooked[fs] = true
    for _, method in ipairs({ "SetText", "SetFormattedText" }) do
        if fs[method] then
            pcall(hooksecurefunc, fs, method, function(self)
                if inAreaFSHook or not (db and db.ui) then return end
                local shown = self.GetText and self:GetText()
                local pt = shown and TranslateAreaText(shown)
                if pt and pt ~= shown then
                    inAreaFSHook = true
                    pcall(self.SetText, self, pt)
                    inAreaFSHook = false
                end
            end)
        end
    end
end

local function WalkAreaUI(root, depth, seen)
    if not root then return end
    depth = depth or 0
    if depth > 11 then return end
    seen = seen or {}
    if seen[root] then return end
    seen[root] = true

    if root.IsObjectType and root:IsObjectType("FontString") then
        HookAreaFS(root)
        local shown = root.GetText and root:GetText()
        local pt = shown and TranslateAreaText(shown)
        if pt and pt ~= shown then pcall(root.SetText, root, pt) end
        return
    end

    if root.GetRegions then
        local ok, regions = pcall(function() return { root:GetRegions() } end)
        if ok then
            for _, region in ipairs(regions) do
                if region and region.IsObjectType and region:IsObjectType("FontString") then
                    HookAreaFS(region)
                    local shown = region.GetText and region:GetText()
                    local pt = shown and TranslateAreaText(shown)
                    if pt and pt ~= shown then pcall(region.SetText, region, pt) end
                end
            end
        end
    end
    if root.GetChildren then
        local ok, children = pcall(function() return { root:GetChildren() } end)
        if ok then
            for _, child in ipairs(children) do WalkAreaUI(child, depth + 1, seen) end
        end
    end
end

local function HookAreaRoots()
    for _, name in ipairs(AREA_ROOT_NAMES) do
        local root = _G[name]
        if root then
            pcall(WalkAreaUI, root, 0, {})
            if root.HookScript and root.HasScript and root:HasScript("OnShow")
                and not areaRootHooked[root] then
                areaRootHooked[root] = true
                pcall(root.HookScript, root, "OnShow", function(self)
                    pcall(WalkAreaUI, self, 0, {})
                end)
            end
        end
    end
    for _, name in ipairs(AREA_TEXT_NAMES) do
        local fs = _G[name]
        if fs then pcall(WalkAreaUI, fs, 0, {}) end
    end
end

local function TranslateAreaUI()
    if not (db and db.ui) then return end
    HookAreaRoots()
    if AES.Runtime then
        AES.Runtime.Repeat("area-ui", 0.12, 0.12, 3, function()
            if not (db and db.ui) then return false end
            HookAreaRoots()
        end)
    end
end
AES.TranslateAreaUI = TranslateAreaUI

local areaWatcher = CreateFrame("Frame")
for _, event in ipairs({ "ADDON_LOADED", "PLAYER_ENTERING_WORLD", "ZONE_CHANGED",
                          "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA",
                          "WORLD_MAP_UPDATE", "QUEST_LOG_UPDATE" }) do
    pcall(areaWatcher.RegisterEvent, areaWatcher, event)
end
areaWatcher:SetScript("OnEvent", function() pcall(TranslateAreaUI) end)

for _, functionName in ipairs({ "WorldMapFrame_Update", "WorldMapFrame_UpdateMap",
                                 "WorldMapFrame_UpdateQuests", "QuestMapUpdateAllQuests" }) do
    if type(_G[functionName]) == "function" then
        pcall(hooksecurefunc, functionName, TranslateAreaUI)
    end
end
end

AES.TranslateDescriptionString = function(text)
    if type(text) ~= "string" or text == "" then return nil end
    if text:find("\n", 1, true) then
        local multi = TranslateMultilineText(text)
        if multi and multi ~= text then return multi end
    end
    for words = 8, 3, -1 do
        local pref = PrefijoDe(text, words)
        local indexes = pref ~= "" and AES.DescByPrefix and AES.DescByPrefix[pref]
        local translated = indexes and MatchPairSet(text, indexes, AES.DescPairs)
        if translated and translated ~= text then return translated end
        indexes = pref ~= "" and AES.TipByPrefix and AES.TipByPrefix[pref]
        translated = indexes and MatchPairSet(text, indexes, AES.TipPairs)
        if translated and translated ~= text then return translated end
    end
    return nil
end

local LIVE_UI_FRAMES = { "PathToAscensionFrame", "AscensionLFGFrame",
                         "AscensionPVEFrame", "AscensionPVPFrame",
                         "AscensionRulesetFrame" }
local liveScaled = setmetatable({}, { __mode = "k" })
local function TranslateLiveSubtree(fr, depth)
    if depth > 8 then return end
    local ok, regions = pcall(function() return { fr:GetRegions() } end)
    if ok and regions then
        for _, r in ipairs(regions) do
            if r.IsObjectType and r:IsObjectType("FontString") then
                local t = r.GetText and r:GetText()
                if t and t ~= "" then
                    local es = TranslateStaticText(t)
                    if es and es ~= t then pcall(r.SetText, r, es) end
                end
            end
        end
    end
    local okc, children = pcall(function() return { fr:GetChildren() } end)
    if okc and children then
        for _, c in ipairs(children) do
            if c.IsObjectType and c:IsObjectType("SimpleHTML") and not liveScaled[c] then
                liveScaled[c] = true
                pcall(c.SetScale, c, 0.9)
            end
            TranslateLiveSubtree(c, depth + 1)
        end
    end
end
local function TranslateLiveFramesOnce()
    if not (db and db.ui) then return end
    for _, fname in ipairs(LIVE_UI_FRAMES) do
        local f = _G[fname]
        if f then pcall(TranslateLiveSubtree, f, 0) end
    end
end

local HookUIFS

local EXCLUDED_ROOTS = { CallBoardUI = true }
local EXCLUDED_PAT = { "AuctionFilterButton" }
local excludeCache = setmetatable({}, { __mode = "k" })
local function FrameExcluded(obj)
    if obj == nil then return false end
    local cached = excludeCache[obj]
    if cached ~= nil then return cached end
    local cur, hops = obj, 0
    while cur and hops < 14 do
        local okn, nm = pcall(function() return cur.GetName and cur:GetName() end)
        if okn and nm and EXCLUDED_ROOTS[nm] then
            excludeCache[obj] = true
            return true
        end
        if okn and nm then
            for _, pat in ipairs(EXCLUDED_PAT) do
                if nm:find(pat, 1, true) then
                    excludeCache[obj] = true
                    return true
                end
            end
        end
        local okp, par = pcall(function() return cur.GetParent and cur:GetParent() end)
        cur = okp and par or nil
        hops = hops + 1
    end
    excludeCache[obj] = false
    return false
end
AES.FrameExcluded = FrameExcluded

local function RetranslateStaticUI()
    if not db or not db.ui then return end
    local frame = EnumerateFrames()
    while frame do
        if FrameExcluded(frame) then
            frame = EnumerateFrames(frame)
        else
            local protected = frame.IsProtected and select(1, frame:IsProtected())
            local forbidden = frame.IsForbidden and frame:IsForbidden()

            local esEntrada = frame.IsObjectType and frame:IsObjectType("EditBox")
            if not protected and not forbidden and not esEntrada then
                local okvis, vis = pcall(function() return frame:IsVisible() end)
                local ok, regions = pcall(function() return { frame:GetRegions() } end)
                if ok and regions then
                    for _, r in ipairs(regions) do
                        if r and r.IsObjectType and r:IsObjectType("FontString") then
                            local t = r:GetText()
                            if t and t ~= "" then
                                local es = TranslateStaticText(t)
                                if es then pcall(r.SetText, r, es) end
                            end
                            if okvis and vis and HookUIFS then pcall(HookUIFS, r) end
                        end
                    end
                end
            end
            frame = EnumerateFrames(frame)
        end
    end
end

local function PrimeStaticSubtree(root, depth)
    if not root then return end
    depth = depth or 0
    if depth > 10 then return end

    local ok, regions = pcall(function() return { root:GetRegions() } end)
    if ok and regions then
        for _, r in ipairs(regions) do
            if r and r.IsObjectType and r:IsObjectType("FontString") then
                local t = r.GetText and r:GetText()
                if type(t) == "string" and t ~= "" then
                    local es = TranslateStaticText(t)
                    if es and es ~= t then pcall(r.SetText, r, es) end
                end
                -- Intercepta o texto antes do primeiro desenho do painel.
                if HookUIFS then pcall(HookUIFS, r) end
            end
        end
    end

    local okc, children = pcall(function() return { root:GetChildren() } end)
    if okc and children then
        for _, child in ipairs(children) do
            PrimeStaticSubtree(child, depth + 1)
        end
    end
end

local function StaticPassSoon(panel)
    if not panel then return end
    pcall(PrimeStaticSubtree, panel, 0)

    -- O painel já é percorrido e tem SetText hookado. Fazemos apenas dois
    -- repasses curtos pelo scheduler compartilhado; scan global fica reservado
    -- para login e /aptbr atualizar.
    if AES.Runtime then
        AES.Runtime.After("static-panel-1", 0.03, function()
            if panel and panel.IsVisible and panel:IsVisible() then
                pcall(PrimeStaticSubtree, panel, 0)
            end
        end)
        AES.Runtime.After("static-panel-2", 0.18, function()
            if panel and panel.IsVisible and panel:IsVisible() then
                pcall(PrimeStaticSubtree, panel, 0)
            end
        end)
    end
end

local staticHooked = {}
local function HookStaticPanels()
    pcall(TranslateLiveFramesOnce)
    for _, name in ipairs({ "GameMenuFrame", "VideoOptionsFrame", "InterfaceOptionsFrame",
                            "AchievementFrame", "SpellBookFrame",

                            "WorldMapFrame", "QuestMapFrame", "WorldMapQuestFrame",
                            "MapQuestFrame", "AscensionWorldMapFrame", "AscensionQuestMapFrame",

                            "AscensionLFGFrame", "AscensionPVEFrame", "AscensionPVPFrame",
                            "AscensionRulesetFrame", "PathToAscensionFrame",
                            "WarmodeMapFrame", "AscensionWeeklyKeystoneFrame",
                            "ChannelFrame",

                            "CharacterAdvancement", "CharacterAdvancementFrame", "AscensionCharacterAdvancement",
                            "ClassTalentFrame", "RaceTalentFrame", "RacialTalentFrame",
                            "SpecializationFrame", "MentorSpecializationFrame", "Collections",
                            "WildCardRapidRollingFrame", "DraftHelpFrame",
                            "SkillCardsFrame", "VanityCollectionFrame" }) do
        local f = _G[name]
        if f then
            -- Prepara também os painéis que ainda estão ocultos.
            pcall(PrimeStaticSubtree, f, 0)
            if not staticHooked[name] and f.HookScript and f:HasScript("OnShow") then
                staticHooked[name] = true
                f:HookScript("OnShow", StaticPassSoon)
            end
        end
    end
end

AES.Perf.IsRelevantUILoad = function(name)
    if type(name) ~= "string" then return false end
    if name == "AscensionPTBR" then return true end
    if name:find("Ascension", 1, true) then return true end
    return name == "Blizzard_AchievementUI"
        or name == "Blizzard_TrainerUI"
        or name == "Blizzard_TradeSkillUI"
        or name == "Blizzard_AuctionUI"
        or name == "Blizzard_TalentUI"
end

local staticWatcher = CreateFrame("Frame")
staticWatcher:RegisterEvent("ADDON_LOADED")
staticWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
staticWatcher:SetScript("OnEvent", function(_, event, name)
    if event == "PLAYER_ENTERING_WORLD" or AES.Perf.IsRelevantUILoad(name) then
        pcall(HookStaticPanels)
    end
end)

if type(C_Tutorial) == "table" then
    local function TutMapStr(v)
        if type(v) ~= "string" or v == "" then return v end
        local es = TranslateStaticText(v)
        if es then return es end
        return v
    end
    for _, fname in ipairs({ "GetKeywordAtIndex", "GetKeywordInfo",
                             "GetTutorialAtIndex", "GetTutorialByID",
                             "GetTutorialDisplay", "GetCategoryInfo",
                             "GetObjectiveInfo", "GetMentorSpecializationInfo" }) do
        local orig = C_Tutorial[fname]
        if type(orig) == "function" then
            C_Tutorial[fname] = function(...)
                if db and not db.ui then return orig(...) end
                local a, b, c, d, e, f, g, h = orig(...)
                return TutMapStr(a), TutMapStr(b), TutMapStr(c), TutMapStr(d),
                    TutMapStr(e), TutMapStr(f), TutMapStr(g), TutMapStr(h)
            end
        end
    end
end


local function TranslateAchievementFS(fs, id, esTable, enTable)
    if not fs or not id then return end
    local es = esTable[id]
    if not es then return end
    local text = fs:GetText()
    local guard = enTable[id]
    if text and (not guard or guard == text) then
        fs:SetText(es)
    end
end

local function TranslateAchButton(button)
    if not button or not button.id then return end
    TranslateAchievementFS(button.label, button.id, AES.AchName, AES.AchNameEN)
    TranslateAchievementFS(button.description, button.id, AES.AchDesc, AES.AchDescEN)
    TranslateAchievementFS(button.reward, button.id, AES.AchReward, AES.AchRewardEN)
end

local function AchTooltipPass(tip, achID)
    if not db or not db.achievements then return end
    local name = tip:GetName()
    for i = 1, tip:NumLines() do
        local fs = _G[name .. "TextLeft" .. i]
        local text = fs and fs:GetText()
        if text and text ~= "" then
            local es = (AES.AchNameEN2ES and AES.AchNameEN2ES[text])
                or (AES.AchCritEN2ES and AES.AchCritEN2ES[text])
            if not es and achID and AES.AchDescEN[achID] == text then
                es = AES.AchDesc[achID]
            end
            if es then fs:SetText(es) end
        end
        local fsr = _G[name .. "TextRight" .. i]
        local textr = fsr and fsr:GetText()
        if textr and AES.AchCritEN2ES and AES.AchCritEN2ES[textr] then
            fsr:SetText(AES.AchCritEN2ES[textr])
        end
    end
    ReshowSoon(tip)
end

local function HookAchievementUI()
    if type(AchievementButton_DisplayAchievement) == "function" then
        hooksecurefunc("AchievementButton_DisplayAchievement", function(button)
            if not db or not db.achievements then return end
            TranslateAchButton(button)
        end)
    end

    if type(AchievementFrameSummary_UpdateAchievements) == "function" then
        hooksecurefunc("AchievementFrameSummary_UpdateAchievements", function()
            if not db or not db.achievements then return end
            for i = 1, 20 do
                local b = _G["AchievementFrameSummaryAchievement" .. i]
                if not b then break end
                TranslateAchButton(b)
                if b.HookScript and not b.__aesHooked then
                    b.__aesHooked = true
                    b:HookScript("OnEnter", function(btn) AchTooltipPass(GameTooltip, btn.id) end)
                end
            end
        end)
    end

    if type(AchievementFrameCategories_DisplayButton) == "function" then
        hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button)
            if not db or not db.achievements then return end
            local fs = button and button.label
            local t = fs and fs:GetText()
            if not t then return end
            local es = (AES.AchCatEN2ES and AES.AchCatEN2ES[t]) or (AES.CustomUI and AES.CustomUI[t])
            if es then fs:SetText(es) end
        end)
    end

    if type(AchievementFrameCategories_UpdateTooltip) == "function" then
        hooksecurefunc("AchievementFrameCategories_UpdateTooltip", function()
            AchTooltipPass(GameTooltip)
        end)
    end
    if type(AchievementMeta_OnEnter) == "function" then
        hooksecurefunc("AchievementMeta_OnEnter", function()
            AchTooltipPass(GameTooltip)
        end)
    end
end

local function HookAchievementAlerts()
    if type(AchievementAlertFrame_ShowAlert) ~= "function" then return end
    hooksecurefunc("AchievementAlertFrame_ShowAlert", function()
        if not db or not db.achievements then return end
        for i = 1, 2 do
            local frame = _G["AchievementAlertFrame" .. i]
            if frame and frame:IsShown() and frame.id then
                TranslateAchievementFS(_G["AchievementAlertFrame" .. i .. "Name"],
                    frame.id, AES.AchName, AES.AchNameEN)
            end
        end
    end)
end

local function HookAchievementLinks()
    hooksecurefunc(ItemRefTooltip, "SetHyperlink", function(tip, link)
        if not db or not db.achievements then return end
        local id = link and tonumber(link:match("achievement:(%d+)"))
        if not id then return end
        local name = tip:GetName()
        TranslateAchievementFS(_G[name .. "TextLeft1"], id, AES.AchName, AES.AchNameEN)
        for i = 2, tip:NumLines() do
            local fs = _G[name .. "TextLeft" .. i]
            local text = fs and fs:GetText()
            if text and text == AES.AchDescEN[id] and AES.AchDesc[id] then
                fs:SetText(AES.AchDesc[id])
                break
            end
        end
        ReshowSoon(tip)
    end)
end

local function TranslateTrainerList()
    local n = CLASS_TRAINER_SKILLS_DISPLAYED or 11
    for i = 1, n do
        local btn = _G["ClassTrainerSkill" .. i]
        if btn and btn.GetText then
            local t = btn:GetText()
            if t and t ~= "" then
                local prefix, name = t:match("^(%s*)(.+)$")
                local es = name and AES.SpellNameEN2ES[name]
                if es then btn:SetText((prefix or "") .. es) end
            end
        end
        local sub = _G["ClassTrainerSkill" .. i .. "SubText"]
        local st = sub and sub:GetText()
        if st and st ~= "" then
            local new = st:gsub("%(Rank (%d+)%)", "(Grau %1)")
            new = AES.SpellNameEN2ES[new] or new
            if new ~= st then sub:SetText(new) end
        end
    end
end

local function TranslateTrainerDetail()
    local nameFS = ClassTrainerSkillName
    local enName = nameFS and nameFS:GetText()
    if enName then
        local es = AES.SpellNameEN2ES[enName]
        if es then nameFS:SetText(es) end
    end
    local subFS = ClassTrainerSubSkillName
    local st = subFS and subFS:GetText()
    if st and st ~= "" then
        local new = st:gsub("%(Rank (%d+)%)", "(Grau %1)")
        if new ~= st then subFS:SetText(new) end
    end

    local reqFS = ClassTrainerSkillRequirements
    local rt = reqFS and reqFS:GetText()
    if rt and rt ~= "" then
        local new = rt:gsub("Requires: ", "Requer: ")
        new = new:gsub("Level (%d+)", "nível %1")
        new = new:gsub("%(Rank (%d+)%)", "(Grau %1)")
        new = new:gsub("[%a][%a' %-]*%a", function(w)
            return TranslateSpellWord(w) or w
        end)
        if new ~= rt then reqFS:SetText(new) end
    end

    local descFS = ClassTrainerSkillDescription
    local dt = descFS and descFS:GetText()
    if dt and #dt > 3 and enName and AES.NameToIDs[enName] then
        for _, id in ipairs(AES.NameToIDs[enName]) do
            if AES.DescByID[id] and TryPairSet(descFS, dt, AES.DescByID[id], AES.DescPairs) then
                break
            end
        end
    end
end

local function HookTrainerUI()
    if type(ClassTrainerFrame_Update) ~= "function" then return end
    hooksecurefunc("ClassTrainerFrame_Update", function()
        if db and db.spells then
            TranslateTrainerList()
            TranslateTrainerDetail()
        end
    end)
    if type(ClassTrainer_SetSelection) == "function" then
        hooksecurefunc("ClassTrainer_SetSelection", function()
            if db and db.spells then TranslateTrainerDetail() end
        end)
    end
    if ClassTrainerFrame and ClassTrainerFrame.HookScript and ClassTrainerFrame:HasScript("OnShow") then
        ClassTrainerFrame:HookScript("OnShow", RetranslateStaticUI)
    end
end

local function TradeSkillWord(t)
    return AES.SpellNameEN2ES[t]
        or (AES.ItemNameEN2ES and AES.ItemNameEN2ES[t])
        or (AES.CustomUI and AES.CustomUI[t])
        or (AES.UIStringsByEN and AES.UIStringsByEN[t])
end

local function TradeSkillSplit(t)
    local pre, core, post = t:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
    if not core then pre, core, post = "", t, "" end
    local base, count = core:match("^(.-)%s*(%[%d+%])$")
    base = base or core
    base = base:gsub("^%s+", ""):gsub("%s+$", "")
    return pre, base, count, post
end

local function TradeSkillRewrap(pre, translated, count, post)
    return pre .. translated .. (count and (" " .. count) or "") .. post
end

local function TranslateTradeSkillFrame()

    local title = _G["TradeSkillFrameTitleText"]
    local tt = title and title.GetText and title:GetText()
    if tt then
        local es = (AES.ProfessionWords and AES.ProfessionWords[tt]) or TradeSkillWord(tt)
        if es then pcall(title.SetText, title, es) end
    end

    for i = 1, 30 do
        local b = _G["TradeSkillSkill" .. i]
        if b and b.GetText then
            local t = b:GetText()
            if t and t ~= "" then
                local pre, base, count, post = TradeSkillSplit(t)
                local es = TradeSkillWord(base)
                if es then
                    local nt = TradeSkillRewrap(pre, es, count, post)
                    if nt ~= t then pcall(b.SetText, b, nt) end
                end
            end
        end
    end
end

local function TranslateTradeSkillDetail()
    local nameFS = _G["TradeSkillSkillName"]
    local en = nameFS and nameFS.GetText and nameFS:GetText()
    if en then
        local es = TradeSkillWord(en)
        if es then pcall(nameFS.SetText, nameFS, es) end
    end

    local descFS = _G["TradeSkillDescription"]
    local dt = descFS and descFS.GetText and descFS:GetText()
    if dt and dt ~= "" and en then
        local ids = AES.NameToIDs[en]
        if ids then
            for _, id in ipairs(ids) do
                if (AES.DescByID[id] and TryPairSet(descFS, dt, AES.DescByID[id], AES.DescPairs))
                    or (AES.TipByID[id] and TryPairSet(descFS, dt, AES.TipByID[id], AES.TipPairs)) then
                    break
                end
            end
        end
    end

    local reqFS = _G["TradeSkillRequirementText"]
    local rt = reqFS and reqFS.GetText and reqFS:GetText()
    if rt and rt ~= "" then
        local new = rt:gsub("^Requires:%s*(.+)$", function(st)
            return "Requer: " .. (TradeSkillWord(st) or st)
        end)
        if new ~= rt then pcall(reqFS.SetText, reqFS, new) end
    end
    local lbl = _G["TradeSkillReagentLabel"]
    if lbl and lbl.GetText and lbl:GetText() == "Reagents:" then
        pcall(lbl.SetText, lbl, "Reagentes:")
    end
    for i = 1, 8 do
        local fs = _G["TradeSkillReagent" .. i .. "Name"]
        local t = fs and fs.GetText and fs:GetText()
        if t and t ~= "" then
            local es = TradeSkillWord(t)
            if es then pcall(fs.SetText, fs, es) end
        end
    end
end

local tsBtnHooked = setmetatable({}, { __mode = "k" })
local tsBtnInHook = false
local function TradeSkillButtonRetrans(b)
    if tsBtnInHook or not (db and db.spells) then return end
    local t = b.GetText and b:GetText()
    if not t or t == "" then return end

    local pre, base, count, post = TradeSkillSplit(t)
    local es = TradeSkillWord(base)
    if es then
        local nt = TradeSkillRewrap(pre, es, count, post)
        if nt ~= t then
            tsBtnInHook = true
            pcall(b.SetText, b, nt)
            tsBtnInHook = false
        end
    end
end

local function HookTradeSkillButtons()
    for i = 1, 30 do
        local b = _G["TradeSkillSkill" .. i]
        if b and not tsBtnHooked[b] and b.SetText then
            tsBtnHooked[b] = true
            pcall(hooksecurefunc, b, "SetText", TradeSkillButtonRetrans)
        end
    end
end
AES.HookTradeSkillButtons = HookTradeSkillButtons

local function HookTradeSkillUI()
    if type(TradeSkillFrame_Update) ~= "function" then return end
    hooksecurefunc("TradeSkillFrame_Update", function()
        if db and db.spells then
            HookTradeSkillButtons()
            TranslateTradeSkillFrame()
            TranslateTradeSkillDetail()
        end
    end)
    if type(TradeSkillFrame_SetSelection) == "function" then
        hooksecurefunc("TradeSkillFrame_SetSelection", function()
            if db and db.spells then
                TranslateTradeSkillFrame()
                TranslateTradeSkillDetail()
            end
        end)
    end
    if TradeSkillFrame and TradeSkillFrame.HookScript and TradeSkillFrame:HasScript("OnShow") then
        TradeSkillFrame:HookScript("OnShow", function()
            if db and db.spells then
                HookTradeSkillButtons()
                pcall(TranslateTradeSkillFrame)
                pcall(TranslateTradeSkillDetail)
            end
        end)
    end
end

AES.TranslateTradeSkillFrame = TranslateTradeSkillFrame
AES.TranslateTradeSkillDetail = TranslateTradeSkillDetail

local tsTick, tsAcc = CreateFrame("Frame"), 0
AES.Perf.RunTradeSkillTick = function(self, dt)
    if not (db and db.spells) then
        self:SetScript("OnUpdate", nil)
        return
    end
    local f = TradeSkillFrame or _G["TradeSkillSkill1"]
    local ok, vis = pcall(function() return f and f.IsVisible and f:IsVisible() end)
    if not (ok and vis) then
        self:SetScript("OnUpdate", nil)
        return
    end
    tsAcc = tsAcc + (dt or 0)
    if tsAcc < 0.18 then return end
    tsAcc = 0
    pcall(TranslateTradeSkillFrame)
    pcall(TranslateTradeSkillDetail)
end

AES.Perf.tsTickEvents = AES.Perf.tsTickEvents or CreateFrame("Frame")
AES.Perf.tsTickEvents:RegisterEvent("TRADE_SKILL_SHOW")
AES.Perf.tsTickEvents:RegisterEvent("TRADE_SKILL_CLOSE")
AES.Perf.tsTickEvents:SetScript("OnEvent", function(_, event)
    if event == "TRADE_SKILL_SHOW" then
        tsAcc = 0
        tsTick:SetScript("OnUpdate", AES.Perf.RunTradeSkillTick)
    else
        tsTick:SetScript("OnUpdate", nil)
    end
end)

-- O Ascension reescreve estes tooltips enquanto o mouse fica sobre o atributo.
local function TranslateCharacterStatText(text)
    if type(text) ~= "string" or text == "" then return nil end

    local statLine = AES.TranslateCharacterStatLine and AES.TranslateCharacterStatLine(text)
    if statLine and statLine ~= text then return statLine end

    -- Primeiro tenta o bloco inteiro. Isso é importante para descrições de
    -- atributos como Força/Agilidade/Intelecto/Espírito que contêm quebras de
    -- linha e já possuem tradução oficial na tabela de UI.
    local whole = TranslateStaticText(text)
    if whole and whole ~= text then return whole end

    local out, pos, changed = {}, 1, false
    while pos <= #text do
        local nlStart, nlEnd = text:find("\n", pos, true)
        local tagStart, tagEnd = text:find("|n", pos, true)
        local cutStart, cutEnd, delimiter
        if nlStart and (not tagStart or nlStart < tagStart) then
            cutStart, cutEnd, delimiter = nlStart, nlEnd, "\n"
        elseif tagStart then
            cutStart, cutEnd, delimiter = tagStart, tagEnd, "|n"
        end

        local line
        if cutStart then
            line = text:sub(pos, cutStart - 1)
        else
            line = text:sub(pos)
        end

        local translated = (AES.TranslateCharacterStatLine and AES.TranslateCharacterStatLine(line))
            or MatchLinePatterns(line) or TranslateStaticText(line)
        if translated and translated ~= line then
            line = translated
            changed = true
        end
        out[#out + 1] = line

        if not cutStart then break end
        out[#out + 1] = delimiter
        pos = cutEnd + 1
    end
    if changed then return table.concat(out) end
    return nil
end

local charStatFSHooked = setmetatable({}, { __mode = "k" })
local inCharStatFSHook = false

local function HookCharacterStatFS(fs)
    if not (fs and fs.SetText) or charStatFSHooked[fs] then return end
    charStatFSHooked[fs] = true

    for _, method in ipairs({ "SetText", "SetFormattedText" }) do
        if fs[method] then
            pcall(hooksecurefunc, fs, method, function(self)
                if inCharStatFSHook or not (db and db.ui and db.patterns) then return end
                local current = self.GetText and self:GetText()
                local translated = current and TranslateCharacterStatText(current)
                if translated and translated ~= current then
                    inCharStatFSHook = true
                    pcall(self.SetText, self, translated)
                    inCharStatFSHook = false
                end
            end)
        end
    end
end

local function TranslateCharacterStatTooltip(tip)
    if not (db and db.ui and db.patterns and tip and tip.GetName) then return end
    local name = tip:GetName()
    if not name then return end

    for i = 1, tip:NumLines() do
        for _, side in ipairs({ "TextLeft", "TextRight" }) do
            local fs = _G[name .. side .. i]
            if fs then
                HookCharacterStatFS(fs)
                local current = fs.GetText and fs:GetText()
                local translated = current and TranslateCharacterStatText(current)
                if translated and translated ~= current then
                    inCharStatFSHook = true
                    pcall(fs.SetText, fs, translated)
                    inCharStatFSHook = false
                end
            end
        end
    end
end
AES.TranslateCharacterStatTooltip = TranslateCharacterStatTooltip

-- Procura linhas criadas depois do OnShow usando o scheduler compartilhado.
local function ScheduleCharacterStatLatePass(tip)
    if not (tip and AES.Runtime) then return end
    AES.Runtime.Repeat("character-stat-tooltip", 0.05, 0.05, 12, function()
        if not (tip.IsVisible and tip:IsVisible()) then return false end
        pcall(TranslateCharacterStatTooltip, tip)
    end)
end

local function HookTooltip(tip)
    if not tip then return end


    local function IsCharPanelTooltip(t)
        local o = t.GetOwner and t:GetOwner()
        local depth = 0
        while o and depth < 8 do
            local n = o.GetName and o:GetName()
            if n and (n:find("AscensionCharacterStatsPanel", 1, true)
                or n == "AscensionCharacterFrame") then
                return true
            end
            o = o.GetParent and o:GetParent()
            depth = depth + 1
        end
        return false
    end

    -- Traduz de novo sempre que o tooltip for atualizado.
    for _, method in ipairs({ "SetText", "AddLine", "AddDoubleLine", "AppendText" }) do
        if tip[method] then
            pcall(hooksecurefunc, tip, method, function(t)
                if db and IsCharPanelTooltip(t) then
                    pcall(TranslateCharacterStatTooltip, t)
                    ScheduleCharacterStatLatePass(t)
                end
            end)
        end
    end
    if tip:HasScript("OnShow") then
        tip:HookScript("OnShow", function(t)
            if not db or AES.Perf.reshowGuard then return end
            if IsCharPanelTooltip(t) then
                TranslateCharacterStatTooltip(t)
                ScheduleCharacterStatLatePass(t)
                return
            end

            local owner = (t.GetSpell and t:GetSpell()) or (t.GetItem and t:GetItem())
                or (t.GetUnit and t:GetUnit())
            if not owner and db.ui then
                local L1 = _G[t:GetName() .. "TextLeft1"]
                local txt = L1 and L1:GetText()
                if txt and txt ~= "" then
                    local es = TranslateStaticText(txt) or MatchLinePatterns(txt)
                    if not es and AES.TranslateSystemTextStrict then
                        local tr = AES.TranslateSystemTextStrict(txt)
                        if tr ~= txt then es = tr end
                    end
                    if es then pcall(L1.SetText, L1, es) end
                end
            end
            TranslateTooltipLines(t)
            ScheduleLatePass(t)
            ReshowSoon(t)
        end)
    end
    if tip:HasScript("OnTooltipSetSpell") then
        tip:HookScript("OnTooltipSetSpell", OnSpellTooltip)
    end
    if tip:HasScript("OnTooltipSetItem") then
        tip:HookScript("OnTooltipSetItem", OnItemTooltip)
    end
    if tip:HasScript("OnTooltipSetUnit") then
        tip:HookScript("OnTooltipSetUnit", OnUnitTooltip)
    end
end

local function HookAuras()
    if GameTooltip.SetUnitAura then
        hooksecurefunc(GameTooltip, "SetUnitAura", OnAuraTooltip)
    end
    if GameTooltip.SetUnitBuff then
        hooksecurefunc(GameTooltip, "SetUnitBuff", function(tip, unit, index)
            OnAuraTooltip(tip, unit, index, "HELPFUL")
        end)
    end
    if GameTooltip.SetUnitDebuff then
        hooksecurefunc(GameTooltip, "SetUnitDebuff", function(tip, unit, index)
            OnAuraTooltip(tip, unit, index, "HARMFUL")
        end)
    end
end

local QUEST_CLASS_ES = {
    Warrior = "Guerreiro", Paladin = "Paladino", Hunter = "Caçador", Rogue = "Ladino",
    Priest = "Sacerdote", ["Death Knight"] = "Cavaleiro da Morte", Shaman = "Xamã",
    Mage = "Mago", Warlock = "Bruxo", Druid = "Druida",
}
local QUEST_RACE_ES = {
    Human = "Humano", Dwarf = "Anão", ["Night Elf"] = "Elfo Noturno", Gnome = "Gnomo",
    Draenei = "Draenei", Orc = "Orc", Undead = "Morto-vivo", Tauren = "Tauren",
    Troll = "Troll", ["Blood Elf"] = "Elfo Sangrento",
}

local function CollapseWS(t)
    t = t:gsub("%s+", " ")
    return (t:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function QuestNormalizeShown(t)
    t = t:gsub("\r", "")
    local n = UnitName and UnitName("player")
    if n and #n > 1 then t = t:gsub(n, "<name>") end
    local c = UnitClass and UnitClass("player")
    if c then
        t = t:gsub(c, "<class>")
        t = t:gsub(c:lower(), "<class>")
    end
    local r = UnitRace and UnitRace("player")
    if r then
        t = t:gsub(r, "<race>")
        t = t:gsub(r:lower(), "<race>")
    end
    return CollapseWS(t)
end

local function QuestRenderES(t)
    local male = not (UnitSex and UnitSex("player") == 3)

    -- Quests.lua preserva parágrafos como sequências escapadas para manter o
    -- arquivo gerado em uma linha por registro. O cliente precisa receber
    -- quebras reais; caso contrário mostra "\\n\\n" no pergaminho.
    t = t:gsub("\\n", "\n"):gsub("|n", "\n")

    t = t:gsub("%$[Gg]([^:;]*):([^;]*);", function(m, f)
        local pick = male and m or f
        return (pick:gsub("^%s+", ""):gsub("%s+$", ""))
    end)
    local name = (UnitName and UnitName("player")) or "aventureiro"
    local c = UnitClass and UnitClass("player")
    local cES = (c and QUEST_CLASS_ES[c]) or "aventureiro"
    local r = UnitRace and UnitRace("player")
    local rES = (r and QUEST_RACE_ES[r]) or ""
    t = t:gsub("%$[Nn]", name):gsub("%$[Cc]", cES):gsub("%$[Rr]", rES)

    t = t:gsub("<name>", name):gsub("<class>", cES):gsub("<race>", rES)
    return t
end
AES.QuestRenderPT = QuestRenderES

local function GuardEq(shown, guardEN)
    if guardEN == nil or type(shown) ~= "string" then return false end
    local left = QuestNormalizeShown(shown)
    local right = guardEN:gsub("\\n", "\n"):gsub("|n", "\n"):gsub("\r", "")
    right = right:gsub("%$[Nn]", "<name>"):gsub("%$[Cc]", "<class>"):gsub("%$[Rr]", "<race>")
    right = CollapseWS(right)
    if left == right then return true end

    -- Classes customizadas do Ascension nem sempre coincidem com UnitClass().
    -- O fallback flexibiliza apenas os placeholders; o restante precisa bater.
    local pattern = right:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
    pattern = pattern:gsub("<name>", ".-"):gsub("<class>", ".-"):gsub("<race>", ".-")
    return left:match("^" .. pattern .. "$") ~= nil
end

local function ResolveQuestIDByShown(title, shown, fields)
    if not (title and shown and shown ~= "" and AES.QuestData) then return nil end
    local cands = (AES.QuestTitleEN2IDs and AES.QuestTitleEN2IDs[title])
        or (AES.QuestTitleES2IDs and AES.QuestTitleES2IDs[title])
    if not cands then return nil end
    for _, id in ipairs(cands) do
        local qd = AES.QuestData[id]
        if qd then
            for _, f in ipairs(fields) do
                if GuardEq(shown, qd[f .. "EN"]) then return id end
                local es = qd[f]
                if es and CollapseWS(shown) == CollapseWS(QuestRenderES(es)) then
                    return id
                end
            end
        end
    end
end

local QUEST_PANEL_FIELDS = {
    { "QuestInfoDescriptionText", "d" },
    { "QuestInfoObjectivesText", "o" },
    { "QuestInfoRewardText", "c" },
    { "QuestProgressText", "p" },
}
local function ResolveQuestIDByPanels(title)
    if not title or title == "" then return nil end
    for _, pf in ipairs(QUEST_PANEL_FIELDS) do
        local fs = _G[pf[1]]
        if fs and fs.GetText and (not fs.IsVisible or fs:IsVisible()) then
            local shown = fs:GetText()
            if shown and shown ~= "" then
                local id = ResolveQuestIDByShown(title, shown, { pf[2] })
                if id then return id end
            end
        end
    end
end
AES.ResolveQuestIDByPanels = ResolveQuestIDByPanels

local function QuestGuardSet(fs, es, en)
    if not (fs and es and en) then return end
    local shown = fs.GetText and fs:GetText()
    if not shown or shown == "" then return end
    if not GuardEq(shown, en) then return end
    pcall(fs.SetText, fs, QuestRenderES(es))
end


-- O Ascension recria estes textos, então as janelas de missão ficam monitoradas.
local questUIFSHooked = setmetatable({}, { __mode = "k" })
local questUIRootHooked = setmetatable({}, { __mode = "k" })
local inQuestUIFSHook = false

local QUEST_UI_ROOT_NAMES = {
    "QuestFrame", "QuestLogFrame", "QuestInfoFrame",
    "QuestFrameGreetingPanel", "QuestFrameDetailPanel",
    "QuestFrameProgressPanel", "QuestFrameRewardPanel",
    "QuestLogDetailScrollChildFrame", "QuestWatchFrame", "WatchFrame",
    "ObjectiveTrackerFrame", "QuestTrackerFrame",
    "AscensionQuestFrame", "AscensionQuestLogFrame",
    "AscensionObjectiveTracker", "AscensionQuestTracker",
    "WorldMapFrame", "QuestMapFrame", "WorldMapQuestFrame", "MapQuestFrame",
    "QuestPOIFrame", "AscensionWorldMapFrame", "AscensionQuestMapFrame",
}

local QUEST_UI_EXPLICIT_NAMES = {
    "QuestLogTitleText", "QuestLogFrameTitleText", "QuestLogNoQuestsText",
    "QuestLogQuestDescription", "QuestLogObjectivesText",
    "QuestLogRewardTitleText", "QuestLogItemChooseText",
    "QuestLogItemReceiveText", "QuestLogSpellLearnText",
    "QuestInfoDescriptionHeader", "QuestInfoObjectivesHeader",
    "QuestInfoRewardsHeader", "QuestInfoItemChooseText",
    "QuestInfoItemReceiveText", "QuestInfoSpellReceiveText",
    "QuestProgressRequiredItemsText", "QuestProgressTitleText",
    "QuestFrameAcceptButton", "QuestFrameDeclineButton",
    "QuestFrameCompleteButton", "QuestFrameCompleteQuestButton",
    "QuestLogFrameAbandonButton", "QuestLogFramePushQuestButton",
    "QuestLogFrameTrackButton", "QuestLogFrameCancelButton",
}

local function TranslateQuestUIText(text)
    if not (db and db.quests) or type(text) ~= "string" or text == "" then return nil end
    local exact = (AES.QuestUIExact and AES.QuestUIExact[text])
        or QUEST_TOOLTIP_STATIC[text]
    if exact then return exact end

    local trackerText = TranslateQuestTooltipText(text)
    if trackerText then return trackerText end

    local title = TranslateQuestTitleText(text)
    if title then return title end
    local objective = AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[text]
    if objective and objective ~= false then return QuestRenderES(objective) end
    local questText = AES.QuestTextEN2PT and AES.QuestTextEN2PT[text]
    if questText and questText ~= false then return QuestRenderES(questText) end

    local static = TranslateStaticText and TranslateStaticText(text)
    if static and static ~= text then return static end

    local prefix, body = text:match("^(%s*[-•]%s*)(.-)%s*$")
    if body and body ~= "" then
        local translated = (AES.QuestUIExact and AES.QuestUIExact[body])
            or (AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[body])
        if translated and translated ~= false then
            return prefix .. QuestRenderES(translated)
        end
        local title = TranslateQuestTitleText(body)
        if title then return prefix .. title end
    end
    return nil
end
AES.TranslateQuestUIText = TranslateQuestUIText

local function HookQuestUIFS(fs)
    if not (fs and fs.SetText) or questUIFSHooked[fs] then return end
    questUIFSHooked[fs] = true
    for _, method in ipairs({ "SetText", "SetFormattedText" }) do
        if fs[method] then
            pcall(hooksecurefunc, fs, method, function(self)
                if inQuestUIFSHook or not (db and db.quests) then return end
                local text = self.GetText and self:GetText()
                local pt = text and TranslateQuestUIText(text)
                if pt and pt ~= text then
                    inQuestUIFSHook = true
                    pcall(self.SetText, self, pt)
                    inQuestUIFSHook = false
                end
            end)
        end
    end
end

local function WalkQuestUI(root, depth, seen)
    if not (root and root.GetRegions and root.GetChildren) then return end
    depth = depth or 0
    if depth > 10 then return end
    seen = seen or {}
    if seen[root] then return end
    seen[root] = true

    local okRegions, regions = pcall(function() return { root:GetRegions() } end)
    if okRegions then
        for _, region in ipairs(regions) do
            if region and region.IsObjectType and region:IsObjectType("FontString") then
                HookQuestUIFS(region)
                local text = region.GetText and region:GetText()
                local pt = text and TranslateQuestUIText(text)
                if pt and pt ~= text then pcall(region.SetText, region, pt) end
            end
        end
    end

    local okChildren, children = pcall(function() return { root:GetChildren() } end)
    if okChildren then
        for _, child in ipairs(children) do
            WalkQuestUI(child, depth + 1, seen)
        end
    end
end

local function ApplyQuestGlobalStrings()
    for globalName, translated in pairs(AES.QuestUIGlobals or {}) do
        if type(rawget(_G, globalName)) == "string" then
            rawset(_G, globalName, translated)
        end
    end
end

local function HookQuestUIRoots()
    for _, name in ipairs(QUEST_UI_ROOT_NAMES) do
        local root = _G[name]
        if root and root.HookScript and not questUIRootHooked[root] then
            questUIRootHooked[root] = true
            local hookRoot = root
            hookRoot:HookScript("OnShow", function()
                if db and db.quests then pcall(WalkQuestUI, hookRoot, 0, {}) end
            end)
        end
    end
end

local function TranslateQuestChrome()
    if not (db and db.quests) then return end
    ApplyQuestGlobalStrings()
    HookQuestUIRoots()

    local seen = {}
    for _, name in ipairs(QUEST_UI_ROOT_NAMES) do
        local root = _G[name]
        if root then pcall(WalkQuestUI, root, 0, seen) end
    end
    for _, name in ipairs(QUEST_UI_EXPLICIT_NAMES) do
        local object = _G[name]
        if object then
            if object.IsObjectType and object:IsObjectType("FontString") then
                HookQuestUIFS(object)
            end
            local text = object.GetText and object:GetText()
            local pt = text and TranslateQuestUIText(text)
            if pt and pt ~= text and object.SetText then pcall(object.SetText, object, pt) end
        end
    end
end
AES.TranslateQuestChrome = TranslateQuestChrome

local function TranslateQuestInfo()
    if not (db and db.quests) then return end
    local id
    if QuestInfoFrame and QuestInfoFrame.questLog then
        local sel = GetQuestLogSelection and GetQuestLogSelection()
        if sel and sel > 0 and GetQuestLogTitle then
            id = select(9, GetQuestLogTitle(sel))
        end
    elseif GetQuestID then
        id = GetQuestID()
    end
    id = tonumber(id)

    if (not id or id == 0) and _G["QuestInfoTitleHeader"] then
        local t = _G["QuestInfoTitleHeader"].GetText and _G["QuestInfoTitleHeader"]:GetText()
        if t then
            id = (AES.QuestTitleEN2ID and AES.QuestTitleEN2ID[t])
                or (AES.QuestTitleES2ID and AES.QuestTitleES2ID[t]) or nil
            if id == false then id = nil end

            if not id then id = ResolveQuestIDByPanels(t) end
        end
    end
    if not id or id == 0 then
        return
    end
    local es_t = AES.QuestTitle[id]
    if es_t then
        QuestGuardSet(_G["QuestInfoTitleHeader"], es_t, AES.QuestTitleEN[id])
    end

    for _, fsName in ipairs({ "QuestInfoItemReceiveText", "QuestInfoItemChooseText",
                              "QuestInfoRewardsHeader", "QuestInfoSpellReceiveText" }) do
        local fs = _G[fsName]
        local t = fs and fs.GetText and fs:GetText()
        local es = t and ((AES.QuestUIExact and AES.QuestUIExact[t])
            or (AES.UIStringsByEN and AES.UIStringsByEN[t])
            or (AES.CustomUI and AES.CustomUI[t])
            or (AES.ServerUI and AES.ServerUI[t]))
        if es then pcall(fs.SetText, fs, es) end
    end
    local qd = AES.QuestData[id]
    if not qd then return end
    QuestGuardSet(_G["QuestInfoDescriptionText"], qd.d, qd.dEN)
    QuestGuardSet(_G["QuestInfoObjectivesText"], qd.o, qd.oEN)
    QuestGuardSet(_G["QuestInfoRewardText"], qd.c, qd.cEN)
    TranslateQuestChrome()
end

local function TranslateQuestItemButtons()
    if not (db and db.items and AES.ItemName) then return end
    local function apply(fsName, link)
        local fs = _G[fsName]
        if not (fs and fs.GetText and link) then return end
        local id = tonumber(link:match("item:(%d+)"))
        local es = id and AES.ItemName[id]
        if not es then return end
        local guard = AES.ItemNameEN and AES.ItemNameEN[id]
        local shown = fs:GetText()
        if shown and (not guard or guard == shown) and shown ~= es then
            pcall(fs.SetText, fs, es)
        end
    end
    for i = 1, 12 do
        local btn = _G["QuestInfoItem" .. i]
        if btn and btn.IsShown and btn:IsShown() and btn.type and btn.GetID
            and GetQuestItemLink then
            apply("QuestInfoItem" .. i .. "Name",
                  select(1, GetQuestItemLink(btn.type, btn:GetID())))
        end
        local pbtn = _G["QuestProgressItem" .. i]
        if pbtn and pbtn.IsShown and pbtn:IsShown() and GetQuestItemLink then
            apply("QuestProgressItem" .. i .. "Name",
                  select(1, GetQuestItemLink("required", i)))
        end
    end
end

-- O painel aberto pela tecla L usa estas APIs para montar as recompensas.
-- GetQuestItemLink pode retornar nil enquanto o item está fora do cache e,
-- além disso, não é o caminho usado pelo Quest Log. Traduzir o primeiro retorno
-- mantém textura, quantidade, qualidade e usabilidade exatamente como vieram.
;(function()
    local function wrapRewardInfo(name)
        local original = _G[name]
        if type(original) ~= "function" then return end
        _G[name] = function(...)
            local itemName, texture, count, quality, usable = original(...)
            if db and db.items and type(itemName) == "string" then
                local translated = AES.ItemNameEN2ES and AES.ItemNameEN2ES[itemName]
                if translated and translated ~= false then itemName = translated end
            end
            return itemName, texture, count, quality, usable
        end
    end
    wrapRewardInfo("GetQuestItemInfo")
    wrapRewardInfo("GetQuestLogChoiceInfo")
    wrapRewardInfo("GetQuestLogRewardInfo")
    wrapRewardInfo("GetQuestLogRequiredItemInfo")
end)()

local function TranslateQuestProgress()
    if not (db and db.quests) then return end
    local id = GetQuestID and tonumber(GetQuestID())
    if (not id or id == 0) and _G["QuestProgressTitleText"] then
        local t = _G["QuestProgressTitleText"].GetText and _G["QuestProgressTitleText"]:GetText()
        if t then
            id = (AES.QuestTitleEN2ID and AES.QuestTitleEN2ID[t])
                or (AES.QuestTitleES2ID and AES.QuestTitleES2ID[t]) or nil
            if id == false then id = nil end

            if not id then id = ResolveQuestIDByPanels(t) end
        end
    end
    if not id or id == 0 then return end
    local es_t = AES.QuestTitle[id]
    if es_t then
        QuestGuardSet(_G["QuestProgressTitleText"], es_t, AES.QuestTitleEN[id])
    end
    local qd = AES.QuestData[id]
    if qd then
        QuestGuardSet(_G["QuestProgressText"], qd.p, qd.pEN)
    end
    TranslateQuestChrome()
end

local function TranslateQuestButtons(prefix, count)
    if not (db and db.quests and AES.QuestTitleEN2ES) then return end
    for i = 1, count do
        local b = _G[prefix .. i]
        if b and b.GetText then
            local t = b:GetText()
            local pt = t and TranslateQuestTitleText(t)
            if pt and pt ~= t then pcall(b.SetText, b, pt) end
        end
    end
end

local function TranslateTitlesIn(root)
    if not (root and root.GetRegions and root.GetChildren) then return end
    local function visit(fr, depth)
        if depth > 5 then return end
        for _, r in ipairs({ fr:GetRegions() }) do
            if r.IsObjectType and r:IsObjectType("FontString") then
                local t = r.GetText and r:GetText()
                local pt = t and TranslateQuestTitleText(t)
                if pt and pt ~= t then pcall(r.SetText, r, pt) end
            end
        end
        for _, c in ipairs({ fr:GetChildren() }) do
            visit(c, depth + 1)
        end
    end
    pcall(visit, root, 0)
end

local function TranslateGreetings()
    TranslateQuestChrome()
    TranslateQuestButtons("QuestTitleButton", 32)
    TranslateQuestButtons("GossipTitleButton", 32)
    TranslateTitlesIn(GossipFrame)
    TranslateTitlesIn(QuestFrameGreetingPanel)

    if AES.Runtime then
        AES.Runtime.After("quest-greeting", 0.05, function()
            TranslateQuestButtons("QuestTitleButton", 32)
            TranslateQuestButtons("GossipTitleButton", 32)
            TranslateTitlesIn(GossipFrame)
            TranslateTitlesIn(QuestFrameGreetingPanel)
        end)
    end
end

local function ReflowQuestPanels()

    for _, name in ipairs({ "QuestFrameRewardPanel", "QuestFrameDetailPanel",
                            "QuestFrameProgressPanel" }) do
        local panel = _G[name]
        if panel and panel.IsShown and panel:IsShown()
            and type(_G[name .. "_OnShow"]) == "function" then
            pcall(_G[name .. "_OnShow"], panel)
        end
    end
    for _, name in ipairs({ "QuestRewardScrollFrame", "QuestDetailScrollFrame",
                            "QuestProgressScrollFrame" }) do
        local sf = _G[name]
        if sf and sf.IsShown and sf:IsShown() then
            if sf.UpdateScrollChildRect then
                pcall(sf.UpdateScrollChildRect, sf)
            end
            local sb = _G[name .. "ScrollBar"]
            if sb and sb.SetValue and sb.GetValue then
                local v = sb:GetValue() or 0
                pcall(sb.SetValue, sb, v + 1)
                pcall(sb.SetValue, sb, v)
            end
        end
    end
end
AES.ReflowQuestPanels = ReflowQuestPanels

local function RunQuestLatePass()
    TranslateQuestInfo()
    TranslateQuestProgress()
    TranslateQuestChrome()
    pcall(ReflowQuestPanels)
    pcall(TranslateQuestItemButtons)
end

local function DelayedQuestPass()
    if not AES.Runtime then return end
    AES.Runtime.After("quest-pass-1", 0.03, RunQuestLatePass)
    AES.Runtime.After("quest-pass-2", 0.12, RunQuestLatePass)
end

local function CaptureGiverSex()
    if not (db and UnitSex) then return end
    local id
    if GetQuestID then id = tonumber(GetQuestID()) end
    if (not id or id == 0) and _G["QuestInfoTitleHeader"] then
        local t = _G["QuestInfoTitleHeader"].GetText and _G["QuestInfoTitleHeader"]:GetText()
        id = t and ((AES.QuestTitleES2ID and AES.QuestTitleES2ID[t])
            or (AES.QuestTitleEN2ID and AES.QuestTitleEN2ID[t])) or nil
        if id == false then id = nil end
        if not id then id = ResolveQuestIDByPanels(t) end
    end
    if not id or id == 0 then return end
    local sex = UnitExists and UnitExists("npc") and UnitSex("npc") or 0
    db.qsex = db.qsex or {}
    if db.qsex[id] == nil then
        db.qsex[id] = sex
    end
end

local questFrame = CreateFrame("Frame")
questFrame:RegisterEvent("QUEST_DETAIL")
questFrame:RegisterEvent("QUEST_PROGRESS")
questFrame:RegisterEvent("QUEST_COMPLETE")
questFrame:RegisterEvent("QUEST_GREETING")
questFrame:RegisterEvent("GOSSIP_SHOW")
questFrame:RegisterEvent("QUEST_ITEM_UPDATE")
questFrame:RegisterEvent("QUEST_LOG_UPDATE")
questFrame:RegisterEvent("QUEST_WATCH_UPDATE")
-- WORLD_MAP_UPDATE não existe em todas as builds 3.3.5a/Ascension.
-- O registro direto interrompia o carregamento do Core.lua e deixava os
-- wrappers do Diário de Missões (tecla L) abaixo deste ponto sem executar.
pcall(questFrame.RegisterEvent, questFrame, "WORLD_MAP_UPDATE")
questFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
questFrame:SetScript("OnEvent", function(self, event)
    if not (db and db.quests) then return end
    TranslateQuestChrome()
    if event == "QUEST_DETAIL" or event == "QUEST_COMPLETE" then
        local elapsed = 0
        local sexer = CreateFrame("Frame")
        sexer:SetScript("OnUpdate", function(sf, dt)
            elapsed = elapsed + dt
            if elapsed < 0.4 then return end
            sf:SetScript("OnUpdate", nil)
            pcall(CaptureGiverSex)
        end)
    end
    if event == "QUEST_PROGRESS" then
        TranslateQuestProgress()
        DelayedQuestPass()
    elseif event == "QUEST_GREETING" or event == "GOSSIP_SHOW" then
        TranslateGreetings()
    elseif event == "QUEST_ITEM_UPDATE" then

        TranslateQuestInfo()
        pcall(ReflowQuestPanels)
        DelayedQuestPass()
    else
        TranslateQuestInfo()
        DelayedQuestPass()
    end
end)
if type(QuestInfo_Display) == "function" then
    hooksecurefunc("QuestInfo_Display", TranslateQuestInfo)
end
if type(GossipFrameUpdate) == "function" then
    hooksecurefunc("GossipFrameUpdate", function()
        TranslateQuestButtons("GossipTitleButton", 32)
    end)
end

AES.TranslateQuestInfo = TranslateQuestInfo
AES.TranslateQuestProgress = TranslateQuestProgress

local gossipIdx
local gossipApplied = {}

local function GossipRenderEN(t)
    local male = not (UnitSex and UnitSex("player") == 3)

    t = t:gsub("%$[Gg]([^:;]*):([^;]*);", function(m, f)
        local pick = male and m or f
        return (pick:gsub("^%s+", ""):gsub("%s+$", ""))
    end)
    local name = (UnitName and UnitName("player")) or ""
    local c = (UnitClass and UnitClass("player")) or ""
    local r = (UnitRace and UnitRace("player")) or ""
    return (t:gsub("%$[Nn]", name):gsub("%$[Cc]", c):gsub("%$[Rr]", r))
end

local function GossipLookup(shown)
    local map = AES.GossipEN2ES
    if not (map and shown and shown ~= "") then return nil end
    local key = shown:gsub("\r", ""):gsub("%s+$", "")
    local es = map[key]
    if es == nil then
        if not gossipIdx then
            gossipIdx = {}
            for en, v in pairs(map) do
                if en:find("%$") then gossipIdx[GossipRenderEN(en)] = v end
            end
        end
        es = gossipIdx[key]
    end
    if es then
        es = QuestRenderES(es)
        gossipApplied[es] = true
        return es
    end
    return nil
end
AES.GossipLookup = GossipLookup


local function TranslateGossipGreeting()
    if not (db and db.gossip) then return end
    for _, fsName in ipairs({ "GossipGreetingText", "GreetingText" }) do
        local fs = _G[fsName]
        local t = fs and fs.GetText and fs:GetText()
        if t and t ~= "" and not gossipApplied[t] then
            local es = GossipLookup(t)
            if es then
                pcall(fs.SetText, fs, es)
            end
        end
    end
    for i = 1, 32 do
        local b = _G["GossipTitleButton" .. i]
        if b and b.GetText and b:IsShown() then
            local t = b:GetText()
            if t and not gossipApplied[t] then
                local es = GossipLookup(t)
                if es then pcall(b.SetText, b, es) end
            end
        end
    end
end
AES.TranslateGossipGreeting = TranslateGossipGreeting

local gossipFrame = CreateFrame("Frame")
gossipFrame:RegisterEvent("GOSSIP_SHOW")
gossipFrame:RegisterEvent("QUEST_GREETING")
gossipFrame:SetScript("OnEvent", function()
    if not (db and db.gossip) then return end
    TranslateGossipGreeting()
    if AES.Runtime then
        AES.Runtime.After("gossip-pass", 0.3, TranslateGossipGreeting)
    end
end)

local bubblePending, bubbleScanner = {}, nil

local function ScanBubbles()
    local now = GetTime()
    local any = false
    for en, info in pairs(bubblePending) do
        if now - info.t0 > 3 then bubblePending[en] = nil else any = true end
    end
    if not (any and WorldFrame) then return false end
    for _, f in ipairs({ WorldFrame:GetChildren() }) do
        if not (f.GetName and f:GetName()) then
            for _, r in ipairs({ f:GetRegions() }) do
                if r.IsObjectType and r:IsObjectType("FontString") then
                    local t = r.GetText and r:GetText()
                    local info = t and bubblePending[t]
                    if info then
                        pcall(r.SetText, r, info.es)

                        if r.GetStringWidth and f.SetWidth then
                            pcall(function()
                                f:SetWidth(math.min(330, r:GetStringWidth() + 28))
                                f:SetHeight(r:GetStringHeight() + 28)
                            end)
                        end
                    end
                end
            end
        end
    end
    return true
end

local function StartBubbleScan()
    if not bubbleScanner then bubbleScanner = CreateFrame("Frame") end
    local elapsed = 0
    bubbleScanner:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.1 then return end
        elapsed = 0
        if not ScanBubbles() then self:SetScript("OnUpdate", nil) end
    end)
end

local function GossipChatFilter(self, event, msg, ...)
    if not (db and db.gossip) or type(msg) ~= "string" then return false end
    local es = GossipLookup(msg)
    if es then
        bubblePending[msg] = { es = es, t0 = GetTime() }
        StartBubbleScan()
        return false, es, ...
    end
    return false
end
AES.GossipChatFilter = GossipChatFilter

if ChatFrame_AddMessageEventFilter then
    for _, ev in ipairs({ "CHAT_MSG_MONSTER_SAY", "CHAT_MSG_MONSTER_YELL",
                          "CHAT_MSG_MONSTER_WHISPER", "CHAT_MSG_MONSTER_EMOTE",
                          "CHAT_MSG_RAID_BOSS_EMOTE", "CHAT_MSG_RAID_BOSS_WHISPER" }) do
        ChatFrame_AddMessageEventFilter(ev, GossipChatFilter)
    end
end

local origGetTitleText = type(GetTitleText) == "function" and GetTitleText or nil

local function CurrentQuestID()
    local id = GetQuestID and tonumber(GetQuestID())
    if id and id ~= 0 then return id end
    local t = origGetTitleText and origGetTitleText()
    if t and t ~= "" and AES.QuestTitleEN2ID then
        id = AES.QuestTitleEN2ID[t]
        if id then return id end
    end
    return nil
end

local function WrapQuestGetter(name, field)
    local orig = _G[name]
    if type(orig) ~= "function" then return end
    _G[name] = function(...)
        local en = orig(...)
        if not (db and db.quests) or type(en) ~= "string" or en == "" then
            return en
        end
        -- GetQuestID é a fonte mais segura: o servidor já informou exatamente
        -- qual missão está aberta. Nesse caso, o texto ptBR pode ser aplicado
        -- mesmo quando bases antigas guardaram o original customizado em esES.
        local exactID = GetQuestID and tonumber(GetQuestID())
        if exactID == 0 then exactID = nil end
        local id = exactID or CurrentQuestID()
        local qd = id and AES.QuestData and AES.QuestData[id]
        local es = qd and qd[field]
        local guard = qd and qd[field .. "EN"]
        if exactID and es then
            return QuestRenderES(es)
        end
        if not (es and guard and GuardEq(en, guard)) then

            local t = origGetTitleText and origGetTitleText()
            local rid = t and ResolveQuestIDByShown(t, en, { field })
            if rid then id = rid end
            qd = id and AES.QuestData and AES.QuestData[id]
            es = qd and qd[field]
            guard = qd and qd[field .. "EN"]
        end
        if es and guard and GuardEq(en, guard) then
            return QuestRenderES(es)
        end

        if db and id and qd and es then
            db.qdrift = db.qdrift or {}
            db.qdrift[id] = db.qdrift[id] or {}
            if db.qdrift[id][field] == nil then
                db.qdrift[id][field] = en
            end
        end
        return en
    end
end
WrapQuestGetter("GetQuestText", "d")
WrapQuestGetter("GetObjectiveText", "o")
WrapQuestGetter("GetProgressText", "p")
WrapQuestGetter("GetRewardText", "c")

if origGetTitleText then
    GetTitleText = function(...)
        local en = origGetTitleText(...)
        if not (db and db.quests) or type(en) ~= "string" or en == "" then
            return en
        end

        local pt = TranslateQuestTitleText(en)
        if pt then return pt end
        return en
    end
end

for _, name in ipairs({ "GetGossipText", "GetGreetingText" }) do
    local orig = _G[name]
    if type(orig) == "function" then
        _G[name] = function(...)
            local en = orig(...)
            if not (db and db.gossip) or type(en) ~= "string" then return en end
            return GossipLookup(en) or en
        end
    end
end

local function WrapTitleList(fname)
    local orig = _G[fname]
    if type(orig) ~= "function" then return end
    _G[fname] = function(...)
        local r = { orig(...) }
        if db and db.quests and AES.QuestTitleEN2ES then
            for i = 1, #r do
                if type(r[i]) == "string" then
                    local pt = TranslateQuestTitleText(r[i])
                    if pt then r[i] = pt end
                end
            end
        end
        return unpack(r)
    end
end
WrapTitleList("GetGossipAvailableQuests")
WrapTitleList("GetGossipActiveQuests")

local function WrapTitleGetter(fname)
    local orig = _G[fname]
    if type(orig) ~= "function" then return end
    _G[fname] = function(...)
        local t = orig(...)
        if db and db.quests and type(t) == "string" and AES.QuestTitleEN2ES then
            local pt = TranslateQuestTitleText(t)
            if pt then return pt end
        end
        return t
    end
end
WrapTitleGetter("GetAvailableTitle")
WrapTitleGetter("GetActiveTitle")

-- Traduz o título antes de o diário montar a lista.
local origGetQuestLogTitle = type(GetQuestLogTitle) == "function" and GetQuestLogTitle or nil

-- O rastreador lê os objetivos direto das APIs do diário.
local function QuestDataFromLogIndex(index, shown, field)
    index = tonumber(index)
    if not (index and index > 0 and origGetQuestLogTitle) then return nil end
    -- Guardamos os retornos antes da conversao pelo mesmo motivo: clientes
    -- customizados podem nao devolver o nono valor para uma entrada invalida.
    local titleInfo = { origGetQuestLogTitle(index) }
    local questID = tonumber(titleInfo[9])
    local qd = questID and AES.QuestData and AES.QuestData[questID]
    if qd then return qd, questID end

    -- O cliente do Project Ascension nem sempre devolve questID no nono
    -- retorno de GetQuestLogTitle. Nesse caso, resolvemos pela combinacao do
    -- titulo original com o proprio texto ingles exibido. O texto elimina a
    -- ambiguidade de missoes diferentes que compartilham o mesmo titulo.
    local title = titleInfo[1]
    if type(title) ~= "string" or title == "" then return nil end
    questID = (AES.QuestTitleEN2ID and AES.QuestTitleEN2ID[title])
        or (AES.QuestTitleES2ID and AES.QuestTitleES2ID[title]) or nil
    if questID == false then questID = nil end
    if not questID and shown and field then
        questID = ResolveQuestIDByShown(title, shown, { field })
    end
    qd = questID and AES.QuestData and AES.QuestData[questID]
    return qd, questID
end

local function TranslateQuestLogText(text, index, field)
    if not (db and db.quests) or type(text) ~= "string" or text == "" then
        return text
    end

    local qd = QuestDataFromLogIndex(index, text, field)
    if qd then
        -- O indice selecionado (ou o titulo original unico usado como
        -- fallback) ja identifica a missao do Diario. Nao devemos exigir uma
        -- segunda igualdade literal com dEN/oEN: o cliente substitui
        -- <name>, <race> e <class> antes de devolver o texto e algumas builds
        -- do Ascension devolvem esses valores em outra localizacao. Essa
        -- guarda fazia a missao ser encontrada corretamente, mas rejeitava a
        -- traducao e mantinha descricao/objetivos em ingles.
        local pt = qd[field]
        if pt then return QuestRenderES(pt) end
    end

    if field == "o" and AES.QuestObjectiveEN2PT then
        local pt = AES.QuestObjectiveEN2PT[text]
        if pt and pt ~= false then return QuestRenderES(pt) end
    end
    return text
end

local origGetQuestLogQuestText = type(GetQuestLogQuestText) == "function"
    and GetQuestLogQuestText or nil
if origGetQuestLogQuestText then
    GetQuestLogQuestText = function(...)
        local r = { origGetQuestLogQuestText(...) }
        -- No cliente 3.3.5a esta API normalmente e chamada sem argumentos.
        -- Nesse caso, o texto pertence a missao atualmente selecionada no
        -- Diario (L). Esperar um indice em "..." fazia titulo traduzir, mas
        -- deixava descricao e objetivos no ingles.
        -- Em Lua 5.1, select(1, ...) nao produz nem mesmo um valor quando
        -- esta funcao e chamada sem argumentos. Passar esse resultado direto
        -- para tonumber() vira tonumber() (zero argumentos) e gera erro.
        local requestedIndex = select(1, ...)
        local index = tonumber(requestedIndex)
        if not index or index <= 0 then
            local selectedIndex = GetQuestLogSelection and GetQuestLogSelection() or nil
            index = tonumber(selectedIndex)
        end
        r[1] = TranslateQuestLogText(r[1], index, "d")
        r[2] = TranslateQuestLogText(r[2], index, "o")
        return unpack(r)
    end
end

local origGetQuestLogLeaderBoard = type(GetQuestLogLeaderBoard) == "function"
    and GetQuestLogLeaderBoard or nil
if origGetQuestLogLeaderBoard then
    GetQuestLogLeaderBoard = function(...)
        local r = { origGetQuestLogLeaderBoard(...) }
        local questIndex = select(2, ...)
        local trackerPT = TranslateQuestTooltipText(r[1])
        if not trackerPT and type(r[1]) == "string" then
            local qd, questID = QuestDataFromLogIndex(questIndex, r[1], "o")
            local contextual = questID and AES.QuestRuntimeTextByID
                and AES.QuestRuntimeTextByID[questID]
            contextual = contextual and contextual[r[1]]
            if contextual then trackerPT = QuestRenderES(contextual) end

            -- Quando o servidor devolve o objetivo completo, usa a tradução
            -- da própria missão. Não substitui objetivos individuais pelo
            -- parágrafo inteiro, comportamento incorreto da v39.
            if not trackerPT and qd and qd.oEN and GuardEq(r[1], qd.oEN) then
                trackerPT = qd.o and QuestRenderES(qd.o) or nil
            end
        end
        r[1] = trackerPT or r[1]
        return unpack(r)
    end
end

if origGetQuestLogTitle then
    GetQuestLogTitle = function(...)
        local r = { origGetQuestLogTitle(...) }
        if db and db.quests and type(r[1]) == "string" and r[1] ~= "" then
            local questID = tonumber(r[9])
            local pt = questID and AES.QuestTitle and AES.QuestTitle[questID]
            if not pt then pt = TranslateQuestTitleText(r[1]) end
            if pt then r[1] = pt end
        end
        return unpack(r)
    end
end

local function TranslateQuestLogTitles()
    if not (db and db.quests) then return end
    local offset = FauxScrollFrame_GetOffset and QuestLogListScrollFrame
        and FauxScrollFrame_GetOffset(QuestLogListScrollFrame) or 0
    for i = 1, 25 do
        local button = _G["QuestLogTitle" .. i]
        local index = offset + i
        if button and button.GetText and button:IsShown() and origGetQuestLogTitle then
            local en, _, _, _, _, _, _, _, questID = origGetQuestLogTitle(index)
            local pt = questID and AES.QuestTitle and AES.QuestTitle[questID]
            if not pt and en then pt = TranslateQuestTitleText(en) end
            if pt and button:GetText() ~= pt then pcall(button.SetText, button, pt) end
        end
    end
end

if type(QuestLog_Update) == "function" then
    hooksecurefunc("QuestLog_Update", function()
        TranslateQuestLogTitles()
        TranslateQuestChrome()
    end)
end
if QuestLogFrame and QuestLogFrame.HookScript then
    QuestLogFrame:HookScript("OnShow", function()
        TranslateQuestLogTitles()
        TranslateQuestChrome()
    end)
end

-- Cobre o painel avançado e rastreadores que já guardaram o texto.
local questTrackerFSHooked = setmetatable({}, { __mode = "k" })
local inQuestTrackerFSHook = false
local questTrackerRoots = setmetatable({}, { __mode = "k" })
local questTrackerLastDiscovery = -1

local function HookQuestTrackerFS(fs)
    if not (fs and fs.SetText) or questTrackerFSHooked[fs] then return end
    questTrackerFSHooked[fs] = true
    for _, method in ipairs({ "SetText", "SetFormattedText" }) do
        if fs[method] then
            pcall(hooksecurefunc, fs, method, function(self)
                if inQuestTrackerFSHook or not (db and db.quests) then return end
                local text = self.GetText and self:GetText()
                local pt = text and TranslateQuestTooltipText(text)
                if pt and pt ~= text then
                    inQuestTrackerFSHook = true
                    pcall(self.SetText, self, pt)
                    inQuestTrackerFSHook = false
                end
            end)
        end
    end
end

local function WalkQuestTracker(root, depth)
    if not (root and root.GetRegions and root.GetChildren) then return end
    depth = depth or 0
    if depth > 9 then return end

    local okRegions, regions = pcall(function() return { root:GetRegions() } end)
    if okRegions then
        for _, region in ipairs(regions) do
            if region and region.IsObjectType and region:IsObjectType("FontString") then
                HookQuestTrackerFS(region)
                local text = region.GetText and region:GetText()
                local pt = text and TranslateQuestTooltipText(text)
                if pt and pt ~= text then pcall(region.SetText, region, pt) end
            end
        end
    end

    local okChildren, children = pcall(function() return { root:GetChildren() } end)
    if okChildren then
        for _, child in ipairs(children) do
            WalkQuestTracker(child, depth + 1)
        end
    end
end

local function DiscoverQuestTrackerRoots()
    local now = GetTime and GetTime() or 0
    if questTrackerLastDiscovery >= 0 and now - questTrackerLastDiscovery < 0.5 then return end
    questTrackerLastDiscovery = now
    for name, frame in pairs(_G) do
        if type(name) == "string" then
            local lower = name:lower()
            if lower:find("watch", 1, true) or lower:find("objective", 1, true)
                or lower:find("tracker", 1, true) then
                local frameType = type(frame)
                if (frameType == "table" or frameType == "userdata")
                    and frame.GetRegions and frame.GetChildren then
                    questTrackerRoots[frame] = true
                end
            end
        end
    end
end

local function TranslateQuestTrackers()
    if not (db and db.quests) then return end
    for root in pairs(questTrackerRoots) do
        WalkQuestTracker(root, 0)
    end
end
AES.TranslateQuestTrackers = TranslateQuestTrackers

local questTrackerWatcher = CreateFrame("Frame")
for _, event in ipairs({ "ADDON_LOADED", "PLAYER_ENTERING_WORLD",
                          "QUEST_LOG_UPDATE", "QUEST_WATCH_UPDATE" }) do
    pcall(questTrackerWatcher.RegisterEvent, questTrackerWatcher, event)
end
questTrackerWatcher:SetScript("OnEvent", function(self, event)
    if event == "ADDON_LOADED" or event == "PLAYER_ENTERING_WORLD" then
        pcall(DiscoverQuestTrackerRoots)
    end
    pcall(TranslateQuestTrackers)
    local elapsed = 0
    questTrackerWatcher:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.15 then return end
        self:SetScript("OnUpdate", nil)
        pcall(TranslateQuestTrackers)
    end)
end)

local uiFSHooked = setmetatable({}, { __mode = "k" })
local inUIFSHook = false
function HookUIFS(fs)
    if uiFSHooked[fs] or not fs.SetText then return end
    uiFSHooked[fs] = true

    for _, metodo in ipairs({ "SetText", "SetFormattedText" }) do
        if fs[metodo] then
            pcall(hooksecurefunc, fs, metodo, function(self)
                if inUIFSHook or not (db and db.ui) then return end
                local txt = self.GetText and self:GetText()
                if type(txt) ~= "string" or txt == "" then return end
                local es = TranslateStaticText(txt)
                    or (AES.TranslateUnitDescriptorText and AES.TranslateUnitDescriptorText(txt))
                if es and es ~= txt then
                    inUIFSHook = true
                    pcall(self.SetText, self, es)
                    inUIFSHook = false
                end
            end)
        end
    end
end

local function WalkUIExact(root, depth, hookFS, skip)
    if not (root and root.GetRegions and root.GetChildren) then return end
    depth = depth or 0
    if depth > 7 then return end

    if skip then
        local okn, nm = pcall(function() return root.GetName and root:GetName() end)
        if okn and nm and skip(nm) then return end
    end

    for _, r in ipairs({ root:GetRegions() }) do
        if r.IsObjectType and r:IsObjectType("FontString") then
            local t = r.GetText and r:GetText()
            local es = t and (TranslateStaticText(t)
                or (AES.TranslateUnitDescriptorText and AES.TranslateUnitDescriptorText(t)))
            if es then pcall(r.SetText, r, es) end
            if hookFS then pcall(HookUIFS, r) end
        end
    end
    for _, c in ipairs({ root:GetChildren() }) do
        WalkUIExact(c, depth + 1, hookFS, skip)
    end
end

local function SkipAuctionFilters(nm)
    return nm:find("AuctionFilterButton", 1, true) ~= nil
end
AES.SkipAuctionFilters = SkipAuctionFilters

local function WalkCharacterStatUI(root, depth)
    if not (root and root.GetRegions and root.GetChildren) then return end
    depth = depth or 0
    if depth > 9 then return end

    local okRegions, regions = pcall(function() return { root:GetRegions() } end)
    if okRegions then
        for _, region in ipairs(regions) do
            if region and region.IsObjectType and region:IsObjectType("FontString") then
                HookCharacterStatFS(region)
                local text = region.GetText and region:GetText()
                local translated = text and TranslateCharacterStatText(text)
                if translated and translated ~= text then
                    inCharStatFSHook = true
                    pcall(region.SetText, region, translated)
                    inCharStatFSHook = false
                end
            end
        end
    end

    local okChildren, children = pcall(function() return { root:GetChildren() } end)
    if okChildren then
        for _, child in ipairs(children) do
            WalkCharacterStatUI(child, depth + 1)
        end
    end
end

local function TranslateCharacterFrame()
    if not (db and db.ui) then return end

    local function pass()
        if not (db and db.ui) then return false end
        pcall(WalkUIExact, CharacterFrame)
        pcall(WalkUIExact, PaperDollFrame)
        pcall(WalkUIExact, _G["AscensionCharacterFrame"], 0, true)
        pcall(WalkCharacterStatUI, _G["AscensionCharacterStatsPanel"], 0)
    end

    pass()
    if AES.Runtime then AES.Runtime.Repeat("character-frame", 0.3, 0.3, 3, pass) end
end

if CharacterFrame and CharacterFrame.HookScript then
    CharacterFrame:HookScript("OnShow", TranslateCharacterFrame)
end
AES.TranslateCharacterFrame = TranslateCharacterFrame

local function DeepPass(panel)
    if not (db and db.ui and panel) then return end
    pcall(WalkUIExact, panel, 0, true)
    if not AES.Runtime then return end

    AES.Runtime.Repeat("deep-panel:" .. tostring(panel), 0.4, 0.4, 3, function()
        if not (db and db.ui) then return false end
        local ok, vis = pcall(panel.IsVisible, panel)
        if not (ok and vis) then return false end
        pcall(WalkUIExact, panel, 0, true)
    end)
end

local serverDeep = {}
local function HookServerPanelsDeep()
    if not (db and db.ui) then return end
    local f, n = EnumerateFrames(), 0
    while f and n < 60000 do
        n = n + 1
        local ok, nm = pcall(f.GetName, f)
        if ok and nm and not serverDeep[nm]
            and (nm:find("Trial") or nm:find("Support") or nm:find("Customer")
                or nm:find("Profession") or nm:find("Challenge") or nm:find("Gamemode")
                or nm:find("Recovery") or nm:find("^Ascension")

                or nm:find("CharacterAdvancement") or nm:find("Collections")
                or nm:find("WildCard") or nm:find("SkillCard")
                or nm:find("Vanity") or nm:find("Draft")
                or nm:find("HelpMenu")) then
            serverDeep[nm] = true
            if f.HookScript and f.HasScript and f:HasScript("OnShow") then
                pcall(f.HookScript, f, "OnShow", function(self) DeepPass(self) end)
            end
            local okv, vis = pcall(function() return f:IsVisible() end)
            if okv and vis then DeepPass(f) end
        end
        f = EnumerateFrames(f)
    end
end
AES.HookServerPanelsDeep = HookServerPanelsDeep

local deepWatcher = CreateFrame("Frame")
deepWatcher:RegisterEvent("ADDON_LOADED")
deepWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
deepWatcher:SetScript("OnEvent", function(_, event, name)
    -- EnumerateFrames pode visitar dezenas de milhares de frames. Não há motivo
    -- para repetir isso a cada addon aleatório carregado.
    if event == "PLAYER_ENTERING_WORLD" or AES.Perf.IsRelevantUILoad(name) then
        pcall(HookServerPanelsDeep)
    end
end)

do
local function AuctionRowPT(index, t)
    local pre, core, post = t:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
    if not core then pre, core, post = "", t, "" end
    local ptName
    local offset = (FauxScrollFrame_GetOffset and BrowseScrollFrame
        and FauxScrollFrame_GetOffset(BrowseScrollFrame)) or 0
    local link = GetAuctionItemLink and GetAuctionItemLink("list", offset + index)
    local id = link and tonumber(link:match("item:(%d+)"))
    if id and AES.ItemName and AES.ItemName[id] then
        local enGuard = AES.ItemNameEN and AES.ItemNameEN[id]
        if not enGuard or enGuard == core then ptName = AES.ItemName[id] end
    end
    if not ptName then ptName = AES.ItemNameEN2ES and AES.ItemNameEN2ES[core] end
    if ptName then return pre .. ptName .. post end
    return nil
end

local function TranslateAuctionRows()
    if not (db and db.items) then return end
    for i = 1, 20 do
        local fs = _G["BrowseButton" .. i .. "Name"]
        if fs and fs.GetText then
            local ok, t = pcall(fs.GetText, fs)
            if ok and type(t) == "string" and t ~= "" then
                local pt = AuctionRowPT(i, t)
                if pt and pt ~= t then pcall(fs.SetText, fs, pt) end
            end
        end
    end
end

local function CatFontString(b)
    if not b then return nil end
    local fs = b.GetFontString and b:GetFontString()
    if fs then return fs end
    local nm = b.GetName and b:GetName()
    return nm and _G[nm .. "NormalText"] or nil
end

local AUC_CAT_FIX = {
    ["Mail"] = "Malha",
    ["Head"] = "Cabeça", ["Neck"] = "Pescoço", ["Shoulder"] = "Ombros",
    ["Shirt"] = "Camisa", ["Chest"] = "Torso", ["Waist"] = "Cintura",
    ["Legs"] = "Calças", ["Feet"] = "Pés", ["Wrist"] = "Pulsos",
    ["Hands"] = "Mãos", ["Finger"] = "Dedo", ["Trinket"] = "Berloque",
    ["Back"] = "Costas", ["Tabard"] = "Tabardo", ["Robe"] = "Veste",
}
local auOverlay = setmetatable({}, { __mode = "k" })
local function CatOverlay(b)
    local orig = CatFontString(b)
    if not orig or not b.CreateFontString then return end
    local ov = auOverlay[b]
    if not ov then
        ov = b:CreateFontString(nil, "OVERLAY")
        local fo = orig.GetFontObject and orig:GetFontObject()
        if fo then
            pcall(ov.SetFontObject, ov, fo)
        elseif orig.GetFont then
            local f, s, fl = orig:GetFont()
            if f then pcall(ov.SetFont, ov, f, s, fl) end
        end
        pcall(ov.SetAllPoints, ov, orig)
        local okj, j = pcall(orig.GetJustifyH, orig)
        if okj and j then pcall(ov.SetJustifyH, ov, j) end
        auOverlay[b] = ov
    end
    local ok, t = pcall(orig.GetText, orig)
    if not ok or type(t) ~= "string" or t == "" then
        pcall(orig.SetAlpha, orig, 1)
        ov:Hide()
        return
    end

    local clean = t:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
        :gsub("^%s+", ""):gsub("%s+$", "")
    local fromFix = AUC_CAT_FIX[t] or AUC_CAT_FIX[clean]
    local pt = fromFix or TranslateStaticText(t)
    if pt and pt ~= t then
        pcall(ov.SetText, ov, pt)
        if fromFix then
            pcall(ov.SetTextColor, ov, 1, 1, 1)
        else
            local okc, cr, cg, cb = pcall(orig.GetTextColor, orig)
            if okc and type(cr) == "number" then
                pcall(ov.SetTextColor, ov, cr, cg, cb)
            else
                pcall(ov.SetTextColor, ov, 1, 1, 1)
            end
        end
        pcall(orig.SetAlpha, orig, 0)
        pcall(orig.Hide, orig)
        ov:Show()
    else
        pcall(orig.Show, orig)
        pcall(orig.SetAlpha, orig, 1)
        ov:Hide()
    end
end

local function TranslateAuctionCats()
    if not (db and db.ui) then return end
    for i = 1, 60 do
        local b = _G["AuctionFilterButton" .. i]
        if b then pcall(CatOverlay, b) end
    end
end

local function TranslateAuction()
    TranslateAuctionRows()
    if AES.catTrans ~= false then TranslateAuctionCats() end
end
AES.catTrans = true
AES.TranslateAuction = TranslateAuction
AES.TranslateAuctionRows = TranslateAuctionRows
AES.TranslateAuctionCats = TranslateAuctionCats

local auHooked = setmetatable({}, { __mode = "k" })
local auInHook = false
local function HookAuctionRow(n)
    local fs = _G["BrowseButton" .. n .. "Name"]
    if not fs or auHooked[fs] or not fs.SetText then return end
    auHooked[fs] = true
    hooksecurefunc(fs, "SetText", function(self)
        if auInHook or not (db and db.items) then return end
        local ok, t = pcall(self.GetText, self)
        if not ok or type(t) ~= "string" or t == "" then return end
        local pt = AuctionRowPT(n, t)
        if pt and pt ~= t then
            auInHook = true
            pcall(self.SetText, self, pt)
            auInHook = false
        end
    end)
end

local function HookAuctionRows()
    for i = 1, 20 do HookAuctionRow(i) end
end

local auFnHooked = false
local function HookAuctionFuncs()
    if auFnHooked then return end
    auFnHooked = true
    for _, fn in ipairs({ "AuctionFrameFilters_UpdateClasses", "AuctionFrameFilters_Update" }) do
        if type(_G[fn]) == "function" then
            hooksecurefunc(fn, function()
                if AES.catTrans then pcall(TranslateAuctionCats) end
            end)
        end
    end
    if type(AuctionFrameBrowse_Update) == "function" then
        hooksecurefunc("AuctionFrameBrowse_Update", function()
            HookAuctionRows()
            pcall(TranslateAuctionRows)
        end)
    end
end
AES.HookAuctionFuncs = HookAuctionFuncs

local liveListWatcher = CreateFrame("Frame")
liveListWatcher:RegisterEvent("TRADE_SKILL_SHOW")
liveListWatcher:RegisterEvent("TRADE_SKILL_UPDATE")
liveListWatcher:RegisterEvent("AUCTION_HOUSE_SHOW")
liveListWatcher:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
liveListWatcher:SetScript("OnEvent", function(_, event)
    if not db then return end
    if event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_UPDATE" then
        if db.ui and TradeSkillFrame then pcall(WalkUIExact, TradeSkillFrame, 0, true) end
    else
        HookAuctionFuncs()
        if event == "AUCTION_HOUSE_SHOW" and db.ui and AuctionFrame then
            pcall(WalkUIExact, AuctionFrame, 0, true, SkipAuctionFilters)
        end
        HookAuctionRows()
        pcall(TranslateAuction)
    end
end)

local auCatTick, auCatAcc = CreateFrame("Frame"), 0
AES.Perf.RunAuctionCatTick = function(self, dt)
    if AES.catTrans == false or not (db and db.ui) then
        self:SetScript("OnUpdate", nil)
        return
    end
    local af = _G["AuctionFrame"]
    local ok, vis = pcall(function() return af and af.IsVisible and af:IsVisible() end)
    if not (ok and vis) then
        self:SetScript("OnUpdate", nil)
        return
    end
    auCatAcc = auCatAcc + (dt or 0)
    if auCatAcc < 0.15 then return end
    auCatAcc = 0
    pcall(TranslateAuctionCats)
end

AES.Perf.auCatEvents = AES.Perf.auCatEvents or CreateFrame("Frame")
AES.Perf.auCatEvents:RegisterEvent("AUCTION_HOUSE_SHOW")
AES.Perf.auCatEvents:RegisterEvent("AUCTION_HOUSE_CLOSED")
AES.Perf.auCatEvents:SetScript("OnEvent", function(_, event)
    if event == "AUCTION_HOUSE_SHOW" then
        auCatAcc = 0
        auCatTick:SetScript("OnUpdate", AES.Perf.RunAuctionCatTick)
    else
        auCatTick:SetScript("OnUpdate", nil)
    end
end)

end

do
local plateElapsed = 0
local plateRootState = setmetatable({}, { __mode = "k" })
local plateFSHooked = setmetatable({}, { __mode = "k" })
local inPlateFSHook = false

local function TranslatePlateText(text)
    if type(text) ~= "string" or text == "" or not AES.UnitNameEN2ES then return nil end

    local translated = AES.UnitNameEN2ES[text]
    if translated then return translated end

    local prefix, body, suffix = text:match("^(%s*)(.-)(%s*)$")
    if body and body ~= text then
        translated = AES.UnitNameEN2ES[body]
        if translated then return prefix .. translated .. suffix end
    end

    local color, inner, reset = text:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
    if inner then
        translated = AES.UnitNameEN2ES[inner]
        if translated then return color .. translated .. reset end
    end
    return nil
end

local function TranslatePlateFS(fs)
    if inPlateFSHook or not (db and db.units and AES.UnitNameEN2ES) then return end
    local text = fs and fs.GetText and fs:GetText()
    local translated = text and TranslatePlateText(text)
    if translated and translated ~= text then
        inPlateFSHook = true
        pcall(fs.SetText, fs, translated)
        inPlateFSHook = false
    end
end

local function HookPlateFS(fs)
    if not (fs and fs.SetText) or plateFSHooked[fs] then return end
    plateFSHooked[fs] = true
    pcall(hooksecurefunc, fs, "SetText", TranslatePlateFS)
    if fs.SetFormattedText then
        pcall(hooksecurefunc, fs, "SetFormattedText", TranslatePlateFS)
    end
    TranslatePlateFS(fs)
end

local function ScanPlateRoot(fr, depth)
    if not (fr and fr.GetRegions and fr.GetChildren) or depth > 4 then return end

    local okRegions, regions = pcall(function() return { fr:GetRegions() } end)
    if okRegions then
        for _, region in ipairs(regions) do
            if region and region.IsObjectType and region:IsObjectType("FontString") then
                HookPlateFS(region)
            end
        end
    end

    local okChildren, children = pcall(function() return { fr:GetChildren() } end)
    if okChildren then
        for _, child in ipairs(children) do
            ScanPlateRoot(child, depth + 1)
        end
    end
end

local function FrameCount(frame, method)
    local fn = frame and frame[method]
    if type(fn) ~= "function" then return -1 end
    local ok, count = pcall(fn, frame)
    return ok and tonumber(count) or -1
end

local function ScanPlateRootIfChanged(root)
    if not root then return end
    local children = FrameCount(root, "GetNumChildren")
    local regions = FrameCount(root, "GetNumRegions")
    local state = plateRootState[root]

    if state and state.children == children and state.regions == regions then return end
    plateRootState[root] = { children = children, regions = regions }
    pcall(ScanPlateRoot, root, 0)
end

-- No 3.3.5a as placas são filhos do WorldFrame e podem ser recicladas. O
-- passe abaixo só aprofunda em raízes novas ou cuja estrutura mudou; FontStrings
-- já encontrados ficam hookados e não precisam ser varridos de novo.
local plateScanner = CreateFrame("Frame")
plateScanner:SetScript("OnUpdate", function(_, dt)
    plateElapsed = plateElapsed + (dt or 0)
    if plateElapsed < 1.0 then return end
    plateElapsed = 0
    if not (db and db.units and AES.UnitNameEN2ES and WorldFrame) then return end

    local ok, children = pcall(function() return { WorldFrame:GetChildren() } end)
    if not ok then return end
    for _, child in ipairs(children) do
        ScanPlateRootIfChanged(child)
    end
end)
end

local UNITFRAME_ROOTS = {
    "XPerl_Target", "XPerl_TargetTarget", "XPerl_Focus", "XPerl_Player",
    "TargetFrame", "FocusFrame", "GossipFrame", "QuestFrame",
}

local function WalkReplaceExact(root, en, es)
    if not (root and root.GetRegions and root.GetChildren) then return end
    local function visit(fr, depth)
        if depth > 6 then return end
        for _, r in ipairs({ fr:GetRegions() }) do
            if r.IsObjectType and r:IsObjectType("FontString") then
                if (r.GetText and r:GetText()) == en then
                    pcall(r.SetText, r, es)
                end
            end
        end
        for _, c in ipairs({ fr:GetChildren() }) do
            visit(c, depth + 1)
        end
    end
    pcall(visit, root, 0)
end

local function TranslateUnitFrames(unit)
    if not (db and db.units) then return end
    local guid = UnitGUID and UnitGUID(unit)
    local id = guid and NpcIdFromGUID(guid)
    local es = id and AES.UnitName[id]
    local en = UnitName and UnitName(unit)
    if not (es and en) or es == en then return end
    local g = AES.UnitNameEN[id]
    if g and g ~= en then return end
    for _, rn in ipairs(UNITFRAME_ROOTS) do
        WalkReplaceExact(_G[rn], en, es)
    end
end

local function DelayedUnitPass(unit)
    if AES.Runtime then
        AES.Runtime.After("unit-frame:" .. tostring(unit), 0.2, function()
            TranslateUnitFrames(unit)
        end)
    end
end

local unitFrameWatcher = CreateFrame("Frame")
unitFrameWatcher:RegisterEvent("PLAYER_TARGET_CHANGED")
unitFrameWatcher:RegisterEvent("PLAYER_FOCUS_CHANGED")
unitFrameWatcher:RegisterEvent("GOSSIP_SHOW")
unitFrameWatcher:RegisterEvent("QUEST_GREETING")
unitFrameWatcher:RegisterEvent("QUEST_DETAIL")
unitFrameWatcher:RegisterEvent("QUEST_PROGRESS")
unitFrameWatcher:RegisterEvent("QUEST_COMPLETE")
unitFrameWatcher:SetScript("OnEvent", function(self, event)
    local unit = (event == "PLAYER_TARGET_CHANGED" and "target")
        or (event == "PLAYER_FOCUS_CHANGED" and "focus") or "npc"
    TranslateUnitFrames(unit)
    DelayedUnitPass(unit)
end)

local CASTBAR_ROOTS = {
    "CastingBarFrame", "TargetFrameSpellBar", "FocusFrameSpellBar",
    "Quartz3CastBarPlayer", "Quartz3CastBarTarget", "Quartz3CastBarFocus",
    "Quartz3CastBarPet", "QuartzCastBar",
}

local function TranslateCastbars(unit)
    if not (db and db.spells) then return end
    local name = UnitCastingInfo and UnitCastingInfo(unit)
    if not name and UnitChannelInfo then
        name = UnitChannelInfo(unit)
    end
    local es = name and AES.SpellNameEN2ES[name]
    if not es or es == name then return end
    for _, rn in ipairs(CASTBAR_ROOTS) do
        WalkReplaceExact(_G[rn], name, es)
    end
end

local function DelayedCastPass(unit)
    if AES.Runtime then
        AES.Runtime.After("castbar:" .. tostring(unit), 0.1, function()
            TranslateCastbars(unit)
        end)
    end
end

local castWatcher = CreateFrame("Frame")
castWatcher:RegisterEvent("UNIT_SPELLCAST_START")
castWatcher:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
castWatcher:SetScript("OnEvent", function(self, event, unit)
    if unit == "player" or unit == "target" or unit == "focus" or unit == "pet" then
        TranslateCastbars(unit)
        DelayedCastPass(unit)
    end
end)

;(function()
    local UPDATE_PREFIX = "APTBRver"
    local myVersionStr = (GetAddOnMetadata and GetAddOnMetadata("AscensionPTBR", "Version")) or "0.0.0"

    local function VersionScore(s)
        if type(s) ~= "string" then return nil end
        s = s:gsub("^v", "")
        local a, b, c, suf = s:match("^(%d+)%.(%d+)%.(%d+)(%a?)$")
        if not a then return nil end
        return tonumber(a) * 1000000 + tonumber(b) * 10000 + tonumber(c) * 100
            + (suf ~= "" and (suf:lower():byte() - 96) or 0)
    end

    local myScore = VersionScore(myVersionStr) or 0
    local notifiedScore = 0
    local lastSent = {}
    local lastWhisper = {}
    local pendingVersion
    local REBROADCAST_CHANNELS = { PARTY = true, RAID = true, GUILD = true, BATTLEGROUND = true }

    local GITHUB_REPO = (GetAddOnMetadata and GetAddOnMetadata("AscensionPTBR", "X-GitHub-Repo"))
        or "GabrielBosco/AscensionPTBR"
    local UPDATE_URL = (GetAddOnMetadata and GetAddOnMetadata("AscensionPTBR", "X-GitHub-Releases"))
        or ("https://github.com/" .. GITHUB_REPO .. "/releases/latest")
    local updPopup

    local function UpdateDB()
        AscensionPTBRDB = AscensionPTBRDB or {}
        return AscensionPTBRDB
    end

    local function TryOpenURL(url)
        for _, name in ipairs({ "OpenURL", "LaunchURL", "OpenExternalURL" }) do
            local fn = _G[name]
            if type(fn) == "function" then
                local ok, opened = pcall(fn, url)
                if ok and opened ~= false then return true end
            end
        end
        return false
    end

    local function ShowUpdatePopupNow(v)
        if not updPopup then
            local f = CreateFrame("Frame", "AscensionPTBRUpdate", UIParent)
            f:SetFrameStrata("DIALOG")
            f:SetWidth(470)
            f:SetHeight(180)
            f:ClearAllPoints()
            f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
            f:SetBackdrop({
                bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
                edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
                tile = true, tileSize = 32, edgeSize = 32,
                insets = { left = 11, right = 12, top = 12, bottom = 11 },
            })
            f:EnableMouse(true)
            f:SetMovable(true)
            f:RegisterForDrag("LeftButton")
            f:SetScript("OnDragStart", function(self) self:StartMoving() end)
            f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
            f:Hide()

            local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
            close:SetPoint("TOPRIGHT", -5, -5)

            local title = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
            title:SetPoint("TOP", 0, -20)
            title:SetText("|cff33ff99AscensionPTBR|r desatualizado")

            local msg = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
            msg:SetPoint("TOP", title, "BOTTOM", 0, -12)
            msg:SetWidth(425)
            msg:SetJustifyH("CENTER")
            f.msg = msg

            local eb = CreateFrame("EditBox", "AscensionPTBRUpdateEB", f, "InputBoxTemplate")
            eb:SetWidth(365)
            eb:SetHeight(20)
            eb:SetPoint("TOP", msg, "BOTTOM", 0, -12)
            eb:SetAutoFocus(false)
            eb:SetText(UPDATE_URL)
            eb:SetScript("OnTextChanged", function(self)
                if self:GetText() ~= UPDATE_URL then
                    self:SetText(UPDATE_URL)
                    self:HighlightText()
                end
            end)
            eb:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
            f.eb = eb

            local b1 = CreateFrame("Button", "AscensionPTBRUpdateB1", f, "UIPanelButtonTemplate")
            b1:SetWidth(175)
            b1:SetHeight(24)
            b1:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -8, 20)
            b1:SetText("Abrir GitHub")
            b1:SetScript("OnClick", function()
                if TryOpenURL(UPDATE_URL) then
                    f:Hide()
                    return
                end
                f.msg:SetText("Copie o endereço abaixo com |cffffffffCtrl+C|r e abra no navegador.")
                f.eb:SetFocus()
                f.eb:HighlightText()
            end)

            local b2 = CreateFrame("Button", "AscensionPTBRUpdateB2", f, "UIPanelButtonTemplate")
            b2:SetWidth(175)
            b2:SetHeight(24)
            b2:SetPoint("BOTTOMLEFT", f, "BOTTOM", 8, 20)
            b2:SetText("Agora não")
            b2:SetScript("OnClick", function() f:Hide() end)

            updPopup = f
            if type(UISpecialFrames) == "table" then
                table.insert(UISpecialFrames, "AscensionPTBRUpdate")
            end
        end

        updPopup.msg:SetText("Versão instalada: |cffffffff" .. myVersionStr
            .. "|r\nNova versão detectada: |cff33ff99" .. v .. "|r")
        updPopup.eb:SetText(UPDATE_URL)
        updPopup:ClearAllPoints()
        updPopup:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
        updPopup:Show()
        updPopup:Raise()
    end

    local function ShowUpdatePopup(v)
        if InCombatLockdown and InCombatLockdown() then
            pendingVersion = v
            return
        end
        ShowUpdatePopupNow(v)
    end

    local function RememberVersion(v)
        local score = VersionScore(v)
        if not score then return end
        local d = UpdateDB()
        local old = d.latestSeenVersion
        if not old or score > (VersionScore(old) or 0) then
            d.latestSeenVersion = v
        end
    end

    local function NotifyNewVersion(v)
        local score = VersionScore(v)
        if not score or score <= myScore or score <= notifiedScore then return end
        notifiedScore = score
        RememberVersion(v)
        DEFAULT_CHAT_FRAME:AddMessage(
            "|cff33ff99AscensionPTBR|r: nova versão |cffffffff" .. v
            .. "|r detectada automaticamente (instalada: " .. myVersionStr .. ").")
        pcall(ShowUpdatePopup, v)
    end

    local function SendVersion(chan, target, force)
        if not SendAddonMessage then return end
        local key = chan .. ":" .. tostring(target or "")
        local now = GetTime and GetTime() or 0
        if not force and lastSent[key] and now - lastSent[key] < 20 then return end
        lastSent[key] = now
        if chan == "WHISPER" then
            if target and target ~= "" then
                SendAddonMessage(UPDATE_PREFIX, "V:" .. myVersionStr, chan, target)
            end
        else
            SendAddonMessage(UPDATE_PREFIX, "V:" .. myVersionStr, chan)
        end
    end

    local function BroadcastAll(force)
        if GetNumRaidMembers and GetNumRaidMembers() > 0 then
            SendVersion("RAID", nil, force)
        elseif GetNumPartyMembers and GetNumPartyMembers() > 0 then
            SendVersion("PARTY", nil, force)
        end
        if IsInGuild and IsInGuild() then
            SendVersion("GUILD", nil, force)
        end
    end

    local function DelayedAutomaticCheck()
        if not AES.Runtime then return end
        AES.Runtime.After("version-check-first", 4, function() BroadcastAll(true) end)
        AES.Runtime.After("version-check-second", 12, function() BroadcastAll(false) end)
    end

    if RegisterAddonMessagePrefix then
        pcall(RegisterAddonMessagePrefix, UPDATE_PREFIX)
    end

    local updFrame = CreateFrame("Frame")
    updFrame:RegisterEvent("CHAT_MSG_ADDON")
    updFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    updFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
    updFrame:RegisterEvent("RAID_ROSTER_UPDATE")
    updFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
    updFrame:SetScript("OnEvent", function(self, event, prefix, msg, channel, sender)
        if event == "PLAYER_REGEN_ENABLED" then
            if pendingVersion then
                local v = pendingVersion
                pendingVersion = nil
                ShowUpdatePopupNow(v)
            end
            return
        end

        if event == "PLAYER_ENTERING_WORLD" then
            local cached = UpdateDB().latestSeenVersion
            if cached and (VersionScore(cached) or 0) > myScore then
                NotifyNewVersion(cached)
            end
            if UpdateDB().updateCheck ~= false then DelayedAutomaticCheck() end
            return
        end

        if event ~= "CHAT_MSG_ADDON" then
            BroadcastAll(false)
            return
        end

        if prefix ~= UPDATE_PREFIX or type(msg) ~= "string" then return end
        local v = msg:match("^V:(%d+%.%d+%.%d+%a?)$")
        local score = v and VersionScore(v)
        if not score then return end

        if score > myScore then
            NotifyNewVersion(v)
        elseif score < myScore then
            local now = GetTime and GetTime() or 0
            if sender and sender ~= "" and (not lastWhisper[sender] or now - lastWhisper[sender] >= 30) then
                lastWhisper[sender] = now
                SendVersion("WHISPER", sender, true)
            elseif channel and REBROADCAST_CHANNELS[channel] then
                SendVersion(channel, nil, false)
            end
        end
    end)

    AES.ShowUpdatePopup = ShowUpdatePopup
    AES.CheckForUpdates = function()
        BroadcastAll(true)
        local cached = UpdateDB().latestSeenVersion
        if cached and (VersionScore(cached) or 0) > myScore then
            NotifyNewVersion(cached)
        else
            DEFAULT_CHAT_FRAME:AddMessage(
                "|cff33ff99AscensionPTBR|r: consulta enviada ao grupo e à guilda. "
                .. "Nenhuma versão superior foi detectada até agora. "
                .. "O cliente 3.3.5a não consulta o GitHub diretamente.")
        end
    end
end)()
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "PLAYER_ENTERING_WORLD" then
        RetranslateStaticUI()
        HookStaticPanels()

        local acf = _G["AscensionCharacterFrame"]
        if acf and acf.HookScript and not AES._charHooked then
            AES._charHooked = true
            acf:HookScript("OnShow", TranslateCharacterFrame)

            local statsScroll = _G["AscensionCharacterStatsPanelScrollFrame"]
            local function OnStatsScroll()
                if not (db and db.ui) then return end
                pcall(WalkUIExact, _G["AscensionCharacterStatsPanel"], 0, true)
                pcall(WalkCharacterStatUI, _G["AscensionCharacterStatsPanel"], 0)
                if AES.Runtime then
                    AES.Runtime.After("character-stats-scroll", 0.1, function()
                        pcall(WalkUIExact, _G["AscensionCharacterStatsPanel"], 0, true)
                        pcall(WalkCharacterStatUI, _G["AscensionCharacterStatsPanel"], 0)
                    end)
                end
            end
            if statsScroll and statsScroll.HookScript then
                if statsScroll:HasScript("OnVerticalScroll") then
                    statsScroll:HookScript("OnVerticalScroll", OnStatsScroll)
                end
                if statsScroll:HasScript("OnMouseWheel") then
                    statsScroll:HookScript("OnMouseWheel", OnStatsScroll)
                end
            end
        end
        return
    end
    if arg1 ~= "AscensionPTBR" then return end
    self:UnregisterEvent("ADDON_LOADED")

    AscensionPTBRDB = AscensionPTBRDB or {}
    db = AscensionPTBRDB
    for k, v in pairs(defaults) do
        if db[k] == nil then db[k] = v end
    end

    -- Remove opções antigas que não são usadas na versão pública.
    for _, key in ipairs({ "capture", "captured", "uicaptured", "qcaptured",
                            "gcaptured", "scaptured", "globalscaptured",
                            "sonda", "marcos" }) do
        db[key] = nil
    end

    AES.ItemNameEN2ES = {}
    for id, en in pairs(AES.ItemNameEN or {}) do
        local es = AES.ItemName[id]
        if es and AES.ItemNameEN2ES[en] == nil then
            AES.ItemNameEN2ES[en] = es
        elseif es and AES.ItemNameEN2ES[en] ~= es then
            AES.ItemNameEN2ES[en] = false
        end
    end

    AES.UnitNameEN2ES = {}
    for id, en in pairs(AES.UnitNameEN or {}) do
        local es = AES.UnitName[id]
        if es and es ~= en then
            if AES.UnitNameEN2ES[en] == nil then
                AES.UnitNameEN2ES[en] = es
            elseif AES.UnitNameEN2ES[en] ~= es then
                AES.UnitNameEN2ES[en] = false
            end
        end
    end
    for en, es in pairs(AES.UnitNameEN2ES) do
        if es == false then AES.UnitNameEN2ES[en] = nil end
    end
    -- Alguns IDs compartilham o mesmo nome inglês, mas têm flexões, grafias ou
    -- dados PT divergentes. O mapa antigo descartava o nome inteiro nesses casos,
    -- deixando o rastreador em inglês. Preferências curadas mantêm o runtime estável.
    for en, pt in pairs(AES.UnitNamePreferredEN2PT or {}) do
        if type(en) == "string" and type(pt) == "string" and pt ~= "" then
            AES.UnitNameEN2ES[en] = pt
        end
    end

    if type(AES.BuildQuestRuntimeIndex) == "function" then
        AES.BuildQuestRuntimeIndex()
    end

    AES.QuestTitleEN2ES = {}
    AES.QuestTitleEN2ID = {}
    AES.QuestTitleES2ID = {}
    AES.QuestTitleEN2IDs = {}
    AES.QuestTitleES2IDs = {}
    AES.QuestObjectiveEN2PT = {}
    AES.QuestTextEN2PT = {}
    for id, en in pairs(AES.QuestTitleEN or {}) do
        local es = AES.QuestTitle[id]
        if es then
            if AES.QuestTitleEN2ES[en] == nil then
                AES.QuestTitleEN2ES[en] = es
                AES.QuestTitleEN2ID[en] = id
            elseif AES.QuestTitleEN2ES[en] ~= es then
                AES.QuestTitleEN2ES[en] = false
                AES.QuestTitleEN2ID[en] = nil
            else

                AES.QuestTitleEN2ID[en] = nil
            end
            local l = AES.QuestTitleEN2IDs[en]
            if not l then l = {}; AES.QuestTitleEN2IDs[en] = l end
            l[#l + 1] = id
            if AES.QuestTitleES2ID[es] == nil then
                AES.QuestTitleES2ID[es] = id
            elseif AES.QuestTitleES2ID[es] ~= id then
                AES.QuestTitleES2ID[es] = false
            end
            local le = AES.QuestTitleES2IDs[es]
            if not le then le = {}; AES.QuestTitleES2IDs[es] = le end
            le[#le + 1] = id
        end
    end
    for _, qd in pairs(AES.QuestData or {}) do
        for _, field in ipairs({ "d", "o", "p", "c" }) do
            local en, pt = qd and qd[field .. "EN"], qd and qd[field]
            if type(en) == "string" and en ~= "" and type(pt) == "string" and pt ~= "" then
                local prior = AES.QuestTextEN2PT[en]
                if prior == nil then
                    AES.QuestTextEN2PT[en] = pt
                elseif prior ~= pt then
                    -- Sem o ID, textos ambíguos ficam no original.
                    AES.QuestTextEN2PT[en] = false
                end
                if field == "o" then
                    prior = AES.QuestObjectiveEN2PT[en]
                    if prior == nil then
                        AES.QuestObjectiveEN2PT[en] = pt
                    elseif prior ~= pt then
                        AES.QuestObjectiveEN2PT[en] = false
                    end
                end
            end
        end
    end
    if not db._v or db._v < 2 then
        db.units = false
        db._v = 2
    end
    if db._v < 3 then

        db.units = true
        db._v = 3
    end
    if db._v < 4 then

        db.gossip = true
        db._v = 4
    end

    ApplyQuestGlobalStrings()
    TranslateQuestChrome()

    HookTooltip(GameTooltip)
    HookTooltip(ItemRefTooltip)

    HookTooltip(ShoppingTooltip1)
    HookTooltip(ShoppingTooltip2)
    HookTooltip(ShoppingTooltip3)
    HookTooltip(ItemRefShoppingTooltip1)
    HookTooltip(ItemRefShoppingTooltip2)
    HookAuras()
    HookSpellbook()
    HookAchievementAlerts()
    HookAchievementLinks()
    ApplyUIStrings()
    if IsAddOnLoaded and IsAddOnLoaded("Blizzard_AchievementUI") then
        HookAchievementUI()
    end
    if IsAddOnLoaded and IsAddOnLoaded("Blizzard_TrainerUI") then
        HookTrainerUI()
    end
    if IsAddOnLoaded and IsAddOnLoaded("Blizzard_TradeSkillUI") then
        HookTradeSkillUI()
    end
    local waiter = CreateFrame("Frame")
    waiter:RegisterEvent("ADDON_LOADED")
    waiter:SetScript("OnEvent", function(w, _, name)
        if name == "Blizzard_AchievementUI" then
            HookAchievementUI()
        elseif name == "Blizzard_TrainerUI" then
            HookTrainerUI()
        elseif name == "Blizzard_TradeSkillUI" then
            HookTradeSkillUI()
        end
    end)

    local n = 0
    for _ in pairs(AES.SpellNameEN2ES) do n = n + 1 end
    DEFAULT_CHAT_FRAME:AddMessage(format(
        "|cff33ff99AscensionPTBR|r carregado: %d nomes de feitiços, %d descrições, %d itens e %d NPCs. Use /aptbr para ver as opções.",
        n, #AES.DescPairs, (function() local c = 0 for _ in pairs(AES.ItemName) do c = c + 1 end return c end)(),
        (function() local c = 0 for _ in pairs(AES.UnitName) do c = c + 1 end return c end)()))
end)


SLASH_ASCENSIONPTBR1 = "/aptbr"
SLASH_ASCENSIONPTBR2 = "/ascensionptbr"
SlashCmdList["ASCENSIONPTBR"] = function(msg)
    msg = (msg or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
    local function status(v) return v and "|cff33ff99SIM|r" or "|cffff3333NÃO|r" end

    if msg == "feitiços" or msg == "feiticos" or msg == "magias" or msg == "spells" then
        db.spells = not db.spells
    elseif msg == "itens" or msg == "items" then
        db.items = not db.items
    elseif msg == "npcs" or msg == "units" then
        db.units = not db.units
    elseif msg == "linhas" or msg == "patterns" then
        db.patterns = not db.patterns
    elseif msg == "ambiente" or msg == "flavor" then
        db.flavor = not db.flavor
    elseif msg == "conquistas" or msg == "achievements" then
        db.achievements = not db.achievements
    elseif msg == "missões" or msg == "missoes" or msg == "quests" then
        db.quests = not db.quests
    elseif msg == "dialogos" or msg == "diálogos" or msg == "gossip" then
        db.gossip = not db.gossip
    elseif msg == "interface" or msg == "ui" then
        db.ui = not db.ui
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r interface alterada: use /reload para aplicar.")
        return
    elseif msg == "chat" then
        local enabled = not (db.chat ~= false)
        if AES.SetChatEnabled then AES.SetChatEnabled(enabled) else db.chat = enabled end
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r tradução do chat: " .. status(db.chat))
        return
    elseif msg == "erros" or msg == "errors" then
        local enabled = not (db.errores ~= false)
        if AES.SetErrorsEnabled then AES.SetErrorsEnabled(enabled) else db.errores = enabled end
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r tradução de erros: " .. status(db.errores))
        return
    elseif msg:match("^voz%s+") or msg:match("^voice%s+") then
        local command = msg:match("^%S+%s+(.+)$") or ""
        if AES.VoiceCommand then
            AES.VoiceCommand(command)
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r: módulo de vozes indisponível.")
        end
        return
    elseif msg == "voz" or msg == "voice" then
        local enabled = not (db.voice ~= false)
        if AES.SetVoiceEnabled then AES.SetVoiceEnabled(enabled) else db.voice = enabled end
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r vozes: "
            .. (db.voice and "|cff33ff99pt-BR|r" or "|cffffffffinglês original|r"))
        return
    elseif msg == "verificar" or msg == "versao" or msg == "versão"
        or msg == "atualizacao" or msg == "atualização" or msg == "update" then
        if AES.CheckForUpdates then AES.CheckForUpdates() end
        return
    elseif msg == "atualizar" or msg == "refresh" then
        RetranslateStaticUI()
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r interface retraduzida.")
        return
    elseif msg ~= "" then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r comandos: feitiços, itens, npcs, missões, diálogos, conquistas, interface, chat, erros, voz ptbr, voz ingles, verificar e atualizar.")
        return
    end

    DEFAULT_CHAT_FRAME:AddMessage(format(
        "|cff33ff99AscensionPTBR|r feitiços:%s itens:%s NPCs:%s linhas:%s ambiente:%s missões:%s diálogos:%s conquistas:%s interface:%s",
        status(db.spells), status(db.items), status(db.units), status(db.patterns), status(db.flavor),
        status(db.quests), status(db.gossip), status(db.achievements), status(db.ui)))
end

AscensionPTBR.__firma = "AscensionPTBR/1.4.0/AscensionES-1.5.9/2026-08-10"
