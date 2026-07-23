local AES = AscensionPTBR or {}
AscensionPTBR = AES

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
AES.UnitName       = AES.UnitName or {}
AES.UnitNameEN     = AES.UnitNameEN or {}
AES.UnitSub        = AES.UnitSub or {}
AES.UnitSubEN      = AES.UnitSubEN or {}
AES.LinePatterns   = AES.LinePatterns or {}
AES.ValueWords     = AES.ValueWords or {}
AES.UIStrings      = AES.UIStrings or {}
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

local function MatchPairSet(text, pairIndexes, pairsTable)
    if type(pairIndexes) == "number" then
        local pair = pairsTable[pairIndexes]
        return pair and MatchPair(text, pair) or nil
    end
    for _, idx in ipairs(pairIndexes) do
        local pair = pairsTable[idx]
        if pair then
            local nt = MatchPair(text, pair)
            if nt then return nt end
        end
    end
    return nil
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

local function MatchLinePatterns(text)
    local function apply(s)

        local exact = TranslateStaticText and TranslateStaticText(s)
        if exact then return exact end
        for _, p in ipairs(AES.LinePatterns) do
            if p[2] then
                local rep, n = s:gsub(p[1], p[2])
                if n > 0 and rep ~= s then return rep end
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

local function TranslateQuestTooltipText(text)
    if not (db and db.quests) or type(text) ~= "string" or text == "" then return nil end
    local function render(v)
        return AES.QuestRenderPT and AES.QuestRenderPT(v) or v
    end

    local direct = QUEST_TOOLTIP_STATIC[text]
        or (AES.QuestTitleEN2ES and AES.QuestTitleEN2ES[text])
        or (AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[text])
    if direct and direct ~= false then return render(direct) end

    -- O painel de objetivos do Ascension repete o objetivo com marcadores.
    -- Conserva recuo, hífen e espaços, substituindo somente o texto.
    local prefix, body = text:match("^(%s*[-•]%s*)(.-)%s*$")
    if body and body ~= "" then
        local translated = (AES.QuestTitleEN2ES and AES.QuestTitleEN2ES[body])
            or (AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[body])
            or QUEST_TOOLTIP_STATIC[body]
        if translated and translated ~= false then return prefix .. render(translated) end
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

local latePassTip, latePassElapsed, latePassShots
local latePassDriver = CreateFrame("Frame")
latePassDriver:SetScript("OnUpdate", function(self, dt)
    if not latePassTip then return end
    if not latePassTip:IsVisible() then
        latePassTip = nil
        return
    end
    latePassElapsed = latePassElapsed + (dt or 0.02)

    if (latePassShots == 0 and latePassElapsed >= 0.25)
        or (latePassShots == 1 and latePassElapsed >= 1.0) then
        latePassShots = latePassShots + 1
        pcall(TranslateTooltipLines, latePassTip)
        if latePassShots >= 2 then
            latePassTip = nil
        end
    end
end)

local function ScheduleLatePass(tip)
    if tip.IsVisible then
        latePassTip = tip
        latePassElapsed = 0
        latePassShots = 0
    end
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
    tip:Show()
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
    tip:Show()
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
    tip:Show()
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

    ApplyLinePatterns(tip)
    tip:Show()
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
    local es = (AES.CustomUI and AES.CustomUI[t])
        or (AES.ServerUI and AES.ServerUI[t])
        or (AES.UIStringsByEN and AES.UIStringsByEN[t])
    if es then return es end

    local base, tail = t:match("^(.-)%s*(:?)%s*$")
    if base and base ~= t and base ~= "" then
        es = (AES.CustomUI and AES.CustomUI[base])
            or (AES.ServerUI and AES.ServerUI[base])
            or (AES.UIStringsByEN and AES.UIStringsByEN[base])
        if es then return es .. (tail or "") end
    end

    local c0, inner, r0 = t:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)%s*$")
    if inner and inner ~= "" and not inner:find("|c") then
        local es2 = (AES.CustomUI and AES.CustomUI[inner])
            or (AES.ServerUI and AES.ServerUI[inner])
            or (AES.UIStringsByEN and AES.UIStringsByEN[inner])
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
local liveTicker = CreateFrame("Frame")
local liveAcc = 0
liveTicker:SetScript("OnUpdate", function(_, dt)
    liveAcc = liveAcc + dt
    if liveAcc < 0.75 then return end
    liveAcc = 0
    if not (db and db.ui) then return end
    for _, fname in ipairs(LIVE_UI_FRAMES) do
        local f = _G[fname]
        if f and f.IsVisible and f:IsVisible() then
            pcall(TranslateLiveSubtree, f, 0)
        end
    end
end)

local HookUIFS

local watched = setmetatable({}, { __mode = "k" })

local function RetranslateStaticUI()
    if not db or not db.ui then return end
    local frame = EnumerateFrames()
    while frame do

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
                            if es then
                                pcall(r.SetText, r, es)
                                watched[r] = true
                            end
                        end

                        if okvis and vis and HookUIFS then pcall(HookUIFS, r) end
                    end
                end
            end
        end
        frame = EnumerateFrames(frame)
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
                -- Attach before the panel is first painted. Any later SetText
                -- performed by Ascension is translated in the same UI cycle.
                if HookUIFS then pcall(HookUIFS, r) end
                watched[r] = true
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

local uiTick, uiAcc = CreateFrame("Frame"), 0
uiTick:SetScript("OnUpdate", function(_, dt)
    if not (db and db.ui) then return end
    uiAcc = uiAcc + dt
    if uiAcc < 0.5 then return end
    uiAcc = 0
    if InCombatLockdown and InCombatLockdown() then return end
    for fs in pairs(watched) do
        local ok, t = pcall(function() return fs:GetText() end)
        if ok and type(t) == "string" and t ~= "" then
            local es = TranslateStaticText(t)
            if es and es ~= t then pcall(fs.SetText, fs, es) end
        end
    end
end)

local staticPassTimer
local staticPassPanel
local function StaticPassSoon(panel)
    staticPassPanel = panel or staticPassPanel
    if staticPassPanel then pcall(PrimeStaticSubtree, staticPassPanel, 0) end
    RetranslateStaticUI()

    if not staticPassTimer then staticPassTimer = CreateFrame("Frame") end
    local elapsed, shots = 0, 0
    staticPassTimer:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + (dt or 0)
        local wait = shots == 0 and 0.03 or 0.15
        if elapsed < wait then return end
        elapsed = 0
        shots = shots + 1
        if staticPassPanel then pcall(PrimeStaticSubtree, staticPassPanel, 0) end
        if shots == 1 then RetranslateStaticUI() end
        if shots >= 2 then
            staticPassPanel = nil
            self:SetScript("OnUpdate", nil)
        end
    end)
end

local staticHooked = {}
local function HookStaticPanels()
    for _, name in ipairs({ "GameMenuFrame", "VideoOptionsFrame", "InterfaceOptionsFrame",
                            "AchievementFrame", "SpellBookFrame",

                            "AscensionLFGFrame", "AscensionPVEFrame", "AscensionPVPFrame",
                            "AscensionRulesetFrame", "PathToAscensionFrame",
                            "WarmodeMapFrame", "AscensionWeeklyKeystoneFrame",
                            "ChannelFrame",

                            "CharacterAdvancement", "Collections",
                            "WildCardRapidRollingFrame", "DraftHelpFrame",
                            "SkillCardsFrame", "VanityCollectionFrame" }) do
        local f = _G[name]
        if f then
            -- Prime hidden panels now, not only after OnShow. This prevents
            -- the original English label from appearing for a frame.
            pcall(PrimeStaticSubtree, f, 0)
            if not staticHooked[name] and f.HookScript and f:HasScript("OnShow") then
                staticHooked[name] = true
                f:HookScript("OnShow", StaticPassSoon)
            end
        end
    end
