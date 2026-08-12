AscensionPTBR = AscensionPTBR or {}

local A = AscensionPTBR

-- Fica separado da UI geral porque a ficha do personagem atualiza isso direto.
A.CharacterStatExact = {
    ["Attributes"] = "Atributos",
    ["General"] = "Geral",
    ["Melee"] = "Corpo a corpo",
    ["Ranged"] = "À distância",
    ["Spell"] = "Feitiços",
    ["Spells"] = "Feitiços",
    ["Defenses"] = "Defesas",
    ["Resistances"] = "Resistências",

    ["Strength"] = "Força",
    ["Agility"] = "Agilidade",
    ["Stamina"] = "Vigor",
    ["Intellect"] = "Intelecto",
    ["Spirit"] = "Espírito",
    ["Health"] = "Vida",
    ["Power"] = "Poder",
    ["Mana"] = "Mana",
    ["Mana Regen"] = "Regeneração de mana",
    ["Mana Regeneration"] = "Regeneração de mana",
    ["Health Regen"] = "Regeneração de vida",
    ["Health Regeneration"] = "Regeneração de vida",
    ["Movement Speed"] = "Velocidade de movimento",
    ["Item Level"] = "Nível do item",
    ["Prestige Level"] = "Nível de prestígio",

    ["Damage"] = "Dano",
    ["Weapon Damage"] = "Dano da arma",
    ["Weapon Speed"] = "Velocidade da arma",
    ["Damage Per Second"] = "Dano por segundo",
    ["DPS"] = "DPS",
    ["Attack Power"] = "Poder de ataque",
    ["Melee Attack Power"] = "Poder de ataque corpo a corpo",
    ["Ranged Attack Power"] = "Poder de ataque à distância",
    ["Spell Power"] = "Poder mágico",
    ["Bonus Damage"] = "Bônus de dano",
    ["Bonus Healing"] = "Bônus de cura",

    ["Increases attack power with melee weapons."] =
        "Aumenta o poder de ataque com armas corpo a corpo.",
    ["Increases the amount of damage that can be blocked with a shield."] =
        "Aumenta a quantidade de dano que pode ser bloqueada com um escudo.",
    ["Increases attack power with both melee and ranged weapons, and improves chance to score a critical hit with all weapons."] =
        "Aumenta o poder de ataque com armas corpo a corpo e à distância e a chance de acerto crítico com todas as armas.",
    ["Increases attack power with both melee and ranged weapons, and improves the chance to score a critical hit with all weapons."] =
        "Aumenta o poder de ataque com armas corpo a corpo e à distância e a chance de acerto crítico com todas as armas.",
    ["Increases attack power with ranged weapons."] =
        "Aumenta o poder de ataque com armas à distância.",
    ["Improves chance to score a critical hit with all weapons."] =
        "Aumenta a chance de acerto crítico com todas as armas.",
    ["Increases armor and chance to dodge attacks."] =
        "Aumenta a armadura e a chance de esquivar de ataques.",
    ["Increases mana points and chance to score a critical hit with spells."] =
        "Aumenta os pontos de mana e a chance de acerto crítico com feitiços.",
    ["Increases the rate at which weapon skills improve."] =
        "Aumenta a taxa de melhoria das perícias com armas.",
    ["Increases health and mana regeneration rates."] =
        "Aumenta as taxas de regeneração de vida e mana.",
    ["Increases health points."] = "Aumenta os pontos de vida.",
    ["Increases health points"] = "Aumenta os pontos de vida",

    ["Hit"] = "Acerto",
    ["Hit Chance"] = "Chance de acerto",
    ["Hit Rating"] = "Índice de acerto",
    ["Melee Hit"] = "Acerto corpo a corpo",
    ["Ranged Hit"] = "Acerto à distância",
    ["Spell Hit"] = "Acerto com feitiços",
    ["Off-Hand Hit"] = "Acerto com a mão secundária",
    ["Off Hand Hit"] = "Acerto com a mão secundária",
    ["Crit"] = "Crítico",
    ["Crit Chance"] = "Chance de acerto crítico",
    ["Crit Rating"] = "Índice de acerto crítico",
    ["Critical Strike"] = "Acerto crítico",
    ["Critical Strike Chance"] = "Chance de acerto crítico",
    ["Critical Strike Rating"] = "Índice de acerto crítico",
    ["Haste"] = "Aceleração",
    ["Haste Rating"] = "Índice de aceleração",
    ["Expertise"] = "Aptidão",
    ["Expertise Rating"] = "Índice de aptidão",
    ["Armor Penetration"] = "Penetração de armadura",
    ["Armor Penetration Rating"] = "Índice de penetração de armadura",
    ["Spell Penetration"] = "Penetração de feitiço",
    ["Penetration"] = "Penetração",

    ["Armor"] = "Armadura",
    ["Defense"] = "Defesa",
    ["Defense Rating"] = "Índice de defesa",
    ["Dodge"] = "Esquiva",
    ["Dodge Chance"] = "Chance de esquiva",
    ["Dodge Rating"] = "Índice de esquiva",
    ["Parry"] = "Aparo",
    ["Parry Chance"] = "Chance de aparo",
    ["Parry Rating"] = "Índice de aparo",
    ["Block"] = "Bloqueio",
    ["Block Chance"] = "Chance de bloqueio",
    ["Block Rating"] = "Índice de bloqueio",
    ["Block Value"] = "Valor de bloqueio",
    ["Resilience"] = "Resiliência",
    ["Resilience Rating"] = "Índice de resiliência",
    ["Before diminishing returns"] = "Antes dos retornos decrescentes",
    ["(Before diminishing returns)"] = "(Antes dos retornos decrescentes)",

    ["Arcane Resistance"] = "Resistência ao Arcano",
    ["Fire Resistance"] = "Resistência ao Fogo",
    ["Nature Resistance"] = "Resistência à Natureza",
    ["Frost Resistance"] = "Resistência ao Gelo",
    ["Shadow Resistance"] = "Resistência à Sombra",
    ["Holy Resistance"] = "Resistência ao Sagrado",

    ["Crit Chance scales primarily from Crit Rating, and Agility."] =
        "A chance de acerto crítico é determinada principalmente pelo Índice de Acerto Crítico e pela Agilidade.",
    ["Crit Chance scales primarily from Crit Rating, and Intellect."] =
        "A chance de acerto crítico é determinada principalmente pelo Índice de Acerto Crítico e pelo Intelecto.",
    ["Crit Chance scales primarily from Crit Rating."] =
        "A chance de acerto crítico é determinada principalmente pelo Índice de Acerto Crítico.",
    ["Hit Chance scales primarily from Hit Rating."] =
        "A chance de acerto é determinada principalmente pelo Índice de Acerto.",
    ["Haste scales primarily from Haste Rating."] =
        "A aceleração é determinada principalmente pelo Índice de Aceleração.",
}

