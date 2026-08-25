local AES = AscensionPTBR or {}
AscensionPTBR = AES
AES.Perf = AES.Perf or {}
AES.Diagnostics = AES.Diagnostics or {}

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
AES.QuestObjectivePartEN2PT = AES.QuestObjectivePartEN2PT or {}
AES.QuestObjectiveNormalizedEN2PT = AES.QuestObjectiveNormalizedEN2PT or {}
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
    ["Seereth Stonebreak"] = "Seereth Quebra-pedra",
    ["Venture Co. Logger"] = "Madeireiro da Empreendimentos S.A.",
    ["Venture Co. Loggers"] = "Madeireiros da Empreendimentos S.A.",
    ["Gem of Cobrahn"] = "Gema de Cobrahn",
    ["Gem of Anacondra"] = "Gema de Sucurina",
    ["Gem of Pythas"] = "Gema de Pítias",
    ["Gem of Serpentis"] = "Gema de Serpentis",
    ["Maur Grimtotem"] = "Mauren Temível Totem",
    -- Objetivos e itens exibidos separadamente pelo tracker de Durotar.
    ["Durotar Tiger Fur"] = "Pele de Tigre de Durotar",
    ["Durotar Tiger Furs"] = "Peles de Tigre de Durotar",
    ["Durator Tiger Fur"] = "Pele de Tigre de Durotar",
    ["Intact Makrura Eye"] = "Olho de Makrura Intacto",
    ["Intact Makrura Eyes"] = "Olhos de Makrura Intactos",
    ["Crawler Mucus"] = "Muco de Rastejante",
    ["Attack Plan: Valley of Trials"] = "Plano de Ataque: Vale das Provações",
    ["Attack Plan: Sen'jin Village"] = "Plano de Ataque: Aldeia Sen'jin",
    ["Attack Plan: Orgrimmar"] = "Plano de Ataque: Orgrimmar",
    ["Zalazane's Head"] = "Cabeça de Zalazane",
    ["Minshina's Skull"] = "Crânio de Minshina",
    ["Search the centaur camp for clues to the flower's properties"] =
        "Procure no acampamento dos centauros pistas sobre as propriedades da flor",
    ["Search the centaur camp for clues to the flower's properties."] =
        "Procure no acampamento dos centauros pistas sobre as propriedades da flor.",
    ["Search the centaur camp for clues to the flower’s properties"] =
        "Procure no acampamento dos centauros pistas sobre as propriedades da flor",
    ["Search the centaur camp for clues to the flower’s properties."] =
        "Procure no acampamento dos centauros pistas sobre as propriedades da flor.",
    ["Visit an Innkeeper and select \"Make this inn your home.\""] =
        "Visite um Estalajadeiro e selecione \"Faça desta estalagem o seu lar\".",
    ["Visit an Innkeeper and select 'Make this inn your home.'"] =
        "Visite um Estalajadeiro e selecione 'Faça desta estalagem o seu lar'.",
    ["Visit an Innkeeper and select Make this inn your home."] =
        "Visite um Estalajadeiro e selecione 'Faça desta estalagem o seu lar'.",
    ["Make this inn your home"] = "Faça desta estalagem o seu lar",
    -- Vale das Provações, Aldeia Sen'jin e Monte Navalha.
    ["Mottled Boar"] = "Javali Mosqueado",
    ["Mottled Boars"] = "Javalis Mosqueados",
    ["Scorpid Worker Tail"] = "Cauda de Escorpídeo Operário",
    ["Scorpid Worker Tails"] = "Caudas de Escorpídeo Operário",
    ["Canvas Scrap"] = "Retalho de Lona",
    ["Canvas Scraps"] = "Retalhos de Lona",
    ["Vile Familiar"] = "Familiar Torpe",
    ["Vile Familiars"] = "Familiares Torpes",
    ["Burning Blade Medallion"] = "Medalhão da Lâmina Ardente",
    ["Sarkoth's Mangled Claw"] = "Garra Dilacerada de Sarkoth",
    ["Fizzle's Claw"] = "Garra de Bulho",
    ["Kron's Amulet"] = "Amuleto de Kron",
    ["Eye of Burning Shadow"] = "Olho da Sombra Ardente",
    ["Admiral Proudmoore's Orders"] = "Ordens do Almirante Proudmore",
    ["Example Collar"] = "Colar de Amostra",
    ["Venomtail Antidote"] = "Antídoto para Caudaçonha",
    ["Ukor's Burden"] = "Fardo de Ulkor",
    ["Cactus Apple"] = "Maçã do Cacto",
    ["Cactus Apples"] = "Maçãs do Cacto",
    ["Taillasher Egg"] = "Ovo de Açoitacauda",
    ["Taillasher Eggs"] = "Ovos de Açoitacauda",
    ["Searing Collar"] = "Colar Calcinante",
    ["Searing Collars"] = "Colares Calcinantes",
    ["Venomtail Poison Sac"] = "Vesícula de Veneno de Caudaçonha",
    ["Venomtail Poison Sacs"] = "Vesículas de Veneno de Caudaçonha",
    ["Kul Tiras Sailor"] = "Marinheiro de Kul Tiraz",
    ["Kul Tiras Sailors"] = "Marinheiros de Kul Tiraz",
    ["Kul Tiras Marine"] = "Fuzileiro de Kul Tiraz",
    ["Kul Tiras Marines"] = "Fuzileiros de Kul Tiraz",
    ["Lieutenant Benedict"] = "Tenente Bento",
    ["Hexed Troll"] = "Troll Enfeitiçado",
    ["Hexed Trolls"] = "Trolls Enfeitiçados",
    ["Voodoo Troll"] = "Troll Vodu",
    ["Voodoo Trolls"] = "Trolls Vodu",
    ["Burning Blade Cultist"] = "Sectário da Lâmina Ardente",
    ["Burning Blade Cultists"] = "Sectários da Lâmina Ardente",
    ["Burning Blade Thug"] = "Bandido da Lâmina Ardente",
    ["Burning Blade Thugs"] = "Bandidos da Lâmina Ardente",
    ["Bloodtalon Taillasher"] = "Açoitacauda Garrasangre",
    ["Bloodtalon Taillashers"] = "Açoitacaudas Garrasangre",
    ["Sack of Supplies"] = "Saco de Suprimentos",
    ["Sacks of Supplies"] = "Sacos de Suprimentos",
    ["Dustwind Savage"] = "Selvagem Sopravento",
    ["Dustwind Savages"] = "Selvagens Sopravento",
    ["Dustwind Storm Witch"] = "Bruxa da Tempestade Sopravento",
    ["Dustwind Storm Witches"] = "Bruxas da Tempestade Sopravento",
    ["Razormane Quilboar"] = "Javatusco Crinavalha",
    ["Razormane Quilboars"] = "Javatuscos Crinavalha",
    ["Razormane Scout"] = "Batedor Crinavalha",
    ["Razormane Scouts"] = "Batedores Crinavalha",
    ["Razormane Dustrunner"] = "Levanta-poeira Crinavalha",
    ["Razormane Dustrunners"] = "Levanta-poeira Crinavalha",
    ["Razormane Battleguard"] = "Guarda de Batalha Crinavalha",
    ["Razormane Battleguards"] = "Guardas de Batalha Crinavalha",
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

local defaults = { spells = true, items = true, units = true, worldNpcNames = true, patterns = true, flavor = true,
                   ui = true, achievements = true, quests = true, gossip = true, chat = true, errores = true,
                   voice = true, updateCheck = true, unitFrameNumbers = true,
                   dragonUICompat = true, detailsCompat = true, lootOverlay = true, dynamicUI = true,
                   raidTranslation = true, durabilityWidget = true, durabilityHudLocked = true,
                   durabilityHudShowWorst = true, durabilityHudScale = 100, durabilityHudOpacity = 92,
                   authorMessage = true }


-- GlobalStrings com placeholders fazem parte da API interna do FrameXML. O Ascension
-- altera algumas assinaturas em relação ao WotLK 3.3.5 original (por exemplo, o C
-- passa uma string já formatada como segundo argumento de CR_HIT_MELEE_TOOLTIP).
-- Trocar um formato %s por %.2f -- ou remover argumentos -- quebra string.format dentro
-- do próprio cliente. Antes de substituir qualquer global formatado, validamos o contrato
-- de argumentos do texto que o cliente realmente carregou.
AES.FormatArgumentContract = function(text)
    if type(text) ~= "string" then return nil end
    local args, implicit, i, maxIndex = {}, 1, 1, 0
    while i <= #text do
        local p = text:find("%", i, true)
        if not p then break end
        if text:sub(p + 1, p + 1) == "%" then
            i = p + 2
        else
            local j = p + 1
            local positional

            -- %2$s / %3$02d
            local digitStart = j
            while text:sub(j, j):match("%d") do j = j + 1 end
            if j > digitStart and text:sub(j, j) == "$" then
                positional = tonumber(text:sub(digitStart, j - 1))
                j = j + 1
            else
                j = p + 1
            end

            while text:sub(j, j):find("[-+ #0]", 1) do j = j + 1 end
            if text:sub(j, j) == "*" then return nil, "dynamic-width" end
            while text:sub(j, j):match("%d") do j = j + 1 end
            if text:sub(j, j) == "." then
                j = j + 1
                if text:sub(j, j) == "*" then return nil, "dynamic-precision" end
                while text:sub(j, j):match("%d") do j = j + 1 end
            end
            local length = text:sub(j, j)
            if length == "h" or length == "l" or length == "L" then j = j + 1 end

            local conversion = text:sub(j, j)
            if not conversion:find("[cdiouxXeEfgGqs]", 1) then
                -- Percentual literal em texto normal; não faz parte do contrato de format().
                i = p + 1
            else
                local index = positional or implicit
                if not positional then implicit = implicit + 1 end
                if index > maxIndex then maxIndex = index end
                local kind = (conversion == "s" or conversion == "q") and "s" or "n"
                if args[index] and args[index] ~= kind then return nil, "mixed-argument" end
                args[index] = kind
                i = j + 1
            end
        end
    end

    local out = {}
    for index = 1, maxIndex do out[index] = args[index] or "-" end
    return table.concat(out, ",")
end

AES.Perf.globalStringFormatSkips = AES.Perf.globalStringFormatSkips or 0
AES.Perf.globalStringFormatSkipKeys = AES.Perf.globalStringFormatSkipKeys or {}

AES.SafeSetGlobalString = function(key, value)
    if type(key) ~= "string" or type(value) ~= "string" then return false, "invalid" end
    local current = rawget(_G, key)
    if type(current) ~= "string" then return false, "missing" end
    if current == value then return true, "same" end

    local sourceContract, sourceErr = AES.FormatArgumentContract(current)
    local targetContract, targetErr = AES.FormatArgumentContract(value)
    if sourceContract == nil or targetContract == nil or sourceContract ~= targetContract then
        AES.Perf.globalStringFormatSkips = (AES.Perf.globalStringFormatSkips or 0) + 1
        local skipped = AES.Perf.globalStringFormatSkipKeys
        if skipped and skipped[key] == nil then
            local count = 0
            for _ in pairs(skipped) do count = count + 1 end
            if count < 64 then
                skipped[key] = (sourceContract or sourceErr or "?") .. " -> "
                    .. (targetContract or targetErr or "?")
            end
        end
        return false, "format-mismatch"
    end

    rawset(_G, key, value)
    return true, "applied"
end

-- Não preenche global inexistente. No Ascension isso evita atropelar objetos criados depois
-- pelo SharedXML (cores, mixins, templates etc.) com uma string de tradução.
AES.ApplySafeGlobalStrings = function()
    if not (db and db.ui) then return 0 end
    local applied = 0
    for key, value in pairs(AES.GlobalStrings or {}) do
        local ok = AES.SafeSetGlobalString and AES.SafeSetGlobalString(key, value)
        if ok then applied = applied + 1 end
    end
    return applied
end

-- Blizzard_Calendar só cria seus globals quando é aberto pela primeira vez.
-- Aplica esse subconjunto no ADDON_LOADED e também alimenta a tradução por
-- texto para rótulos que já tenham sido desenhados antes desse evento.
AES.ApplyCalendarGlobalStrings = function()
    if not (db and db.ui) then return 0 end
    local applied = 0
    local byEnglish = AES.UIStringsByEN
    for key, value in pairs(AES.CalendarGlobalStrings or {}) do
        local english = type(key) == "string" and rawget(_G, key) or nil
        if type(english) == "string" and english ~= "" and type(byEnglish) == "table" then
            local prior = byEnglish[english]
            if prior == nil or prior == value then byEnglish[english] = value end
        end
        local ok = AES.SafeSetGlobalString and AES.SafeSetGlobalString(key, value)
        if ok then applied = applied + 1 end
    end
    return applied
end

-- O SharedXML do Ascension espera objetos ColorMixin nesses dois globals. Addons antigos
-- de 3.3.5 às vezes trocam isso por tabelas { r, g, b, a }, quebrando KeywordTooltip:GetRGBA().
-- Converte só quando o objeto está inválido e reaproveita a cor atual sempre que der.
AES.RepairTooltipColors = function()
    local function hasRGBA(value)
        return type(value) == "table" and type(value.GetRGBA) == "function"
    end

    local function repair(name, dr, dg, dbv, da)
        local value = rawget(_G, name)
        if hasRGBA(value) then return false end

        local r, g, b, a = dr, dg, dbv, da
        if type(value) == "table" then
            r = tonumber(value.r or value[1]) or r
            g = tonumber(value.g or value[2]) or g
            b = tonumber(value.b or value[3]) or b
            a = tonumber(value.a or value[4]) or a
        end

        local create = rawget(_G, "CreateColor")
        if type(create) == "function" then
            local ok, color = pcall(create, r, g, b, a)
            if ok and hasRGBA(color) then
                rawset(_G, name, color)
                return true
            end
        end

        -- Algumas builds não exportam CreateColor. Este objeto simples já entrega o que o tooltip espera.
        rawset(_G, name, {
            r = r, g = g, b = b, a = a,
            GetRGB = function(self) return self.r, self.g, self.b end,
            GetRGBA = function(self) return self.r, self.g, self.b, self.a end,
        })
        return true
    end

    local fixed = 0
    if repair("TOOLTIP_DEFAULT_BACKGROUND_COLOR", 0.090, 0.090, 0.188, 1.000) then fixed = fixed + 1 end
    if repair("TOOLTIP_DEFAULT_COLOR", 1.000, 1.000, 1.000, 1.000) then fixed = fixed + 1 end
    return fixed
end

-- ID e link vão direto ao ponto. Texto solto fica num cache pequeno.
local itemTextCache, itemTextCacheCount = {}, 0
local itemTextMissCache, itemTextMissCount = {}, 0
local ITEM_TEXT_CACHE_LIMIT = 4096
local ITEM_TEXT_MISS_LIMIT = 1024
local ITEM_TEXT_MISS_TTL = 2.0

local function ItemLinkIDs(link)
    if type(link) ~= "string" then return nil, nil end
    local itemID = tonumber(link:match("item:(%-?%d+)"))
    local randomID = tonumber(link:match(
        "item:%-?%d+:%-?%d*:%-?%d*:%-?%d*:%-?%d*:%-?%d*:(%-?%d*)"))
    return itemID, randomID
end

local function RandomAffixPT(link)
    local _, randomID = ItemLinkIDs(link)
    if not randomID or randomID == 0 then return nil end
    if randomID < 0 then
        randomID = -randomID
        return (AES.RandomSuffixPTByID and AES.RandomSuffixPTByID[randomID])
            or (AES.RandomPropertyPTByID and AES.RandomPropertyPTByID[randomID])
    end
    return (AES.RandomPropertyPTByID and AES.RandomPropertyPTByID[randomID])
        or (AES.RandomSuffixPTByID and AES.RandomSuffixPTByID[randomID])
end
AES.RandomAffixPT = RandomAffixPT

local function CacheItemText(en, pt)
    if type(en) ~= "string" or en == "" or type(pt) ~= "string" or pt == "" or en == pt then
        return
    end
    if itemTextCacheCount >= ITEM_TEXT_CACHE_LIMIT then
        itemTextCache = {}
        itemTextCacheCount = 0
    end
    if itemTextCache[en] == nil then itemTextCacheCount = itemTextCacheCount + 1 end
    itemTextCache[en] = pt
    itemTextMissCache[en] = nil
end

local function RememberItemTextMiss(text, now)
    if not now then return end
    if itemTextMissCount >= ITEM_TEXT_MISS_LIMIT then
        itemTextMissCache = {}
        itemTextMissCount = 0
    end
    if itemTextMissCache[text] == nil then itemTextMissCount = itemTextMissCount + 1 end
    itemTextMissCache[text] = now
end