end

local staticWatcher = CreateFrame("Frame")
staticWatcher:RegisterEvent("ADDON_LOADED")
staticWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
staticWatcher:SetScript("OnEvent", function() pcall(HookStaticPanels) end)

if type(C_Tutorial) == "table" then
    local function TutMapStr(v)
        if type(v) ~= "string" or v == "" then return v end
        local es = TranslateStaticText(v)
        if es then return es end
        if db and db.capture and #v >= 3 and v:find("%a")
            and (v:find(" ") or #v >= 12) then
            db.uicaptured = db.uicaptured or {}
            db.uicaptured[v] = true
        end
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

function TranslateStaticTextProbe(t)
    return TranslateStaticText(t)
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
    tip:Show()
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
        tip:Show()
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
                local base, count = t:match("^(.-)%s*(%[%d+%])$")
                base = base or t
                local es = TradeSkillWord(base)
                if es then pcall(b.SetText, b, es .. (count and (" " .. count) or "")) end
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

local function HookTradeSkillUI()
    if type(TradeSkillFrame_Update) ~= "function" then return end
    hooksecurefunc("TradeSkillFrame_Update", function()
        if db and db.spells then
            TranslateTradeSkillFrame()
            TranslateTradeSkillDetail()
        end
    end)
    if type(TradeSkillFrame_SetSelection) == "function" then
        hooksecurefunc("TradeSkillFrame_SetSelection", function()
            if db and db.spells then TranslateTradeSkillDetail() end
        end)
    end
    if TradeSkillFrame and TradeSkillFrame.HookScript and TradeSkillFrame:HasScript("OnShow") then
        TradeSkillFrame:HookScript("OnShow", RetranslateStaticUI)
    end
end

AES.TranslateTradeSkillFrame = TranslateTradeSkillFrame
AES.TranslateTradeSkillDetail = TranslateTradeSkillDetail

local function HookTooltip(tip)
    if not tip then return end

    local inReshow = false

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

    local function CaptureTip(t)
        if not (db and db.capture) then return end
        db.captured = db.captured or {}
        local nm = t:GetName()
        for i = 1, t:NumLines() do
            local fs = _G[nm .. "TextLeft" .. i]
            local txt = fs and fs:GetText()
            if txt and txt ~= "" and txt:find("%a") then
                db.captured[txt] = true
            end
        end
    end
    if tip:HasScript("OnHide") then
        tip:HookScript("OnHide", CaptureTip)
    end
    if tip:HasScript("OnShow") then
        tip:HookScript("OnShow", function(t)
            if not db or inReshow then return end
            CaptureTip(t)
            if IsCharPanelTooltip(t) then return end

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

            inReshow = true
            pcall(t.Show, t)
            inReshow = false
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

local OPTIONS_LIST = {
    { key = "spells", text = "Feitiços, talentos e auras" },
    { key = "items", text = "Itens (nomes)" },
    { key = "flavor", text = "Texto de ambientação dos itens (a citação amarela)" },
    { key = "units", text = "Nomes de NPCs (os personalizados do CoA podem continuar em inglês)" },
    { key = "quests", text = "Missões (descrição, objetivos, progresso e conclusão)" },
    { key = "gossip", text = "Diálogos de NPCs (janela de conversa, chat e balões)" },
    { key = "achievements", text = "Conquistas" },
    { key = "patterns", text = "Linhas genéricas de tooltip (custo, alcance, graus...)" },
    { key = "ui", text = "Interface e menus (algumas alterações exigem /reload)" },
    { key = "erros", text = "Mensagens de erro na tela", setter = "SetErrorsEnabled" },
    { key = "chat", text = "Mensagens do chat (saque, experiência, sistema...)", setter = "SetChatEnabled" },
    { key = "voice", text = "Vozes de erro em português brasileiro", setter = "SetVoiceEnabled" },
}

local function BuildOptionsPanel()
    if not InterfaceOptions_AddCategory then return end
    local panel = CreateFrame("Frame", "AscensionPTBROptionsPanel", UIParent)
    panel.name = "AscensionPTBR"

    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("AscensionPTBR |cff33ff99— Português do Brasil|r")

    local sub = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    sub:SetJustifyH("LEFT")
    sub:SetText("As alterações são aplicadas imediatamente, salvo quando indicado. Comandos: /aptbr")

    local prev
    for i, opt in ipairs(OPTIONS_LIST) do
        local cb = CreateFrame("CheckButton", "AscensionPTBROptCheck" .. i, panel, "InterfaceOptionsCheckButtonTemplate")
        if prev then
            cb:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, -4)
        else
            cb:SetPoint("TOPLEFT", sub, "BOTTOMLEFT", -2, -14)
        end
        local label = _G[cb:GetName() .. "Text"]
        if label then
            label:SetText(opt.text)
        end
        cb.optKey = opt.key
        cb:SetScript("OnClick", function(self)
            local on = self:GetChecked() and true or false
            if opt.setter and AES[opt.setter] then
                AES[opt.setter](on)
            elseif db then
                db[opt.key] = on
            end
            if opt.key == "ui" then
                DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r interface: use /reload para aplicar as alterações")
            end
        end)
        prev = cb
    end

    panel:SetScript("OnShow", function()
        for i = 1, #OPTIONS_LIST do
            local cb = _G["AscensionPTBROptCheck" .. i]
            if cb and db then
                cb:SetChecked(db[cb.optKey] and true or false)
            end
        end
    end)

    InterfaceOptions_AddCategory(panel)
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
    return guardEN ~= nil
        and QuestNormalizeShown(shown) == CollapseWS(guardEN:gsub("\r", ""))
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

        if db.capture and _G["QuestInfoTitleHeader"] then
            local t = _G["QuestInfoTitleHeader"].GetText and _G["QuestInfoTitleHeader"]:GetText()
            if t and t ~= "" then
                db.qcaptured = db.qcaptured or {}
                local dFS = _G["QuestInfoDescriptionText"]
                local oFS = _G["QuestInfoObjectivesText"]
                db.qcaptured[t] = {
                    d = dFS and dFS.GetText and dFS:GetText() or nil,
                    o = oFS and oFS.GetText and oFS:GetText() or nil,
                }
            end
        end
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
        local es = t and ((AES.UIStringsByEN and AES.UIStringsByEN[t])
            or (AES.CustomUI and AES.CustomUI[t]))
        if es then pcall(fs.SetText, fs, es) end
    end
    local qd = AES.QuestData[id]
    if not qd then return end
    QuestGuardSet(_G["QuestInfoDescriptionText"], qd.d, qd.dEN)
    QuestGuardSet(_G["QuestInfoObjectivesText"], qd.o, qd.oEN)
    QuestGuardSet(_G["QuestInfoRewardText"], qd.c, qd.cEN)
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
    for i = 1, 8 do
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
end

local function TranslateQuestButtons(prefix, count)
    if not (db and db.quests and AES.QuestTitleEN2ES) then return end
    for i = 1, count do
        local b = _G[prefix .. i]
        if b and b.GetText then
            local t = b:GetText()
            local es = t and AES.QuestTitleEN2ES[t]
            if es then pcall(b.SetText, b, es) end
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
                local es = t and AES.QuestTitleEN2ES and AES.QuestTitleEN2ES[t]
                if es then pcall(r.SetText, r, es) end
            end
        end
        for _, c in ipairs({ fr:GetChildren() }) do
            visit(c, depth + 1)
        end
    end
    pcall(visit, root, 0)
end

local greetDelay
local function TranslateGreetings()
    TranslateQuestButtons("QuestTitleButton", 32)
    TranslateQuestButtons("GossipTitleButton", 32)
    TranslateTitlesIn(GossipFrame)
    TranslateTitlesIn(QuestFrameGreetingPanel)

    if not greetDelay then
        greetDelay = CreateFrame("Frame")
    end
    local elapsed = 0
    greetDelay:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.3 then return end
        self:SetScript("OnUpdate", nil)
        TranslateQuestButtons("QuestTitleButton", 32)
        TranslateQuestButtons("GossipTitleButton", 32)
        TranslateTitlesIn(GossipFrame)
        TranslateTitlesIn(QuestFrameGreetingPanel)
    end)
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