A.CharacterStatPatterns = {
    { "^Crit rating ([%d%.,]+) %(%+([%d%.,]+)%% crit chance%)$",
      "Índice de acerto crítico %1 (+%2%% de chance de acerto crítico)" },
    { "^Critical Strike Rating ([%d%.,]+) %(%+([%d%.,]+)%% crit chance%)$",
      "Índice de acerto crítico %1 (+%2%% de chance de acerto crítico)" },
    { "^Haste rating ([%d%.,]+) %(([%d%.,]+)%% haste%)$",
      "Índice de aceleração %1 (%2%% de aceleração)" },
    { "^Haste Rating ([%d%.,]+) %(([%d%.,]+)%% haste%)$",
      "Índice de aceleração %1 (%2%% de aceleração)" },

    { "^Increases your melee chance to hit a target of level (%d+) by ([%d%.,]+)%% %(([%+%-]?[%d%.,]+)%%%)$",
      "Aumenta sua chance de acertar ataques corpo a corpo contra um alvo de nível %1 em %2%% (%3%%)" },
    { "^Increases your ranged chance to hit a target of level (%d+) by ([%d%.,]+)%% %(([%+%-]?[%d%.,]+)%%%)$",
      "Aumenta sua chance de acertar ataques à distância contra um alvo de nível %1 em %2%% (%3%%)" },
    { "^Increases your spell chance to hit a target of level (%d+) by ([%d%.,]+)%% %(([%+%-]?[%d%.,]+)%%%)$",
      "Aumenta sua chance de acertar feitiços contra um alvo de nível %1 em %2%% (%3%%)" },
    { "^Increases your melee chance to hit a target of level (%d+) by ([%d%.,]+)%%%.?$",
      "Aumenta sua chance de acertar ataques corpo a corpo contra um alvo de nível %1 em %2%%." },
    { "^Increases your ranged chance to hit a target of level (%d+) by ([%d%.,]+)%%%.?$",
      "Aumenta sua chance de acertar ataques à distância contra um alvo de nível %1 em %2%%." },
    { "^Increases your spell chance to hit a target of level (%d+) by ([%d%.,]+)%%%.?$",
      "Aumenta sua chance de acertar feitiços contra um alvo de nível %1 em %2%%." },

    { "^([%d%.,]+)%% chance to hit is required to never miss a raid boss%.$",
      "É necessário ter %1%% de chance de acerto para nunca errar um chefe de raide." },
    { "^([%d%.,]+)%% chance to hit is required to never miss a player%.$",
      "É necessário ter %1%% de chance de acerto para nunca errar um jogador." },
    { "^([%d%.,]+)%% spell hit chance is required to never miss a raid boss%.$",
      "É necessário ter %1%% de chance de acerto com feitiços para nunca errar um chefe de raide." },
    { "^([%d%.,]+)%% spell hit chance is required to never miss a player%.$",
      "É necessário ter %1%% de chance de acerto com feitiços para nunca errar um jogador." },

    { "^Dodge Rating of ([%d%.,]+) adds ([%d%.,]+)%% Dodge$",
      "Índice de esquiva %1 concede %2%% de esquiva" },
    { "^Parry Rating of ([%d%.,]+) adds ([%d%.,]+)%% Parry$",
      "Índice de aparo %1 concede %2%% de aparo" },
    { "^Block Rating of ([%d%.,]+) adds ([%d%.,]+)%% Block$",
      "Índice de bloqueio %1 concede %2%% de bloqueio" },
    { "^Your block stops ([%d%.,]+) damage%.$",
      "Seu bloqueio impede %1 de dano." },
    { "^Before diminishing returns$", "Antes dos retornos decrescentes" },
    { "^%(Before diminishing returns%)$", "(Antes dos retornos decrescentes)" },

    { "^Defense Rating ([%d%.,]+) %(%+([%d%.,]+) Defense%)$",
      "Índice de defesa %1 (+%2 de Defesa)" },
    { "^Increases chance to Dodge, Block and Parry by ([%d%.,]+)%%$",
      "Aumenta em %1%% a chance de esquivar, bloquear e aparar" },
    { "^Decreases chance to be hit and critically hit by ([%d%.,]+)%%$",
      "Reduz em %1%% a chance de ser atingido e sofrer um acerto crítico" },

    { "^Reduces chance to be dodged or parried by (.+)$",
      "Reduz em %1 a chance de seus ataques serem esquivados ou aparados" },
    { "^Expertise rating ([%d%.,]+) %(%+([%d%.,]+) expertise%)$",
      "Índice de aptidão %1 (+%2 de aptidão)" },

    { "^Armor penetration rating ([%d%.,]+) %(Enemy armor reduced by up to ([%d%.,]+)%%%)%.$",
      "Índice de penetração de armadura %1 (armadura inimiga reduzida em até %2%%)." },
    { "^Armor Penetration Rating ([%d%.,]+) %(Enemy Armor Reduced by up to ([%d%.,]+)%%%)%.$",
      "Índice de penetração de armadura %1 (armadura inimiga reduzida em até %2%%)." },
    { "^Spell Penetration ([%d%.,]+) %(Reduces enemy resistances by ([%d%.,]+)%)$",
      "Penetração de feitiço %1 (reduz as resistências inimigas em %2)" },

    { "^Reduces chance to be critically hit by ([%d%.,]+)%%%.$",
      "Reduz em %1%% a chance de você sofrer um acerto crítico." },
    { "^Reduces the effect of mana%-drains and the damage of critical strikes by ([%d%.,]+)%%%.$",
      "Reduz em %1%% o efeito de drenagens de mana e o dano de acertos críticos." },
    { "^Provides ([%d%.,]+)%% additional damage reduction against all damage done by players and their pets or minions%.$",
      "Concede %1%% de redução adicional contra todo o dano causado por jogadores e seus mascotes ou lacaios." },

    { "^Increases the ability to resist (.+)%-based attacks, spells and abilities%.$",
      "Aumenta a capacidade de resistir a ataques, feitiços e habilidades baseados em %1." },
    { "^Resistance against level (%d+): (.+)$",
      "Resistência contra nível %1: %2" },

    { "^Increases damage with melee weapons by ([%d%.,]+) damage per second%.$",
      "Aumenta em %1 o dano por segundo com armas corpo a corpo." },
    { "^Increases damage with ranged weapons by ([%d%.,]+) damage per second%.$",
      "Aumenta em %1 o dano por segundo com armas à distância." },
    { "^Increases melee attack power by ([%d%.,]+)%.$",
      "Aumenta o poder de ataque corpo a corpo em %1." },
    { "^Increases ranged attack power by ([%d%.,]+)%.$",
      "Aumenta o poder de ataque à distância em %1." },
    { "^Increases spell power by ([%d%.,]+)%.$",
      "Aumenta o poder mágico em %1." },
    { "^Increases your spell power by ([%d%.,]+)%.$",
      "Aumenta seu poder mágico em %1." },
    { "^Increases attack power by ([%d%.,]+)%.$",
      "Aumenta o poder de ataque em %1." },
    { "^Increases your attack power by ([%d%.,]+)%.$",
      "Aumenta seu poder de ataque em %1." },
    { "^Increases your hit rating by ([%d%.,]+)%.$",
      "Aumenta seu índice de acerto em %1." },
    { "^Increases your critical strike rating by ([%d%.,]+)%.$",
      "Aumenta seu índice de acerto crítico em %1." },
    { "^Increases your crit rating by ([%d%.,]+)%.$",
      "Aumenta seu índice de acerto crítico em %1." },
    { "^Increases your haste rating by ([%d%.,]+)%.$",
      "Aumenta seu índice de aceleração em %1." },
    { "^Increases your defense rating by ([%d%.,]+)%.$",
      "Aumenta seu índice de defesa em %1." },
    { "^Increases spell penetration by ([%d%.,]+)%.$",
      "Aumenta a penetração de feitiço em %1." },
    { "^Increases your armor penetration rating by ([%d%.,]+)%.$",
      "Aumenta seu índice de penetração de armadura em %1." },
    { "^Increases your expertise rating by ([%d%.,]+)%.$",
      "Aumenta seu índice de aptidão em %1." },
    { "^Increases your dodge rating by ([%d%.,]+)%.$",
      "Aumenta seu índice de esquiva em %1." },
    { "^Increases your parry rating by ([%d%.,]+)%.$",
      "Aumenta seu índice de aparo em %1." },
    { "^Increases your resilience rating by ([%d%.,]+)%.$",
      "Aumenta seu índice de resiliência em %1." },
    { "^Increases your shield block rating by ([%d%.,]+)%.$",
      "Aumenta seu índice de bloqueio com escudo em %1." },
    { "^Increases the block value of your shield by ([%d%.,]+)%.$",
      "Aumenta o valor de bloqueio do seu escudo em %1." },

    { "^Improves critical avoidance rating by ([%d%.,]+)%.$",
      "Aumenta em %1 o índice para evitar acertos críticos." },
    { "^Improves critical strike rating by ([%d%.,]+)%.$",
      "Aumenta o índice de acerto crítico em %1." },
    { "^Improves haste rating by ([%d%.,]+)%.$",
      "Aumenta o índice de aceleração em %1." },
    { "^Improves hit avoidance rating by ([%d%.,]+)%.$",
      "Aumenta em %1 o índice para evitar acertos." },
    { "^Improves hit rating by ([%d%.,]+)%.$",
      "Aumenta o índice de acerto em %1." },
    { "^Improves melee critical avoidance rating by ([%d%.,]+)%.$",
      "Aumenta em %1 o índice para evitar acertos críticos corpo a corpo." },
    { "^Improves melee critical strike rating by ([%d%.,]+)%.$",
      "Aumenta o índice de acerto crítico corpo a corpo em %1." },
    { "^Improves melee haste rating by ([%d%.,]+)%.$",
      "Aumenta o índice de aceleração corpo a corpo em %1." },
    { "^Improves melee hit avoidance rating by ([%d%.,]+)%.$",
      "Aumenta em %1 o índice para evitar acertos corpo a corpo." },
    { "^Improves melee hit rating by ([%d%.,]+)%.$",
      "Aumenta o índice de acerto corpo a corpo em %1." },
    { "^Improves ranged critical avoidance rating by ([%d%.,]+)%.$",
      "Aumenta em %1 o índice para evitar acertos críticos à distância." },
    { "^Improves ranged critical strike rating by ([%d%.,]+)%.$",
      "Aumenta o índice de acerto crítico à distância em %1." },
    { "^Improves ranged haste rating by ([%d%.,]+)%.$",
      "Aumenta o índice de aceleração à distância em %1." },
    { "^Improves ranged hit avoidance rating by ([%d%.,]+)%.$",
      "Aumenta em %1 o índice para evitar acertos à distância." },
    { "^Improves ranged hit rating by ([%d%.,]+)%.$",
      "Aumenta o índice de acerto à distância em %1." },
    { "^Improves spell critical avoidance rating by ([%d%.,]+)%.$",
      "Aumenta em %1 o índice para evitar acertos críticos com feitiços." },
    { "^Improves spell critical strike rating by ([%d%.,]+)%.$",
      "Aumenta o índice de acerto crítico com feitiços em %1." },
    { "^Improves spell haste rating by ([%d%.,]+)%.$",
      "Aumenta o índice de aceleração com feitiços em %1." },
    { "^Improves spell hit avoidance rating by ([%d%.,]+)%.$",
      "Aumenta em %1 o índice para evitar acertos com feitiços." },
    { "^Improves spell hit rating by ([%d%.,]+)%.$",
      "Aumenta o índice de acerto com feitiços em %1." },
    { "^Improves your resilience rating by ([%d%.,]+)%.$",
      "Aumenta seu índice de resiliência em %1." },

    { "^Increases Attack Power by ([%d%.,]+)$",
      "Aumenta o poder de ataque em %1." },
    { "^Increases Block Value by ([%d%.,]+)$",
      "Aumenta o valor de bloqueio em %1." },
    { "^Increases Health by ([%d%.,]+)$",
      "Aumenta a vida em %1." },
    { "^Increases Health Regeneration by ([%d%.,]+) Per Second while not in combat$",
      "Aumenta a regeneração de vida em %1 por segundo enquanto estiver fora de combate." },
    { "^Increases Mana Regeneration by ([%d%.,]+) Per 5 Seconds while not casting$",
      "Aumenta a regeneração de mana em %1 a cada 5 s enquanto não lança feitiços." },
    { "^Increases your healing by up to ([%d%.,]+)$",
      "Aumenta sua cura em até %1." },
    { "^Restores ([%d%.,]+) health per 5 sec%.$",
      "Restaura %1 de vida a cada 5 s." },
    { "^Restores ([%d%.,]+) mana per 5 sec%.$",
      "Restaura %1 de mana a cada 5 s." },

    { "^([%d%.,]+) mana regenerated every 5 seconds while not casting$",
      "%1 de mana regenerada a cada 5 s enquanto não lança feitiços" },
    { "^([%d%.,]+) mana regenerated every 5 seconds while casting$",
      "%1 de mana regenerada a cada 5 s durante o lançamento de feitiços" },
    { "^([%d%.,]+) health regenerated every 5 seconds$",
      "%1 de vida regenerada a cada 5 s" },

    { "^Reduces physical damage taken by ([%d%.,]+)%%%.$",
      "Reduz em %1%% o dano físico recebido." },
    { "^Reduces Physical Damage taken by ([%d%.,]+)%%%.$",
      "Reduz em %1%% o dano físico recebido." },
    { "^Increases the speed that your spells cast by ([%d%.,]+)%%%.$",
      "Aumenta a velocidade de lançamento dos seus feitiços em %1%%." },
    { "^Increases damage done by magical spells and effects by up to ([%d%.,]+)%.$",
      "Aumenta em até %1 o dano causado por feitiços e efeitos mágicos." },
    { "^Increases healing done by magical spells and effects by up to ([%d%.,]+)%.$",
      "Aumenta em até %1 a cura realizada por feitiços e efeitos mágicos." },
    { "^Damage reduction against an attacker of level (%d+): ([%d%.,]+)%%$",
      "Redução de dano contra um atacante de nível %1: %2%%" },
    { "^Movement speed: ([%d%.,]+)%%$", "Velocidade de movimento: %1%%" },
    { "^Item Level: ([%d%.,]+)$", "Nível do item: %1" },
}

