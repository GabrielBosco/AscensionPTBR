AscensionPTBR = AscensionPTBR or {}

local A = AscensionPTBR

-- Textos usados no painel de atributos do Ascension. Mantemos esta tabela
-- separada da interface geral porque o painel recria as linhas com frequência.
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

    { "^([%d%.,]+) mana regenerated every 5 seconds while not casting$",
      "%1 de mana regenerada a cada 5 s enquanto não lança feitiços" },
    { "^([%d%.,]+) mana regenerated every 5 seconds while casting$",
      "%1 de mana regenerada a cada 5 s durante o lançamento de feitiços" },
    { "^([%d%.,]+) health regenerated every 5 seconds$",
      "%1 de vida regenerada a cada 5 s" },

    { "^Reduces physical damage taken by ([%d%.,]+)%%%.$",
      "Reduz em %1%% o dano físico recebido." },
    { "^Damage reduction against an attacker of level (%d+): ([%d%.,]+)%%$",
      "Redução de dano contra um atacante de nível %1: %2%%" },
    { "^Movement speed: ([%d%.,]+)%%$", "Velocidade de movimento: %1%%" },
    { "^Item Level: ([%d%.,]+)$", "Nível do item: %1" },
}

local cache = {}
local cacheCount = 0
local CACHE_LIMIT = 1024

function A.TranslateCharacterStatLine(text)
    if type(text) ~= "string" or text == "" then return nil end

    local cached = cache[text]
    if cached ~= nil then return cached ~= false and cached or nil end

    local translated = A.CharacterStatExact[text]
    if not translated then
        local patterns = A.CharacterStatPatterns
        for i = 1, #patterns do
            local pair = patterns[i]
            local result, changed = text:gsub(pair[1], pair[2])
            if changed > 0 and result ~= text then
                translated = result
                break
            end
        end
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