local questDelay
local function DelayedQuestPass()
    if not questDelay then
        questDelay = CreateFrame("Frame")
    end
    local elapsed, shots = 0, 0
    questDelay:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if (shots == 0 and elapsed < 0.3) or (shots == 1 and elapsed < 1.0) then
            return
        end
        shots = shots + 1
        TranslateQuestInfo()
        TranslateQuestProgress()
        pcall(ReflowQuestPanels)
        pcall(TranslateQuestItemButtons)
        if shots >= 2 then
            self:SetScript("OnUpdate", nil)
        end
    end)
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
questFrame:SetScript("OnEvent", function(self, event)
    if not (db and db.quests) then return end
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

local capCount = {}
local function GossipCapture(store, t)
    if not db or gossipApplied[t] or #t > 3000 then return end
    db[store] = db[store] or {}
    if db[store][t] then return end
    if capCount[store] == nil then
        local n = 0
        for _ in pairs(db[store]) do n = n + 1 end
        capCount[store] = n
    end
    if capCount[store] >= 400 then return end
    capCount[store] = capCount[store] + 1
    db[store][t] = {
        n = (UnitName and UnitName("player")) or "",
        c = (UnitClass and UnitClass("player")) or "",
        r = (UnitRace and UnitRace("player")) or "",
    }
end

local function TranslateGossipGreeting()
    if not (db and db.gossip) then return end
    for _, fsName in ipairs({ "GossipGreetingText", "GreetingText" }) do
        local fs = _G[fsName]
        local t = fs and fs.GetText and fs:GetText()
        if t and t ~= "" and not gossipApplied[t] then
            local es = GossipLookup(t)
            if es then
                pcall(fs.SetText, fs, es)
            else
                GossipCapture("gcaptured", t)
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

local gossipDelay
local gossipFrame = CreateFrame("Frame")
gossipFrame:RegisterEvent("GOSSIP_SHOW")
gossipFrame:RegisterEvent("QUEST_GREETING")
gossipFrame:SetScript("OnEvent", function()
    if not (db and db.gossip) then return end
    TranslateGossipGreeting()

    if not gossipDelay then gossipDelay = CreateFrame("Frame") end
    local elapsed = 0
    gossipDelay:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.3 then return end
        self:SetScript("OnUpdate", nil)
        TranslateGossipGreeting()
    end)
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
    GossipCapture("scaptured", msg)
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
        local id = CurrentQuestID()
        local qd = id and AES.QuestData and AES.QuestData[id]
        local es = qd and qd[field]
        local guard = qd and qd[field .. "EN"]
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

        local es = AES.QuestTitleEN2ES and AES.QuestTitleEN2ES[en]
        if es then return es end
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
                    local es = AES.QuestTitleEN2ES[r[i]]
                    if es then r[i] = es end
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
            local es = AES.QuestTitleEN2ES[t]
            if es then return es end
        end
        return t
    end
end
WrapTitleGetter("GetAvailableTitle")
WrapTitleGetter("GetActiveTitle")

-- O diário de missões clássico monta a coluna da esquerda diretamente com
-- GetQuestLogTitle(). Traduzir somente os FontStrings depois do Update fazia o
-- título aparecer em inglês por alguns quadros (e voltar ao inglês ao rolar).
-- Preservamos todos os retornos da API e substituímos apenas o primeiro.
local origGetQuestLogTitle = type(GetQuestLogTitle) == "function" and GetQuestLogTitle or nil
if origGetQuestLogTitle then
    GetQuestLogTitle = function(...)
        local r = { origGetQuestLogTitle(...) }
        if db and db.quests and type(r[1]) == "string" and r[1] ~= "" then
            local questID = tonumber(r[9])
            local pt = questID and AES.QuestTitle and AES.QuestTitle[questID]
            if not pt and AES.QuestTitleEN2ES then
                pt = AES.QuestTitleEN2ES[r[1]]
            end
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
            if not pt and en and AES.QuestTitleEN2ES then pt = AES.QuestTitleEN2ES[en] end
            if pt and button:GetText() ~= pt then pcall(button.SetText, button, pt) end
        end
    end
end

if type(QuestLog_Update) == "function" then
    hooksecurefunc("QuestLog_Update", TranslateQuestLogTitles)
end
if QuestLogFrame and QuestLogFrame.HookScript then
    QuestLogFrame:HookScript("OnShow", TranslateQuestLogTitles)
end

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
                if es and es ~= txt then
                    inUIFSHook = true
                    pcall(self.SetText, self, es)
                    inUIFSHook = false
                end
            end)
        end
    end
end

local function WalkUIExact(root, depth, hookFS)
    if not (root and root.GetRegions and root.GetChildren) then return end
    depth = depth or 0
    if depth > 7 then return end
    for _, r in ipairs({ root:GetRegions() }) do
        if r.IsObjectType and r:IsObjectType("FontString") then
            local t = r.GetText and r:GetText()
            local es = t and TranslateStaticText(t)
            if es then pcall(r.SetText, r, es) end
            if hookFS then pcall(HookUIFS, r) end
        end
    end
    for _, c in ipairs({ root:GetChildren() }) do
        WalkUIExact(c, depth + 1, hookFS)
    end
end

local charDelay
local function TranslateCharacterFrame()
    if not (db and db.ui) then return end
    pcall(WalkUIExact, CharacterFrame)
    pcall(WalkUIExact, PaperDollFrame)
    pcall(WalkUIExact, _G["AscensionCharacterFrame"], 0, true)
    if not charDelay then
        charDelay = CreateFrame("Frame")
    end
    local elapsed, shots = 0, 0
    charDelay:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.3 then return end
        elapsed = 0
        shots = shots + 1
        pcall(WalkUIExact, CharacterFrame)
        pcall(WalkUIExact, PaperDollFrame)
        pcall(WalkUIExact, _G["AscensionCharacterFrame"], 0, true)
        if shots == 1 then

            RetranslateStaticUI()
        end
        if shots >= 3 then
            self:SetScript("OnUpdate", nil)
        end
    end)
end

if CharacterFrame and CharacterFrame.HookScript then
    CharacterFrame:HookScript("OnShow", TranslateCharacterFrame)
end
AES.TranslateCharacterFrame = TranslateCharacterFrame