local cache = {}
local cacheCount = 0
local CACHE_LIMIT = 1024

-- Bucket pela primeira letra pra não testar a lista inteira em todo tooltip.
local patternBuckets = {}
local patternFallback = {}
for i = 1, #A.CharacterStatPatterns do
    local pair = A.CharacterStatPatterns[i]
    local pattern = pair and pair[1]
    local first = type(pattern) == "string" and pattern:match("^%^([%a])")
    if first then
        local key = first:lower()
        local bucket = patternBuckets[key]
        if not bucket then
            bucket = {}
            patternBuckets[key] = bucket
        end
        bucket[#bucket + 1] = i
    else
        patternFallback[#patternFallback + 1] = i
    end
end

local function TryCharacterStatPatterns(text, indexes)
    if not indexes then return nil end
    for n = 1, #indexes do
        local pair = A.CharacterStatPatterns[indexes[n]]
        local result, changed = text:gsub(pair[1], pair[2])
        if changed > 0 and result ~= text then return result end
    end
    return nil
end

function A.TranslateCharacterStatLine(text)
    if type(text) ~= "string" or text == "" then return nil end

    local cached = cache[text]
    if cached ~= nil then return cached ~= false and cached or nil end

    local translated = A.CharacterStatExact[text]
    if not translated then
        local first = text:sub(1, 1)
        local key = first:match("%a") and first:lower() or nil
        translated = TryCharacterStatPatterns(text, key and patternBuckets[key])
            or TryCharacterStatPatterns(text, patternFallback)
    end

    if not translated then
        local stat = text:match("^Crit Chance scales primarily from Crit Rating, and (.-)%.$")
        if stat then
            stat = A.CharacterStatExact[stat] or stat
            translated = "A chance de acerto crítico é determinada principalmente pelo Índice de Acerto Crítico e por " .. stat .. "."
        end
    end

    if cacheCount >= CACHE_LIMIT then
        cache = {}
        cacheCount = 0
    end
    cache[text] = translated or false
    cacheCount = cacheCount + 1
    return translated
end