local function TranslateItemNameText(text, link, explicitID)
    if type(text) ~= "string" or text == "" then return nil end

    local textOnlyLookup = not link and explicitID == nil
    -- Cache por texto vale tambem para tooltips com link: itens custom resolvidos
    -- por padrao nao repetem regex ao passar o mouse de novo.
    local cached = itemTextCache[text]
    if cached then return cached end
    if textOnlyLookup then
        local now = GetTime and GetTime() or nil
    -- Item pode não estar no cache do cliente ainda. Segura a falha por 2s e tenta depois.
        local missedAt = itemTextMissCache[text]
        if now and missedAt and (now - missedAt) < ITEM_TEXT_MISS_TTL then return nil end
    end

    local linkID = link and select(1, ItemLinkIDs(link)) or nil
    local itemID = tonumber(explicitID) or linkID
    local ptBase = itemID and AES.ItemName and AES.ItemName[itemID]
    if ptBase then
        local enBase = AES.ItemNameEN and AES.ItemNameEN[itemID]
        -- A base histórica do Ascension contém milhares de nomes ainda em inglês.
        -- Se ItemName[id] for idêntico ao texto EN, NÃO tratamos isso como tradução:
        -- deixamos o fallback estrutural (Skill Card/Mystic Scroll/forged etc.) continuar.
        local isRealTranslation = (ptBase ~= text) and (not enBase or ptBase ~= enBase)
        if isRealTranslation and (not enBase or text == enBase or text == ptBase) then
            return ptBase
        end

        if isRealTranslation and enBase and text:sub(1, #enBase) == enBase then
            local suffix = text:sub(#enBase + 1):match("^%s+(.-)%s*$")
            if suffix and suffix ~= "" then
                local suffixPT = RandomAffixPT(link)
                    or (AES.SuffixWords and AES.SuffixWords[suffix])
                if suffixPT then
                    return ptBase .. " " .. suffixPT
                end
            end
        end
    end

    if AES.TranslateCustomItemName then
        -- IDs custom do Ascension podem ser reutilizados entre realms/temporadas.
        -- Se o nome EN esperado pelo snapshot local nao bater com o nome que o
        -- cliente esta mostrando agora, o texto atual vira a fonte da traducao.
        -- E uma comparacao O(1) por tooltip e evita aplicar nome antigo no item novo.
        local expectedEN = itemID and AES.ItemNameEN and AES.ItemNameEN[itemID]
        local sourceName = text
        if expectedEN and (text == expectedEN or text:sub(1, #expectedEN) == expectedEN) then
            sourceName = expectedEN
        end
        local okCustom, customPT = pcall(AES.TranslateCustomItemName, sourceName, itemID, text)
        if okCustom and type(customPT) == "string" and customPT ~= "" and customPT ~= sourceName then
            -- Cache por texto visivel: itens custom/padroes custam regex apenas no primeiro hover.
            CacheItemText(text, customPT)
            return customPT
        end
    end

    if not link and type(GetItemInfo) == "function" then
        local ok, resolvedName, resolvedLink = pcall(GetItemInfo, text)
        if ok and type(resolvedLink) == "string" then
            local resolvedID = select(1, ItemLinkIDs(resolvedLink))
            local translated = TranslateItemNameText(text, resolvedLink, resolvedID)
            if translated then
                CacheItemText(text, translated)
                return translated
            end
            if type(resolvedName) == "string" and resolvedName ~= text then
                translated = TranslateItemNameText(resolvedName, resolvedLink, resolvedID)
                if translated then
                    CacheItemText(text, translated)
                    return translated
                end
            end
        end
    end
    if textOnlyLookup then
        RememberItemTextMiss(text, GetTime and GetTime() or nil)
    end
    return nil
end
AES.TranslateItemNameText = TranslateItemNameText

local function TranslateValue(v)
    local w = AES.ValueWords
    if w[v] then return w[v] end
    if AES.SpellNameEN2ES[v] then return AES.SpellNameEN2ES[v] end
    local num, word = v:match("^([%d%.,]+) (.+)$")
    if num and w[word] then return num .. " " .. w[word] end
    return v
end

-- Há textos antigos com pedaços ruins. Corrigimos na hora de mostrar, sem reprocessar a base inteira.
local translatedTextFixes = {
    {"quex", "que ex"},
    {"Felanfa", "Lâmina Vil"},
    {"Barragén", "Barragem"},
    {"Bucle", "Ciclo"},
    {"Pirofrío", "Fogofrio"},
    {"Pirofrio", "Fogofrio"},
    {"Geadapiercer", "Perfura-gelo"},
    {"entramte", "recebido"},
    {"destalhar", "explodir"},
    {"resetear", "reiniciar"},
    {"Eruptores de Lava", "Estouros de Lava"},
    {"Eruptar Lava", "Estouro de Lava"},
    {"Baforada Arcana", "Barragem Arcana"},
    {"Tromba Arcana", "Barragem Arcana"},
    {"Bateria Arcana", "Barragem Arcana"},
    {"Bola de Fogo Lunar", "Fogo Lunar"},
    {"Lentear", "Lentidão"},
    {"Inverno Gelado", "Calafrio do Inverno"},
    {"Calafrio invernal", "Calafrio do Inverno"},
    {"Núcleo de magma", "Núcleo Fundido"},
    {"núcleo de magma", "Núcleo Fundido"},
    {"núcleo em chamas", "Núcleo Fundido"},
    {"Fogo da Alma", "Fogo d'Alma"},
    {"Raio de Sombras", "Seta Sombria"},
    {"Descarga de Fogofrio", "Seta de Fogofrio"},
    {"Tromba de mísseis", "Barragem de Mísseis"},
    {"Estrelhaplomo", "Fogo Estelar"},
    {"Estrelhabrisa", "Surto Estelar"},
    {"Tuerra Viva", "Bomba Viva"},
    {"Raio Caótico", "Seta do Caos"},
    {"Bola de Fogo Sombria", "Chama Sombria"},
    {"Quemaescorpión", "Queimadura Sombria"},
    {"jugadoresy", "jogadores e"},
    {"jugadores", "jogadores"},
    {"causande", "causando"},
    {"consuminem", "consumindo"},

    -- Restos de palavras coladas pela conversao antiga.
    {"chance dem ", "chance de "},
    {"instantaneamentem", "instantaneamente"},
    {"adicionalmentem", "adicionalmente"},
    {"criticamentem", "criticamente"},
    {"somentem", "somente"},
    {"novamentem", "novamente"},
    {"rapidamentem", "rapidamente"},
    {"selvagementem", "selvagemente"},
    {"lentamentem", "lentamente"},
    {"automaticamentem", "automaticamente"},
    {"parcialmentem", "parcialmente"},
    {"mentalmentem", "mentalmente"},
    {"posteriormentem", "posteriormente"},
    {"aleatoriamentem", "aleatoriamente"},
    {"Internamentem", "Internamente"},
    {"temporariamentem", "temporariamente"},
    {"diretamentem", "diretamente"},
    {"suavementem", "suavemente"},
    {"Atualmentem", "Atualmente"},
    {"restantem ", "restante em "},
    {"Agilidadem ", "Agilidade em "},
    {"chancem ", "chance em "},
    {"velocidadem ", "velocidade em "},
    {"Tranquilidadem ", "Tranquilidade em "},
    {"Furtividadem ", "Furtividade em "},
    {"Instabilidadem ", "Instabilidade em "},
    {"Invisibilidadem ", "Invisibilidade em "},
    {"Tempestadem ", "Tempestade em "},
    {"Liberdadem ", "Liberdade em "},
    {"Célerem ", "Célere em "},
    {"mortem ", "morte em "},
    {"sanguem ", "sangue em "},
    {"Sanguem ", "Sangue em "},
    {"Riptidem ", "Riptide em "},
    {"Manglem ", "Mangle em "},
    {"Glaivem ", "Glaive em "},
    {"Starfirem ", "Starfire em "},
    {"Contracorrentem ", "Contracorrente em "},
    {"recebestem ", "recebe em "},
    {"absorvenem ", "absorvendo "},
    {"destruinem ", "destruindo "},
    {"roubanem ", "roubando "},
    {"sofrenem ", "sofrendo "},
    {"redirecionanem ", "redirecionando "},
    {"compartilhanem ", "compartilhando "},
    {"regeneramem ", "regenerando "},
    {"curamem ", "curando "},
    {"recuperamem ", "recuperando "},
    {"concedenem ", "concedendo "},
    {"Geranem ", "Gera "},
    {"Regeneranem ", "Regenera "},
    {"Recebenem ", "Recebe "},
    {"Choquem ", "Choque em "},
    {"Aceleração Ardentem ", "Aceleração Ardente em "},
    {"dentro delem ", "dentro dele em "},
    {" m delem ", " m dele em "},
    {"Mestre delementos", "Mestre dos Elementos"},
    {"tipo delemental", "tipo de elemental"},
    {"Totem delemento terrestrem ", "Totem do Elemental da Terra em "},
    {"polaridadees", "polaridades"},
    {"entre sim", "entre si"},
    {"dois os ", "dos "},
    {"dá luta", "da luta"},
    {"Mana queimado", "Mana queimada"},
    {"Energia queimadura", "Energia queimada"},
    {"Fúria queimadura", "Fúria queimada"},
    {"Bônus Capstone", "Bônus de Ápice"},
    {"Onda de Choquempurra", "Onda de Choque empurra"},
    {"Golpe Tempestademais", "Golpe da Tempestade mais"},
    {" delementos", " de elementos"},
    {"Escudo terrestrem ", "Escudo de Terra em "},
    {"Sismo terrestrem ", "Terremoto em "},
    {"Choque terrestrem ", "Choque Terreno em "},
    {"runa terrestrem ", "runa terrestre em "},
    {"Totem de Vínculo Terrestrem ", "Totem de Vínculo Terrestre em "},
    {"terrestrem ", "terrestre em "},
    {"Terrestrem ", "Terrestre em "},
    {"Incessantem ", "Incessante em "},
    {"atacantem ", "atacante em "},
    {"Garrotem ", "Garrote em "},
    {"Pestem ", "Peste em "},
    {"Ajudantem ", "Ajudante em "},
    {"Congelantem ", "Congelante em "},
    {"tempestadem ", "tempestade em "},
    {"enxamem ", "enxame em "},
    {"Sacerdotem ", "Sacerdote em "},
    {"Horripilantem ", "Horripilante em "},
    {"serpentem ", "serpente em "},
    {"Serpentem ", "Serpente em "},
    {"Starsurgem ", "Starsurge em "},
    {"Calcinantem ", "Calcinante em "},
    {"Gigantem ", "Gigante em "},
    {"Ardentem ", "Ardente em "},
    {"Destrozantem ", "Destroçante em "},
    {"Expertisem ", "Expertise em "},
    {"Ravagem ", "Ravage em "},
    {"Sanguecruentem ", "Sanguecruente em "},
    {"Mortal Strikem ", "Golpe Mortal em "},
    {"Shield Strikem ", "Ataque Escudo em "},
    {"Metamorfosem ", "Metamorfose em "},
    {"Ciclonem ", "Ciclone em "},
    {"Mordida do mongoosem ", "Mordida de Mangusto em "},
    {"Mongoosem ", "Mangusto em "},
    {"mongoosem ", "mangusto em "},
    {"Necromantem ", "Necromante em "},
    {"Baluartem ", "Baluarte em "},
    {"Sombranochem ", "Ocaso em "},
    {"Vórticem ", "Vórtice em "},
    {"Virtudem ", "Virtude em "},
    {"Filbladem ", "Lâmina Vil em "},
    {"Aniquilantem ", "Aniquilante em "},
    {"absorventem ", "absorvente em "},
    {"flameantem ", "flamejante em "},
    {"Tigrem ", "Tigre em "},
    {"Hibernatem ", "Hibernate em "},
    {"Hélicem ", "Hélice em "},
    {"Innervatem ", "Innervate em "},
    {"Eclipsem ", "Eclipse em "},
    {"Bloqueantem ", "Bloqueante em "},
    {"Deterrencem ", "Deterrence em "},
    {"Electrocutem ", "Electrocute em "},
    {"Recuperatem ", "Recuperate em "},
    {"Recuperatestá", "Recuperate está"},
    {"Mestrem ", "Mestre em "},
    {"debilidadem ", "debilidade em "},
    {"Sangrolustrem ", "Sede de Sangue em "},
    {"Gougem ", "Gouge em "},
    {"Mascotem ", "Mascote em "},
    {"Fomem ", "Fome em "},
    {"Fulminantem ", "Fulminante em "},
    {"Instablem ", "Instável em "},
    {"quantidadem ", "quantidade em "},
    {"Escarlatem ", "Escarlate em "},
    {"Cauterizantem ", "Cauterizante em "},
    {"Soulfirem ", "Soulfire em "},
    {"Penitentem ", "Penitente em "},
    {"fatalidadem ", "fatalidade em "},
    {"Relampejantem ", "Relampejante em "},
    {"Hipnosem ", "Hipnose em "},
    {"Hurricanem ", "Hurricane em "},
    {"Ventocortantem ", "Ventocortante em "},
    {"Rakem ", "Rake em "},
    {"Rupturem ", "Rupture em "},
    {"áspidem ", "áspide em "},
    {"Rimem ", "Rime em "},
    {"Purgem ", "Purge em "},
    {"Vontadem ", "Vontade em "},
    {"Penetrantem ", "Penetrante em "},
    {"Kilhing Spreem ", "Assassinato Múltiplo em "},
    {"Flamejantem ", "Flamejante em "},
    {"Piedadem ", "Piedade em "},
    {"Netherstrikem ", "Netherstrike em "},
    {"Chancem ", "Chance em "},
    {"Vigilancem ", "Vigilância em "},
    {"Cronomantem ", "Cronomante em "},
    {"Consumes 1 Ember", "Consome 1 Brasa"},
    {"dano de SombraSombra", "dano de Gelo Sombrio"},
    {"cada ataquexcluirá", "cada ataque removerá"},

    -- Estes precisam de contexto; uma troca generica de "sanem" pioraria outra frase.
    {"fazendo com que você sanem ", "fazendo com que você se cure em "},
    {"causando você que você sanem ", "fazendo com que você se cure em "},
    {"e a outros membros do grupo se lhes sanem ", "e curando outros membros do grupo em "},
}

-- Nomes de habilidades encontrados literalmente em ingles dentro de descricoes
-- ja traduzidas. A troca usa limite de palavra para nao quebrar nomes maiores.
local translatedNameFixes = {
    {"Demon Hunter", "Caçador de Demônios"},
    {"Rocket Boots", "Botas Foguete"},
    {"Temporal Blast", "Explosão Temporal"},
    {"Shattering Slam", "Golpe Desintegrador"},
    {"Frostfire Bolt", "Seta de Fogofrio"},
    {"Arcane Missiles", "Mísseis Arcanos"},
    {"Arcane Barrage", "Barragem Arcana"},
    {"Arcane Blast", "Impacto Arcano"},
    {"Shadow Bolt", "Seta Sombria"},
    {"Chaos Bolt", "Seta do Caos"},
    {"Flame Shock", "Choque Flamejante"},
    {"Frost Shock", "Choque Congelante"},
    {"Earth Shock", "Choque Terreno"},
    {"Cone of Cold", "Cone de Frio"},
    {"Deep Freeze", "Congelamento Profundo"},
    {"Frozen Orb", "Orbe Congelado"},
    {"Ice Lance", "Lança de Gelo"},
    {"Soul Fire", "Fogo d'Alma"},
    {"Bloodthirst", "Sede de Sangue"},
    {"Bloodsurge", "Onda de Sangue"},
    {"Flash de Luz", "Clarão de Luz"},
    {"Cat Form", "Forma de Felino"},
    {"Frostbolt", "Seta de Gelo"},
    {"Fireball", "Bola de Fogo"},
    {"Pyroblast", "Piroexplosão"},
    {"Starsurge", "Surto Estelar"},
    {"Moonfire", "Fogo Lunar"},
    {"Froststrike", "Golpe Gélido"},
    {"Mangle", "Destroçar"},
    {"Glaive", "Guja"},
    {"Haunt", "Assombrar"},
    {"Ignite", "Ignição"},
    {"Ravage", "Devastar"},
    {"Sprint", "Disparada"},
    {"Shaman", "Xamã"},
    {"Ghoul", "Carniçal"},
    {"Ambush", "Emboscar"},
    {"Renew", "Renovar"},
    {"Pummel", "Murro"},
    {"Undead", "Morto-vivo"},
    {"Smite", "Punição"},
    {"Shred", "Retalhar"},
    {"Felguard", "Guarda Vil"},
    {"Scorch", "Chamuscado"},
    {"Wraith", "Espectro"},
    {"Rogue", "Ladino"},
    {"Gouge", "Desorientar"},
    {"Druid", "Druida"},
    {"Hunter", "Caçador"},
    {"Shock", "Choque"},
    {"Riptide", "Contracorrente"},
    {"Starfire", "Fogo Estelar"},
    {"Blink", "Lampejo"},
    {"Overload", "Sobrecarga"},
    {"Capstone", "Ápice"},
    {"Stacks", "Acúmulos"},
    {"Static", "Estática"},
    {"Ember", "Brasa"},
    {"Spirit", "Espírito"},
    {"Expertise", "Perícia"},
    {"Deterrence", "Dissuasão"},
    {"Hurricane", "Furacão"},
    {"Rake", "Ancinho"},
    {"Rupture", "Ruptura"},
    {"Purge", "Expurgar"},
    {"Innervate", "Avivar"},
    {"Hibernate", "Hibernar"},
    {"Electrocute", "Eletrocussão"},
    {"Recuperate", "Recuperar"},
    {"Netherstrike", "Golpe Etéreo"},
    {"Soulfire", "Fogo d'Alma"},
    {"Incinerate", "Incinerar"},
    {"Thrust", "Estocada"},
    {"Killing Spree", "Assassinato Múltiplo"},
}

local function ReplacePlain(text, from, to)
    local a, b = text:find(from, 1, true)
    if not a then return text end

    local out, pos = {}, 1
    repeat
        out[#out + 1] = text:sub(pos, a - 1)
        out[#out + 1] = to
        pos = b + 1
        a, b = text:find(from, pos, true)
    until not a
    out[#out + 1] = text:sub(pos)
    return table.concat(out)
end

local function IsAsciiWordByte(ch)
    if ch == nil or ch == "" then return false end
    local b = ch:byte()
    return (b >= 48 and b <= 57)
        or (b >= 65 and b <= 90)
        or (b >= 97 and b <= 122)
        or b == 95
end

local function ReplaceBoundedPlain(text, from, to)
    local out, pos, search, changed = {}, 1, 1, false
    local firstWord = IsAsciiWordByte(from:sub(1, 1))
    local lastWord = IsAsciiWordByte(from:sub(-1))

    while true do
        local a, b = text:find(from, search, true)
        if not a then break end

        local leftOK = not firstWord or a == 1 or not IsAsciiWordByte(text:sub(a - 1, a - 1))
        local rightOK = not lastWord or b == #text or not IsAsciiWordByte(text:sub(b + 1, b + 1))
        if leftOK and rightOK then
            out[#out + 1] = text:sub(pos, a - 1)
            out[#out + 1] = to
            pos = b + 1
            search = b + 1
            changed = true
        else
            search = a + 1
        end
    end

    if not changed then return text end
    out[#out + 1] = text:sub(pos)
    return table.concat(out)
end

local function PolishTranslatedText(text)
    for i = 1, #translatedTextFixes do
        local fix = translatedTextFixes[i]
        if text:find(fix[1], 1, true) then
            text = ReplacePlain(text, fix[1], fix[2])
        end
    end
    for i = 1, #translatedNameFixes do
        local fix = translatedNameFixes[i]
        if text:find(fix[1], 1, true) then
            text = ReplaceBoundedPlain(text, fix[1], fix[2])
        end
    end
    return text
end

local function ApplyTemplate(output, caps)
    local rendered = output:gsub("{{(%d+)}}", function(n)
        local c = caps[tonumber(n)]
        if c == nil then return "" end
        return TranslateValue(c)
    end)
    return rendered
end

local subPatternCache = {}

-- Estes helpers ficam na tabela da addon para não estourar o limite de locals do Lua 5.1.
AES._TooltipMatch = AES._TooltipMatch or {
    normalizedPatternCache = {},
    colorlessPatternCache = {},
}
AES._TooltipMatch.normalizedPatternCacheCount = AES._TooltipMatch.normalizedPatternCacheCount or 0
AES._TooltipMatch.colorlessPatternCacheCount = AES._TooltipMatch.colorlessPatternCacheCount or 0
AES._TooltipMatch.PATTERN_CACHE_LIMIT = AES._TooltipMatch.PATTERN_CACHE_LIMIT or 4096
AES._TooltipMatch.subPatternCacheCount = AES._TooltipMatch.subPatternCacheCount or 0

function AES._TooltipMatch.NormalizeTooltipEscapes(text)
    if type(text) ~= "string" then return text end
    if not text:find("|", 1, true) and not text:find("\r", 1, true) then return text end
    text = text:gsub("\r", ""):gsub("|R", "|r"):gsub("|[nN]", "\n")
    return (text:gsub("|[cC](%x%x%x%x%x%x%x%x)", function(hex)
        return "|c" .. hex:lower()
    end))
end

function AES._TooltipMatch.NormalizedPairPattern(pattern)
    local cache = AES._TooltipMatch.normalizedPatternCache
    local cached = cache[pattern]
    if cached then return cached end
    cached = AES._TooltipMatch.NormalizeTooltipEscapes(pattern)
    if AES._TooltipMatch.normalizedPatternCacheCount >= AES._TooltipMatch.PATTERN_CACHE_LIMIT then
        cache = {}
        AES._TooltipMatch.normalizedPatternCache = cache
        AES._TooltipMatch.normalizedPatternCacheCount = 0
    end
    cache[pattern] = cached
    AES._TooltipMatch.normalizedPatternCacheCount = AES._TooltipMatch.normalizedPatternCacheCount + 1
    return cached
end

function AES._TooltipMatch.StripTooltipColors(text)
    if type(text) ~= "string" then return text end
    return (text:gsub("|[cC]%x%x%x%x%x%x%x%x", ""):gsub("|[rR]", ""))
end

function AES._TooltipMatch.ColorlessPairPattern(pattern)
    local cache = AES._TooltipMatch.colorlessPatternCache
    local cached = cache[pattern]
    if cached then return cached end
    cached = AES._TooltipMatch.StripTooltipColors(pattern)
    if AES._TooltipMatch.colorlessPatternCacheCount >= AES._TooltipMatch.PATTERN_CACHE_LIMIT then
        cache = {}
        AES._TooltipMatch.colorlessPatternCache = cache
        AES._TooltipMatch.colorlessPatternCacheCount = 0
    end
    cache[pattern] = cached
    AES._TooltipMatch.colorlessPatternCacheCount = AES._TooltipMatch.colorlessPatternCacheCount + 1
    return cached
end

function AES._TooltipMatch.PreparePairText(text)
    local normalizedText = AES._TooltipMatch.NormalizeTooltipEscapes(text)
    local colorlessText
    if normalizedText:find("|c", 1, true) then
        colorlessText = AES._TooltipMatch.StripTooltipColors(normalizedText)
    end
    return normalizedText, colorlessText
end

local function SegmentPattern(anchored)
    local sub = subPatternCache[anchored]
    if sub == nil then
        sub = anchored
        if sub:sub(1, 1) == "^" then sub = sub:sub(2) end
        if sub:sub(-4) == "%s*$" then sub = sub:sub(1, -5) end
        if AES._TooltipMatch.subPatternCacheCount >= AES._TooltipMatch.PATTERN_CACHE_LIMIT then
            subPatternCache = {}
            AES._TooltipMatch.subPatternCacheCount = 0
        end
        subPatternCache[anchored] = sub
        AES._TooltipMatch.subPatternCacheCount = AES._TooltipMatch.subPatternCacheCount + 1
    end
    return sub
end

local function MatchPair(text, pair, normalizedText, colorlessText)
    local work = text
    local pattern = pair[1]
    local caps = { work:match(pattern) }

    if caps[1] == nil then
        local normalizedWork = normalizedText or AES._TooltipMatch.NormalizeTooltipEscapes(work)
        local normalizedPattern = AES._TooltipMatch.NormalizedPairPattern(pattern)
        if normalizedWork ~= work or normalizedPattern ~= pattern then
            work = normalizedWork
            pattern = normalizedPattern
            caps = { work:match(pattern) }
        end
    end

    if caps[1] == nil and (work:find("|c", 1, true) or pattern:find("|c", 1, true)) then
        local colorlessWork = colorlessText or AES._TooltipMatch.StripTooltipColors(work)
        local colorlessPattern = AES._TooltipMatch.ColorlessPairPattern(pattern)
        if colorlessWork ~= work or colorlessPattern ~= pattern then
            work = colorlessWork
            pattern = colorlessPattern
            caps = { work:match(pattern) }
        end
    end

    if caps[1] ~= nil then
        return ApplyTemplate(pair[2], caps)
    end

    local sub = SegmentPattern(pattern)
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

local function TryPair(fs, text, pair, normalizedText, colorlessText)
    local nt = MatchPair(text, pair, normalizedText, colorlessText)
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
            return tonumber(hex:sub(5, 8), 16)
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
    local normalizedText, colorlessText = AES._TooltipMatch.PreparePairText(text)
    if type(pairIndexes) == "number" then
        local pair = pairsTable[pairIndexes]
        return pair and TryPair(fs, text, pair, normalizedText, colorlessText) or false
    end
    for _, idx in ipairs(pairIndexes) do
        local pair = pairsTable[idx]
        if pair and TryPair(fs, text, pair, normalizedText, colorlessText) then return true end
    end
    return false
end

local function MatchPairSet(text, pairIndexes, pairsTable)
    if not pairIndexes then return nil end
    local normalizedText, colorlessText = AES._TooltipMatch.PreparePairText(text)
    if type(pairIndexes) == "number" then
        local pair = pairsTable[pairIndexes]
        return pair and MatchPair(text, pair, normalizedText, colorlessText) or nil
    end
    for _, idx in ipairs(pairIndexes) do
        local pair = pairsTable[idx]
        local nt = pair and MatchPair(text, pair, normalizedText, colorlessText)
        if nt then return nt end
    end
    return nil
end

local function TranslateBodyByPairs(tip, pairIndexes, pairsTable)
    if not pairIndexes then return false end
    local name = tip:GetName()
    local changed = false
    for i = 2, tip:NumLines() do
        local fs = _G[name .. "TextLeft" .. i]
        local text = fs and fs:GetText()
        if text and #text > 3 and TryPairSet(fs, text, pairIndexes, pairsTable) then
            -- Um mesmo spell pode ter varias linhas indexadas. Nao paramos na
            -- primeira correspondencia; isso evitava traduzir apenas parte do tooltip.
            changed = true
        end
    end
    return changed
end

-- Monta os prefixos numa passada só. Esta parte já pesou bastante quando repetia trabalho.
local function PrefijosDe(texto)
    local s = texto:gsub("|[cC]%x%x%x%x%x%x%x%x", ""):gsub("|[rR]", ""):gsub("|[nN]", " ")
    local words, n = {}, 0
    for w in s:gmatch("%a+") do
        n = n + 1
        words[n] = w:lower()
        if n == 8 then break end
    end
    local out = {}
    for count = math.min(n, 8), 3, -1 do
        out[#out + 1] = table.concat(words, " ", 1, count)
    end
    return out
end

local function TranslateBodyByPrefix(tip)
    local name = tip:GetName()
    local hecho = false
    for i = 2, tip:NumLines() do
        local fs = _G[name .. "TextLeft" .. i]
        local text = fs and fs:GetText()
        if text and #text > 12 then

            local prefixes = PrefijosDe(text)
            for p = 1, #prefixes do
                local pref = prefixes[p]
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

-- Nome de habilidade exibido na UI. O Ascension/DragonUI pode envolver o nome
-- em cor/icone ou entregar uma variante do texto, enquanto o spellID continua
-- sendo a referencia estavel. Centralizar isso evita cada tela ter um matcher
-- diferente e nao adiciona varredura continua. O segundo retorno e a chave EN
-- canonica usada pelos indices de descricao/rank.
function AES.TranslateSpellNameText(text, spellID)
    if type(text) ~= "string" or text == "" then return nil end
    local map = AES.SpellNameEN2ES
    if type(map) ~= "table" then return nil end

    local direct = map[text]
    if type(direct) == "string" and direct ~= "" and direct ~= text then
        return direct, text
    end

    local lead, body, trail = text:match("^(%s*)(.-)(%s*)$")
    lead, body, trail = lead or "", body or text, trail or ""

    local icon = ""
    local iconPrefix, iconBody = body:match("^(|T.-|t%s*)(.+)$")
    if iconBody then icon, body = iconPrefix or "", iconBody end

    local colorOpen, inner, colorClose = body:match("^(|[cC]%x%x%x%x%x%x%x%x)(.-)(|[rR])$")
    local key = inner or body
    local translated = map[key]
    local canonical = key

    if not translated then
        local base, rank = key:match("^(.-)%s+%((Rank%s+%d+)%)$")
        if base and map[base] then
            canonical = base
            local rankPT = (AES.RankEN2ES and AES.RankEN2ES[rank]) or rank:gsub("^Rank", "Grau")
            translated = map[base] .. " (" .. rankPT .. ")"
        end
    end

    if not translated and spellID and GetSpellInfo then
        local ok, spellName = pcall(GetSpellInfo, tonumber(spellID) or spellID)
        if ok and type(spellName) == "string" and spellName ~= "" then
            canonical = spellName
            translated = map[spellName]
        end
    end

    if type(translated) ~= "string" or translated == "" then return nil, canonical end
    local rendered = lead .. icon .. (colorOpen or "") .. translated .. (colorClose or "") .. trail
    if rendered == text then return nil, canonical end
    return rendered, canonical
end

local TranslateStaticText


local function MatchLinePatterns(text)
    local function apply(s)
        local exact = TranslateStaticText and TranslateStaticText(s)
        if exact then return exact end

    -- Se o Runtime ainda não subiu, usa o caminho simples e não deixa o tooltip morrer.
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

-- Variantes custom que o servidor escreve diretamente nos botoes do diario.
-- Mantidas separadas do indice principal para nao depender do questID retornado
-- pela versao custom da API.
local QUEST_TITLE_EXACT = {
    ["Area: Registration"] = "Arena: Inscrição",
    ["Arena: Registration"] = "Arena: Inscrição",
}

-- Os botoes do diario podem receber o texto antes de ADDON_LOADED terminar.
-- Prepara somente o indice titulo EN -> PT ja na carga do Core; o bootstrap
-- completo continua montando os demais indices normalmente mais abaixo.
local function EnsureQuestTitleTextIndex()
    if type(AES.QuestTitleEN2ES) == "table" and next(AES.QuestTitleEN2ES) then
        return AES.QuestTitleEN2ES
    end

    local index = {}
    for id, english in pairs(AES.QuestTitleEN or {}) do
        local translated = AES.QuestTitle and AES.QuestTitle[id]
        if type(english) == "string" and english ~= ""
            and type(translated) == "string" and translated ~= "" then
            local prior = index[english]
            if prior == nil then
                index[english] = translated
            elseif prior ~= translated then
                index[english] = false
            end
        end
    end
    AES.QuestTitleEN2ES = index
    return index
end
EnsureQuestTitleTextIndex()

-- NPC e tracker às vezes entregam só o título formatado, sem questID.
local function TranslateQuestTitleText(text, depth)
    if type(text) ~= "string" or text == "" then return nil end
    depth = depth or 0
    if depth > 5 then return nil end

    local titleIndex = EnsureQuestTitleTextIndex()
    local translated = QUEST_TITLE_EXACT[text] or titleIndex[text]
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

    body = text:match("^(.-)%s*%([Dd]ungeon%)%s*$")
    pt = body and TranslateQuestTitleText(body, depth + 1)
    if pt then return pt .. " (Masmorra)" end

    body = text:match("^(.-)%s*%([Rr]aid%)%s*$")
    pt = body and TranslateQuestTitleText(body, depth + 1)
    if pt then return pt .. " (Raide)" end

    body = text:match("^(.-)%s*%([Gg]roup%)%s*$")
    pt = body and TranslateQuestTitleText(body, depth + 1)
    if pt then return pt .. " (Grupo)" end

    local first, rest = text:match("^([^\n]+)(\n.+)$")
    pt = first and TranslateQuestTitleText(first, depth + 1)
    if pt then return pt .. rest end
    return nil
end
AES.TranslateQuestTitleText = TranslateQuestTitleText

do
    local questDynamicFallbackCache = {}
    local questDynamicFallbackCount = 0
    local QUEST_DYNAMIC_FALLBACK_PATTERNS = {
        { "^Speak with%s+(.+)$", "Fale com " },
        { "^Speak to%s+(.+)$", "Fale com " },
        { "^Talk to%s+(.+)$", "Fale com " },
        { "^Meet with%s+(.+)$", "Encontre-se com " },
        { "^Report to%s+(.+)$", "Apresente-se a " },
        { "^Scout through%s+(.+)$", "Explore " },
        { "^Scout%s+(.+)$", "Explore " },
        { "^Travel to%s+(.+)$", "Vá até " },
        { "^Go to%s+(.+)$", "Vá até " },
        { "^Return to%s+(.+)$", "Retorne a " },
        { "^Find%s+(.+)$", "Encontre " },
        { "^Kill%s+(.+)$", "Mate " },
        { "^Slay%s+(.+)$", "Mate " },
        { "^Defeat%s+(.+)$", "Derrote " },
        { "^Destroy%s+(.+)$", "Destrua " },
        { "^Collect%s+(.+)$", "Colete " },
        { "^Gather%s+(.+)$", "Colete " },
        { "^Obtain%s+(.+)$", "Obtenha " },
        { "^Recover%s+(.+)$", "Recupere " },
        { "^Retrieve%s+(.+)$", "Recupere " },
        { "^Bring%s+(.+)$", "Leve " },
        { "^Deliver%s+(.+)$", "Entregue " },
        { "^Use%s+(.+)$", "Use " },
        { "^Rescue%s+(.+)$", "Resgate " },
        { "^Free%s+(.+)$", "Liberte " },
        { "^Release%s+(.+)$", "Liberte " },
        { "^Escort%s+(.+)$", "Escolte " },
        { "^Discover%s+(.+)$", "Descubra " },
        { "^Explore%s+(.+)$", "Explore " },
        { "^Investigate%s+(.+)$", "Investigue " },
        { "^Reach%s+(.+)$", "Chegue a " },
        { "^Enter%s+(.+)$", "Entre em " },
        { "^Complete%s+(.+)$", "Conclua " },
        { "^Learn%s+(.+)$", "Aprenda " },
        { "^Capture%s+(.+)$", "Capture " },
    }

    local function QuestDynamicTargetPT(target)
        if type(target) ~= "string" or target == "" then return nil end
        local trimmed = target:gsub("^%s+", ""):gsub("%s+$", "")
        -- Objetivos dinâmicos costumam chegar como "10 Foo", enquanto os índices guardam apenas "Foo".
        -- Separamos a quantidade para reaproveitar os mapas de NPC/item/área sem criar milhares de aliases.
        local count, countedTarget = trimmed:match("^(%d+)%s+(.+)$")
        local lookupTarget = countedTarget or trimmed
        local noArticle = lookupTarget:match("^[Tt]he%s+(.+)$") or lookupTarget
        local function lookup(v)
            if not v or v == "" then return nil end
            return (AES.UnitNameEN2ES and AES.UnitNameEN2ES[v])
                or (AES.AreaNames and AES.AreaNames[v])
                or (AES.QuestTrackerNameEN2PT and AES.QuestTrackerNameEN2PT[v])
                or (AES.SpellNameEN2ES and AES.SpellNameEN2ES[v])
                or (AES.TranslateItemNameText and AES.TranslateItemNameText(v))
        end
        local pt = lookup(lookupTarget)
        if not pt and noArticle ~= lookupTarget then pt = lookup(noArticle) end
        if pt == false or not pt then return nil end
        if count then return count .. " " .. pt end
        return pt
    end

    local function TranslateQuestDynamicFallback(text)
        if type(text) ~= "string" or text == "" then return nil end
        local cached = questDynamicFallbackCache[text]
        if cached then return cached end

        local body, punctuation = text:match("^(.-)([%.%!%?]?)$")
        body = body or text
        punctuation = punctuation or ""

        for i = 1, #QUEST_DYNAMIC_FALLBACK_PATTERNS do
            local pair = QUEST_DYNAMIC_FALLBACK_PATTERNS[i]
            local target = body:match(pair[1])
            if target then
                local targetPT = QuestDynamicTargetPT(target)
                if targetPT then
                    local out = pair[2] .. targetPT .. punctuation
                    questDynamicFallbackCount = questDynamicFallbackCount + 1
                    if questDynamicFallbackCount > 2048 then
                        questDynamicFallbackCache = {}
                        questDynamicFallbackCount = 1
                    end
                    questDynamicFallbackCache[text] = out
                    return out
                end
                return nil
            end
        end
        return nil
    end
    AES.TranslateQuestDynamicFallback = TranslateQuestDynamicFallback

end

local function TranslateQuestTooltipText(text)
    if not (db and db.quests) or type(text) ~= "string" or text == "" then return nil end
    local function render(v)
        return AES.QuestRenderPT and AES.QuestRenderPT(v) or v
    end

    local direct = (AES.QuestUIExact and AES.QuestUIExact[text])
        or QUEST_TOOLTIP_STATIC[text]
        or (AES.QuestTrackerNameEN2PT and AES.QuestTrackerNameEN2PT[text])
        or (AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[text])
        or (AES.QuestObjectivePartEN2PT and AES.QuestObjectivePartEN2PT[text])
        or (AES.QuestRuntimeTextNormalized and AES.QuestRuntimeTextNormalized[text])
    if direct and direct ~= false then return render(direct) end

    if (AES.QuestObjectiveNormalizedEN2PT or AES.QuestRuntimeTextNormalized)
        and (text:find("\\n", 1, true) or text:find("|n", 1, true)
            or text:find("\n", 1, true) or text:find("  ", 1, true)) then
        local normalizedQuestText = text:gsub("\\n", "\n"):gsub("|n", "\n")
        normalizedQuestText = normalizedQuestText:gsub("%s+", " ")
            :gsub("^%s+", ""):gsub("%s+$", "")
        direct = (AES.QuestObjectiveNormalizedEN2PT
                and AES.QuestObjectiveNormalizedEN2PT[normalizedQuestText])
            or (AES.QuestRuntimeTextNormalized
                and AES.QuestRuntimeTextNormalized[normalizedQuestText])
        if direct and direct ~= false then return render(direct) end
    end

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

    local objectiveCount = text:match("^Objectives%s*%((%d+)%)$")
        or text:match("^Objetives%s*%((%d+)%)$")
    if objectiveCount then return "Objetivos (" .. objectiveCount .. ")" end

    local completeBody = text:match("^(.-)%s*%([Cc]omplete[d]?%)%s*$")
    if completeBody and completeBody ~= "" then
        local completePT = (AES.QuestUIExact and AES.QuestUIExact[completeBody])
            or (AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[completeBody])
            or (AES.QuestObjectivePartEN2PT and AES.QuestObjectivePartEN2PT[completeBody])
        if completePT and completePT ~= false then
            return render(completePT) .. " (Concluído)"
        end
    end

    local function trackedBodyPT(body)
        if type(body) ~= "string" or body == "" then return nil end
        local directPT = (AES.QuestUIExact and AES.QuestUIExact[body])
            or (AES.UnitNameEN2ES and AES.UnitNameEN2ES[body])
            or (AES.QuestTrackerNameEN2PT and AES.QuestTrackerNameEN2PT[body])
            or (AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[body])
            or (AES.QuestObjectivePartEN2PT and AES.QuestObjectivePartEN2PT[body])
            or (AES.TranslateItemNameText and AES.TranslateItemNameText(body))
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

        local itemBody = body:match("^(.-)%s+[Cc]ollected$")
        if not itemBody then itemBody = body:match("^(.-)%s+[Gg]athered$") end
        if not itemBody then itemBody = body:match("^(.-)%s+[Ff]ound$") end
        if not itemBody then itemBody = body:match("^(.-)%s+[Oo]btained$") end
        if not itemBody then itemBody = body:match("^(.-)%s+[Uu]sed$") end
        if itemBody then
            local itemPT = (AES.QuestTrackerNameEN2PT and AES.QuestTrackerNameEN2PT[itemBody])
                or (AES.TranslateItemNameText and AES.TranslateItemNameText(itemBody))
            if itemPT and itemPT ~= false then return render(itemPT) end
        end
        return nil
    end

    -- Tracker varia a ordem do contador dependendo da build. Mantém os três formatos.
    local progress, progressBody = text:match("^(%d+/%d+)%s+(.+)$")
    if progressBody and progressBody ~= "" then
        local progressPT = trackedBodyPT(progressBody)
        if progressPT then return progressPT .. ": " .. progress end
    end

    local counterBody, counter = text:match("^(.-):%s*(%d+/%d+)%s*$")
    if counterBody and counterBody ~= "" then
        local counterPT = trackedBodyPT(counterBody)
        if counterPT then return counterPT .. ": " .. counter end
    end

    local trailingBody, trailingCounter = text:match("^(.-)%s+(%d+/%d+)%s*$")
    if trailingBody and trailingBody ~= "" then
        local trailingPT = trackedBodyPT(trailingBody)
        if trailingPT then return trailingPT .. ": " .. trailingCounter end
    end

    local dynamicPT = AES.TranslateQuestDynamicFallback and AES.TranslateQuestDynamicFallback(text)
    if dynamicPT then return dynamicPT end

    local title = TranslateQuestTitleText(text)
    if title then return title end

    local prefix, body = text:match("^(%s*[-•]%s*)(.-)%s*$")
    if body and body ~= "" then
        local translated = (AES.QuestUIExact and AES.QuestUIExact[body])
            or (AES.QuestTrackerNameEN2PT and AES.QuestTrackerNameEN2PT[body])
            or (AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[body])
            or (AES.QuestObjectivePartEN2PT and AES.QuestObjectivePartEN2PT[body])
            or (AES.QuestTextEN2PT and AES.QuestTextEN2PT[body])
            or QUEST_TOOLTIP_STATIC[body]
        if translated and translated ~= false then return prefix .. render(translated) end
        local dynamicPT = AES.TranslateQuestDynamicFallback and AES.TranslateQuestDynamicFallback(body)
        if dynamicPT then return prefix .. dynamicPT end
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
                local esName, spellKey = plainName and AES.TranslateSpellNameText(plainName)
                if esCustom then
                    pcall(fs.SetText, fs, (icon or "") .. (pre or "") .. esCustom .. (post or ""))
                    changed = true
                elseif esName then
                    pcall(fs.SetText, fs, (icon or "") .. (pre or "") .. esName .. (post or ""))
                    contextIds = AES.NameToIDs[spellKey or plainName]
                    if contextIds then contexts[#contexts + 1] = contextIds end
                    changed = true
                elseif plainName and AES.NameToIDs[plainName] then
                    contextIds = AES.NameToIDs[plainName]
                    contexts[#contexts + 1] = contextIds
                end

                if not changed and db.ui then
                    local esUI = (AES.CustomUI and AES.CustomUI[text])
                        or (AES.UIStringsByEN and AES.UIStringsByEN[text])
                        or (AES.UIStrings and AES.UIStrings[text])
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

                if not changed and db.items then
                -- Transmog vem como texto solto e sem itemID. Resolve só quando precisar.
                    local transmogPrefix, transmogBody = text:match("^(Transmogrified to:%s*)(.+)$")
                    local transmogPrefixPT = "Transmogrificado para: "
                    if not transmogBody then
                        transmogPrefix, transmogBody = text:match("^(Transmogrificado para:%s*)(.+)$")
                    end
                    if transmogBody then
                        local icon, core = transmogBody:match("^(|T.-|t%s*)(.*)$")
                        icon, core = icon or "", core or transmogBody
                        local color, inner, reset = core:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
                        local itemPT = AES.TranslateItemNameText and AES.TranslateItemNameText(inner or core)
                        if itemPT and itemPT ~= false then
                            pcall(fs.SetText, fs, transmogPrefixPT .. icon
                                .. (color or "") .. itemPT .. (reset or ""))
                            text = transmogPrefixPT .. icon .. (color or "") .. itemPT .. (reset or "")
                            changed = true
                        end
                    end
                end

                if not changed then
                -- Item custom nem sempre expõe GetItemSpell; o corpo da linha é o plano B.
                    local effectPrefix, effectBody = text:match("^(Equip:%s+)(.+)$")
                    local effectPrefixPT = "Equipar: "
                    if not effectBody then
                        effectPrefix, effectBody = text:match("^(Equipar:%s+)(.+)$")
                    end
                    if not effectBody then
                        effectPrefix, effectBody = text:match("^(Equipado:%s+)(.+)$")
                    end
                    if not effectBody then
                        effectPrefix, effectBody = text:match("^(Use:%s+)(.+)$")
                        effectPrefixPT = "Usar: "
                    end
                    if not effectBody then
                        effectPrefix, effectBody = text:match("^(Uso:%s+)(.+)$")
                        effectPrefixPT = "Usar: "
                    end
                    if not effectBody then
                        effectPrefix, effectBody = text:match("^(Usar:%s+)(.+)$")
                        effectPrefixPT = "Usar: "
                    end
                    if not effectBody then
                        effectPrefix, effectBody = text:match("^(Set:%s+)(.+)$")
                        effectPrefixPT = "Conjunto: "
                    end
                    if not effectBody then
                        effectPrefix, effectBody = text:match("^(Conjunto:%s+)(.+)$")
                        effectPrefixPT = "Conjunto: "
                    end
                    if not effectBody then
                        effectPrefix, effectBody = text:match("^(Socket Bonus:%s+)(.+)$")
                        effectPrefixPT = "Bônus de engaste: "
                    end
                    if not effectBody then
                        effectPrefix, effectBody = text:match("^(Bônus de engaste:%s+)(.+)$")
                        effectPrefixPT = "Bônus de engaste: "
                    end
                    if not effectBody then
                        effectPrefix, effectBody = text:match("^(Chance on hit:%s+)(.+)$")
                        effectPrefixPT = "Chance ao acertar: "
                    end
                    if not effectBody then
                        effectPrefix, effectBody = text:match("^(Chance ao acertar:%s+)(.+)$")
                        effectPrefixPT = "Chance ao acertar: "
                    end
                    if effectBody then
                        -- Primeiro tenta o parser de atributos de item. Ele cobre os formatos
                        -- atuais da AscensionDB (PvE/PvP Power, ratings, MP5, resistências etc.)
                        -- sem varrer tabelas: é lookup/pattern sob demanda e possui cache próprio.
                        local translated = (AES.TranslateItemEffectCore and AES.TranslateItemEffectCore(effectBody))
                            or (AES.TranslateItemStatCore and AES.TranslateItemStatCore(effectBody))
                            or (AES.TranslateCharacterStatLine and AES.TranslateCharacterStatLine(effectBody))
                            or TranslateStaticText(effectBody) or MatchLinePatterns(effectBody)
                        if translated and translated ~= effectBody then
                            pcall(fs.SetText, fs, effectPrefixPT .. translated)
                            text = effectPrefixPT .. translated
                            changed = true
                        end

                        local fearDuration = not changed and effectBody:match(
                            "^Chance upon dealing direct magic damage to scare a creature, causing it to run in fear for up to ([%d%.,]+) sec%.?$")
                        if fearDuration then
                            translated = "Ao causar dano mágico direto, há uma chance de amedrontar a criatura, fazendo-a fugir por até "
                                .. fearDuration .. " s."
                            pcall(fs.SetText, fs, effectPrefixPT .. translated)
                            text = effectPrefixPT .. translated
                            changed = true
                        end
                        local bodyPrefixes = PrefijosDe(effectBody)
                        for p = 1, #bodyPrefixes do
                            if changed then break end
                            local bodyPrefix = bodyPrefixes[p]
                            if #bodyPrefix >= 8 then
                                local candidates = AES.TipByPrefix and AES.TipByPrefix[bodyPrefix]
                                translated = candidates and MatchPairSet(effectBody, candidates, AES.TipPairs)
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
                    local prefixes = PrefijosDe(text)
                    for p = 1, #prefixes do
                        local pref = prefixes[p]
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

                local new = (AES.TranslateItemEffectLine and AES.TranslateItemEffectLine(text))
                    or (AES.TranslateItemStatLine and AES.TranslateItemStatLine(text)) or text
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
                        local es = AES.SpellNameEN2ES[thing] or (AES.TranslateItemNameText and AES.TranslateItemNameText(thing)) or thing
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
                            or (AES.TranslateItemNameText and AES.TranslateItemNameText(core))
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
                        pre, preES = "Use: ", "Usar: "
                    elseif new:sub(1, 5) == "Set: " then
                        pre, preES = "Set: ", "Conjunto: "
                    elseif new:sub(1, 14) == "Socket Bonus: " then
                        pre, preES = "Socket Bonus: ", "Bônus de engaste: "
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
                local rep = (AES.TranslateItemEffectLine and AES.TranslateItemEffectLine(text))
                    or (AES.TranslateItemStatLine and AES.TranslateItemStatLine(text)) or MatchLinePatterns(text)
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

    local ptName, spellKey = AES.TranslateSpellNameText(enName, spellID)
    if ptName then L1:SetText(ptName) end
    local lookupName = spellKey or enName

    local L2 = _G[name .. "TextLeft2"]
    local rankText = L2 and L2:GetText()
    if rankText and AES.RankEN2ES[rankText] then
        L2:SetText(AES.RankEN2ES[rankText])
    end

    -- No CoA o spellID e a referencia mais estavel. Se o ID exato casar,
    -- evitamos varrer todos os ranks com o mesmo nome e o indice por prefixo.
    local matched = false
    if spellID then
        if AES.DescByID[spellID] then
            matched = TranslateBodyByPairs(tip, AES.DescByID[spellID], AES.DescPairs) or matched
        end
        if AES.TipByID[spellID] then
            matched = TranslateBodyByPairs(tip, AES.TipByID[spellID], AES.TipPairs) or matched
        end
    end

    -- Algumas builds devolvem outro ID/rank para o mesmo nome; tenta pelo nome antes de desistir.
    if not matched and lookupName and AES.NameToIDs[lookupName] then
        for _, id in ipairs(AES.NameToIDs[lookupName]) do
            if id ~= spellID then
                local idMatched = false
                if AES.DescByID[id] then
                    idMatched = TranslateBodyByPairs(tip, AES.DescByID[id], AES.DescPairs) or idMatched
                end
                if AES.TipByID[id] then
                    idMatched = TranslateBodyByPairs(tip, AES.TipByID[id], AES.TipPairs) or idMatched
                end
                if idMatched then
                    matched = true
                    break
                end
            end
        end
    end

    -- Prefixo e a rede de seguranca. E bem mais caro, entao so roda quando
    -- o caminho indexado nao encontrou a descricao.
    if not matched then
        local ok, result = pcall(TranslateBodyByPrefix, tip)
        if ok and result then matched = true end
    end

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
    local esName, spellKey = AES.TranslateSpellNameText(enName, spellID)
    if esName then L1:SetText(esName) end
    local lookupName = spellKey or enName

    local translated = false
    if spellID and AES.TipByID[spellID] then
        translated = TranslateBodyByPairs(tip, AES.TipByID[spellID], AES.TipPairs)
    end
    if not translated and lookupName and AES.NameToIDs[lookupName] then
        for _, id in ipairs(AES.NameToIDs[lookupName]) do
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

    if itemID then
        -- Sempre deixa o tradutor olhar o NOME do item exibido. O caminho comum
        -- continua sendo lookup O(1) por ID; se for um item custom novo/reutilizado,
        -- o fallback por padrao roda somente neste tooltip (nunca por frame).
        local L1 = _G[name .. "TextLeft1"]
        local text = L1 and L1:GetText()
        local translated = text and AES.TranslateItemNameText
            and AES.TranslateItemNameText(text, link, itemID)
        if translated and translated ~= text then L1:SetText(translated) end
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

local function IsSafeNpcSubtitleByID(npcID, candidate)
    if not npcID or type(candidate) ~= "string" then return false end
    local value = candidate:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    value = value:match("^<(.-)>$") or value
    value = value:gsub("^%s+", ""):gsub("%s+$", "")
    if value == "" then return false end

    local enName = AES.UnitNameEN and AES.UnitNameEN[npcID]
    local ptName = AES.UnitName and AES.UnitName[npcID]
    local lower = value:lower():gsub("%s+", " ")
    if type(enName) == "string" and lower == enName:lower():gsub("%s+", " ") then return false end
    if type(ptName) == "string" and lower == ptName:lower():gsub("%s+", " ") then return false end
    return true
end

local function ResolveSafeNpcSubtitleByID(npcID, shown)
    if not npcID then return nil end
    local enSub = AES.UnitSubEN and AES.UnitSubEN[npcID]
    local ptSub = AES.UnitSub and AES.UnitSub[npcID]

    if IsSafeNpcSubtitleByID(npcID, ptSub) then
        return ptSub, enSub
    end

    -- Algumas linhas herdadas da base antiga trazem o nome do NPC no campo de
    -- subtítulo. Nesses casos ignoramos o dado ruim e tentamos traduzir a função
    -- inglesa real, em vez de exibir Nome/Nome.
    local source = type(enSub) == "string" and enSub ~= "" and enSub or shown
    if type(source) == "string" and source ~= "" and AES.TranslateNpcRoleText then
        local ok, translated = pcall(AES.TranslateNpcRoleText, source)
        if ok and type(translated) == "string" then
            translated = translated:match("^<(.-)>$") or translated
            if IsSafeNpcSubtitleByID(npcID, translated) then
                return translated, enSub
            end
        end
    end
    return nil, enSub
end

AES.IsSafeNpcSubtitleByID = IsSafeNpcSubtitleByID
AES.ResolveSafeNpcSubtitleByID = ResolveSafeNpcSubtitleByID

local function OnUnitTooltip(tip)
    if not db then return end
    local _, unit = tip:GetUnit()
    local guid = unit and UnitGUID(unit)
    local refreshWorldName = false
    local npcID = db.units and NpcIdFromGUID(guid)
    local tipName = tip:GetName()
    local L1 = tipName and _G[tipName .. "TextLeft1"]
    local apiName = unit and UnitName and UnitName(unit)

    if npcID then
        local text = L1 and L1:GetText()
        local guard = AES.UnitNameEN[npcID]
        if text and AES.UnitName[npcID] and (not guard or guard == text or guard == apiName) then
            L1:SetText(AES.UnitName[npcID])
        end

        local L2 = tipName and _G[tipName .. "TextLeft2"]
        local t2 = L2 and L2:GetText()
        if t2 and not t2:match("^Level") and not t2:match("^Nível") then
            local safeSub, subGuard = ResolveSafeNpcSubtitleByID(npcID, t2)
            if safeSub and (not subGuard or subGuard == t2 or safeSub == t2) then
                L2:SetText(safeSub)
            end
        end
    end

    -- NPC custom nem sempre tem UnitSub na base 3.3.5. Nesses casos traduz o
    -- título/função direto do tooltip (ex.: <Guns and Ammo Merchant>).
    if AES.TranslateNpcRoleText and tipName then
        for i = 2, math.min(tip:NumLines(), 4) do
            local fs = _G[tipName .. "TextLeft" .. i]
            local shown = fs and fs:GetText()
            local translated = shown and AES.TranslateNpcRoleText(shown)
            if translated and translated ~= shown then
                if AES.LearnWorldNpcRole and unit then
                    local okLearn, learned = pcall(AES.LearnWorldNpcRole, unit, shown, translated)
                    if okLearn and learned then refreshWorldName = true end
                end
                pcall(fs.SetText, fs, translated)
            end
        end
    end

    if AES.TranslateUnitDescriptorText then
        for i = 2, tip:NumLines() do
            local fs = _G[tipName .. "TextLeft" .. i]
            local shown = fs and fs:GetText()
            local translated = shown and AES.TranslateUnitDescriptorText(shown)
            if translated and translated ~= shown then pcall(fs.SetText, fs, translated) end
        end
    end

    ApplyLinePatterns(tip)

    -- Se outro ponto já traduziu o título, aproveita em vez de resolver de novo.
    -- Assim NPC custom que já aparece em PT-BR no tooltip passa a alimentar a placa no mundo.
    if db.units and type(apiName) == "string" and apiName ~= "" and L1 then
        local shown = L1:GetText()
        if type(shown) == "string" and shown ~= "" then
            shown = shown:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
            if shown ~= apiName and not shown:match("^Level%s") and not shown:match("^Nível%s") then
                AES.UnitNameEN2ES = AES.UnitNameEN2ES or {}
                AES.UnitNameEN2ES[apiName] = shown
            end
        end
    end

    -- O tooltip de unidade não precisa ser escondido/mostrado novamente para
    -- atualizar texto. Forçar Show() a cada mouseover causava a piscada visível
    -- no card e ainda acordava o layout do tooltip sem necessidade.
    -- Só refrescamos a placa quando aprendemos uma função nova do NPC.
    if refreshWorldName and AES.TranslateNativeNameplate and unit then
        pcall(AES.TranslateNativeNameplate, unit)
    end
end

local function EscapeLuaPattern(text)
    return (text:gsub("([^%w])", "%%%1"))
end

-- Linha de jogador é montada pelo Ascension, tipo "Level 20 ... (Player)".
function AES.TranslateUnitDescriptorText(text)
    if type(text) ~= "string" or text == "" then return nil end

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
            local es = t and AES.TranslateSpellNameText(t)
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
            local es = text and AES.TranslateSpellNameText(text)
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

function TranslateStaticText(t)
    local es = (AES.TalentUIExact and AES.TalentUIExact[t])
        or (AES.OfficialDisplayExact and AES.OfficialDisplayExact[t])
        or (AES.CharacterStatExact and AES.CharacterStatExact[t])
        or (AES.CharacterPanelExact and AES.CharacterPanelExact[t])
        or (AES.CustomUI and AES.CustomUI[t])
        or (AES.ServerUI and AES.ServerUI[t])
        or (AES.UIStringsByEN and AES.UIStringsByEN[t])
        or (AES.UIStrings and AES.UIStrings[t])
        or (AES.AreaNames and AES.AreaNames[t])
    if es then return es end

    -- Textos de interface montados em tempo real (logout, saida, ressuscitar etc.)
    -- nao existem como uma string literal no GlobalStrings: o cliente formata o numero
    -- e a unidade antes de desenhar. Fazemos so esses padroes curtos aqui, sem scanner.
    if type(t) == "string" then
        local amount, unit, target = t:match("^(%d+)%s+([%a]+)%s+until%s+([%a]+)$")
        if amount and unit and target then
            local u = unit:lower()
            local unitPT
            if u == "second" then unitPT = "segundo"
            elseif u == "seconds" then unitPT = "segundos"
            elseif u == "minute" then unitPT = "minuto"
            elseif u == "minutes" then unitPT = "minutos"
            elseif u == "hour" then unitPT = "hora"
            elseif u == "hours" then unitPT = "horas"
            end

            local targetPT
            target = target:lower()
            if target == "logout" then targetPT = "desconectar"
            elseif target == "exit" then targetPT = "sair"
            elseif target == "release" then targetPT = "liberar o espírito"
            elseif target == "resurrection" then targetPT = "a ressurreição"
            end

            if unitPT and targetPT then
                if target == "resurrection" then
                    return amount .. " " .. unitPT .. " até " .. targetPT
                end
                return amount .. " " .. unitPT .. " até " .. targetPT
            end
        end
    end

    -- O C espalha texto fora do CharacterFrame. Usa as mesmas bases do CharacterUI para não traduzir cada aba de um jeito.
    if AES.TranslateCharacterPanelLine then
        local ok, value = pcall(AES.TranslateCharacterPanelLine, t)
        if ok and type(value) == "string" and value ~= "" and value ~= t then return value end
    end
    if AES.TranslateCharacterStatLine then
        local ok, value = pcall(AES.TranslateCharacterStatLine, t)
        if ok and type(value) == "string" and value ~= "" and value ~= t then return value end
    end

    if db and db.quests then
        local questExact = (AES.QuestTitleEN2ES and AES.QuestTitleEN2ES[t])
            or (AES.QuestTextEN2PT and AES.QuestTextEN2PT[t])
            or (AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[t])
        if questExact and questExact ~= false then
            return (AES.QuestRenderPT and AES.QuestRenderPT(questExact)) or questExact
        end
    end

    local base, tail = t:match("^(.-)%s*(:?)%s*$")
    if base and base ~= t and base ~= "" then
        es = (AES.TalentUIExact and AES.TalentUIExact[base])
            or (AES.OfficialDisplayExact and AES.OfficialDisplayExact[base])
            or (AES.CharacterStatExact and AES.CharacterStatExact[base])
            or (AES.CharacterPanelExact and AES.CharacterPanelExact[base])
            or (AES.CustomUI and AES.CustomUI[base])
            or (AES.ServerUI and AES.ServerUI[base])
            or (AES.UIStringsByEN and AES.UIStringsByEN[base])
            or (AES.UIStrings and AES.UIStrings[base])
            or (AES.AreaNames and AES.AreaNames[base])
        if es then return es .. (tail or "") end
    end

    local c0, inner, r0 = t:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)%s*$")
    if inner and inner ~= "" and not inner:find("|c") then
        local es2 = (AES.TalentUIExact and AES.TalentUIExact[inner])
            or (AES.CharacterStatExact and AES.CharacterStatExact[inner])
            or (AES.CharacterPanelExact and AES.CharacterPanelExact[inner])
            or (AES.CustomUI and AES.CustomUI[inner])
            or (AES.ServerUI and AES.ServerUI[inner])
            or (AES.UIStringsByEN and AES.UIStringsByEN[inner])
            or (AES.UIStrings and AES.UIStrings[inner])
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

    if db and db.units and AES.UnitSubEN2PT then
        local subPT = AES.UnitSubEN2PT[t]
        if subPT then return subPT end
        local subEN = t:match("^<(.-)>$")
        subPT = subEN and AES.UnitSubEN2PT[subEN]
        if subPT then return "<" .. subPT .. ">" end
    end

    if db and db.spells and AES.SpellNameEN2ES and #t >= 4 then
        local esSpell = AES.TranslateSpellNameText(t)
        if esSpell and esSpell ~= t then return esSpell end
    end
    return nil
end


AES.TranslateStaticText = TranslateStaticText

-- Só traduz o FontString da zona. Não mexe nas APIs e não arruma briga com outro addon.
do
local areaFSHooked = setmetatable({}, { __mode = "k" })
local areaRootHooked = setmetatable({}, { __mode = "k" })
local inAreaFSHook = false

local AREA_ROOT_NAMES = {
    -- O mapa do Ascension usa frames protegidos. Traduzimos apenas rótulos explícitos
    -- e os frames de zona/minimapa para não contaminar WorldMapBlobFrame/EnableMouse.
    "MinimapCluster", "BattlefieldMinimap", "ZoneTextFrame", "SubZoneTextFrame",
}

local function AreasEnabled()
    if AES.IsFeatureEnabled then return AES.IsFeatureEnabled("maps", true) end
    return not db or db.maps ~= false
end

local AREA_TEXT_NAMES = {
    "ZoneTextString", "SubZoneTextString", "MinimapZoneText",
    "WorldMapFrameAreaLabel", "WorldMapFrameAreaDescription",
    "WorldMapFrameTitleText", "WorldMapZoneInfo", "WorldMapZoneText",
    "QuestMapFrameTitleText", "AscensionMapZoneText", "AscensionWorldMapZoneText",
}

local function AreaExact(text)
    if type(text) ~= "string" or text == "" then return nil end
    return (AES.AreaNames and AES.AreaNames[text]) or (AES.MapLabels and AES.MapLabels[text])
end

local function TranslateAreaText(text)
    if type(text) ~= "string" or text == "" then return nil end
    local direct = AreaExact(text)
    if direct and direct ~= text then return direct end

    local color, inner, reset = text:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
    local innerPT = inner and AreaExact(inner)
    if innerPT and innerPT ~= inner then return color .. innerPT .. reset end

    local area, levels = text:match("^(.-)(%s+%(%d+[%d%s%-–—]*%))$")
    local areaPT = area and AreaExact(area)
    if areaPT and areaPT ~= area then return areaPT .. levels end

    local first, rest = text:match("^([^\n]+)(\n.+)$")
    local firstPT = first and AreaExact(first)
    if firstPT and firstPT ~= first then return firstPT .. rest end
    return nil
end
AES.TranslateAreaText = TranslateAreaText

local function HookAreaFS(fs)
    if not (fs and fs.SetText) or areaFSHooked[fs] then return end
    areaFSHooked[fs] = true
    for _, method in ipairs({ "SetText", "SetFormattedText" }) do
        if fs[method] then
            pcall(hooksecurefunc, fs, method, function(self)
                if inAreaFSHook or not AreasEnabled() then return end
                if self.IsVisible then
                    local ok, visible = pcall(self.IsVisible, self)
                    if ok and not visible then return end
                end
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
            local okVisible, visible = pcall(function() return root:IsVisible() end)
            if okVisible and visible then pcall(WalkAreaUI, root, 0, {}) end
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
    if not AreasEnabled() then return end
    HookAreaRoots()
    if AES.Runtime then
        AES.Runtime.Repeat("area-ui", 0.12, 0.12, 3, function()
            if not AreasEnabled() then return false end
            HookAreaRoots()
        end)
    end
end
AES.TranslateAreaUI = TranslateAreaUI

local areaWatcher = CreateFrame("Frame")
for _, event in ipairs({ "ADDON_LOADED", "PLAYER_ENTERING_WORLD", "ZONE_CHANGED",
                          "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA",
                          "WORLD_MAP_UPDATE" }) do
    pcall(areaWatcher.RegisterEvent, areaWatcher, event)
end
areaWatcher:SetScript("OnEvent", function(_, event, name)
    if event == "ADDON_LOADED" then
        if type(name) ~= "string" then return end
        local relevant = name == "AscensionPTBR"
            or name:find("Ascension", 1, true)
            or name == "Blizzard_WorldMap"
        if not relevant then return end
    end
    pcall(TranslateAreaUI)
end)

end

AES.TranslateDescriptionString = function(text)
    if type(text) ~= "string" or text == "" then return nil end
    if text:find("\n", 1, true) then
        local multi = TranslateMultilineText(text)
        if multi and multi ~= text then return multi end
    end
    local prefixes = PrefijosDe(text)
    for p = 1, #prefixes do
        local pref = prefixes[p]
        local indexes = pref ~= "" and AES.DescByPrefix and AES.DescByPrefix[pref]
        local translated = indexes and MatchPairSet(text, indexes, AES.DescPairs)
        if translated and translated ~= text then return translated end
        indexes = pref ~= "" and AES.TipByPrefix and AES.TipByPrefix[pref]
        translated = indexes and MatchPairSet(text, indexes, AES.TipPairs)
        if translated and translated ~= text then return translated end
    end
    return nil
end

-- Guarda o ultimo texto que o proprio AscensionPTBR escreveu em cada FontString.
-- Alguns addons atualizam o mesmo texto em cascata; sem isso, uma traducao ja
-- pronta pode voltar para o tradutor e sofrer novas substituicoes em loop.
local uiFSLastTarget = setmetatable({}, { __mode = "k" })

local function ApplyStaticFontString(fs, current, translated)
    if not (fs and fs.SetText) or type(translated) ~= "string" or translated == ""
        or translated == current then return false end
    uiFSLastTarget[fs] = translated
    local ok = pcall(fs.SetText, fs, translated)
    if not ok then uiFSLastTarget[fs] = nil end
    return ok
end

-- Nameplates são atualizadas e recicladas muitas vezes enquanto o jogador anda ou
-- gira a câmera. Elas têm tradutor próprio em WorldNames.lua e nunca devem cair
-- no scanner genérico de interface. O bloco fica isolado para não consumir locals
-- do chunk principal (limite de 200 do Lua 5.1).
;(function()
    local positiveCache = setmetatable({}, { __mode = "k" })

    local function ObjectNameLooksLikePlate(obj)
        if not (obj and obj.GetName) then return false end
        local ok, name = pcall(obj.GetName, obj)
        if not ok or type(name) ~= "string" then return false end
        local lower = name:lower()
        return lower:find("nameplate", 1, true) ~= nil
            or lower:find("compactunitframe", 1, true) ~= nil
    end

    local function IsNameplateObject(obj)
        if not obj then return false end
        if obj.__aptbrWorldName or obj.__aptbrNameplateRoot or positiveCache[obj] then
            positiveCache[obj] = true
            return true
        end

        local current, hops = obj, 0
        while current and hops < 18 do
            -- No cliente do Ascension, as placas, bolhas e nomes 3D vivem sob o
            -- WorldFrame. Nenhum tradutor generico de interface deve instalar
            -- hooks nessa arvore. Isso inclui placas ainda vazias no pool.
            if current == WorldFrame or current.__aptbrWorldName
                or current.__aptbrNameplateRoot or ObjectNameLooksLikePlate(current) then
                positiveCache[obj] = true
                return true
            end

            local okUnit, unit = pcall(function()
                return current.unit or current.displayedUnit or current.unitToken or current.__aptbrUnit
            end)
            if okUnit and type(unit) == "string" and unit:match("^nameplate") then
                positiveCache[obj] = true
                return true
            end

            local okPlate, isPlate = pcall(function()
                local unitFrame = current.UnitFrame or current.unitFrame
                return unitFrame ~= nil and (unitFrame.name ~= nil
                    or unitFrame.healthBar ~= nil or unitFrame.optionTable ~= nil)
            end)
            if okPlate and isPlate then
                positiveCache[obj] = true
                return true
            end

            local okParent, parent = pcall(function()
                return current.GetParent and current:GetParent()
            end)
            current = okParent and parent or nil
            hops = hops + 1
        end
        return false
    end

    AES.IsNameplateObject = IsNameplateObject
end)()

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
                    if es and es ~= t then ApplyStaticFontString(r, t, es) end
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

local EXCLUDED_ROOTS = {
    CallBoardUI = true,
    -- LootSlot() e outros cliques seguros nao podem herdar taint do tradutor visual.
    LootFrame = true,
}
local EXCLUDED_PAT = {
    "AuctionFilterButton",
    "LootButton",
    "GroupLootFrame",
    "LootHistoryFrame",
    -- O Quadro de Chamados tem módulo próprio. Deixar o scanner genérico entrar
    -- nessa árvore duplica trabalho e pesa bastante em máquinas mais fracas.
    "CallBoard",
    "Callboard",
    "DailyQuest",
    "WeeklyQuest",
    "QuestBoard",
    "HeroesCall",
}
local excludeCache = setmetatable({}, { __mode = "k" })
local function FrameExcluded(obj)
    if obj == nil then return false end
    if AES.IsNameplateObject and AES.IsNameplateObject(obj) then return true end
    -- Frames do cliente sao reciclados e podem mudar de pai. Cacheamos apenas
    -- exclusoes positivas; um "false" antigo poderia virar nameplate depois.
    if excludeCache[obj] then return true end
    local cur, hops = obj, 0
    while cur and hops < 14 do
        -- Um filho pode nao ser protegido mesmo estando dentro de um frame seguro.
        -- Se algum pai for proibido pelo cliente, deixa esse bloco quieto.
        if cur.IsForbidden then
            local okf, forbidden = pcall(cur.IsForbidden, cur)
            if okf and forbidden then
                excludeCache[obj] = true
                return true
            end
        end
        if cur.IsProtected then
            local okp, protected = pcall(cur.IsProtected, cur)
            if okp and protected then
                excludeCache[obj] = true
                return true
            end
        end

        local okn, nm = pcall(function() return cur.GetName and cur:GetName() end)
        if okn and nm and EXCLUDED_ROOTS[nm] then
            excludeCache[obj] = true
            return true
        end
        if okn and nm then
            -- Nomes de itens dos slots do C são dados internos do PaperDoll,
            -- não textos da interface. Traduzir essas FontStrings faz o nome
            -- ultrapassar o botão e atravessar a coluna de atributos.
            if nm:match("^Character.+Slot$")
                or nm:match("^Inspect.+Slot$")
                or nm:match("^PaperDoll.+Slot$")
                or nm:match("^AscensionCharacter.+Slot$")
                or nm:find("EquipmentSlot", 1, true) then
                excludeCache[obj] = true
                return true
            end
            for _, pat in ipairs(EXCLUDED_PAT) do
                if nm:find(pat, 1, true) then
                    excludeCache[obj] = true
                    return true
                end
            end
        end
        local okParent, par = pcall(function() return cur.GetParent and cur:GetParent() end)
        cur = okParent and par or nil
        hops = hops + 1
    end
    return false
end
AES.FrameExcluded = FrameExcluded

local function PrimeStaticSubtree(root, depth)
    if not root or FrameExcluded(root) then return end
    depth = depth or 0
    if depth > 10 then return end

    local ok, regions = pcall(function() return { root:GetRegions() } end)
    if ok and regions then
        for _, r in ipairs(regions) do
            if r and r.IsObjectType and r:IsObjectType("FontString") then
                local t = r.GetText and r:GetText()
                if type(t) == "string" and t ~= "" then
                    local es = TranslateStaticText(t)
                    if es and es ~= t then ApplyStaticFontString(r, t, es) end
                end
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

local function FixGameMenuLabels()
    local menu = _G.GameMenuFrame
    if not menu then return end
    if type(InCombatLockdown) == "function" and InCombatLockdown() then return end

    -- O GameMenu pode estar protegido, então o scanner genérico pula a árvore para
    -- não gerar taint. Aqui alteramos somente FontStrings, nunca scripts/atributos.
    local function TranslateFontString(fs)
        if not (fs and fs.GetText and fs.SetText) then return end
        local ok, text = pcall(fs.GetText, fs)
        if not ok or type(text) ~= "string" or text == "" then return end
        local pt = TranslateStaticText(text)
        if pt and pt ~= text then ApplyStaticFontString(fs, text, pt) end
    end

    local queue, head, visited = { menu }, 1, 0
    while queue[head] and visited < 160 do
        local frame = queue[head]
        head = head + 1
        visited = visited + 1

        if frame.GetFontString then
            local ok, fs = pcall(frame.GetFontString, frame)
            if ok then TranslateFontString(fs) end
        end
        if frame.GetRegions then
            local ok, regions = pcall(function() return { frame:GetRegions() } end)
            if ok and regions then
                for i = 1, #regions do
                    local region = regions[i]
                    if region and region.IsObjectType and region:IsObjectType("FontString") then
                        TranslateFontString(region)
                    end
                end
            end
        end
        if frame.GetChildren then
            local ok, children = pcall(function() return { frame:GetChildren() } end)
            if ok and children then
                for i = 1, #children do queue[#queue + 1] = children[i] end
            end
        end
    end
end

-- Dois repasses e chega. Mais que isso começa a pesar sem trazer ganho.
local function StaticPassSoon(panel)
    if not panel then return end
    if panel == _G.GameMenuFrame then pcall(FixGameMenuLabels) end
    pcall(PrimeStaticSubtree, panel, 0)

    if AES.Runtime then
        AES.Runtime.After("static-panel-1", 0.03, function()
            if panel and panel.IsVisible and panel:IsVisible() then
                pcall(PrimeStaticSubtree, panel, 0)
            end
        end)
        AES.Runtime.After("static-panel-2", 0.18, function()
            if panel and panel.IsVisible and panel:IsVisible() then
                if panel == _G.GameMenuFrame then pcall(FixGameMenuLabels) end
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

                            "AscensionLFGFrame", "AscensionPVEFrame", "AscensionPVPFrame",
                            "AscensionRulesetFrame", "PathToAscensionFrame",
                            "WarmodeMapFrame", "AscensionWeeklyKeystoneFrame",
                            "ChannelFrame", "CalendarFrame",

                            "CharacterAdvancement", "CharacterAdvancementFrame", "AscensionCharacterAdvancement",
                            "ClassTalentFrame", "RaceTalentFrame", "RacialTalentFrame",
                            "SpecializationFrame", "MentorSpecializationFrame", "Collections",
                            "WildCardRapidRollingFrame", "DraftHelpFrame",
                            "SkillCardsFrame", "VanityCollectionFrame" }) do
        local f = _G[name]
        if f then
            local okVisible, visible = pcall(function() return f:IsVisible() end)
            if okVisible and visible then pcall(PrimeStaticSubtree, f, 0) end
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
        or name == "Blizzard_Calendar"
end

local staticWatcher = CreateFrame("Frame")
staticWatcher:RegisterEvent("ADDON_LOADED")
staticWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
staticWatcher:SetScript("OnEvent", function(_, event, name)
    if event == "PLAYER_ENTERING_WORLD" or AES.Perf.IsRelevantUILoad(name) then
        if name == "Blizzard_Calendar" and AES.ApplyCalendarGlobalStrings then
            pcall(AES.ApplyCalendarGlobalStrings)
        end
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
                local es = name and AES.TranslateSpellNameText(name)
                if es then btn:SetText((prefix or "") .. es) end
            end
        end
        local sub = _G["ClassTrainerSkill" .. i .. "SubText"]
        local st = sub and sub:GetText()
        if st and st ~= "" then
            local translated = AES.TranslateSpellNameText(st)
            local new = translated or st
            new = new:gsub("%(Rank (%d+)%)", "(Grau %1)")
            if new ~= st then sub:SetText(new) end
        end
    end
end

local function TranslateTrainerDetail()
    local nameFS = ClassTrainerSkillName
    local enName = nameFS and nameFS:GetText()
    if enName then
        local es = AES.TranslateSpellNameText(enName)
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
        ClassTrainerFrame:HookScript("OnShow", function()
            if not db or not db.spells then return end
            TranslateTrainerList()
            TranslateTrainerDetail()
            if db.ui then PrimeStaticSubtree(ClassTrainerFrame) end
        end)
    end
end

local function TradeSkillWord(t)
    return AES.TranslateSpellNameText(t)
        or (AES.TranslateItemNameText and AES.TranslateItemNameText(t))
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

local function QueueTradeSkillPasses()
    if not (db and db.spells) then return end
    pcall(HookTradeSkillButtons)
    pcall(TranslateTradeSkillFrame)
    pcall(TranslateTradeSkillDetail)
    if AES.Runtime then
        AES.Runtime.Repeat("tradeskill-refresh", 0.06, 0.16, 4, function()
            local f = TradeSkillFrame or _G["TradeSkillSkill1"]
            local ok, vis = pcall(function() return f and f.IsVisible and f:IsVisible() end)
            if not (ok and vis) then return false end
            pcall(TranslateTradeSkillFrame)
            pcall(TranslateTradeSkillDetail)
        end)
    end
end

AES.Perf.tsTickEvents = AES.Perf.tsTickEvents or CreateFrame("Frame")
AES.Perf.tsTickEvents:RegisterEvent("TRADE_SKILL_SHOW")
AES.Perf.tsTickEvents:RegisterEvent("TRADE_SKILL_UPDATE")
AES.Perf.tsTickEvents:RegisterEvent("TRADE_SKILL_CLOSE")
AES.Perf.tsTickEvents:SetScript("OnEvent", function(_, event)
    if event == "TRADE_SKILL_CLOSE" then
        if AES.Runtime then AES.Runtime.Cancel("tradeskill-refresh") end
        return
    end
    QueueTradeSkillPasses()
end)

-- O C tem configuração própria. Ele não pode depender do antigo botão genérico
-- de Interface, porque muita gente deixa esse bloco desligado por desempenho.
function AES.CharacterUIEnabled()
    if AES.IsFeatureEnabled then return AES.IsFeatureEnabled("characterUI", true) end
    return not (db and db.characterUI == false)
end

-- O C reescreve tooltip direto; este cache evita piscar e refazer serviço.
local function TranslateCharacterStatText(text)
    if type(text) ~= "string" or text == "" then return nil end

    -- O painel C usa somente o parser de atributos. Parsers de item não entram
    -- aqui: GameTooltip é reutilizado pelo cliente e misturar os dois contextos
    -- fazia linhas de equipamentos aparecerem como se fossem status do personagem.
    local statLine = AES.TranslateCharacterStatLine and AES.TranslateCharacterStatLine(text)
    if statLine and statLine ~= text then return statLine end

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
local charStatFSFastCache = setmetatable({}, { __mode = "k" })
local charStatTooltips = setmetatable({}, { __mode = "k" })
local inCharStatFSHook = false
local charStatsActive = false
local LooksLikeCharacterStatTooltip

local function IsCharacterPanelObject(obj)
    local depth = 0
    while obj and depth < 10 do
        local name = obj.GetName and obj:GetName()
        if name and (name == "CharacterFrame"
            or name == "PaperDollFrame"
            or name == "AscensionCharacterFrame"
            or name:find("AscensionCharacterStatsPanel", 1, true)) then
            return true
        end
        obj = obj.GetParent and obj:GetParent()
        depth = depth + 1
    end
    return false
end

-- Slots de equipamento pertencem à árvore do CharacterFrame, mas seus
-- tooltips nunca são status. A verificação pelo owner funciona antes mesmo de
-- GameTooltip:GetItem() ser preenchido, fechando a janela de corrida do cliente.
local function IsEquipmentSlotTooltip(tip)
    local owner = tip and tip.GetOwner and tip:GetOwner()
    if not owner then return false end

    local name = owner.GetName and owner:GetName()
    if name and (name:match("^Character.+Slot$")
        or name:match("^Inspect.+Slot$")
        or name:match("^PaperDoll.+Slot$")
        or name:find("EquipmentSlot", 1, true)) then
        return true
    end

    -- Addons de interface podem trocar o nome do botão, mas normalmente
    -- preservam o ID do slot e o link do equipamento do jogador.
    if type(GetInventoryItemLink) == "function" and owner.GetID then
        local okID, slotID = pcall(owner.GetID, owner)
        if okID and type(slotID) == "number" and slotID >= 1 and slotID <= 19 then
            local okLink, link = pcall(GetInventoryItemLink, "player", slotID)
            if okLink and link then return true end
        end
    end
    return false
end

-- Owner anônimo existe no Ascension; confere só quando aparece, nunca por frame.
local function IsCharPanelTooltip(tip)
    if not (tip and charStatsActive) then return false end
    if IsEquipmentSlotTooltip(tip) then return false end
    if charStatTooltips[tip] then return true end
    local owner = tip.GetOwner and tip:GetOwner()
    -- Estar dentro do CharacterFrame não basta: slots de equipamento também são
    -- filhos desse painel. Exige conteúdo reconhecido como atributo para não
    -- classificar o tooltip de um item equipado como tooltip de status.
    return IsCharacterPanelObject(owner) and LooksLikeCharacterStatTooltip(tip)
end

LooksLikeCharacterStatTooltip = function(tip)
    -- Tooltips de atributos do painel custom podem ter owner anônimo e o painel
    -- pode viver fora da árvore do CharacterFrame. Para não confundir tooltip de
    -- ITEM com tooltip do C, a detecção olha só as duas primeiras linhas e exige
    -- que o parser específico de atributos reconheça o título (Strength 34 etc.).
    if not (tip and tip.GetName and tip.NumLines) then return false end
    local name = tip:GetName()
    if not name then return false end
    local maxLines = math.min(tonumber(tip:NumLines()) or 0, 2)
    for i = 1, maxLines do
        for _, side in ipairs({ "TextLeft", "TextRight" }) do
            local fs = _G[name .. side .. i]
            local text = fs and fs.GetText and fs:GetText()
            if text and AES.TranslateCharacterStatLine then
                local ok, translated = pcall(AES.TranslateCharacterStatLine, text)
                if ok and translated and translated ~= text then return true end
            end
        end
    end
    return false
end

local function HasConcreteTooltipContent(tip)
    if not tip then return false end
    for _, getter in ipairs({ "GetItem", "GetSpell", "GetUnit" }) do
        if type(tip[getter]) == "function" then
            local ok, first, second = pcall(tip[getter], tip)
            if ok and (first ~= nil or second ~= nil) then return true end
        end
    end
    return false
end

local function MarkCharacterStatTooltip(tip)
    -- GameTooltip pode trocar de atributo para item sem um OnHide intermediário.
    -- Se já houver conteúdo concreto, ele pertence ao pipeline normal do tooltip.
    if HasConcreteTooltipContent(tip) or IsEquipmentSlotTooltip(tip) then
        charStatTooltips[tip] = nil
        return false
    end
    if charStatsActive and LooksLikeCharacterStatTooltip(tip) then
        charStatTooltips[tip] = true
        return true
    end
    return false
end

local function ClearCharacterStatTooltip(tip)
    if not (tip and charStatTooltips[tip]) then return end
    charStatTooltips[tip] = nil
    if AES.Runtime then
        AES.Runtime.Cancel("character-stat-tooltip:" .. tostring(tip) .. ":early")
        AES.Runtime.Cancel("character-stat-tooltip:" .. tostring(tip) .. ":late")
    end
end

local function IsCharacterStatFontString(fs)
    local parent = fs and fs.GetParent and fs:GetParent()
    if not parent then return false end
    if charStatTooltips[parent] then return true end
    if IsCharacterPanelObject(parent) then return true end
    if parent.GetOwner and IsCharPanelTooltip(parent) then return true end
    return false
end

-- O mesmo texto volta várias vezes. Guarda por FontString e evita refazer padrão.
local function HookCharacterStatFS(fs)
    if not (fs and fs.SetText) or charStatFSHooked[fs] then return end
    charStatFSHooked[fs] = true

    for _, method in ipairs({ "SetText", "SetFormattedText" }) do
        if fs[method] then
            pcall(hooksecurefunc, fs, method, function(self)
                if inCharStatFSHook or not AES.CharacterUIEnabled() then return end
                if self.IsVisible and not self:IsVisible() then return end
                if not IsCharacterStatFontString(self) then return end

                local current = self.GetText and self:GetText()
                if type(current) ~= "string" or current == "" then return end

                local state = charStatFSFastCache[self]
                local translated
                if state and state.source == current then
                    translated = state.translated
                    if translated == false then translated = nil end
                else
                    translated = TranslateCharacterStatText(current)
                    charStatFSFastCache[self] = {
                        source = current,
                        translated = translated or false,
                    }
                end

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
    if not (AES.CharacterUIEnabled() and tip and tip.GetName) then return end
    if HasConcreteTooltipContent(tip) or IsEquipmentSlotTooltip(tip) then
        ClearCharacterStatTooltip(tip)
        return
    end
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

local function CharacterStatTooltipTaskKey(tip, suffix)
    return "character-stat-tooltip:" .. tostring(tip) .. ":" .. suffix
end

-- Duas passadas tardias pegam as linhas pós-OnShow. Não aumenta isso sem medir FPS.
local function ScheduleCharacterStatLatePass(tip)
    if not (tip and AES.Runtime and MarkCharacterStatTooltip(tip)) then return end
    AES.Runtime.After(CharacterStatTooltipTaskKey(tip, "early"), 0.01, function()
        if not (tip.IsVisible and tip:IsVisible() and charStatTooltips[tip]) then return false end
        pcall(TranslateCharacterStatTooltip, tip)
    end)
    AES.Runtime.After(CharacterStatTooltipTaskKey(tip, "late"), 0.08, function()
        if not (tip.IsVisible and tip:IsVisible() and charStatTooltips[tip]) then return false end
        pcall(TranslateCharacterStatTooltip, tip)
    end)
end

local function HookTooltip(tip)
    -- Tooltips privados usados como leitores internos não são interface para o
    -- jogador. Hooká-los faz todo SetUnit interno disparar tradução, timers e
    -- reexibição. Em WorldNames isso acontecia a cada NPC entrando na câmera.
    if not tip or tip.__aptbrPrivateScanner or tip.__AscensionPTBRHooked then return end
    tip.__AscensionPTBRHooked = true

    if tip:HasScript("OnShow") then
        tip:HookScript("OnShow", function(t)
            if not db or AES.Perf.reshowGuard then return end
            if MarkCharacterStatTooltip(t) then
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
    if tip:HasScript("OnHide") then
        tip:HookScript("OnHide", function(t)
            if charStatTooltips[t] then
                charStatTooltips[t] = nil
                if AES.Runtime then
                    AES.Runtime.Cancel(CharacterStatTooltipTaskKey(t, "early"))
                    AES.Runtime.Cancel(CharacterStatTooltipTaskKey(t, "late"))
                end
            end
        end)
    end
    if tip:HasScript("OnTooltipSetSpell") then
        tip:HookScript("OnTooltipSetSpell", function(t)
            ClearCharacterStatTooltip(t)
            OnSpellTooltip(t)
        end)
    end
    if tip:HasScript("OnTooltipSetItem") then
        tip:HookScript("OnTooltipSetItem", function(t)
            ClearCharacterStatTooltip(t)
            OnItemTooltip(t)
        end)
    end
    if tip:HasScript("OnTooltipSetUnit") then
        tip:HookScript("OnTooltipSetUnit", function(t)
            ClearCharacterStatTooltip(t)
            OnUnitTooltip(t)
        end)
    end
end

-- Addons carregados depois podem criar painéis próprios. A versão anterior
-- enumerava a UI inteira e instalava hooks permanentes em cada FontString e
-- GameTooltip encontrado. O pool de nameplates e o tooltip privado de NPC
-- acabavam presos nesse pipeline, causando travadas ao andar ou girar a câmera.
--
-- Agora o refresh tardio é estritamente direcionado aos painéis conhecidos.
-- Não há EnumerateFrames global, não há hook em FontString arbitrário e não há
-- custo novo quando unidades entram ou saem da tela.
;(function()
    local watcher = CreateFrame("Frame")

    local function RefreshLateAddonUI()
        if not (db and db.ui) then return end
        pcall(HookStaticPanels)
    end

    watcher:RegisterEvent("ADDON_LOADED")
    watcher:RegisterEvent("PLAYER_ENTERING_WORLD")
    watcher:SetScript("OnEvent", function(_, event, addonName)
        if event == "ADDON_LOADED" and not AES.Perf.IsRelevantUILoad(addonName) then return end
        if AES.Runtime then
            AES.Runtime.After("addon-compat-ui-refresh",
                event == "PLAYER_ENTERING_WORLD" and 0.35 or 0.12,
                RefreshLateAddonUI)
        else
            pcall(RefreshLateAddonUI)
        end
    end)

    AES.RefreshLateAddonUI = RefreshLateAddonUI
end)()

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

-- Quests.lua guarda \n escapado. Aqui vira quebra real antes de mostrar na janela.
local function QuestRenderES(t)
    local male = not (UnitSex and UnitSex("player") == 3)

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

local function QuestUIWritable(object)
    if not object then return false end
    if object.IsForbidden then
        local ok, forbidden = pcall(object.IsForbidden, object)
        if ok and forbidden then return false end
    end
    if not (InCombatLockdown and InCombatLockdown()) then return true end

    local current = object
    for _ = 1, 12 do
        if not current then break end
        if current.IsProtected then
            local ok, protected = pcall(current.IsProtected, current)
            if ok and protected then
                AES.Diagnostics.protectedDeferrals = (AES.Diagnostics.protectedDeferrals or 0) + 1
                AES.Diagnostics.questProtectedSkips = (AES.Diagnostics.questProtectedSkips or 0) + 1
                AES.Diagnostics.lastProtectedDeferral = "SetText/quest-ui"
                return false
            end
        end
        local ok, parent = pcall(function()
            return current.GetParent and current:GetParent()
        end)
        current = ok and parent or nil
    end
    return true
end

local function QuestGuardSet(fs, es, en)
    if not (fs and es and en) then return end
    if not QuestUIWritable(fs) then return end
    local shown = fs.GetText and fs:GetText()
    if not shown or shown == "" then return end
    if not GuardEq(shown, en) then return end
    pcall(fs.SetText, fs, QuestRenderES(es))
end


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

-- Primeiro tenta mapa direto. Regex só entra quando precisa mesmo.
local function TranslateQuestUIText(text)
    if not (db and db.quests) or type(text) ~= "string" or text == "" then return nil end
    local exact = (AES.QuestUIExact and AES.QuestUIExact[text])
        or QUEST_TOOLTIP_STATIC[text]
    if exact then return exact end

    local title = TranslateQuestTitleText(text)
    if title then return title end
    local objective = AES.QuestObjectiveEN2PT and AES.QuestObjectiveEN2PT[text]
    if objective and objective ~= false then return QuestRenderES(objective) end
    local questText = AES.QuestTextEN2PT and AES.QuestTextEN2PT[text]
    if questText and questText ~= false then return QuestRenderES(questText) end

    if #text <= 140 and not text:find("\n", 1, true) and not text:find("|n", 1, true) then
        local function QuestTargetPT(target)
            if type(target) ~= "string" or target == "" then return target end
            local punct = target:sub(-1) == "." and "." or ""
            if punct ~= "" then target = target:sub(1, -2) end
            local core = target
            local article = core:match("^[Tt]he%s+(.+)$")
            if article then core = article end
            local pt = (AES.UnitNameEN2ES and AES.UnitNameEN2ES[core])
                or (AES.AreaNames and AES.AreaNames[core])
                or (AES.QuestTrackerNameEN2PT and AES.QuestTrackerNameEN2PT[core])
                or (AES.TranslateItemNameText and AES.TranslateItemNameText(core))
            if pt == false then pt = nil end
            return (pt or target) .. punct
        end

        local target = text:match("^[Ss]peak with (.+)$") or text:match("^[Ss]peak to (.+)$")
            or text:match("^[Tt]alk to (.+)$")
        if target then return "Fale com " .. QuestTargetPT(target) end

        target = text:match("^[Ss]cout through (.+)$") or text:match("^[Ss]cout (.+)$")
        if target then return "Explore " .. QuestTargetPT(target) end

        target = text:match("^[Tt]ravel to (.+)$") or text:match("^[Gg]o to (.+)$")
        if target then return "Vá até " .. QuestTargetPT(target) end

        target = text:match("^[Rr]eturn to (.+)$")
        if target then return "Retorne a " .. QuestTargetPT(target) end
    end

    local trackerText = TranslateQuestTooltipText(text)
    if trackerText then return trackerText end

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

local questUITextCache = {}
local questUITextCacheCount = 0
local QUEST_UI_TEXT_CACHE_LIMIT = 2048

-- Tracker martela o mesmo texto; traduz uma vez e reaproveita.
local function CachedQuestUIText(text)
    if type(text) ~= "string" or text == "" then return nil end
    local cached = questUITextCache[text]
    if cached ~= nil then return cached ~= false and cached or nil end

    local translated = TranslateQuestUIText(text)
    if questUITextCacheCount >= QUEST_UI_TEXT_CACHE_LIMIT then
        questUITextCache = {}
        questUITextCacheCount = 0
    end
    questUITextCache[text] = translated or false
    questUITextCacheCount = questUITextCacheCount + 1
    return translated
end

local function HookQuestUIFS(fs)
    if not (fs and fs.SetText) or questUIFSHooked[fs] or not QuestUIWritable(fs) then return end
    questUIFSHooked[fs] = true
    for _, method in ipairs({ "SetText", "SetFormattedText" }) do
        if fs[method] then
            pcall(hooksecurefunc, fs, method, function(self)
                if inQuestUIFSHook or not (db and db.quests) then return end
                if self.IsVisible and not self:IsVisible() then return end
                if not QuestUIWritable(self) then return end
                local text = self.GetText and self:GetText()
                local pt = text and CachedQuestUIText(text)
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
                local pt = text and CachedQuestUIText(text)
                if pt and pt ~= text and QuestUIWritable(region) then
                    pcall(region.SetText, region, pt)
                end
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
            if AES.SafeSetGlobalString then
                AES.SafeSetGlobalString(globalName, translated)
            end
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
        if root and (not root.IsVisible or root:IsVisible()) then
            pcall(WalkQuestUI, root, 0, seen)
        end
    end
    for _, name in ipairs(QUEST_UI_EXPLICIT_NAMES) do
        local object = _G[name]
        if object then
            if object.IsObjectType and object:IsObjectType("FontString") then
                HookQuestUIFS(object)
            end
            local text = object.GetText and object:GetText()
            local pt = text and CachedQuestUIText(text)
            if pt and pt ~= text and object.SetText and QuestUIWritable(object) then
                pcall(object.SetText, object, pt)
            end
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

-- Recompensa do L: troca só o nome. Textura, qtd e qualidade ficam do cliente.
local function TranslateQuestItemButtons()
    if not (db and db.items and AES.ItemName) then return end
    local function apply(fsName, link)
        local fs = _G[fsName]
        if not (fs and fs.GetText and link) then return end
        local shown = fs:GetText()
        local id = tonumber(link:match("item:(%d+)"))
        local translated = shown and AES.TranslateItemNameText
            and AES.TranslateItemNameText(shown, link, id)
        if translated and translated ~= shown then pcall(fs.SetText, fs, translated) end
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

-- Loja usa link/ID quando tem. Não sobrescreve API global do mercador.
do
    local function MerchantItemPT(index, shown, buyback)
        if not (db and db.items and type(shown) == "string" and shown ~= "") then return nil end
        local link
        if buyback and type(GetBuybackItemLink) == "function" then
            local ok, v = pcall(GetBuybackItemLink, index)
            if ok then link = v end
        elseif type(GetMerchantItemLink) == "function" then
            local ok, v = pcall(GetMerchantItemLink, index)
            if ok then link = v end
        end
        return AES.TranslateItemNameText and AES.TranslateItemNameText(shown, link) or nil
    end

    local function TranslateMerchantItemNames()
        if not (db and db.items) then return end
        local perPage = tonumber(MERCHANT_ITEMS_PER_PAGE) or 10
        local page = MerchantFrame and tonumber(MerchantFrame.page) or 1
        if not page or page < 1 then page = 1 end
        local offset = (page - 1) * perPage

        for i = 1, perPage do
            local fs = _G["MerchantItem" .. i .. "Name"]
            if fs and fs.GetText and fs.SetText then
                local ok, shown = pcall(fs.GetText, fs)
                if ok and type(shown) == "string" and shown ~= "" then
                    local pt = MerchantItemPT(offset + i, shown, false)
                    if pt and pt ~= shown then pcall(fs.SetText, fs, pt) end
                end
            end
        end

        local buybackFS = _G.MerchantBuyBackItemName
        if buybackFS and buybackFS.GetText and buybackFS.SetText then
            local ok, shown = pcall(buybackFS.GetText, buybackFS)
            if ok and type(shown) == "string" and shown ~= "" then
                local pt = MerchantItemPT(1, shown, true)
                if pt and pt ~= shown then pcall(buybackFS.SetText, buybackFS, pt) end
            end
        end
    end
    AES.TranslateMerchantItemNames = TranslateMerchantItemNames


    if type(MerchantFrame_Update) == "function" then
        hooksecurefunc("MerchantFrame_Update", TranslateMerchantItemNames)
    end
    if type(MerchantFrame_UpdateBuybackInfo) == "function" then
        hooksecurefunc("MerchantFrame_UpdateBuybackInfo", TranslateMerchantItemNames)
    end
    if MerchantFrame and MerchantFrame.HookScript then
        MerchantFrame:HookScript("OnShow", TranslateMerchantItemNames)
    end

    local merchantWatcher = CreateFrame("Frame")
    merchantWatcher:RegisterEvent("MERCHANT_SHOW")
    merchantWatcher:RegisterEvent("MERCHANT_UPDATE")
    pcall(merchantWatcher.RegisterEvent, merchantWatcher, "BUYBACK_UPDATE")
    merchantWatcher:SetScript("OnEvent", function()
        TranslateMerchantItemNames()
        if AES.Runtime then
            AES.Runtime.After("merchant-item-names", 0.05, TranslateMerchantItemNames)
        end
    end)
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

-- Um passe atrasado pega widget que nasce depois do evento. Sem scan duplicado.
local function DelayedQuestPass()
    if not AES.Runtime then return end
    AES.Runtime.After("quest-pass", 0.08, RunQuestLatePass)
end

-- A captura persistente de sexo do entregador foi removida: qsex nunca era lido
-- pela addon e crescia no SavedVariables a cada quest visitada.

local questFrame = CreateFrame("Frame")
questFrame:RegisterEvent("QUEST_DETAIL")
questFrame:RegisterEvent("QUEST_PROGRESS")
questFrame:RegisterEvent("QUEST_COMPLETE")
questFrame:RegisterEvent("QUEST_GREETING")
questFrame:RegisterEvent("GOSSIP_SHOW")
questFrame:RegisterEvent("QUEST_ITEM_UPDATE")
questFrame:RegisterEvent("QUEST_LOG_UPDATE")
questFrame:RegisterEvent("QUEST_WATCH_UPDATE")
-- Nem toda build tem WORLD_MAP_UPDATE. Esse pcall é de propósito.
pcall(questFrame.RegisterEvent, questFrame, "WORLD_MAP_UPDATE")
questFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
questFrame:SetScript("OnEvent", function(self, event)
    if not (db and db.quests) then return end

    if event == "QUEST_LOG_UPDATE" or event == "QUEST_WATCH_UPDATE" then
        -- O tracker do Ascension recicla FontStrings depois da atualizacao do log.
        -- Refazemos apenas a arvore conhecida de quests, com debounce, em vez de
        -- deixar um scanner permanente rodando em OnUpdate.
        if AES.Runtime then
            AES.Runtime.After("quest-watch-refresh", 0.06, function()
                if db and db.quests then pcall(TranslateQuestChrome) end
            end)
        else
            pcall(TranslateQuestChrome)
        end
        return
    end

    if event == "WORLD_MAP_UPDATE" then
        -- Não percorre a árvore protegida do mapa. Os rótulos conhecidos são
        -- atualizados fora da pilha segura, sem taint em WorldMapBlobFrame.
        if AES.Runtime then
            AES.Runtime.After("quest-map-safe", 0.05, function()
                if db and db.quests then pcall(TranslateQuestChrome) end
            end)
        else
            pcall(TranslateQuestChrome)
        end
        return
    end

    TranslateQuestChrome()
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
do
    local count, limit = 0, 2048
    AES.RememberGossipApplied = function(text)
        if type(text) ~= "string" or text == "" then return end
        if gossipApplied[text] == nil then
            count = count + 1
            if count > limit then
                gossipApplied = {}
                count = 1
            end
        end
        gossipApplied[text] = true
    end
end

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

    -- Custom/endgame pode chegar com quebras diferentes dependendo do frame do
    -- Ascension. Consulta só o índice pequeno do GossipExtra; não normalizamos
    -- as dezenas de milhares de entradas do mapa principal a cada abertura.
    if es == nil and AES.GossipExtraNormalized then
        local normalized = key:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
        es = AES.GossipExtraNormalized[normalized]
    end

    -- Alguns NPCs custom entregam variáveis como classe/jogador já resolvidas no texto.
    -- O complemento de Gossip pode reconhecer esses formatos sem manter uma entrada por classe.
    if es == nil and AES.GossipPatternFallback then
        local okPattern, translated = pcall(AES.GossipPatternFallback, key)
        if okPattern and type(translated) == "string" and translated ~= "" and translated ~= key then
            es = translated
        end
    end

    -- Muitos NPCs custom do CoA reutilizam textos que já existem na base de
    -- interface, mas não em Gossip.lua. Aproveita esses mapas antes de desistir.
    -- É lookup O(1); não construímos um índice normalizado gigante ao abrir NPC.
    if es == nil then
        es = (AES.ServerUI and AES.ServerUI[key])
            or (AES.CustomUI and AES.CustomUI[key])
            or (AES.UIStringsByEN and AES.UIStringsByEN[key])
        if es == nil and TranslateStaticText then
            local okStatic, translated = pcall(TranslateStaticText, key)
            if okStatic and type(translated) == "string" and translated ~= key then
                es = translated
            end
        end
    end

    -- Fallback leve para opções curtas comuns de NPCs custom que ainda não
    -- chegaram às bases. Não tenta traduzir frases longas por heurística.
    if es == nil and #key <= 100 then
        if key == "I want to browse your wares." or key == "I want to see your wares." then
            es = "Quero ver suas mercadorias."
        elseif key == "I want to make this inn my home." then
            es = "Quero fazer desta estalagem o meu lar."
        else
            local subject = key:match("^Tell me about (.-)%.?$")
            if subject and subject ~= "" then
                local ptSubject = TranslateStaticText and TranslateStaticText(subject) or nil
                es = "Fale-me sobre " .. ((ptSubject and ptSubject ~= subject) and ptSubject or subject) .. "."
            end
        end
    end

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
        AES.RememberGossipApplied(es)
        return es
    end
    return nil
end
AES.GossipLookup = GossipLookup


-- Gossip pode chegar um tiquinho depois do GOSSIP_SHOW, daí o passe tardio.
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

do
    if type(GossipFrameUpdate) == "function" then
        pcall(hooksecurefunc, "GossipFrameUpdate", TranslateGossipGreeting)
    end
end

local gossipFrame = CreateFrame("Frame")
gossipFrame:RegisterEvent("GOSSIP_SHOW")
gossipFrame:RegisterEvent("QUEST_GREETING")
gossipFrame:SetScript("OnEvent", function()
    if not (db and db.gossip) then return end
    TranslateGossipGreeting()
    if AES.Runtime then
        AES.Runtime.After("gossip-pass", 0.08, TranslateGossipGreeting)
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
    local resolved = {}
    for _, f in ipairs({ WorldFrame:GetChildren() }) do
        if not (f.GetName and f:GetName()) then
            for _, r in ipairs({ f:GetRegions() }) do
                if r.IsObjectType and r:IsObjectType("FontString") then
                    local t = r.GetText and r:GetText()
                    local info = t and bubblePending[t]
                    if info then
                        pcall(r.SetText, r, info.es)
                        resolved[t] = true

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
    for en in pairs(resolved) do bubblePending[en] = nil end
    return next(bubblePending) ~= nil
end

local function StartBubbleScan()
    if not bubbleScanner then bubbleScanner = CreateFrame("Frame") end
    if bubbleScanner:GetScript("OnUpdate") then return end
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

local origGetQuestLogTitle = type(GetQuestLogTitle) == "function" and GetQuestLogTitle or nil
local questLogTitleHooked = setmetatable({}, { __mode = "k" })
local questLogTitleBusy = false
local questLogTitlePassPending = false

local function ReadQuestLogTitle(index)
    if not origGetQuestLogTitle then return nil, nil end
    local title, _, _, _, _, _, _, _, questID = origGetQuestLogTitle(index)
    return title, questID
end

local function SetQuestLogTitle(button, translated)
    if not (button and translated and translated ~= "") then return false end
    local shown = button.GetText and button:GetText()
    if shown == translated then return true end
    if not QuestUIWritable(button) then
        questLogTitlePassPending = true
        return false
    end

    questLogTitleBusy = true
    local ok = pcall(button.SetText, button, translated)
    questLogTitleBusy = false
    return ok
end

local function HookQuestLogTitleButton(button)
    if not (button and button.SetText) or questLogTitleHooked[button] then return end
    questLogTitleHooked[button] = true
    if hooksecurefunc then
        pcall(hooksecurefunc, button, "SetText", function(self)
            if questLogTitleBusy or not (db and db.quests) then return end
            local shown = self.GetText and self:GetText()
            local translated = shown and TranslateQuestTitleText(shown)
            if translated and translated ~= shown then
                SetQuestLogTitle(self, translated)
            end
        end)
    end
end

local function TranslateQuestLogTitles()
    if not (db and db.quests) then return end
    if not (InCombatLockdown and InCombatLockdown()) then
        questLogTitlePassPending = false
    end
    local offset = FauxScrollFrame_GetOffset and QuestLogListScrollFrame
        and FauxScrollFrame_GetOffset(QuestLogListScrollFrame) or 0
    for i = 1, 25 do
        local button = _G["QuestLogTitle" .. i]
        local index = offset + i
        if button and button.GetText and button:IsShown() then
            HookQuestLogTitleButton(button)
            local en, questID = ReadQuestLogTitle(index)
            local pt = questID and AES.QuestTitle and AES.QuestTitle[questID]
            if not pt and en then pt = TranslateQuestTitleText(en) end
            if not pt then pt = TranslateQuestTitleText(button:GetText()) end
            if pt then SetQuestLogTitle(button, pt) end
        end
    end
end
AES.TranslateQuestLogTitles = TranslateQuestLogTitles

local function QueueQuestLogTitlePass(delay)
    if AES.Runtime then
        AES.Runtime.After("quest-log-title-pass", delay or 0.06, function()
            if db and db.quests and QuestLogFrame and QuestLogFrame.IsVisible
                and QuestLogFrame:IsVisible() then
                pcall(TranslateQuestLogTitles)
            end
        end)
    else
        pcall(TranslateQuestLogTitles)
    end
end

if type(QuestLog_Update) == "function" then
    hooksecurefunc("QuestLog_Update", function()
        if not (db and db.quests and QuestLogFrame and QuestLogFrame.IsVisible
            and QuestLogFrame:IsVisible()) then return end
        TranslateQuestLogTitles()
        pcall(WalkQuestUI, QuestLogFrame, 0, {})
        QueueQuestLogTitlePass(0.08)
    end)
end
if QuestLogFrame and QuestLogFrame.HookScript then
    QuestLogFrame:HookScript("OnShow", function()
        TranslateQuestLogTitles()
        TranslateQuestChrome()
        QueueQuestLogTitlePass(0.08)
    end)
end

local questLogTitleWatcher = CreateFrame("Frame")
for _, event in ipairs({ "QUEST_LOG_UPDATE", "QUEST_ACCEPTED", "QUEST_REMOVED",
                          "PLAYER_REGEN_ENABLED" }) do
    pcall(questLogTitleWatcher.RegisterEvent, questLogTitleWatcher, event)
end
questLogTitleWatcher:SetScript("OnEvent", function(self, event)
    if not (db and db.quests and QuestLogFrame and QuestLogFrame.IsVisible
        and QuestLogFrame:IsVisible()) then return end
    if event == "PLAYER_REGEN_ENABLED" and not questLogTitlePassPending then return end
    pcall(TranslateQuestLogTitles)
    QueueQuestLogTitlePass(0.08)
end)

local questTrackerRoots = setmetatable({}, { __mode = "k" })
local questTrackerRootHooked = setmetatable({}, { __mode = "k" })
AES.Perf.questTrackerFontStrings = AES.Perf.questTrackerFontStrings
    or setmetatable({}, { __mode = "k" })
AES.Perf.questTrackerFastPasses = AES.Perf.questTrackerFastPasses or 0

local function HookQuestTrackerFS(fs)
    HookQuestUIFS(fs)
end

local function WalkQuestTracker(root, depth)
    if not (root and root.GetRegions and root.GetChildren) then return end
    depth = depth or 0
    if depth > 8 then return end

    local okRegions, regions = pcall(function() return { root:GetRegions() } end)
    if okRegions then
        for _, region in ipairs(regions) do
            if region and region.IsObjectType and region:IsObjectType("FontString") then
                AES.Perf.questTrackerFontStrings[region] = true
                HookQuestTrackerFS(region)
                local text = region.GetText and region:GetText()
                local pt = text and CachedQuestUIText(text)
                if pt and pt ~= text and QuestUIWritable(region) then
                    pcall(region.SetText, region, pt)
                end
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

local function AddKnownQuestTrackerRoots()
    for _, name in ipairs({
        "QuestWatchFrame", "WatchFrame", "ObjectiveTrackerFrame", "QuestTrackerFrame",
        "AscensionObjectiveTracker", "AscensionQuestTracker"
    }) do
        local frame = _G[name]
        if frame and frame.GetRegions and frame.GetChildren then
            questTrackerRoots[frame] = true
            if frame.HookScript and not questTrackerRootHooked[frame] then
                questTrackerRootHooked[frame] = true
                pcall(frame.HookScript, frame, "OnShow", function(self)
                    if db and db.quests then pcall(WalkQuestTracker, self, 0) end
                end)
            end
        end
    end
end

local function DiscoverQuestTrackerRoots(fullScan)
    AddKnownQuestTrackerRoots()
end

-- Depois do primeiro passeio, os FontStrings se traduzem pelo próprio SetText.
-- O passe curto revisa só o que já foi encontrado; de tempos em tempos fazemos
-- uma volta completa para pegar bloco novo criado com o tracker já aberto.
local function TranslateQuestTrackers(forceTree)
    if not (db and db.quests) then return end

    if not forceTree then
        for fs in pairs(AES.Perf.questTrackerFontStrings) do
            if not fs.IsVisible or fs:IsVisible() then
                local text = fs.GetText and fs:GetText()
                local pt = text and CachedQuestUIText(text)
                if pt and pt ~= text and QuestUIWritable(fs) then
                    pcall(fs.SetText, fs, pt)
                end
            end
        end

        AES.Perf.questTrackerFastPasses = AES.Perf.questTrackerFastPasses + 1
        if AES.Perf.questTrackerFastPasses % 12 ~= 0 then return end
    end

    for root in pairs(questTrackerRoots) do
        if not root.IsVisible or root:IsVisible() then
            WalkQuestTracker(root, 0)
        end
    end
end
AES.TranslateQuestTrackers = TranslateQuestTrackers

local questTrackerWatcher = CreateFrame("Frame")
for _, event in ipairs({ "ADDON_LOADED", "PLAYER_ENTERING_WORLD",
                          "QUEST_WATCH_UPDATE", "QUEST_ACCEPTED", "QUEST_REMOVED",
                          "QUEST_WATCH_LIST_CHANGED", "PLAYER_REGEN_ENABLED" }) do
    pcall(questTrackerWatcher.RegisterEvent, questTrackerWatcher, event)
end

local function QueueQuestTrackerPass(delay, forceTree)
    delay = delay or 0.08
    if AES.Runtime then
        AES.Runtime.After("quest-tracker-pass", delay, function()
            pcall(TranslateQuestTrackers, forceTree)
        end)
    else
        pcall(TranslateQuestTrackers, forceTree)
    end
end

questTrackerWatcher:SetScript("OnEvent", function(self, event, arg1)
    if not (db and db.quests) then return end
    if event == "PLAYER_ENTERING_WORLD" then
        pcall(DiscoverQuestTrackerRoots, true)
        pcall(TranslateQuestTrackers, true)
        QueueQuestTrackerPass(0.20, true)
        return
    elseif event == "ADDON_LOADED" then
        if not AES.Perf.IsRelevantUILoad(arg1) then return end
        pcall(DiscoverQuestTrackerRoots, false)
        QueueQuestTrackerPass(0.15, true)
        return
    elseif event ~= "QUEST_WATCH_UPDATE" then
        QueueQuestTrackerPass(0.06, true)
        return
    end

    QueueQuestTrackerPass(0.06)
end)

local uiFSHooked = setmetatable({}, { __mode = "k" })
local uiFSBusy = setmetatable({}, { __mode = "k" })
function HookUIFS(fs)
    -- Nameplates têm um tradutor próprio em WorldNames.lua. Hookar o SetText delas
    -- aqui faz TranslateStaticText rodar toda vez que um player entra na câmera.
    if not fs or fs.__aptbrWorldName
        or (AES.IsNameplateObject and AES.IsNameplateObject(fs))
        or (FrameExcluded and FrameExcluded(fs)) then return end
    if uiFSHooked[fs] or not fs.SetText then return end
    uiFSHooked[fs] = true

    for _, metodo in ipairs({ "SetText", "SetFormattedText" }) do
        if fs[metodo] then
            pcall(hooksecurefunc, fs, metodo, function(self)
                if uiFSBusy[self] or self.__aptbrWorldName or not (db and db.ui) then return end
                if AES.IsNameplateObject and AES.IsNameplateObject(self) then return end
                if FrameExcluded and FrameExcluded(self) then return end
                if self.IsVisible then
                    local ok, visible = pcall(self.IsVisible, self)
                    if ok and not visible then return end
                end
                local txt = self.GetText and self:GetText()
                if type(txt) ~= "string" or txt == "" then return end

                -- Se esse texto foi escrito pelo proprio tradutor, ele ja esta pronto.
                -- Quando o jogo/addon escrever outro valor, o marcador e descartado e
                -- a nova string pode ser traduzida normalmente.
                if uiFSLastTarget[self] == txt then return end
                uiFSLastTarget[self] = nil

                local es = TranslateStaticText(txt)
                    or (AES.TranslateUnitDescriptorText and AES.TranslateUnitDescriptorText(txt))
                if es and es ~= txt then
                    uiFSBusy[self] = true
                    uiFSLastTarget[self] = es
                    local ok = pcall(self.SetText, self, es)
                    if not ok then uiFSLastTarget[self] = nil end
                    uiFSBusy[self] = nil
                end
            end)
        end
    end
end

local function WalkUIExact(root, depth, hookFS, skip)
    if not (root and root.GetRegions and root.GetChildren) then return end
    if FrameExcluded and FrameExcluded(root) then return end
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
            if es and es ~= t then ApplyStaticFontString(r, t, es) end
            if hookFS then pcall(HookUIFS, r) end
        end
    end
    for _, c in ipairs({ root:GetChildren() }) do
        WalkUIExact(c, depth + 1, hookFS, skip)
    end
end

-- Menu de clique direito nasce sob demanda. Traduz só o botão que acabou de aparecer.
do
    local function TranslateDropDownLevel(level)
        if not (db and db.ui) then return end
        level = tonumber(level) or tonumber(UIDROPDOWNMENU_MENU_LEVEL) or 1
        local list = _G["DropDownList" .. level]
        if not list then return end

        local count = tonumber(list.numButtons)
        local button = count and _G["DropDownList" .. level .. "Button" .. count]
        if button then
            pcall(WalkUIExact, button, 0, true)
        elseif list.IsShown and list:IsShown() then
            pcall(WalkUIExact, list, 0, true)
        end
    end

    local function TranslateVisibleDropDowns()
        if not (db and db.ui) then return end
        for level = 1, 3 do
            local list = _G["DropDownList" .. level]
            if list and list.IsShown and list:IsShown() then
                pcall(WalkUIExact, list, 0, true)
            end
        end
    end

    if type(UIDropDownMenu_AddButton) == "function" then
        pcall(hooksecurefunc, "UIDropDownMenu_AddButton", function(_, level)
            TranslateDropDownLevel(level)
        end)
    end
    if type(ToggleDropDownMenu) == "function" then
        pcall(hooksecurefunc, "ToggleDropDownMenu", function()
            TranslateVisibleDropDowns()
            if AES.Runtime then
                AES.Runtime.After("unit-dropdown", 0.01, TranslateVisibleDropDowns)
            end
        end)
    end
    AES.TranslateVisibleDropDowns = TranslateVisibleDropDowns
end

local function SkipAuctionFilters(nm)
    -- Filtros e linhas de resultado mudam o tempo todo. Nao coloca o hook generico
    -- de FontString nesses elementos; o bloco do leilao cuida deles de forma agrupada.
    return nm:find("AuctionFilterButton", 1, true) ~= nil
        or nm:find("BrowseButton", 1, true) == 1
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

AES.CharacterUIRoots = AES.CharacterUIRoots or {
    "CharacterFrame", "PaperDollFrame", "PetPaperDollFrame", "AscensionCharacterFrame",
    "AscensionCharacterStatsPanel", "AscensionPaperDollPanel", "AllStatsFrame",
    "ReputationFrame", "SkillFrame", "TokenFrame", "CurrencyFrame",
    "TradeSkillFrame", "CraftFrame", "CompanionFrame", "MountJournal",
    "MountCollectionFrame", "CollectionsFrame", "VanityCollectionFrame", "WardrobeFrame",
    "BookOfAscensionFrame", "BookOfArtisansFrame", "ItemTextFrame", "CharacterAdvancementFrame",
}

local function CharacterFrameVisible()
    for _, name in ipairs(AES.CharacterUIRoots) do
        local panel = _G[name]
        if panel and panel.IsVisible then
            local ok, visible = pcall(panel.IsVisible, panel)
            if ok and visible then return true end
        end
    end
    return false
end

local function CharacterStatsVisiblePass()
    if not AES.CharacterUIEnabled() or not CharacterFrameVisible() then return false end
    for _, name in ipairs(AES.CharacterUIRoots) do
        local panel = _G[name]
        if panel then
            pcall(WalkUIExact, panel, 0, false)
            pcall(WalkCharacterStatUI, panel, 0)
        end
    end
    return true
end

local function StopCharacterStatsLivePass()
    charStatsActive = false
    if AES.Runtime then
        AES.Runtime.Cancel("character-frame")
        AES.Runtime.Cancel("character-stats-scroll")
    end
    for tip in pairs(charStatTooltips) do
        charStatTooltips[tip] = nil
        if AES.Runtime then
            AES.Runtime.Cancel(CharacterStatTooltipTaskKey(tip, "early"))
            AES.Runtime.Cancel(CharacterStatTooltipTaskKey(tip, "late"))
        end
    end
end

local function StartCharacterStatsLivePass()
    charStatsActive = CharacterFrameVisible()
end

local function TranslateCharacterFrame()
    if not AES.CharacterUIEnabled() then return end
    StartCharacterStatsLivePass()
    CharacterStatsVisiblePass()
    if AES.Runtime then
        AES.Runtime.Repeat("character-frame", 0.05, 0.10, 3, function()
            return CharacterStatsVisiblePass()
        end)
    end
end

if CharacterFrame and CharacterFrame.HookScript then
    CharacterFrame:HookScript("OnShow", TranslateCharacterFrame)
    if CharacterFrame.HasScript and CharacterFrame:HasScript("OnHide") then
        CharacterFrame:HookScript("OnHide", StopCharacterStatsLivePass)
    end
end
AES.TranslateCharacterFrame = TranslateCharacterFrame

local function DeepPass(panel)
    if not (db and db.ui and panel) then return end
    pcall(WalkUIExact, panel, 0, true)
    if not AES.Runtime then return end

    AES.Runtime.Repeat("deep-panel:" .. tostring(panel), 0.35, 0.35, 1, function()
        if not (db and db.ui) then return false end
        local ok, vis = pcall(panel.IsVisible, panel)
        if not (ok and vis) then return false end
        pcall(WalkUIExact, panel, 0, true)
    end)
end

;(function()
    local serverDeep = setmetatable({}, { __mode = "k" })
    local panelRoots = {
        "TrialsFrame", "TrialFrame", "AscensionTrialsFrame", "AscensionTrialFrame",
        "ChallengesFrame", "AscensionChallengesFrame", "TrialListFrame",
        "TrialsWindow", "TrialWindow", "AscensionTrialsWindow",
        "SupportFrame", "CustomerSupportFrame", "AscensionSupportFrame",
        "ProfessionFrame", "ProfessionsFrame", "AscensionProfessionFrame",
        "CharacterAdvancement", "CharacterAdvancementFrame", "Collections",
        "WildCardRapidRollingFrame", "SkillCardsFrame", "VanityCollectionFrame",
        "DraftHelpFrame", "HelpMenu", "AscensionHelpMenu",
    }

    local function HookPanel(panel)
        if not panel or serverDeep[panel] or FrameExcluded(panel) then return false end
        serverDeep[panel] = true

        if panel.HookScript and panel.HasScript then
            local okHas, hasOnShow = pcall(panel.HasScript, panel, "OnShow")
            if okHas and hasOnShow then
                pcall(panel.HookScript, panel, "OnShow", function(self)
                    DeepPass(self)
                end)
            end
        end

        local okVisible, visible = pcall(function()
            return panel.IsVisible and panel:IsVisible()
        end)
        if okVisible and visible then DeepPass(panel) end
        return true
    end

    -- Antes eram enumerados ate 60 mil frames e qualquer nome iniciado por
    -- "Ascension" era aceito. Nameplates do cliente podiam cair nesse filtro e
    -- receber hooks permanentes. Agora apenas paineis 2D conhecidos sao visitados.
    local function HookKnownPanels()
        if not (db and db.ui) then return end
        for i = 1, #panelRoots do
            local panel = _G[panelRoots[i]]
            if panel then HookPanel(panel) end
        end
    end
    AES.HookServerPanelsDeep = HookKnownPanels

    local watcher = CreateFrame("Frame")
    watcher:RegisterEvent("ADDON_LOADED")
    watcher:RegisterEvent("PLAYER_ENTERING_WORLD")
    watcher:SetScript("OnEvent", function(_, event, name)
        if event ~= "PLAYER_ENTERING_WORLD" and not AES.Perf.IsRelevantUILoad(name) then return end
        if AES.Runtime then
            AES.Runtime.After("server-panels-deep",
                event == "PLAYER_ENTERING_WORLD" and 0.45 or 0.12,
                HookKnownPanels)
        else
            pcall(HookKnownPanels)
        end
    end)
end)()

-- NÃO juntar esse bloco no chunk principal: Lua 5.1 tem limite de 200 locals.
;(function()

do
local auRowCache = {}

local function AuctionVisible()
    local af = _G["AuctionFrame"]
    if not (af and af.IsVisible) then return false end
    local ok, visible = pcall(af.IsVisible, af)
    return ok and visible
end

local function AuctionRowPT(index, t)
    local pre, core, post = t:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
    if not core then pre, core, post = "", t, "" end

    local offset = (FauxScrollFrame_GetOffset and BrowseScrollFrame
        and FauxScrollFrame_GetOffset(BrowseScrollFrame)) or 0
    local link = GetAuctionItemLink and GetAuctionItemLink("list", offset + index)

    -- A mesma linha pode receber varios refreshes durante uma unica busca. Se link e
    -- texto nao mudaram, reaproveita o resultado e evita consultar/traduzir de novo.
    local cached = auRowCache[index]
    if cached and cached.text == t and cached.link == link then
        return cached.pt or nil
    end

    local id = link and tonumber(link:match("item:(%d+)"))
    local ptName = AES.TranslateItemNameText and AES.TranslateItemNameText(core, link, id)
    local pt = ptName and (pre .. ptName .. post) or nil
    auRowCache[index] = { text = t, link = link, pt = pt or false }
    return pt
end

local function TranslateAuctionRows()
    if not (db and db.items) then return end

    local limit = tonumber(_G.NUM_BROWSE_TO_DISPLAY) or 20
    if limit < 1 then limit = 20 end
    if limit > 20 then limit = 20 end

    for i = 1, limit do
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
    ["Back"] = "Capa", ["Tabard"] = "Tabardo", ["Robe"] = "Veste",
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
        -- Se o overlay ja esta correto, nao redesenha sem necessidade.
        local current = ov.GetText and ov:GetText()
        if current ~= pt then pcall(ov.SetText, ov, pt) end
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

-- O AuctionFrame atualiza a mesma lista varias vezes por busca/pagina. Em vez de
-- traduzir dentro de cada SetText, agrupa os refreshes em uma unica tarefa curta.
local function QueueAuctionRows(delay)
    if not (db and db.items) then return end
    if AES.Runtime then
        AES.Runtime.After("auction-row-refresh", delay or 0.01, function()
            if not AuctionVisible() then return false end
            pcall(TranslateAuctionRows)
        end)
    elseif AuctionVisible() then
        pcall(TranslateAuctionRows)
    end
end

local function QueueAuctionCats(delay, key)
    if AES.catTrans == false or not (db and db.ui) then return end
    if AES.Runtime then
        AES.Runtime.After(key or "auction-category-refresh", delay or 0.03, function()
            if not AuctionVisible() then return false end
            pcall(TranslateAuctionCats)
        end)
    elseif AuctionVisible() then
        pcall(TranslateAuctionCats)
    end
end

local auFnHooked = false
local function HookAuctionFuncs()
    if auFnHooked then return end
    auFnHooked = true

    for _, fn in ipairs({ "AuctionFrameFilters_UpdateClasses", "AuctionFrameFilters_Update" }) do
        if type(_G[fn]) == "function" then
            hooksecurefunc(fn, function()
                QueueAuctionCats(0.03)
            end)
        end
    end

    if type(AuctionFrameBrowse_Update) == "function" then
        hooksecurefunc("AuctionFrameBrowse_Update", function()
            QueueAuctionRows(0.01)
        end)
    end
end
AES.HookAuctionFuncs = HookAuctionFuncs

local liveListWatcher = CreateFrame("Frame")
liveListWatcher:RegisterEvent("TRADE_SKILL_SHOW")
liveListWatcher:RegisterEvent("TRADE_SKILL_UPDATE")
liveListWatcher:RegisterEvent("AUCTION_HOUSE_SHOW")
liveListWatcher:RegisterEvent("AUCTION_HOUSE_CLOSED")
liveListWatcher:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
liveListWatcher:SetScript("OnEvent", function(_, event)
    if not db then return end

    if event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_UPDATE" then
        if db.ui and TradeSkillFrame then pcall(WalkUIExact, TradeSkillFrame, 0, true) end
        return
    end

    if event == "AUCTION_HOUSE_CLOSED" then
        auRowCache = {}
        if AES.Runtime then
            AES.Runtime.Cancel("auction-row-refresh")
            AES.Runtime.Cancel("auction-category-refresh")
            AES.Runtime.Cancel("auction-category-late")
        end
        return
    end

    HookAuctionFuncs()

    if event == "AUCTION_HOUSE_SHOW" then
        if db.ui and AuctionFrame then
            pcall(WalkUIExact, AuctionFrame, 0, true, SkipAuctionFilters)
        end
        QueueAuctionRows(0.02)
        QueueAuctionCats(0.03)
        -- Um unico repasse tardio cobre categorias criadas depois da abertura.
        QueueAuctionCats(0.20, "auction-category-late")
        return
    end

    -- O leilão dispara esse evento várias vezes. A mesma chave junta os refreshes.
    QueueAuctionRows(0.02)
end)

end


-- Nameplates ficam no WorldNames.lua. Nada de vasculhar o WorldFrame por aqui.
-- para não manter OnUpdate, weak tables e hooks duplicados no Core.

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

local function WalkTranslateNpcRoles(root)
    if not (root and root.GetRegions and root.GetChildren and AES.TranslateNpcRoleText) then return end
    local function visit(fr, depth)
        if depth > 6 then return end
        for _, r in ipairs({ fr:GetRegions() }) do
            if r.IsObjectType and r:IsObjectType("FontString") and r.GetText then
                local shown = r:GetText()
                local translated = shown and AES.TranslateNpcRoleText(shown)
                if translated and translated ~= shown then pcall(r.SetText, r, translated) end
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

    local ptName = id and AES.UnitName and AES.UnitName[id]
    local enName = UnitName and UnitName(unit)
    local guardName = id and AES.UnitNameEN and AES.UnitNameEN[id]
    local canName = ptName and enName and ptName ~= enName
        and (not guardName or guardName == enName)

    local enSub = id and AES.UnitSubEN and AES.UnitSubEN[id]
    local ptSub = id and select(1, ResolveSafeNpcSubtitleByID(id, enSub))
    local canSub = type(enSub) == "string" and enSub ~= ""
        and type(ptSub) == "string" and ptSub ~= "" and enSub ~= ptSub

    for _, rn in ipairs(UNITFRAME_ROOTS) do
        local root = _G[rn]
        if canName then WalkReplaceExact(root, enName, ptName) end
        if canSub then
            WalkReplaceExact(root, enSub, ptSub)
            WalkReplaceExact(root, "<" .. enSub .. ">", "<" .. ptSub .. ">")
        end
        WalkTranslateNpcRoles(root)
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
    local es = name and AES.TranslateSpellNameText(name)
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

end)()

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

-- O bootstrap/event frame também fica isolado do chunk principal. Isso cria uma
-- margem real abaixo do limite de 200 locals do Lua 5.1, evitando que o próximo
-- hotfix volte a estourar só por adicionar mais uma variável local.
;(function()
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "PLAYER_ENTERING_WORLD" then
        if AES.ApplySafeGlobalStrings then pcall(AES.ApplySafeGlobalStrings) end
        if AES.RepairTooltipColors then pcall(AES.RepairTooltipColors) end
        if AES.ApplyWorldNpcNameplates then pcall(AES.ApplyWorldNpcNameplates) end
        HookStaticPanels()
        if QuestLogFrame and QuestLogFrame.IsVisible and QuestLogFrame:IsVisible() then
            pcall(TranslateQuestLogTitles)
            QueueQuestLogTitlePass(0.12)
        end

        local acf = _G["AscensionCharacterFrame"]
        if acf and acf.HookScript and not AES._charHooked then
            AES._charHooked = true
            acf:HookScript("OnShow", TranslateCharacterFrame)
            if acf.HasScript and acf:HasScript("OnHide") then
                acf:HookScript("OnHide", StopCharacterStatsLivePass)
            end

            local statsScroll = _G["AscensionCharacterStatsPanelScrollFrame"]
            local function OnStatsScroll()
                if not AES.CharacterUIEnabled() then return end
                if not CharacterFrameVisible() then return end
                pcall(WalkUIExact, _G["AscensionCharacterStatsPanel"], 0, false)
                pcall(WalkCharacterStatUI, _G["AscensionCharacterStatsPanel"], 0)
                StartCharacterStatsLivePass()
                if AES.Runtime then
                    AES.Runtime.After("character-stats-scroll", 0.08, function()
                        if not CharacterFrameVisible() then return end
                        pcall(WalkUIExact, _G["AscensionCharacterStatsPanel"], 0, false)
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

    if AES.ApplySafeGlobalStrings then pcall(AES.ApplySafeGlobalStrings) end
    if AES.ApplyOfficialDisplayGlobals then
        pcall(AES.ApplyOfficialDisplayGlobals, db)
    end
    if AES.RepairTooltipColors then pcall(AES.RepairTooltipColors) end

    -- Lixo de opção antiga. Se vier de versão velha, limpa no carregamento.
    for _, key in ipairs({ "capture", "captured", "uicaptured", "qcaptured",
                            "gcaptured", "scaptured", "globalscaptured",
                            "sonda", "marcos", "qdrift", "qsex" }) do
        db[key] = nil
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

    AES.UnitSubEN2PT = {}
    for id, en in pairs(AES.UnitSubEN or {}) do
        local pt = AES.UnitSub and AES.UnitSub[id]
        local ptName = AES.UnitName and AES.UnitName[id]
        local enName = AES.UnitNameEN and AES.UnitNameEN[id]
        local safe = type(pt) == "string" and pt ~= ""
            and (type(ptName) ~= "string" or pt:lower():gsub("%s+", " ") ~= ptName:lower():gsub("%s+", " "))
            and (type(enName) ~= "string" or pt:lower():gsub("%s+", " ") ~= enName:lower():gsub("%s+", " "))
        if type(en) == "string" and en ~= "" and safe and en ~= pt then
            local prior = AES.UnitSubEN2PT[en]
            if prior == nil then
                AES.UnitSubEN2PT[en] = pt
            elseif prior ~= pt then
                AES.UnitSubEN2PT[en] = false
            end
        end
    end
    for en, pt in pairs(AES.UnitSubEN2PT) do
        if pt == false then AES.UnitSubEN2PT[en] = nil end
    end
    -- Vários IDs com o mesmo EN? Essa lista decide qual PT ganha.
    for en, pt in pairs(AES.UnitNamePreferredEN2PT or {}) do
        if type(en) == "string" and type(pt) == "string" and pt ~= "" then
            AES.UnitNameEN2ES[en] = pt
        end
    end

    if AES.ApplyWorldNpcNameplates then pcall(AES.ApplyWorldNpcNameplates) end

-- Não ressuscitar o índice completo de quests: duplicava texto demais na memória.
    AES.QuestRuntimeTextByID = nil
    AES.QuestRuntimeTextNormalized = nil

    AES.QuestTitleEN2ES = {}
    AES.QuestTitleEN2ID = {}
    AES.QuestTitleES2ID = {}
    AES.QuestTitleEN2IDs = {}
    AES.QuestTitleES2IDs = {}
    AES.QuestObjectiveEN2PT = {}
    AES.QuestObjectivePartEN2PT = {}
    AES.QuestObjectiveNormalizedEN2PT = {}
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
                    -- Sem ID e com duas traduções possíveis? Deixa original. Melhor que chutar.
                    AES.QuestTextEN2PT[en] = false
                end
                if field == "o" then
                    prior = AES.QuestObjectiveEN2PT[en]
                    if prior == nil then
                        AES.QuestObjectiveEN2PT[en] = pt
                    elseif prior ~= pt then
                        AES.QuestObjectiveEN2PT[en] = false
                    end

                    -- Tracker às vezes quebra o objetivo em linhas; guarda só esses pedaços.
                    local hasLayout = en:find("\\n", 1, true) or en:find("|n", 1, true)
                        or en:find("\n", 1, true) or en:find("  ", 1, true)
                    local enShown = en:gsub("\\n", "\n"):gsub("|n", "\n"):gsub("\r", "")
                    local ptShown = pt:gsub("\\n", "\n"):gsub("|n", "\n"):gsub("\r", "")
                    if hasLayout then
                        local enNorm = CollapseWS(enShown)
                        local ptNorm = CollapseWS(ptShown)
                        prior = AES.QuestObjectiveNormalizedEN2PT[enNorm]
                        if prior == nil then
                            AES.QuestObjectiveNormalizedEN2PT[enNorm] = ptNorm
                        elseif prior ~= ptNorm then
                            AES.QuestObjectiveNormalizedEN2PT[enNorm] = false
                        end
                    end

                    local enParts, ptParts = {}, {}
                    for line in (enShown .. "\n"):gmatch("(.-)\n") do
                        line = line:gsub("^%s+", ""):gsub("%s+$", "")
                        if line ~= "" then enParts[#enParts + 1] = line end
                    end
                    for line in (ptShown .. "\n"):gmatch("(.-)\n") do
                        line = line:gsub("^%s+", ""):gsub("%s+$", "")
                        if line ~= "" then ptParts[#ptParts + 1] = line end
                    end
                    if #enParts > 1 and #enParts == #ptParts then
                        for i = 1, #enParts do
                            local enPart, ptPart = enParts[i], ptParts[i]
                            prior = AES.QuestObjectivePartEN2PT[enPart]
                            if prior == nil then
                                AES.QuestObjectivePartEN2PT[enPart] = ptPart
                            elseif prior ~= ptPart then
                                AES.QuestObjectivePartEN2PT[enPart] = false
                            end
                        end
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
    if QuestLogFrame and QuestLogFrame.IsVisible and QuestLogFrame:IsVisible() then
        pcall(TranslateQuestLogTitles)
        QueueQuestLogTitlePass(0.08)
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
        if AES.RepairTooltipColors then pcall(AES.RepairTooltipColors) end
        if db and db.ui and type(name) == "string"
            and (name:find("Ascension", 1, true) or name:find("Blizzard_", 1, true))
            and AES.ApplySafeGlobalStrings then
            pcall(AES.ApplySafeGlobalStrings)
        end
        if name == "Blizzard_Calendar" and AES.ApplyCalendarGlobalStrings then
            pcall(AES.ApplyCalendarGlobalStrings)
            pcall(HookStaticPanels)
        end
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
end)()


-- /aptbr pertence ao painel de opções (Config.lua). Mantemos os comandos técnicos
-- em aliases próprios para não registrar o mesmo slash duas vezes.
SLASH_ASCENSIONPTBR1 = "/ascensionptbr"
SLASH_ASCENSIONPTBR2 = "/aptbrcmd"
SlashCmdList["ASCENSIONPTBR"] = function(msg)
    msg = (msg or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
    local function status(v) return v and "|cff33ff99SIM|r" or "|cffff3333NÃO|r" end

    if msg == "feitiços" or msg == "feiticos" or msg == "magias" or msg == "spells" then
        db.spells = not db.spells
    elseif msg == "itens" or msg == "items" then
        db.items = not db.items
    elseif msg == "npcs" or msg == "units" then
        db.units = not db.units
        if AES.ApplyWorldNpcNameplates then pcall(AES.ApplyWorldNpcNameplates) end
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
        HookStaticPanels()
        if AES.RefreshCharacterUI then pcall(AES.RefreshCharacterUI, true) end
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r painéis conhecidos retraduzidos.")
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

function AES.RunDiagnostics()
    local memoryKB = collectgarbage and collectgarbage("count") or 0
    local taskCount = 0
    if AES.Runtime and AES.Runtime.tasks then
        for _ in pairs(AES.Runtime.tasks) do taskCount = taskCount + 1 end
    end
    local moduleCount = 0
    if AES.Runtime and AES.Runtime.modules then
        for _ in pairs(AES.Runtime.modules) do moduleCount = moduleCount + 1 end
    end
    local trackerRoots, trackerTexts = 0, 0
    for _ in pairs(questTrackerRoots) do trackerRoots = trackerRoots + 1 end
    for _ in pairs(AES.Perf.questTrackerFontStrings or {}) do trackerTexts = trackerTexts + 1 end
    local skipped = AES.Perf and tonumber(AES.Perf.globalStringFormatSkips) or 0
    local drift = AES.Perf and tonumber(AES.Perf.questDriftCount) or 0
    local diag = AES.Diagnostics or {}
    local char = AES.GetCharacterUIDiagnostics and AES.GetCharacterUIDiagnostics() or {}
    local world = AES.GetWorldNameDiagnostics and AES.GetWorldNameDiagnostics() or {}
    local activeFeatures = {}
    for _, info in ipairs({
        { "spells", "feitiços" }, { "items", "itens" }, { "units", "NPCs" },
        { "quests", "missões" }, { "gossip", "diálogos" }, { "chat", "chat" },
        { "ui", "interface" }, { "characterUI", "C" }, { "worldNames", "placas" },
        { "voice", "vozes" },
    }) do
        if not db or db[info[1]] ~= false then activeFeatures[#activeFeatures + 1] = info[2] end
    end
    local tooltipName = "nenhum"
    for _, name in ipairs({ "GameTooltip", "ItemRefTooltip", "ShoppingTooltip1", "ShoppingTooltip2" }) do
        local tip = _G[name]
        if tip and tip.IsVisible and tip:IsVisible() then
            tooltipName = tip.GetName and tip:GetName() or "tooltip sem nome"
            break
        end
    end
    local version = GetAddOnMetadata and GetAddOnMetadata("AscensionPTBR", "Version") or "1.5.1"
    local combat = InCombatLockdown and InCombatLockdown() and "SIM" or "NÃO"
    local lastError = tostring(diag.lastRuntimeError or "nenhum")
    if #lastError > 180 then lastError = lastError:sub(1, 177) .. "..." end

    DEFAULT_CHAT_FRAME:AddMessage(format(
        "|cff33ff99AscensionPTBR|r diagnóstico v%s | combate=%s | memória Lua=%.1f MB",
        tostring(version), combat, (tonumber(memoryKB) or 0) / 1024))
    DEFAULT_CHAT_FRAME:AddMessage(format(
        "  módulos=%d | tarefas=%d | cache de quests=%d | cache de padrões=%d",
        moduleCount, taskCount, tonumber(questUITextCacheCount) or 0,
        tonumber(AES.Perf.linePatternCacheCount) or 0))
    DEFAULT_CHAT_FRAME:AddMessage("  ativos: " .. table.concat(activeFeatures, ", "))
    DEFAULT_CHAT_FRAME:AddMessage(format(
        "  rastreador: raízes=%d textos=%d | painel C=%s raízes=%d | tooltip=%s | pendentes=%d",
        trackerRoots, trackerTexts, tostring(char.panel or "nenhum"),
        tonumber(char.roots) or 0, tooltipName, tonumber(char.pending) or 0))
    DEFAULT_CHAT_FRAME:AddMessage(format(
        "  nameplates=%d cacheNPC=%d | ações adiadas=%d | skips de quest=%d",
        tonumber(world.plates) or 0, tonumber(world.roleIDs) or 0,
        tonumber(diag.protectedDeferrals) or 0, tonumber(diag.questProtectedSkips) or 0))
    DEFAULT_CHAT_FRAME:AddMessage(format(
        "  último bloqueio=%s (%s) | última ação protegida=%s",
        tostring(diag.lastBlockedFunction or "nenhum"), tostring(diag.lastBlockedEvent or "sem evento"),
        tostring(diag.lastProtectedDeferral or diag.lastProtectedAction or "nenhuma")))
    DEFAULT_CHAT_FRAME:AddMessage(format(
        "  erros do scheduler=%d | último erro=%s | formatos protegidos=%d | divergências de quest=%d",
        tonumber(diag.runtimeErrorCount) or 0, lastError, skipped or 0, drift or 0))
end

SLASH_APTBRDIAG1 = "/aptbrdiag"
SlashCmdList["APTBRDIAG"] = AES.RunDiagnostics

AscensionPTBR.__firma = "AscensionPTBR/1.5.2/AscensionES-1.5.9/2026-08-24"