local deepTimers = setmetatable({}, { __mode = "k" })
local function DeepPass(panel)
    if not (db and db.ui and panel) then return end
    pcall(WalkUIExact, panel, 0, true)
    local t = deepTimers[panel]
    if not t then
        t = CreateFrame("Frame")
        deepTimers[panel] = t
    end
    local elapsed, shots = 0, 0
    t:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.4 then return end
        elapsed = 0
        shots = shots + 1
        local ok, vis = pcall(function() return panel:IsVisible() end)
        if ok and vis then pcall(WalkUIExact, panel, 0, true) end
        if shots >= 3 then self:SetScript("OnUpdate", nil) end
    end)
end

local vivos = setmetatable({}, { __mode = "k" })
local vivosTick, vivosAcc = CreateFrame("Frame"), 0
vivosTick:SetScript("OnUpdate", function(_, dt)
    if not (db and db.ui) then return end
    vivosAcc = vivosAcc + dt
    if vivosAcc < 0.5 then return end
    vivosAcc = 0
    if InCombatLockdown and InCombatLockdown() then return end
    for panel in pairs(vivos) do
        local ok, vis = pcall(function() return panel:IsVisible() end)
        if ok and vis then pcall(WalkUIExact, panel, 0, true) end
    end
end)

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
                or nm:find("Vanity") or nm:find("Draft")) then
            serverDeep[nm] = true
            if f.HookScript and f.HasScript and f:HasScript("OnShow") then
                pcall(f.HookScript, f, "OnShow", function(self) DeepPass(self) end)
            end
            vivos[f] = true
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
deepWatcher:SetScript("OnEvent", function() pcall(HookServerPanelsDeep) end)

local plateElapsed = 0
local plateScanner = CreateFrame("Frame")
plateScanner:SetScript("OnUpdate", function(self, dt)
    plateElapsed = plateElapsed + dt
    if plateElapsed < 0.5 then return end
    plateElapsed = 0
    if not (db and db.units and AES.UnitNameEN2ES and WorldFrame) then return end
    local kids = { WorldFrame:GetChildren() }
    for _, child in ipairs(kids) do
        if child.IsVisible and child:IsVisible() then
            local function scanFS(fr, depth)
                for _, r in ipairs({ fr:GetRegions() }) do
                    if r.IsObjectType and r:IsObjectType("FontString") then
                        local t = r.GetText and r:GetText()
                        local es = t and AES.UnitNameEN2ES[t]
                        if es then pcall(r.SetText, r, es) end
                    end
                end
                if depth < 2 then
                    for _, c in ipairs({ fr:GetChildren() }) do
                        scanFS(c, depth + 1)
                    end
                end
            end
            pcall(scanFS, child, 0)
        end
    end
end)

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

local unitDelay
local function DelayedUnitPass(unit)
    if not unitDelay then
        unitDelay = CreateFrame("Frame")
    end
    local elapsed = 0
    unitDelay:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.2 then return end
        self:SetScript("OnUpdate", nil)
        TranslateUnitFrames(unit)
    end)
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

local castDelay
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
    if not castDelay then
        castDelay = CreateFrame("Frame")
    end
    local elapsed = 0
    castDelay:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.1 then return end
        self:SetScript("OnUpdate", nil)
        TranslateCastbars(unit)
    end)
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

local UPDATE_PREFIX = "APTBRver"
local myVersionStr = (GetAddOnMetadata and GetAddOnMetadata("AscensionPTBR", "Version")) or "0.0.0"

local function VersionScore(s)
    local a, b, c, suf = s:match("^(%d+)%.(%d+)%.(%d+)(%a?)$")
    if not a then return nil end
    return tonumber(a) * 1000000 + tonumber(b) * 10000 + tonumber(c) * 100
        + (suf ~= "" and (suf:lower():byte() - 96) or 0)
end

local myScore = VersionScore(myVersionStr) or 0
local notifiedScore = 0
local lastSent = {}
local REBROADCAST_CHANNELS = { PARTY = true, RAID = true, GUILD = true, BATTLEGROUND = true }

local UPDATE_URL = "https://github.com/GabrielBosco/AscensionPTBR/releases"
local updPopup

local function TryOpenURL(url)
    for _, name in ipairs({ "OpenURL", "LaunchURL", "OpenExternalURL" }) do
        local fn = _G[name]
        if type(fn) == "function" and pcall(fn, url) then
            return true
        end
    end
    return false
end

local function ShowUpdatePopup(v)
    if not updPopup then
        local f = CreateFrame("Frame", "AscensionPTBRUpdate", UIParent)
        f:SetFrameStrata("DIALOG")
        f:SetWidth(440)
        f:SetHeight(150)
        f:SetPoint("TOP", UIParent, "TOP", 0, -140)
        f:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 32, edgeSize = 32,
            insets = { left = 11, right = 12, top = 12, bottom = 11 },
        })
        f:EnableMouse(true)
        local msg = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        msg:SetPoint("TOP", 0, -22)
        msg:SetWidth(400)
        f.msg = msg
        local eb = CreateFrame("EditBox", "AscensionPTBRUpdateEB", f, "InputBoxTemplate")
        eb:SetWidth(330)
        eb:SetHeight(20)
        eb:SetPoint("TOP", msg, "BOTTOM", 0, -10)
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
        b1:SetWidth(160)
        b1:SetHeight(24)
        b1:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -8, 18)
        b1:SetText("Atualizar")
        b1:SetScript("OnClick", function()
            if TryOpenURL(UPDATE_URL) then
                f:Hide()
                return
            end
            f.msg:SetText("Copie o link com |cffffffffCtrl+C|r e cole no navegador:")
            f.eb:SetFocus()
            f.eb:HighlightText()
        end)
        local b2 = CreateFrame("Button", "AscensionPTBRUpdateB2", f, "UIPanelButtonTemplate")
        b2:SetWidth(160)
        b2:SetHeight(24)
        b2:SetPoint("BOTTOMLEFT", f, "BOTTOM", 8, 18)
        b2:SetText("Cancelar")
        b2:SetScript("OnClick", function() f:Hide() end)
        updPopup = f
    end
    updPopup.msg:SetText("|cff33ff99AscensionPTBR|r: há uma nova versão |cffffffff" .. v
        .. "|r disponível (você possui " .. myVersionStr .. ").")
    updPopup.eb:SetText(UPDATE_URL)
    updPopup:Show()
end

local function BroadcastVersion(chan)
    if not SendAddonMessage then return end

    if myVersionStr:match("%a$") then return end
    local now = GetTime()
    if lastSent[chan] and now - lastSent[chan] < 30 then return end
    lastSent[chan] = now
    SendAddonMessage(UPDATE_PREFIX, "V:" .. myVersionStr, chan)
end

local function BroadcastAll()
    if GetNumRaidMembers and GetNumRaidMembers() > 0 then
        BroadcastVersion("RAID")
    elseif GetNumPartyMembers and GetNumPartyMembers() > 0 then
        BroadcastVersion("PARTY")
    end
    if IsInGuild and IsInGuild() then
        BroadcastVersion("GUILD")
    end
end

local updFrame = CreateFrame("Frame")
updFrame:RegisterEvent("CHAT_MSG_ADDON")
updFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
updFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
updFrame:RegisterEvent("RAID_ROSTER_UPDATE")
updFrame:SetScript("OnEvent", function(self, event, prefix, msg, channel)
    if event ~= "CHAT_MSG_ADDON" then
        BroadcastAll()
        return
    end
    if prefix ~= UPDATE_PREFIX or type(msg) ~= "string" then return end
    local v = msg:match("^V:(%d+%.%d+%.%d+%a?)$")
    local score = v and VersionScore(v)
    if not score then return end
    if score > myScore and score > notifiedScore then
        notifiedScore = score
        DEFAULT_CHAT_FRAME:AddMessage(
            "|cff33ff99AscensionPTBR|r: há uma nova versão |cffffffff" .. v
            .. "|r disponível (você possui " .. myVersionStr
            .. "). Baixe em |cff99ccffgithub.com/GabrielBosco/AscensionPTBR|r (seção Releases).")
        pcall(ShowUpdatePopup, v)
    elseif score < myScore and channel and REBROADCAST_CHANNELS[channel] then
        BroadcastVersion(channel)
    end
end)

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
            local statsPass = CreateFrame("Frame")
            local function OnStatsScroll()
                if not (db and db.ui) then return end
                pcall(WalkUIExact, _G["AscensionCharacterStatsPanel"], 0, true)
                local elapsed = 0
                statsPass:SetScript("OnUpdate", function(self, dt)
                    elapsed = elapsed + dt
                    if elapsed < 0.1 then return end
                    self:SetScript("OnUpdate", nil)
                    pcall(WalkUIExact, _G["AscensionCharacterStatsPanel"], 0, true)
                end)
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

    AES.ItemNameEN2ES = {}
    for id, en in pairs(AES.ItemNameEN or {}) do
        local es = AES.ItemName[id]
        if es and AES.ItemNameEN2ES[en] == nil then
            AES.ItemNameEN2ES[en] = es
        elseif es and AES.ItemNameEN2ES[en] ~= es then
            AES.ItemNameEN2ES[en] = false
        end
    end

    AES.UnitNameEN2ES = AES.UnitNameEN2ES or {}
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

    AES.QuestTitleEN2ES = {}
    AES.QuestTitleEN2ID = {}
    AES.QuestTitleES2ID = {}
    AES.QuestTitleEN2IDs = {}
    AES.QuestTitleES2IDs = {}
    AES.QuestObjectiveEN2PT = {}
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
        local en, pt = qd and qd.oEN, qd and qd.o
        if type(en) == "string" and en ~= "" and type(pt) == "string" and pt ~= "" then
            local prior = AES.QuestObjectiveEN2PT[en]
            if prior == nil then
                AES.QuestObjectiveEN2PT[en] = pt
            elseif prior ~= pt then
                -- Objetivos ingleses idênticos com traduções distintas não
                -- são seguros sem o ID; o tooltip permanece original.
                AES.QuestObjectiveEN2PT[en] = false
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
    BuildOptionsPanel()

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

local capHUD
local function CapHUDMuestra(modo)
    if not capHUD then
        capHUD = CreateFrame("Frame", nil, UIParent)
        capHUD:SetWidth(460)
        capHUD:SetHeight(46)
        capHUD:SetPoint("TOP", UIParent, "TOP", 0, -90)
        capHUD:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 16, edgeSize = 14,
            insets = { left = 3, right = 3, top = 3, bottom = 3 },
        })
        capHUD:SetBackdropColor(0, 0, 0, 0.8)
        capHUD.cab = capHUD:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        capHUD.cab:SetPoint("TOPLEFT", 10, -6)
        capHUD.ult = capHUD:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        capHUD.ult:SetPoint("TOPLEFT", 10, -24)
        capHUD.ult:SetWidth(440)
        capHUD.ult:SetJustifyH("LEFT")
    end
    capHUD.modo = modo
    capHUD.total = 0
    capHUD.cab:SetText("|cff33ff99AscensionPTBR|r capturando " .. modo .. "  ·  0 textos")
    capHUD.ult:SetText("|cff999999passe o mouse sobre os textos…|r")
    capHUD:Show()
end

local function CapHUDApunta(total, texto)
    if not capHUD then return end
    capHUD.total = total
    capHUD.cab:SetText(("|cff33ff99AscensionPTBR|r capturando %s  ·  |cffffd100%d|r textos")
        :format(capHUD.modo or "", total))
    texto = texto:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("\n", " ")
    if #texto > 68 then texto = texto:sub(1, 68) .. "…" end
    capHUD.ult:SetText("|cff00ff00+|r " .. texto)

    UIFrameFlash(capHUD, 0.12, 0.12, 0.24, false, 0, 0)
end

local function CapHUDOculta()
    if capHUD then capHUD:Hide() end
end

SLASH_ASCENSIONES1 = "/aptbr"
SLASH_ASCENSIONES2 = "/ascensionptbr"
SLASH_ASCENSIONES3 = "/ases"
SLASH_ASCENSIONES4 = "/ascensiones"
SlashCmdList["ASCENSIONES"] = function(msg)
    msg = (msg or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
    local function status(v) return v and "|cff33ff99SIM|r" or "|cffff3333NÃO|r" end
    if msg == "feitiços" or msg == "feiticos" or msg == "magias" or msg == "hechizos" or msg == "spells" then
        db.spells = not db.spells
    elseif msg == "itens" or msg == "objetos" or msg == "items" then
        db.items = not db.items
    elseif msg == "npcs" or msg == "units" then
        db.units = not db.units
    elseif msg == "linhas" or msg == "lineas" or msg == "patterns" then
        db.patterns = not db.patterns
    elseif msg == "ambiente" or msg == "ambiental" or msg == "flavor" then
        db.flavor = not db.flavor
    elseif msg == "conquistas" or msg == "logros" or msg == "achievements" then
        db.achievements = not db.achievements
    elseif msg == "missões" or msg == "missoes" or msg == "misiones" or msg == "quests" then
        db.quests = not db.quests
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r tradução de missões: " .. status(db.quests))
        return
    elseif msg == "dialogos" or msg == "diálogos" or msg == "gossip" then
        db.gossip = not db.gossip
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r tradução dos diálogos de NPCs: " .. status(db.gossip))
        return
    elseif msg == "capturar" or msg == "capture" then
        db.capture = not db.capture
        if db.capture then
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r CAPTURADOR ATIVADO: passe o mouse pelos tooltips que deseja registrar. Ao terminar, use /aptbr capturar e depois /reload.")
        else
            local n = 0
            for _ in pairs(db.captured or {}) do n = n + 1 end
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r capturador parado: " .. n .. " textos registrados. Use /reload para salvá-los no disco.")
        end
        return
    elseif msg == "volcarui" then

        db.uicaptured = db.uicaptured or {}
        local n = 0
        local fr = EnumerateFrames()
        while fr do
            local okv, vis = pcall(function() return fr:IsVisible() end)
            if okv and vis then
                local okr, regions = pcall(function() return { fr:GetRegions() } end)
                if okr and regions then
                    for _, r in ipairs(regions) do
                        if r.IsObjectType and r:IsObjectType("FontString") then
                            local t = r.GetText and r:GetText()
                            if t and #t >= 3 and t:find("%a") and not TranslateStaticText(t) then
                                if not db.uicaptured[t] then n = n + 1 end
                                db.uicaptured[t] = true
                            end
                        end
                    end
                end
            end
            fr = EnumerateFrames(fr)
        end
        DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99AscensionPTBR|r interface visível analisada: %d textos novos. Use /reload para salvá-los."):format(n))
        return
    elseif msg == "volcartut" then

        if type(C_Tutorial) ~= "table" then
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r este cliente não possui C_Tutorial.")
            return
        end
        db.uicaptured = db.uicaptured or {}
        local antes = 0
        for _ in pairs(db.uicaptured) do antes = antes + 1 end
        local oldcap = db.capture
        db.capture = true
        local cats = (C_Tutorial.GetCategories and C_Tutorial.GetCategories()) or {}
        for _, cid in ipairs(cats) do
            pcall(C_Tutorial.GetCategoryInfo, cid)
            pcall(C_Tutorial.SetTutorialFilter, cid, "")
            local n = (C_Tutorial.GetNumTutorials and C_Tutorial.GetNumTutorials()) or 0
            for i = 1, n do
                local ok, tid = pcall(C_Tutorial.GetTutorialAtIndex, i)
                if ok and tid then
                    pcall(C_Tutorial.GetTutorialDisplay, tid)
                    local ok2, objs = pcall(C_Tutorial.GetObjectives, tid)
                    if ok2 and type(objs) == "table" then
                        for _, oid in ipairs(objs) do
                            pcall(C_Tutorial.GetObjectiveInfo, oid)
                        end
                    end
                end
            end
        end
        if C_Tutorial.SetKeywordFilter then pcall(C_Tutorial.SetKeywordFilter, "") end
        local nk = (C_Tutorial.GetNumKeywords and C_Tutorial.GetNumKeywords()) or 0
        for i = 1, nk do pcall(C_Tutorial.GetKeywordAtIndex, i) end
        db.capture = oldcap
        local despues = 0
        for _ in pairs(db.uicaptured) do despues = despues + 1 end
        DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99AscensionPTBR|r guia analisado: %d textos novos (%d no total). Use /reload para salvá-los."):format(despues - antes, despues))
        return
    elseif msg == "mision" then

        local out = {}
        out[#out + 1] = "GetQuestID: " .. tostring(GetQuestID and (GetQuestID() or "nil") or "NÃO EXISTE")
        out[#out + 1] = "questLog: " .. tostring(QuestInfoFrame and QuestInfoFrame.questLog)
        local th = _G["QuestInfoTitleHeader"]
        local title = th and th.GetText and th:GetText() or "Sem título"
        out[#out + 1] = "título exibido: [" .. tostring(title) .. "]"
        local id = title and ((AES.QuestTitleEN2ID and AES.QuestTitleEN2ID[title])
            or (AES.QuestTitleES2ID and AES.QuestTitleES2ID[title]))
        if (not id or id == false) and title then
            id = ResolveQuestIDByPanels(title)
            if id then out[#out + 1] = "ID obtido pelo TEXTO (título repetido)" end
        end
        out[#out + 1] = "ID por título: " .. tostring(id)
        local qid = tonumber(GetQuestID and GetQuestID() or nil)
        if not qid or qid == 0 then qid = tonumber(id) end
        if qid and AES.QuestData[qid] then
            local qd = AES.QuestData[qid]
            out[#out + 1] = "dados: SIM (d=" .. tostring(qd.d ~= nil) .. " o=" .. tostring(qd.o ~= nil)
                .. " p=" .. tostring(qd.p ~= nil) .. " c=" .. tostring(qd.c ~= nil) .. ")"
            local checks = {
                { "desc", "QuestInfoDescriptionText", qd.dEN },
                { "obj", "QuestInfoObjectivesText", qd.oEN },
                { "entrega", "QuestInfoRewardText", qd.cEN },
            }
            for _, ck in ipairs(checks) do
                local fs = _G[ck[2]]
                local shown = fs and fs.GetText and fs:GetText()
                if shown and shown ~= "" and ck[3] then
                    local a = QuestNormalizeShown(shown)
                    local b = CollapseWS(ck[3]:gsub("\r", ""))
                    out[#out + 1] = "verificação " .. ck[1] .. ": " .. (a == b and "CORRESPONDE" or "NÃO corresponde")
                    if a ~= b then
                        local n = math.min(#a, #b)
                        local i = n + 1
                        for j = 1, n do
                            if a:sub(j, j) ~= b:sub(j, j) then
                                i = j
                                break
                            end
                        end
                        out[#out + 1] = "  diferença na posição " .. i .. ": exibido=[" ..
                            a:sub(math.max(1, i - 15), i + 25):gsub("|", "||") .. "] dados=[" ..
                            b:sub(math.max(1, i - 15), i + 25):gsub("|", "||") .. "]"
                    end
                end
            end
        else
            out[#out + 1] = "dados: NÃO para id " .. tostring(qid)
        end
        for _, l in ipairs(out) do
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99APTBR missão|r " .. l)
        end
        return
    elseif msg == "interface" or msg == "interface" or msg == "ui" then
        db.ui = not db.ui
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r interface alterada: use /reload para aplicar")
    elseif msg == "chat" then
        local newState = not (db.chat ~= false)
        if AES.SetChatEnabled then AES.SetChatEnabled(newState) else db.chat = newState end
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r tradução das mensagens do chat: " .. status(db.chat))
        return
    elseif msg == "erros" or msg == "errors" then
        local newState = not (db.erros ~= false)
        if AES.SetErrorsEnabled then AES.SetErrorsEnabled(newState) else db.erros = newState end
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r tradução das mensagens de erro: " .. status(db.erros))
        return
    elseif msg == "voz" or msg == "voice" then
        local newState = not (db.voice ~= false)
        if AES.SetVoiceEnabled then AES.SetVoiceEnabled(newState) else db.voice = newState end
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r vozes de erro: " .. status(db.voice))
        return
    elseif msg == "atualizar" or msg == "refrescar" or msg == "refresh" then
        RetranslateStaticUI()
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r interface estática retraduzida")
        return
    elseif msg == "marcos" or msg == "frames" then

        db.marcos = {}
        local seen, n, cont = {}, 0, 0
        local f = EnumerateFrames()
        while f and n < 60000 do
            n = n + 1
            local okv, vis = pcall(function() return f:IsVisible() end)
            if okv and vis then
                local okn, nm = pcall(f.GetName, f)
                if okn and nm and #nm > 3 and not seen[nm] then
                    local okr, regions = pcall(function() return { f:GetRegions() } end)
                    if okr and regions then
                        for _, r in ipairs(regions) do
                            if r and r.IsObjectType and r:IsObjectType("FontString")
                                and r.GetText and r:GetText() and r:GetText() ~= "" then
                                seen[nm] = true
                                db.marcos[#db.marcos + 1] = nm
                                cont = cont + 1
                                break
                            end
                        end
                    end
                end
            end
            f = EnumerateFrames(f)
        end
        DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99AscensionPTBR|r %d quadros com texto registrados. Use /reload para salvá-los."):format(cont))
        return
    elseif msg == "cappanel" or msg == "capturapanel" then

        db.uicaptured = db.uicaptured or {}
        if AES._cappanel then
            AES._cappanel:SetScript("OnUpdate", nil)
            AES._cappanel = nil
            CapHUDOculta()
            local n = 0
            for _ in pairs(db.uicaptured) do n = n + 1 end
            DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99AscensionPTBR|r captura de painéis PARADA: %d textos salvos. Use /reload."):format(n))
            return
        end
        local ticker = CreateFrame("Frame")
        AES._cappanel = ticker
        local acc, nuevos, cursor = 0, 0, nil
        ticker:SetScript("OnUpdate", function(self, dt)
            acc = acc + dt

            if acc < 0.01 then return end
            acc = 0
            local f, n = cursor or EnumerateFrames(), 0
            while f and n < 5000 do
                n = n + 1
                local okv, vis = pcall(function() return f:IsVisible() end)
                if okv and vis then
                    local okr, regions = pcall(function() return { f:GetRegions() } end)
                    if okr and regions then
                        for _, r in ipairs(regions) do
                            if r and r.IsObjectType and r:IsObjectType("FontString") then
                                local t = r.GetText and r:GetText()
                                if t and #t >= 3 and t:find("%a") and not TranslateStaticText(t) then
                                    if not db.uicaptured[t] then
                                        db.uicaptured[t] = true
                                        nuevos = nuevos + 1
                                        CapHUDApunta(nuevos, t)
                                    end
                                end
                            end
                        end
                    end
                end

                local oke, sig = pcall(EnumerateFrames, f)
                if not oke then f = nil; break end
                f = sig
            end
            cursor = f
        end)
        CapHUDMuestra("painéis")
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r captura de PAINÉIS ativada. Abra cada tela com calma. Ao terminar, use /aptbr cappanel e depois /reload.")
        return
    elseif msg == "diag" then

        local objetivo = "Band together"
        DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99AES|r db.ui=%s | buscando %q en marcos visibles..."):format(tostring(db and db.ui), objetivo))
        local hits, f, n = 0, EnumerateFrames(), 0
        while f and n < 60000 do
            n = n + 1
            local okv, vis = pcall(function() return f:IsVisible() end)
            if okv and vis then
                local nm = (f.GetName and f:GetName()) or "(anônimo)"
                local prot = f.IsProtected and select(1, f:IsProtected())
                local forb = f.IsForbidden and f:IsForbidden()
                local okr, regions = pcall(function() return { f:GetRegions() } end)
                if okr and regions then
                    for _, r in ipairs(regions) do
                        local okt, t = pcall(function() return r.GetText and r:GetText() end)
                        if okt and type(t) == "string" and t:find(objetivo, 1, true) then
                            hits = hits + 1
                            local tipo = (r.IsObjectType and r:IsObjectType("FontString")) and "FontString" or "region"
                            DEFAULT_CHAT_FRAME:AddMessage(("  [%s] en %s | prot=%s forb=%s"):format(tipo, nm, tostring(prot), tostring(forb)))
                        end
                    end
                end
                local ok2, t2 = pcall(function() return f.GetText and f:GetText() end)
                if ok2 and type(t2) == "string" and t2:find(objetivo, 1, true) then
                    hits = hits + 1
                    local tipo = (f.IsObjectType and f:IsObjectType("SimpleHTML")) and "SimpleHTML" or "Frame:GetText"
                    DEFAULT_CHAT_FRAME:AddMessage(("  [%s] MARCO %s | prot=%s forb=%s"):format(tipo, nm, tostring(prot), tostring(forb)))
                end
            end
            f = EnumerateFrames(f)
        end
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AES|r ocurrencias encontradas: " .. hits .. " (marcos recorridos: " .. n .. ")")
        return
    elseif msg == "volcarpanel" or msg == "panel" then

        db.uicaptured = db.uicaptured or {}
        local botones, f, n = {}, EnumerateFrames(), 0
        while f and n < 60000 do
            n = n + 1
            local okv, vis = pcall(function() return f:IsVisible() end)
            if okv and vis and f.GetScript and f.HasScript and f:HasScript("OnEnter") then
                local oks, s = pcall(f.GetScript, f, "OnEnter")
                if oks and s then botones[#botones + 1] = f end
            end
            f = EnumerateFrames(f)
        end
        DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99AscensionPTBR|r %d elementos com tooltip; analisando..."):format(#botones))
        CapHUDMuestra("panel")
        local i, nuevos = 0, 0
        local t = CreateFrame("Frame")
        t:SetScript("OnUpdate", function(self)
            local hechos = 0
            while i < #botones and hechos < 12 do
                i = i + 1
                hechos = hechos + 1
                local b = botones[i]
                local okv, vis = pcall(function() return b:IsVisible() end)
                if okv and vis then
                    local s = b:GetScript("OnEnter")
                    if s then
                        pcall(s, b)
                        if GameTooltip and GameTooltip:IsVisible() then
                            local nm = GameTooltip:GetName()
                            for k = 1, GameTooltip:NumLines() do
                                local fs = _G[nm .. "TextLeft" .. k]
                                local txt = fs and fs.GetText and fs:GetText()
                                if txt and #txt >= 12 and txt:find("%a")
                                    and not TranslateStaticText(txt) then
                                    if not db.uicaptured[txt] then
                                        db.uicaptured[txt] = true
                                        nuevos = nuevos + 1
                                        CapHUDApunta(nuevos, txt)
                                    end
                                end
                            end
                            pcall(GameTooltip.Hide, GameTooltip)
                        end
                    end
                end
            end
            if capHUD then
                capHUD.cab:SetText(("|cff33ff99AscensionPTBR|r analisando painel  ·  %d/%d  ·  |cffffd100%d|r textos")
                    :format(i, #botones, nuevos))
            end
            if i >= #botones then
                self:SetScript("OnUpdate", nil)
                CapHUDOculta()
                DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99AscensionPTBR|r painel analisado: %d textos sem tradução. Troque de classe/aba e repita, ou use /reload."):format(nuevos))
            end
        end)
        return
    elseif msg == "porque" then

        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r sonda ativada: abra o tooltip e mantenha-o por 4 s...")
        local f, t = CreateFrame("Frame"), 0
        f:SetScript("OnUpdate", function(self, dt)
            t = t + dt
            if t < 4 then return end
            self:SetScript("OnUpdate", nil)
            local tip = GameTooltip
            if not (tip and tip:IsVisible()) then
                DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r interface: use /reload para aplicar as alterações")
                return
            end
            local nm = tip:GetName()
            DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99AscensionPTBR|r tooltip %s, %d linhas:"):format(nm, tip:NumLines()))
            for i = 1, tip:NumLines() do
                local fs = _G[nm .. "TextLeft" .. i]
                local txt = fs and fs.GetText and fs:GetText()
                if txt and txt ~= "" then
                    local corto = txt:sub(1, 46):gsub("|", "||")
                    local est = (TranslateStaticText(txt) and "ESTATICO OK") or "-"
                    if est == "-" and #txt > 12 then
                        for cuantas = 8, 3, -1 do
                            local pref = PrefijoDe(txt, cuantas)
                            if #pref >= 8 then
                                local c = AES.DescByPrefix and AES.DescByPrefix[pref]
                                if c then
                                    est = ("PREFIJO(%d) %d cand."):format(cuantas, #c)
                                    local okp = false
                                    for _, idx in ipairs(c) do
                                        local par = AES.DescPairs[idx]
                                        if par and txt:match(par[1]) then okp = true break end
                                    end
                                    est = est .. (okp and " CASA" or " NINGUNO CASA")
                                    break
                                end
                            end
                        end
                        if est == "-" then est = "SEM CHAVE DE PREFIXO" end
                    end
                    DEFAULT_CHAT_FRAME:AddMessage(("  %d: %s | %s"):format(i, est, corto))

                    db.sonda = db.sonda or {}
                    db.sonda[#db.sonda + 1] = ("[%d][%s] %s"):format(i, est, txt)
                end
            end
        end)
        return
    elseif msg == "volcarglobales" or msg == "globales" then

        db.globalscaptured = db.globalscaptured or {}
        local n, ya = 0, 0
        for k, v in pairs(_G) do
            if type(k) == "string" and type(v) == "string"
                and k:match("^[A-Z][A-Z0-9_]+$") and #v >= 3 and #v <= 800
                and v:find("%a") and not v:find("^[A-Z][A-Z0-9_]+$") then
                if TranslateStaticText(v) then
                    ya = ya + 1
                elseif not db.globalscaptured[k] then
                    db.globalscaptured[k] = v
                    n = n + 1
                end
            end
        end
        DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99AscensionPTBR|r globais: %d novas sem tradução, %d já cobertas. Use /reload."):format(n, ya))
        return
    elseif msg == "volcarfeitiços" or msg == "feitiços" then

        db.uicaptured = db.uicaptured or {}
        if AES._volcado then
            AES._volcado:SetScript("OnUpdate", nil)
            AES._volcado = nil
            CapHUDOculta()
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r varredura INTERROMPIDA. Use /reload para salvar.")
            return
        end
        local oculto = AES._tipOculto
        if not oculto then
            oculto = CreateFrame("GameTooltip", "AscensionPTBRScanTip", nil, "GameTooltipTemplate")
            oculto:SetOwner(UIParent, "ANCHOR_NONE")
            AES._tipOculto = oculto
        end
        local f = CreateFrame("Frame")
        AES._volcado = f
        local id, nuevos, vistos = 0, 0, 0

        local TOPE = 1200000
        CapHUDMuestra("feitiços")
        f:SetScript("OnUpdate", function(self)

            local hechos = 0
            while id < TOPE and hechos < 250 do
                id = id + 1
                hechos = hechos + 1
                local nombre = GetSpellInfo(id)
                if nombre then
                    vistos = vistos + 1
                    oculto:ClearLines()
                    local okl = pcall(oculto.SetHyperlink, oculto, "spell:" .. id)
                    if okl then
                        for i = 1, oculto:NumLines() do
                            local fs = _G["AscensionPTBRScanTipTextLeft" .. i]
                            local t = fs and fs.GetText and fs:GetText()
                            if t and #t >= 20 and t:find("%a") and not TranslateStaticText(t) then
                                if not db.uicaptured[t] then
                                    db.uicaptured[t] = true
                                    nuevos = nuevos + 1
                                    if nuevos % 25 == 0 then CapHUDApunta(nuevos, t) end
                                end
                            end
                        end
                    end
                end
            end
            if capHUD then
                capHUD.cab:SetText(("|cff33ff99AscensionPTBR|r analisando feitiços  ·  %d%%  ·  |cffffd100%d|r textos")
                    :format(math.floor(id / TOPE * 100), nuevos))
            end
            if id >= TOPE then
                self:SetScript("OnUpdate", nil)
                AES._volcado = nil
                CapHUDOculta()
                DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99AscensionPTBR|r análise CONCLUÍDA: %d feitiços revisados e %d textos sem tradução salvos. Use /reload."):format(vistos, nuevos))
            end
        end)
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r analisando descrições de feitiços... você pode continuar jogando. Para cancelar: /aptbr volcarfeitiços")
        return
    elseif msg == "captip" or msg == "tooltips" then

        db.uicaptured = db.uicaptured or {}
        if AES._captip then
            AES._captip:SetScript("OnUpdate", nil)
            AES._captip = nil
            CapHUDOculta()
            local n = 0
            for _ in pairs(db.uicaptured) do n = n + 1 end
            DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99AscensionPTBR|r captura de tooltips PARADA: %d textos salvos. Use /reload."):format(n))
            return
        end
        local f = CreateFrame("Frame")
        AES._captip = f
        local acc, nuevos = 0, 0
        f:SetScript("OnUpdate", function(self, dt)
            acc = acc + dt

            if acc < 0.05 then return end
            acc = 0
            if not (GameTooltip and GameTooltip:IsVisible()) then return end
            local nm = GameTooltip:GetName()
            for i = 1, GameTooltip:NumLines() do
                for _, suf in ipairs({ "TextLeft", "TextRight" }) do
                    local fs = _G[nm .. suf .. i]
                    local t = fs and fs.GetText and fs:GetText()

                    if t and #t >= 3 and t:find("%a") and not TranslateStaticText(t) then
                        if not db.uicaptured[t] then
                            db.uicaptured[t] = true
                            nuevos = nuevos + 1
                            CapHUDApunta(nuevos, t)
                        end
                    end
                end
            end
        end)
        CapHUDMuestra("tooltips")
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r captura de TOOLTIPS ativada: passe o mouse por cada profissão. Ao terminar, use /aptbr captip e depois /reload.")
        return
    elseif msg == "traduce" then

        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r sonda de tradução ativada: abra o tooltip e mantenha-o por 4 s...")
        local probe = CreateFrame("Frame")
        local elapsed = 0
        probe:SetScript("OnUpdate", function(self, dt)
            elapsed = elapsed + dt
            if elapsed < 4 then return end
            self:SetScript("OnUpdate", nil)
            if not GameTooltip:IsVisible() then
                DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r interface: use /reload para aplicar as alterações")
                return
            end
            local list = CollectTooltipFontStrings(GameTooltip)
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r FontStrings coletados: " .. #list)
            for i, fs in ipairs(list) do
                if i <= 8 then
                    local t = fs:GetText() or ""
                    t = t:gsub("|", "||"):sub(1, 55)
                    DEFAULT_CHAT_FRAME:AddMessage("  " .. i .. ": " .. t)
                end
            end
            local ok, err = pcall(TranslateTooltipLines, GameTooltip)
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AES|r pasada manual: " .. (ok and "executada" or ("ERRO: " .. tostring(err))))
        end)
        return
    elseif msg:match("^volcar") then

        local needle = msg:match("^volcar%s+(.+)$") or "Deals"
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r sonda ativada: passe o mouse pelo tooltip — captura em 4 s...")
        local probe = CreateFrame("Frame")
        local elapsed = 0
        probe:SetScript("OnUpdate", function(self, dt)
            elapsed = elapsed + dt
            if elapsed < 4 then return end
            self:SetScript("OnUpdate", nil)
            local found = 0
            local frame = EnumerateFrames()
            while frame do
                local ok, regions = pcall(function() return { frame:GetRegions() } end)
                if ok and regions then
                    for _, r in ipairs(regions) do
                        if r and r.IsObjectType and r:IsObjectType("FontString")
                            and r.IsVisible and r:IsVisible() then
                            local t = r:GetText()
                            if t and t:lower():find(needle, 1, true) then
                                found = found + 1
                                local f, chain = frame, {}
                                while f and #chain < 6 do
                                    chain[#chain + 1] = (f.GetName and f:GetName()) or "(anônimo)"
                                    f = f.GetParent and f:GetParent()
                                end
                                DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR sonda|r " .. found .. ": " .. table.concat(chain, " < "))
                                local shown = t:gsub("|", "||"):gsub("\n", "\\n"):gsub("\r", "\\r")
                                if #shown > 150 then shown = shown:sub(1, 150) .. "..." end
                                DEFAULT_CHAT_FRAME:AddMessage("    texto bruto: [" .. shown .. "]")
                            end
                        end
                    end
                end
                frame = EnumerateFrames(frame)
            end
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR sonda|r fim: " .. found .. " correspondências de '" .. needle .. "'")
        end)
        return
    elseif msg ~= "" then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r comandos: /aptbr feitiços | itens | npcs | diálogos | linhas | ambiente | conquistas | interface | atualizar")
        return
    end
    DEFAULT_CHAT_FRAME:AddMessage(format(
        "|cff33ff99AscensionPTBR|r feitiços:%s itens:%s NPCs:%s linhas:%s ambiente:%s missões:%s diálogos:%s conquistas:%s interface:%s",
        status(db.spells), status(db.items), status(db.units), status(db.patterns), status(db.flavor),
        status(db.quests), status(db.gossip), status(db.achievements), status(db.ui)))
end

AscensionPTBR.__firma = "AscensionPTBR/1.5.10/2026-07-23"
