AscensionPTBR = AscensionPTBR or {}

local A = AscensionPTBR

-- Fica separado da UI geral porque a ficha do personagem atualiza isso direto.
A.CharacterStatExact = {
    ["Attributes"] = "Atributos",
    ["Base Stats"] = "Atributos básicos",
    ["Base Statistics"] = "Atributos básicos",
    ["General"] = "Geral",
    ["Melee"] = "Corpo a corpo",
    ["Ranged"] = "À distância",
    ["Spell"] = "Feitiços",
    ["Spells"] = "Feitiços",
    ["Defenses"] = "Defesas",
    ["Resistances"] = "Resistências",

    -- Cabeçalhos e grupos da ficha customizada do Ascension
    ["Equipment"] = "Equipamento",
    ["Enhanced Attributes"] = "Atributos Aprimorados",
    ["Enhanced Attribute"] = "Atributo Aprimorado",
    ["Character"] = "Personagem",
    ["Character Info"] = "Informações do Personagem",
    ["Statistics"] = "Estatísticas",
    ["Stats"] = "Estatísticas",
    ["Attack"] = "Ataque",
    ["Resistance"] = "Resistência",

    -- Atributos aprimorados do CoA
    ["Avoidance"] = "Evasão",
    ["Critical Strike Avoidance"] = "Evasão de acerto crítico",
    ["Damage Taken"] = "Dano recebido",
    ["Healing Taken"] = "Cura recebida",
    ["Physical Damage"] = "Dano físico",
    ["Ranged Damage"] = "Dano à distância",
    ["Spell Damage"] = "Dano de feitiço",
    ["Spell Healing"] = "Cura de feitiço",
    ["Mana per 5"] = "Mana a cada 5 s",
    ["Mana Per 5"] = "Mana a cada 5 s",
    ["Out of Combat Regeneration"] = "Regeneração fora de combate",
    ["Mana Cost"] = "Custo de mana",

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
    ["PvE Power"] = "Poder JxA",
    ["PVE Power"] = "Poder JxA",
    ["PvP Power"] = "Poder JxJ",
    ["PVP Power"] = "Poder JxJ",

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
    ["Bonus Spell Damage"] = "Bônus de dano mágico",
    ["Bonus Spell Healing"] = "Bônus de cura mágica",
    ["Spell Crit"] = "Crítico com feitiços",
    ["Spell Crit Chance"] = "Chance de crítico com feitiços",
    ["Mana Regen."] = "Regen. de mana",
    ["Mana Regen"] = "Regen. de mana",
    ["Acceleration"] = "Aceleração",

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
    ["Block Amount"] = "Valor de bloqueio",
    ["Shield Block Value"] = "Valor de bloqueio do escudo",
    ["Health Regen Per 5 Sec"] = "Regeneração de vida a cada 5 s",
    ["Mana Regen Per 5 Sec"] = "Regeneração de mana a cada 5 s",
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
    ["Hit Chance scales Primarily from Hit Rating."] =
        "A chance de acerto é determinada principalmente pelo Índice de Acerto.",
    ["Crit Chance scales Primarily from Crit Rating, and Agility."] =
        "A chance de acerto crítico é determinada principalmente pelo Índice de Acerto Crítico e pela Agilidade.",
    ["Crit Chance scales Primarily from Crit Rating, and Intellect."] =
        "A chance de acerto crítico é determinada principalmente pelo Índice de Acerto Crítico e pelo Intelecto.",
    ["Crit Chance scales Primarily from Crit Rating."] =
        "A chance de acerto crítico é determinada principalmente pelo Índice de Acerto Crítico.",
    ["Haste scales Primarily from Haste Rating."] =
        "A aceleração é determinada principalmente pelo Índice de Aceleração.",
    ["Expertise scales primarily from Expertise Rating."] =
        "A aptidão é determinada principalmente pelo Índice de Aptidão.",
    ["Expertise scales Primarily from Expertise Rating."] =
        "A aptidão é determinada principalmente pelo Índice de Aptidão.",
    ["Armor Penetration scales primarily from Armor Penetration Rating."] =
        "A penetração de armadura é determinada principalmente pelo Índice de Penetração de Armadura.",
    ["Armor Penetration scales Primarily from Armor Penetration Rating."] =
        "A penetração de armadura é determinada principalmente pelo Índice de Penetração de Armadura.",

    -- CoA / painel C: explicações do acerto da mão secundária. São textos
    -- renderizados pelo StatsPanel depois que o jogo calcula os valores; por isso
    -- traduzimos o resultado pronto e não alteramos os GlobalStrings/formatos.
    ["This is only for off-hand auto attacks."] =
        "Isso se aplica apenas aos ataques automáticos da mão secundária.",
    ["This is only for off hand auto attacks."] =
        "Isso se aplica apenas aos ataques automáticos da mão secundária.",
    ["This stat is only for off-hand auto attacks."] =
        "Este atributo se aplica apenas aos ataques automáticos da mão secundária.",
    ["Your normal hit rating is used for your abilities."] =
        "Seu índice de acerto normal é usado nas suas habilidades.",
    ["Your melee hit rating is used for your abilities."] =
        "Seu índice de acerto corpo a corpo é usado nas suas habilidades.",
    ["Your ranged hit rating is used for your abilities."] =
        "Seu índice de acerto à distância é usado nas suas habilidades.",
    ["Your spell hit rating is used for your spells and abilities."] =
        "Seu índice de acerto com feitiços é usado nos seus feitiços e habilidades.",
    ["Haste scales primarily from Haste Rating."] =
        "A aceleração é determinada principalmente pelo Índice de Aceleração.",

    -- 1.5.6: ficha C / estatísticas customizadas do Ascension
    ["Primary Stat"] = "Atributo primário",
    ["Primary Attribute"] = "Atributo primário",
    ["Average Item Level"] = "Nível médio dos itens",
    ["Average iLvl"] = "Nível médio dos itens",
    ["iLvl"] = "Nível do item",
    ["Damage Reduction"] = "Redução de dano",
    ["Physical Damage Reduction"] = "Redução de dano físico",
    ["Magic Damage Reduction"] = "Redução de dano mágico",
    ["Healing Done"] = "Cura realizada",
    ["Damage Done"] = "Dano causado",
    ["Bonus Armor"] = "Bônus de Armadura",
    ["Melee Haste"] = "Aceleração corpo a corpo",
    ["Ranged Haste"] = "Aceleração à distância",
    ["Spell Haste"] = "Aceleração com feitiços",
    ["Melee Crit"] = "Crítico corpo a corpo",
    ["Ranged Crit"] = "Crítico à distância",
    ["Spell Critical Strike"] = "Acerto crítico com feitiços",
    ["Hit Avoidance"] = "Evasão de acerto",
    ["Hit Avoidance Rating"] = "Índice de evasão de acerto",
    ["Critical Avoidance"] = "Evasão de acerto crítico",
    ["Critical Avoidance Rating"] = "Índice de evasão de acerto crítico",
    ["Critical Strike Avoidance Rating"] = "Índice de evasão de acerto crítico",
    ["Critical Strike Avoidance Rating (Melee)"] = "Índice de evasão de crítico (corpo a corpo)",
    ["Critical Strike Avoidance Rating (Ranged)"] = "Índice de evasão de crítico (à distância)",
    ["Critical Strike Avoidance Rating (Spell)"] = "Índice de evasão de crítico (feitiços)",
    ["Hit Avoidance Rating (Melee)"] = "Índice de evasão de acerto (corpo a corpo)",
    ["Hit Avoidance Rating (Ranged)"] = "Índice de evasão de acerto (à distância)",
    ["Hit Avoidance Rating (Spell)"] = "Índice de evasão de acerto (feitiços)",
    ["Critical Strike Rating (Melee)"] = "Índice de acerto crítico (corpo a corpo)",
    ["Critical Strike Rating (Ranged)"] = "Índice de acerto crítico (à distância)",
    ["Critical Strike Rating (Spell)"] = "Índice de acerto crítico (feitiços)",
    ["Haste Rating (Melee)"] = "Índice de aceleração (corpo a corpo)",
    ["Haste Rating (Ranged)"] = "Índice de aceleração (à distância)",
    ["Haste Rating (Spell)"] = "Índice de aceleração (feitiços)",
    ["Hit Rating (Melee)"] = "Índice de acerto (corpo a corpo)",
    ["Hit Rating (Ranged)"] = "Índice de acerto (à distância)",
    ["Hit Rating (Spell)"] = "Índice de acerto (feitiços)",
    ["Melee Critical Strike"] = "Acerto crítico corpo a corpo",
    ["Ranged Critical Strike"] = "Acerto crítico à distância",
    ["Spell Critical Strike Chance"] = "Chance de acerto crítico com feitiços",
    ["Melee Critical Strike Chance"] = "Chance de acerto crítico corpo a corpo",
    ["Ranged Critical Strike Chance"] = "Chance de acerto crítico à distância",
    ["Melee Hit Chance"] = "Chance de acerto corpo a corpo",
    ["Ranged Hit Chance"] = "Chance de acerto à distância",
    ["Spell Hit Chance"] = "Chance de acerto com feitiços",
    ["Attack Speed"] = "Velocidade de ataque",
    ["Melee Attack Speed"] = "Velocidade de ataque corpo a corpo",
    ["Ranged Attack Speed"] = "Velocidade de ataque à distância",
    ["Cast Speed"] = "Velocidade de lançamento",
    ["Main Hand Damage"] = "Dano da mão principal",
    ["Off Hand Damage"] = "Dano da mão secundária",
    ["Main Hand Speed"] = "Velocidade da mão principal",
    ["Off Hand Speed"] = "Velocidade da mão secundária",
    ["Spell Penetration Rating"] = "Índice de penetração de feitiço",
    ["Armor Reduction"] = "Redução de armadura",
    ["Enemy Armor Reduction"] = "Redução de armadura do inimigo",
    ["Critical Damage"] = "Dano crítico",
    ["Critical Healing"] = "Cura crítica",
    ["Life Steal"] = "Roubo de vida",
    ["Leech"] = "Sanguessuga",
    ["Mastery"] = "Maestria",
    ["Mastery Rating"] = "Índice de maestria",
    ["PvE Damage"] = "Dano JxA",
    ["PvE Healing"] = "Cura JxA",
    ["PvE Damage Reduction"] = "Redução de dano JxA",
    ["PvP Damage"] = "Dano JxJ",
    ["PvP Healing"] = "Cura JxJ",
    ["PvP Damage Reduction"] = "Redução de dano JxJ",

    ["Increases your chance to dodge attacks."] = "Aumenta sua chance de esquivar de ataques.",
    ["Increases your chance to parry attacks."] = "Aumenta sua chance de aparar ataques.",
    ["Increases your chance to block attacks."] = "Aumenta sua chance de bloquear ataques.",
    ["Increases your chance to critically hit with melee attacks."] = "Aumenta sua chance de acerto crítico com ataques corpo a corpo.",
    ["Increases your chance to critically hit with ranged attacks."] = "Aumenta sua chance de acerto crítico com ataques à distância.",
    ["Increases your chance to critically hit with spells."] = "Aumenta sua chance de acerto crítico com feitiços.",
    ["Increases your chance to hit with melee attacks."] = "Aumenta sua chance de acerto com ataques corpo a corpo.",
    ["Increases your chance to hit with ranged attacks."] = "Aumenta sua chance de acerto com ataques à distância.",
    ["Increases your chance to hit with spells."] = "Aumenta sua chance de acerto com feitiços.",
    ["Increases the speed of your melee attacks."] = "Aumenta a velocidade dos seus ataques corpo a corpo.",
    ["Increases the speed of your ranged attacks."] = "Aumenta a velocidade dos seus ataques à distância.",
    ["Increases the speed of your spell casting."] = "Aumenta a velocidade de lançamento dos seus feitiços.",
    ["Reduces the chance for your attacks to be dodged or parried."] = "Reduz a chance de seus ataques serem esquivados ou aparados.",
    ["Reduces enemy resistances to your spells."] = "Reduz as resistências inimigas aos seus feitiços.",

    -- A AscensionDB descreve PvE Power como dano/cura maiores e dano recebido menor.
    ["PvE Power increases your damage and healing done while reducing the damage you take."] =
        "O Poder JxA aumenta o dano e a cura realizados e reduz o dano que você recebe.",
    ["PVE Power increases your damage and healing done while reducing the damage you take."] =
        "O Poder JxA aumenta o dano e a cura realizados e reduz o dano que você recebe.",
    ["PvE Power is only active at max level."] = "O Poder JxA só fica ativo no nível máximo.",
    ["PVE Power is only active at max level."] = "O Poder JxA só fica ativo no nível máximo.",
    ["PvP Power increases your damage and healing done to players."] =
        "O Poder JxJ aumenta o dano e a cura realizados contra jogadores.",
    ["PVP Power increases your damage and healing done to players."] =
        "O Poder JxJ aumenta o dano e a cura realizados contra jogadores.",

    -- Cobertura completa das famílias da ficha C / PaperDollFrame.
    -- Mantemos estes textos como resultado renderizado; nenhum format string do
    -- cliente é sobrescrito aqui, evitando incompatibilidade com o StatsPanel do CoA.
    ["Attack Rating"] = "Índice de ataque",
    ["Ranged Attack Rating"] = "Índice de ataque à distância",
    ["Weapon Skill"] = "Perícia com arma",
    ["Weapon Skill Rating"] = "Índice de perícia com arma",
    ["Main Hand Weapon Skill"] = "Perícia com arma da mão principal",
    ["Main-Hand Weapon Skill"] = "Perícia com arma da mão principal",
    ["Off Hand Weapon Skill"] = "Perícia com arma da mão secundária",
    ["Off-Hand Weapon Skill"] = "Perícia com arma da mão secundária",
    ["Ranged Weapon Skill"] = "Perícia com arma à distância",
    ["Main Hand"] = "Mão principal",
    ["Main-Hand"] = "Mão principal",
    ["Off Hand"] = "Mão secundária",
    ["Off-Hand"] = "Mão secundária",
    ["Main Hand Hit"] = "Acerto da mão principal",
    ["Main-Hand Hit"] = "Acerto da mão principal",
    ["Main Hand Hit Chance"] = "Chance de acerto da mão principal",
    ["Main-Hand Hit Chance"] = "Chance de acerto da mão principal",
    ["Off Hand Hit Chance"] = "Chance de acerto da mão secundária",
    ["Off-Hand Hit Chance"] = "Chance de acerto da mão secundária",
    ["Melee Damage"] = "Dano corpo a corpo",
    ["Melee Speed"] = "Velocidade corpo a corpo",
    ["Ranged Speed"] = "Velocidade à distância",
    ["Main Hand DPS"] = "DPS da mão principal",
    ["Off Hand DPS"] = "DPS da mão secundária",
    ["Ranged DPS"] = "DPS à distância",
    ["Critical Hit"] = "Acerto crítico",
    ["Critical Hit Chance"] = "Chance de acerto crítico",
    ["Melee Crit Chance"] = "Chance de acerto crítico corpo a corpo",
    ["Ranged Crit Chance"] = "Chance de acerto crítico à distância",
    ["Spell Crit Rating"] = "Índice de acerto crítico com feitiços",
    ["Melee Crit Rating"] = "Índice de acerto crítico corpo a corpo",
    ["Ranged Crit Rating"] = "Índice de acerto crítico à distância",
    ["Melee Haste Rating"] = "Índice de aceleração corpo a corpo",
    ["Ranged Haste Rating"] = "Índice de aceleração à distância",
    ["Spell Haste Rating"] = "Índice de aceleração com feitiços",
    ["Melee Expertise"] = "Aptidão corpo a corpo",
    ["Melee Expertise Rating"] = "Índice de aptidão corpo a corpo",
    ["Spell Bonus Damage"] = "Bônus de dano mágico",
    ["Spell Bonus Healing"] = "Bônus de cura mágica",
    ["Spell Damage Bonus"] = "Bônus de dano mágico",
    ["Healing Bonus"] = "Bônus de cura",
    ["Mana Regen While Casting"] = "Regeneração de mana durante o lançamento",
    ["Mana Regen While Not Casting"] = "Regeneração de mana fora do lançamento",
    ["Health Regen Out of Combat"] = "Regeneração de vida fora de combate",
    ["Damage per Second"] = "Dano por segundo",
    ["Physical Resistance"] = "Resistência física",
    ["Excellent"] = "Excelente",
    ["Very Good"] = "Muito boa",
    ["Good"] = "Boa",
    ["Fair"] = "Moderada",
    ["Poor"] = "Baixa",
    ["None"] = "Nenhuma",

    -- Descrições padrão do painel de personagem do WoW 3.3.5.
    ["Seconds per attack"] = "Segundos por ataque",
    ["Increases weapon damage"] = "Aumenta o dano da arma",
    ["Bonus damage to spell attacks."] = "Bônus de dano para ataques com feitiços.",
    ["The total amount of damage done."] = "A quantidade total de dano causado.",
    ["Decreases the amount of damage taken from physical attacks."] =
        "Reduz a quantidade de dano recebido de ataques físicos.",
    ["The amount of reduction is influenced by the level of the attacker."] =
        "A quantidade reduzida é influenciada pelo nível do atacante.",
    ["Your attack rating affects your chance to hit a target, and is based on the weapon skill of the weapon you are currently wielding."] =
        "Seu índice de ataque afeta sua chance de acertar um alvo e é baseado na perícia da arma que você está usando.",
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

    { "^Increases your melee chance to hit a target of level (%d+) by ([%d%.,]+)%% |c%x%x%x%x%x%x%x%x%(([%+%-]?[%d%.,]+)%%%)|r%.?$",
      "Aumenta sua chance de acertar ataques corpo a corpo contra um alvo de nível %1 em %2%% (%3%%)." },
    { "^Increases your ranged chance to hit a target of level (%d+) by ([%d%.,]+)%% |c%x%x%x%x%x%x%x%x%(([%+%-]?[%d%.,]+)%%%)|r%.?$",
      "Aumenta sua chance de acertar ataques à distância contra um alvo de nível %1 em %2%% (%3%%)." },
    { "^Increases your spell chance to hit a target of level (%d+) by ([%d%.,]+)%% |c%x%x%x%x%x%x%x%x%(([%+%-]?[%d%.,]+)%%%)|r%.?$",
      "Aumenta sua chance de acertar feitiços contra um alvo de nível %1 em %2%% (%3%%)." },

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

    -- Acerto da mão secundária (StatsPanel custom do Conquest of Azeroth).
    -- O bônus verde pode vir como código de cor ou como texto simples, dependendo
    -- da versão do cliente. Cobrimos os dois sem tocar no string.format do jogo.
    { "^Increases your melee off%-hand chance to hit a target of level (%d+) by ([%d%.,]+)%% |c%x%x%x%x%x%x%x%x%(([%+%-]?[%d%.,]+)%%%)|r%.?$",
      "Aumenta sua chance de acerto com a mão secundária contra um alvo de nível %1 em %2%% (%3%%)." },
    { "^Increases your melee off hand chance to hit a target of level (%d+) by ([%d%.,]+)%% |c%x%x%x%x%x%x%x%x%(([%+%-]?[%d%.,]+)%%%)|r%.?$",
      "Aumenta sua chance de acerto com a mão secundária contra um alvo de nível %1 em %2%% (%3%%)." },
    { "^Increases your melee off%-hand chance to hit a target of level (%d+) by ([%d%.,]+)%% %(([%+%-]?[%d%.,]+)%%%)%.?$",
      "Aumenta sua chance de acerto com a mão secundária contra um alvo de nível %1 em %2%% (%3%%)." },
    { "^Increases your melee off hand chance to hit a target of level (%d+) by ([%d%.,]+)%% %(([%+%-]?[%d%.,]+)%%%)%.?$",
      "Aumenta sua chance de acerto com a mão secundária contra um alvo de nível %1 em %2%% (%3%%)." },
    { "^Increases your melee off%-hand chance to hit a target of level (%d+) by ([%d%.,]+)%%%.?$",
      "Aumenta sua chance de acerto com a mão secundária contra um alvo de nível %1 em %2%%." },
    { "^Increases your melee off hand chance to hit a target of level (%d+) by ([%d%.,]+)%%%.?$",
      "Aumenta sua chance de acerto com a mão secundária contra um alvo de nível %1 em %2%%." },

    { "^([%d%.,]+)%% chance to hit is required to never miss a raid boss with your off%-hand weapon%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um chefe de raide com sua arma da mão secundária." },
    { "^([%d%.,]+)%% chance to hit is required to never miss a raid boss with your off hand weapon%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um chefe de raide com sua arma da mão secundária." },
    { "^([%d%.,]+)%% chance to hit is required to never miss a player with your off%-hand weapon%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um jogador com sua arma da mão secundária." },
    { "^([%d%.,]+)%% chance to hit is required to never miss a player with your off hand weapon%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um jogador com sua arma da mão secundária." },

    -- Variações equivalentes vistas em builds diferentes do painel C.
    { "^([%d%.,]+)%% off%-hand hit chance is required to never miss a raid boss%.?$",
      "É necessário ter %1%% de chance de acerto com a mão secundária para nunca errar um chefe de raide." },
    { "^([%d%.,]+)%% off%-hand hit chance is required to never miss a player%.?$",
      "É necessário ter %1%% de chance de acerto com a mão secundária para nunca errar um jogador." },

    { "^([%d%.,]+)%% chance to hit is required to never miss a raid boss%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um chefe de raide." },
    { "^([%d%.,]+)%% chance to hit is required to never miss a player%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um jogador." },
    { "^([%d%.,]+)%% spell hit chance is required to never miss a raid boss%.?$",
      "É necessário ter %1%% de chance de acerto com feitiços para nunca errar um chefe de raide." },
    { "^([%d%.,]+)%% spell hit chance is required to never miss a player%.?$",
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

    -- Textos auxiliares de caps/ataques automáticos usados pelo StatsPanel.
    { "^This is only for main%-hand auto attacks%.?$",
      "Isso se aplica apenas aos ataques automáticos da mão principal." },
    { "^This is only for ranged auto attacks%.?$",
      "Isso se aplica apenas aos ataques automáticos à distância." },
    { "^Your normal hit rating is used for (.+) abilities%.?$",
      "Seu índice de acerto normal é usado nas habilidades %1." },

    { "^Armor penetration rating ([%d%.,]+) %(Enemy damage reduction from armor reduced by up to ([%d%.,]+)%%%)%.$",
      "Índice de penetração de armadura %1 (reduz em até %2%% a redução de dano do inimigo concedida pela armadura)." },
    { "^Armor penetration rating ([%d%.,]+) %(Enemy damage reduction from armor reduced by up to ([%d%.,]+)%%%)$",
      "Índice de penetração de armadura %1 (reduz em até %2%% a redução de dano do inimigo concedida pela armadura)." },
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

    -- 1.5.7: frases reais mostradas pelo painel C do Ascension. A capitalização
    -- varia em relação aos GlobalStrings originais, então elas precisam de padrões
    -- próprios em vez de depender só de correspondência literal.
    { "^Increases Attack Power by ([%d%.,]+)%.?$",
      "Aumenta o Poder de Ataque em %1." },
    { "^Increases Block Amount by ([%d%.,]+)%.?$",
      "Aumenta o valor de bloqueio em %1." },
    { "^Increases Shield Block Value by ([%d%.,]+)%.?$",
      "Aumenta o valor de bloqueio do escudo em %1." },
    { "^Increases Armor by ([%d%.,]+)%.?$",
      "Aumenta a armadura em %1." },
    { "^Increases chance to Dodge by ([%d%.,]+)%%%.?$",
      "Aumenta a chance de esquiva em %1%%." },
    { "^Increases chance to Parry by ([%d%.,]+)%%%.?$",
      "Aumenta a chance de aparo em %1%%." },
    { "^Increases chance to Block by ([%d%.,]+)%%%.?$",
      "Aumenta a chance de bloqueio em %1%%." },
    { "^Increases chance to score a Critical Hit with all weapons by ([%d%.,]+)%%%.?$",
      "Aumenta em %1%% a chance de acerto crítico com todas as armas." },
    { "^Increases chance to score a Critical Hit with melee weapons by ([%d%.,]+)%%%.?$",
      "Aumenta em %1%% a chance de acerto crítico com armas corpo a corpo." },
    { "^Increases chance to score a Critical Hit with ranged weapons by ([%d%.,]+)%%%.?$",
      "Aumenta em %1%% a chance de acerto crítico com armas de longo alcance." },
    { "^Increases chance to score a Critical Hit with spells by ([%d%.,]+)%%%.?$",
      "Aumenta em %1%% a chance de acerto crítico com feitiços." },
    { "^Increases rate at which weapon skills improve by ([%d%.,]+)%%%.?$",
      "Aumenta em %1%% a taxa de melhoria das perícias com armas." },
    { "^Increases Health by ([%d%.,]+)%.?$",
      "Aumenta os pontos de vida em %1." },
    { "^Increases Mana by ([%d%.,]+)%.?$",
      "Aumenta os pontos de mana em %1." },
    { "^Increases Spell Power by ([%d%.,]+)%.?$",
      "Aumenta o Poder Mágico em %1." },
    { "^Increases Health Regeneration by ([%d%.,]+)%.?$",
      "Aumenta a regeneração de vida em %1." },
    { "^Increases Mana Regeneration by ([%d%.,]+)%.?$",
      "Aumenta a regeneração de mana em %1." },

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

    -- 1.5.6: formatos vistos na ficha C e em itens atuais do Ascension
    { "^Average Item Level:?%s*([%d%.,]+)$", "Nível médio dos itens: %1" },
    { "^Item Level%s+([%d%.,]+)$", "Nível do item: %1" },
    { "^Attack Power:?%s*([%d%.,]+)$", "Poder de ataque: %1" },
    { "^Melee Attack Power:?%s*([%d%.,]+)$", "Poder de ataque corpo a corpo: %1" },
    { "^Ranged Attack Power:?%s*([%d%.,]+)$", "Poder de ataque à distância: %1" },
    { "^Spell Power:?%s*([%d%.,]+)$", "Poder mágico: %1" },
    { "^Armor:?%s*([%d%.,]+)$", "Armadura: %1" },
    { "^Damage:?%s*([%d%.,]+)%s*%-%s*([%d%.,]+)$", "Dano: %1 - %2" },
    { "^Weapon Speed:?%s*([%d%.,]+)$", "Velocidade da arma: %1" },
    { "^Speed:?%s*([%d%.,]+)$", "Velocidade: %1" },
    { "^([%d%.,]+) damage per second$", "%1 de dano por segundo" },
    { "^([%d%.,]+)%% chance to block$", "%1%% de chance de bloqueio" },
    { "^([%d%.,]+)%% chance to dodge$", "%1%% de chance de esquiva" },
    { "^([%d%.,]+)%% chance to parry$", "%1%% de chance de aparo" },
    { "^([%d%.,]+)%% chance to crit$", "%1%% de chance de acerto crítico" },

    { "^PvE Power:?%s*([%d%.,]+)$", "Poder JxA: %1" },
    { "^PVE Power:?%s*([%d%.,]+)$", "Poder JxA: %1" },
    { "^PvP Power:?%s*([%d%.,]+)$", "Poder JxJ: %1" },
    { "^PVP Power:?%s*([%d%.,]+)$", "Poder JxJ: %1" },
    { "^Increases damage and healing done by ([%d%.,]+)%%%.$", "Aumenta em %1%% o dano e a cura realizados." },
    { "^Increases damage done by ([%d%.,]+)%%%.$", "Aumenta em %1%% o dano causado." },
    { "^Increases healing done by ([%d%.,]+)%%%.$", "Aumenta em %1%% a cura realizada." },
    { "^Reduces damage taken by ([%d%.,]+)%%%.$", "Reduz em %1%% o dano recebido." },
    { "^Reduces physical damage taken by ([%d%.,]+)%%%.$", "Reduz em %1%% o dano físico recebido." },
    { "^Reduces Physical Damage taken by ([%d%.,]+)%%%.$", "Reduz em %1%% o dano físico recebido." },
    { "^Reduces Physical Damage taken by ([%d%.,]+)%%%.?$", "Reduz em %1%% o dano físico recebido." },
    { "^Reduces magic damage taken by ([%d%.,]+)%%%.$", "Reduz em %1%% o dano mágico recebido." },
    { "^Increases damage and healing done to players by ([%d%.,]+)%%%.$", "Aumenta em %1%% o dano e a cura realizados contra jogadores." },
    { "^Reduces damage taken from players by ([%d%.,]+)%%%.$", "Reduz em %1%% o dano recebido de jogadores." },
    { "^Increases movement speed by ([%d%.,]+)%%%.$", "Aumenta a velocidade de movimento em %1%%." },

    { "^Critical Strike Avoidance Rating:?%s*([%d%.,]+)$", "Índice de evasão de acerto crítico: %1" },
    { "^Hit Avoidance Rating:?%s*([%d%.,]+)$", "Índice de evasão de acerto: %1" },
    { "^Improves critical strike avoidance rating by ([%d%.,]+)%.$", "Aumenta o índice de evasão de acerto crítico em %1." },
    { "^Improves critical strike avoidance rating by ([%d%.,]+)%s*%(([%d%.,]+)%%%s*@%s*L(%d+)%)%.$", "Aumenta o índice de evasão de acerto crítico em %1 (%2%% no nível %3)." },
    { "^Improves hit avoidance rating by ([%d%.,]+)%s*%(([%d%.,]+)%%%s*@%s*L(%d+)%)%.$", "Aumenta o índice de evasão de acerto em %1 (%2%% no nível %3)." },

    -- Algumas estatísticas (principalmente Defesa) não trazem símbolo de porcentagem antes de @ Lxx.
    { "^Increases defense rating by ([%d%.,]+)%s*%(([%d%.,]+)%s*@%s*L(%d+)%)%.?$",
      "Aumenta o índice de defesa em %1 (%2 no nível %3)." },
    { "^Increases your defense rating by ([%d%.,]+)%s*%(([%d%.,]+)%s*@%s*L(%d+)%)%.?$",
      "Aumenta seu índice de defesa em %1 (%2 no nível %3)." },
    { "^Increases your hit rating by ([%d%.,]+)%s*%(([%d%.,]+)%%%s*@%s*L(%d+)%)%.?$",
      "Aumenta seu índice de acerto em %1 (%2%% no nível %3)." },
    { "^Increases your critical strike rating by ([%d%.,]+)%s*%(([%d%.,]+)%%%s*@%s*L(%d+)%)%.?$",
      "Aumenta seu índice de acerto crítico em %1 (%2%% no nível %3)." },
    { "^Increases your haste rating by ([%d%.,]+)%s*%(([%d%.,]+)%%%s*@%s*L(%d+)%)%.?$",
      "Aumenta seu índice de aceleração em %1 (%2%% no nível %3)." },
    { "^Increases your armor penetration rating by ([%d%.,]+)%s*%(([%d%.,]+)%%%s*@%s*L(%d+)%)%.?$",
      "Aumenta seu índice de penetração de armadura em %1 (%2%% no nível %3)." },

    -- Linhas padrão e variantes atuais do StatsPanel que ainda podiam escapar.
    { "^Increases Critical Hit chance by ([%d%.,]+)%%%.?$",
      "Aumenta a chance de acerto crítico em %1%%." },
    { "^Increases Spell Critical Hit by ([%d%.,]+)%%%.?$",
      "Aumenta a chance de acerto crítico com feitiços em %1%%." },
    { "^Increases Melee Critical Hit by ([%d%.,]+)%%%.?$",
      "Aumenta a chance de acerto crítico corpo a corpo em %1%%." },
    { "^Increases Ranged Critical Hit by ([%d%.,]+)%%%.?$",
      "Aumenta a chance de acerto crítico à distância em %1%%." },
    { "^Damage reduction against a level (%d+) attacker:%s*([%d%.,]+)%%$",
      "Redução de dano contra um atacante de nível %1: %2%%" },
    { "^Reduces periodic damage and chance to be critically hit by ([%d%.,]+)%%%.$",
      "Reduz em %1%% o dano periódico e a chance de sofrer um acerto crítico." },
    { "^Reduces periodic damage and chance to be critically hit by ([%d%.,]+)%%%.?$",
      "Reduz em %1%% o dano periódico e a chance de sofrer um acerto crítico." },
    { "^Weapon Skill Rating ([%d%.,]+)$", "Índice de perícia com arma %1" },
    { "^Weapon Skill Rating ([%d%.,]+)%s*%(%+([%d%.,]+) skill%)$",
      "Índice de perícia com arma %1 (+%2 de perícia)" },
    { "^Increases your healing by up to ([%d%.,]+)%.?$",
      "Aumenta sua cura em até %1." },
    { "^Spell Penetration ([%d%.,]+) %(Reduces enemy resistances by ([%d%.,]+)%)%.?$",
      "Penetração de feitiço %1 (reduz as resistências inimigas em %2)." },

    -- Caps de acerto para todas as famílias, inclusive mão principal/secundária,
    -- ataques à distância e feitiços.
    { "^([%d%.,]+)%% chance to hit is required to never miss a raid boss with your main%-hand weapon%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um chefe de raide com sua arma da mão principal." },
    { "^([%d%.,]+)%% chance to hit is required to never miss a raid boss with your main hand weapon%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um chefe de raide com sua arma da mão principal." },
    { "^([%d%.,]+)%% chance to hit is required to never miss a player with your main%-hand weapon%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um jogador com sua arma da mão principal." },
    { "^([%d%.,]+)%% chance to hit is required to never miss a player with your main hand weapon%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um jogador com sua arma da mão principal." },
    { "^([%d%.,]+)%% chance to hit is required to never miss a raid boss with ranged attacks%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um chefe de raide com ataques à distância." },
    { "^([%d%.,]+)%% chance to hit is required to never miss a player with ranged attacks%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um jogador com ataques à distância." },
    { "^([%d%.,]+)%% chance to hit is required to never miss a raid boss with spells%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um chefe de raide com feitiços." },
    { "^([%d%.,]+)%% chance to hit is required to never miss a player with spells%.?$",
      "É necessário ter %1%% de chance de acerto para nunca errar um jogador com feitiços." },

    -- Variações de rating exibidas sem os nomes exatos dos GlobalStrings antigos.
    { "^Melee Crit rating ([%d%.,]+) %(%+([%d%.,]+)%% crit chance%)$",
      "Índice de acerto crítico corpo a corpo %1 (+%2%% de chance de acerto crítico)" },
    { "^Ranged Crit rating ([%d%.,]+) %(%+([%d%.,]+)%% crit chance%)$",
      "Índice de acerto crítico à distância %1 (+%2%% de chance de acerto crítico)" },
    { "^Spell Crit rating ([%d%.,]+) %(%+([%d%.,]+)%% crit chance%)$",
      "Índice de acerto crítico com feitiços %1 (+%2%% de chance de acerto crítico)" },
    { "^Melee Haste rating ([%d%.,]+) %(([%d%.,]+)%% haste%)$",
      "Índice de aceleração corpo a corpo %1 (%2%% de aceleração)" },
    { "^Ranged Haste rating ([%d%.,]+) %(([%d%.,]+)%% haste%)$",
      "Índice de aceleração à distância %1 (%2%% de aceleração)" },
    { "^Spell Haste rating ([%d%.,]+) %(([%d%.,]+)%% haste%)$",
      "Índice de aceleração com feitiços %1 (%2%% de aceleração)" },
}

-- Fallback semântico do painel C. Ele só roda depois dos padrões específicos e
-- trabalha exclusivamente com textos já renderizados. Assim cobre variações novas
-- do StatsPanel sem alterar GlobalStrings nem contratos de string.format.
local characterStatPhrasePT = {}
for en, pt in pairs(A.CharacterStatExact) do
    if type(en) == "string" and type(pt) == "string"
        and #en <= 64 and en:match("^[%w%s%-%(%)/]+$") then
        local key = en:lower():gsub("\194\160", " "):gsub("%s+", " ")
            :gsub("^%s+", ""):gsub("%s+$", "")
        characterStatPhrasePT[key] = pt
    end
end

local extraStatPhrases = {
    ["normal hit rating"] = "Índice de acerto normal",
    ["melee chance to hit"] = "Chance de acerto corpo a corpo",
    ["ranged chance to hit"] = "Chance de acerto à distância",
    ["spell chance to hit"] = "Chance de acerto com feitiços",
    ["main-hand chance to hit"] = "Chance de acerto da mão principal",
    ["main hand chance to hit"] = "Chance de acerto da mão principal",
    ["off-hand chance to hit"] = "Chance de acerto da mão secundária",
    ["off hand chance to hit"] = "Chance de acerto da mão secundária",
    ["main-hand hit chance"] = "Chance de acerto da mão principal",
    ["main hand hit chance"] = "Chance de acerto da mão principal",
    ["off-hand hit chance"] = "Chance de acerto da mão secundária",
    ["off hand hit chance"] = "Chance de acerto da mão secundária",
    ["melee critical hit chance"] = "Chance de acerto crítico corpo a corpo",
    ["ranged critical hit chance"] = "Chance de acerto crítico à distância",
    ["spell critical hit chance"] = "Chance de acerto crítico com feitiços",
    ["critical hit chance"] = "Chance de acerto crítico",
    ["critical strike chance"] = "Chance de acerto crítico",
    ["melee critical strike chance"] = "Chance de acerto crítico corpo a corpo",
    ["ranged critical strike chance"] = "Chance de acerto crítico à distância",
    ["spell critical strike chance"] = "Chance de acerto crítico com feitiços",
    ["crit chance"] = "Chance de acerto crítico",
    ["melee crit chance"] = "Chance de acerto crítico corpo a corpo",
    ["ranged crit chance"] = "Chance de acerto crítico à distância",
    ["spell crit chance"] = "Chance de acerto crítico com feitiços",
    ["armor penetration"] = "Penetração de armadura",
    ["armor penetration rating"] = "Índice de penetração de armadura",
    ["spell penetration rating"] = "Índice de penetração de feitiço",
    ["weapon skill rating"] = "Índice de perícia com arma",
    ["weapon skill"] = "Perícia com arma",
    ["block amount"] = "Valor de bloqueio",
    ["shield block value"] = "Valor de bloqueio do escudo",
    ["critical damage"] = "Dano crítico",
    ["critical healing"] = "Cura crítica",
    ["life steal"] = "Roubo de vida",
    ["lifesteal"] = "Roubo de vida",
    ["mastery"] = "Maestria",
    ["mastery rating"] = "Índice de maestria",
    ["damage reduction"] = "Redução de dano",
    ["physical damage reduction"] = "Redução de dano físico",
    ["magic damage reduction"] = "Redução de dano mágico",
    ["pve power"] = "Poder JxA",
    ["pvp power"] = "Poder JxJ",
    ["pve damage"] = "Dano JxA",
    ["pve healing"] = "Cura JxA",
    ["pvp damage"] = "Dano JxJ",
    ["pvp healing"] = "Cura JxJ",
}
for key, value in pairs(extraStatPhrases) do characterStatPhrasePT[key] = value end

local characterStatObjectPT = {
    ["strength"] = "sua Força", ["agility"] = "sua Agilidade",
    ["stamina"] = "seu Vigor", ["intellect"] = "seu Intelecto", ["spirit"] = "seu Espírito",
    ["armor"] = "sua armadura", ["bonus armor"] = "seu bônus de armadura",
    ["attack power"] = "seu poder de ataque", ["melee attack power"] = "seu poder de ataque corpo a corpo",
    ["ranged attack power"] = "seu poder de ataque à distância", ["spell power"] = "seu poder mágico",
    ["healing power"] = "seu poder de cura", ["health"] = "sua vida", ["mana"] = "sua mana",
    ["health regeneration"] = "sua regeneração de vida", ["mana regeneration"] = "sua regeneração de mana",
    ["hit rating"] = "seu índice de acerto", ["melee hit rating"] = "seu índice de acerto corpo a corpo",
    ["ranged hit rating"] = "seu índice de acerto à distância", ["spell hit rating"] = "seu índice de acerto com feitiços",
    ["critical strike rating"] = "seu índice de acerto crítico", ["crit rating"] = "seu índice de acerto crítico",
    ["melee critical strike rating"] = "seu índice de acerto crítico corpo a corpo",
    ["ranged critical strike rating"] = "seu índice de acerto crítico à distância",
    ["spell critical strike rating"] = "seu índice de acerto crítico com feitiços",
    ["haste rating"] = "seu índice de aceleração", ["melee haste rating"] = "seu índice de aceleração corpo a corpo",
    ["ranged haste rating"] = "seu índice de aceleração à distância",
    ["spell haste rating"] = "seu índice de aceleração com feitiços",
    ["expertise"] = "sua aptidão", ["expertise rating"] = "seu índice de aptidão",
    ["defense"] = "sua Defesa", ["defense rating"] = "seu índice de defesa",
    ["dodge"] = "sua esquiva", ["dodge chance"] = "sua chance de esquiva", ["dodge rating"] = "seu índice de esquiva",
    ["parry"] = "seu aparo", ["parry chance"] = "sua chance de aparo", ["parry rating"] = "seu índice de aparo",
    ["block"] = "seu bloqueio", ["block chance"] = "sua chance de bloqueio", ["block rating"] = "seu índice de bloqueio",
    ["block amount"] = "seu valor de bloqueio", ["block value"] = "seu valor de bloqueio",
    ["shield block value"] = "seu valor de bloqueio do escudo",
    ["resilience"] = "sua resiliência", ["resilience rating"] = "seu índice de resiliência",
    ["armor penetration"] = "sua penetração de armadura",
    ["armor penetration rating"] = "seu índice de penetração de armadura",
    ["spell penetration"] = "sua penetração de feitiço",
    ["spell penetration rating"] = "seu índice de penetração de feitiço",
    ["hit avoidance"] = "sua evasão de acerto", ["hit avoidance rating"] = "seu índice de evasão de acerto",
    ["critical avoidance"] = "sua evasão de acerto crítico",
    ["critical avoidance rating"] = "seu índice de evasão de acerto crítico",
    ["critical strike avoidance rating"] = "seu índice de evasão de acerto crítico",
    ["movement speed"] = "sua velocidade de movimento",
    ["critical damage"] = "seu dano crítico", ["critical healing"] = "sua cura crítica",
    ["life steal"] = "seu roubo de vida", ["lifesteal"] = "seu roubo de vida",
    ["mastery"] = "sua maestria", ["mastery rating"] = "seu índice de maestria",
    ["pve power"] = "seu Poder JxA", ["pvp power"] = "seu Poder JxJ",
    ["damage reduction"] = "sua redução de dano",
    ["physical damage reduction"] = "sua redução de dano físico",
    ["magic damage reduction"] = "sua redução de dano mágico",
    ["melee chance to hit"] = "sua chance de acerto corpo a corpo",
    ["ranged chance to hit"] = "sua chance de acerto à distância",
    ["spell chance to hit"] = "sua chance de acerto com feitiços",
    ["main-hand chance to hit"] = "sua chance de acerto da mão principal",
    ["main hand chance to hit"] = "sua chance de acerto da mão principal",
    ["off-hand chance to hit"] = "sua chance de acerto da mão secundária",
    ["off hand chance to hit"] = "sua chance de acerto da mão secundária",
    ["critical strike chance"] = "sua chance de acerto crítico",
    ["critical hit chance"] = "sua chance de acerto crítico",
    ["melee critical strike chance"] = "sua chance de acerto crítico corpo a corpo",
    ["ranged critical strike chance"] = "sua chance de acerto crítico à distância",
    ["spell critical strike chance"] = "sua chance de acerto crítico com feitiços",
}

local characterStatActivityPT = {
    ["main-hand auto attacks"] = "ataques automáticos da mão principal",
    ["main hand auto attacks"] = "ataques automáticos da mão principal",
    ["off-hand auto attacks"] = "ataques automáticos da mão secundária",
    ["off hand auto attacks"] = "ataques automáticos da mão secundária",
    ["ranged auto attacks"] = "ataques automáticos à distância",
    ["melee auto attacks"] = "ataques automáticos corpo a corpo",
    ["auto attacks"] = "ataques automáticos",
    ["abilities"] = "habilidades", ["spells"] = "feitiços",
    ["spells and abilities"] = "feitiços e habilidades",
}

local function NormalizeCharacterStatPhrase(text)
    if type(text) ~= "string" then return nil end
    return text:lower():gsub("\194\160", " "):gsub("%s+", " ")
        :gsub("^%s+", ""):gsub("%s+$", ""):gsub("%.$", "")
end

local function CharacterStatPhrase(text)
    local key = NormalizeCharacterStatPhrase(text)
    return key and characterStatPhrasePT[key] or nil
end

local function CharacterStatObject(text, owned)
    local key = NormalizeCharacterStatPhrase(text)
    if not key then return nil end
    local value = characterStatObjectPT[key]
    if not value then return nil end
    if owned == false then
        value = value:gsub("^seu ", "o "):gsub("^sua ", "a ")
    end
    return value
end

local function CharacterStatSourceList(source)
    if type(source) ~= "string" then return nil end
    local first, second = source:match("^(.-),%s+and%s+(.+)$")
    if first and second then
        local a, b = CharacterStatPhrase(first), CharacterStatPhrase(second)
        if a and b then return a .. " e " .. b end
    end
    return CharacterStatPhrase(source)
end

local function CleanCharacterStatAmount(value)
    if type(value) ~= "string" then return value end
    return (value:gsub("%.$", ""))
end

local function TranslateCharacterStatGeneric(text)
    if type(text) ~= "string" or text == "" then return nil end
    local core = text:gsub("\194\160", " "):gsub("^%s+", ""):gsub("%s+$", "")

    -- Rótulo + valor, incluindo frações/percentuais usados pelo painel custom.
    local label, suffix = core:match("^(.-)(:%s*.+)$")
    local labelPT = label and CharacterStatPhrase(label)
    if labelPT then return labelPT .. suffix end
    label, suffix = core:match("^(.-)(%s+[%+%-]?[%d%.,]+%%?.*)$")
    labelPT = label and CharacterStatPhrase(label)
    if labelPT then return labelPT .. suffix end

    -- Fórmulas de escala do Ascension (Crit/Haste/Hit e estatísticas futuras).
    local statName, source = core:match("^(.-) scales [Pp]rimarily from (.-)%.?$")
    if statName and source then
        local statPT, sourcePT = CharacterStatPhrase(statName), CharacterStatSourceList(source)
        if statPT and sourcePT then
            return "O valor de " .. statPT .. " depende principalmente de " .. sourcePT .. "."
        end
    end

    -- Frases de aumento/redução mais comuns. Só traduz se o atributo capturado for
    -- conhecido, evitando mexer em texto comum que por acaso apareça no C.
    local object, amount = core:match("^Increases your (.-) by ([%+%-]?[%d%.,]+%%?)%.?$")
    if object and amount then
        local pt = CharacterStatObject(object, true)
        if pt then return "Aumenta " .. pt .. " em " .. CleanCharacterStatAmount(amount) .. "." end
    end
    object, amount = core:match("^Improves your (.-) by ([%+%-]?[%d%.,]+%%?)%.?$")
    if object and amount then
        local pt = CharacterStatObject(object, true)
        if pt then return "Aumenta " .. pt .. " em " .. CleanCharacterStatAmount(amount) .. "." end
    end
    object, amount = core:match("^Reduces your (.-) by ([%+%-]?[%d%.,]+%%?)%.?$")
    if object and amount then
        local pt = CharacterStatObject(object, true)
        if pt then return "Reduz " .. pt .. " em " .. CleanCharacterStatAmount(amount) .. "." end
    end
    object, amount = core:match("^Decreases your (.-) by ([%+%-]?[%d%.,]+%%?)%.?$")
    if object and amount then
        local pt = CharacterStatObject(object, true)
        if pt then return "Reduz " .. pt .. " em " .. CleanCharacterStatAmount(amount) .. "." end
    end

    object, amount = core:match("^Increases (.-) by ([%+%-]?[%d%.,]+%%?)%.?$")
    if object and amount then
        local pt = CharacterStatObject(object, false)
        if pt then return "Aumenta " .. pt .. " em " .. CleanCharacterStatAmount(amount) .. "." end
    end
    object, amount = core:match("^Improves (.-) by ([%+%-]?[%d%.,]+%%?)%.?$")
    if object and amount then
        local pt = CharacterStatObject(object, false)
        if pt then return "Aumenta " .. pt .. " em " .. CleanCharacterStatAmount(amount) .. "." end
    end
    object, amount = core:match("^Reduces (.-) by ([%+%-]?[%d%.,]+%%?)%.?$")
    if object and amount then
        local pt = CharacterStatObject(object, false)
        if pt then return "Reduz " .. pt .. " em " .. CleanCharacterStatAmount(amount) .. "." end
    end
    object, amount = core:match("^Decreases (.-) by ([%+%-]?[%d%.,]+%%?)%.?$")
    if object and amount then
        local pt = CharacterStatObject(object, false)
        if pt then return "Reduz " .. pt .. " em " .. CleanCharacterStatAmount(amount) .. "." end
    end

    -- Avisos de uso exclusivo e de qual índice alimenta determinada mecânica.
    local activity = core:match("^This is only for (.-)%.?$")
        or core:match("^This stat is only for (.-)%.?$")
    if activity then
        local pt = characterStatActivityPT[NormalizeCharacterStatPhrase(activity)]
        if pt then return "Este atributo se aplica apenas a " .. pt .. "." end
    end

    local rating, use = core:match("^Your (.-) is used for your (.-)%.?$")
    if rating and use then
        local ratingPT = CharacterStatPhrase(rating)
        local usePT = characterStatActivityPT[NormalizeCharacterStatPhrase(use)]
        if ratingPT and usePT then return "Seu " .. ratingPT:lower() .. " é usado em " .. usePT .. "." end
    end

    -- Linhas de rating em formato genérico, úteis quando o Ascension troca apenas
    -- o nome do atributo mantendo a fórmula visual do PaperDollFrame.
    local ratingName, ratingValue, bonusValue, bonusName = core:match(
        "^(.-) ([%d%.,]+) %(%+([%d%.,]+)%%? (.-)%)$")
    if ratingName then
        local ratingPT = CharacterStatPhrase(ratingName)
        local bonusPT = CharacterStatPhrase(bonusName)
        if ratingPT and bonusPT then
            return ratingPT .. " " .. ratingValue .. " (+" .. bonusValue .. " de " .. bonusPT .. ")"
        end
    end

    return nil
end

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
        if changed > 0 and result ~= text then
            -- [%d%.,]+ pode absorver o ponto final em alguns textos do cliente.
            -- Normaliza somente pontuação duplicada no fim da frase.
            result = result:gsub("%.%.+$", ".")
            return result
        end
    end
    return nil
end

local function LocalizeStatDecimals(text)
    if type(text) ~= "string" then return text end
    return (text:gsub("(%d)%.(%d)", "%1,%2"))
end
A.LocalizeStatDecimals = LocalizeStatDecimals

local function SplitDecoratedStatText(text)
    local lead, core, trail = text:match("^(%s*)(.-)(%s*)$")
    core = core or text
    local color, inner, reset = core:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
    if color and inner then
        return lead or "", inner, (color or ""), (reset or ""), trail or ""
    end
    return lead or "", core, "", "", trail or ""
end

function A.TranslateCharacterStatLine(text)
    if type(text) ~= "string" or text == "" then return nil end

    local cached = cache[text]
    if cached ~= nil then return cached ~= false and cached or nil end

    -- Alguns widgets do Ascension embrulham o texto em espaços/cor. Traduzimos
    -- apenas o miolo e recolocamos a decoração, evitando centenas de duplicatas
    -- no dicionário e mantendo a cor original do painel.
    local lead, core, color, reset, trail = SplitDecoratedStatText(text)
    if core ~= text then
        local inner = A.TranslateCharacterStatLine(core)
        if inner and inner ~= core then
            local decorated = lead .. color .. inner .. reset .. trail
            cache[text] = decorated
            cacheCount = cacheCount + 1
            return decorated
        end
    end

    local translated = A.CharacterStatExact[text]

    -- Padrões completos vêm antes do fallback de rótulo+valor. Isso evita deixar
    -- pedaços em inglês em linhas como "Defense Rating 14 (+2 Defense)".
    if not translated then
        local first = text:sub(1, 1)
        local key = first:match("%a") and first:lower() or nil
        translated = TryCharacterStatPatterns(text, key and patternBuckets[key])
            or TryCharacterStatPatterns(text, patternFallback)
    end

    -- Fallback semântico para variações do StatsPanel que preservam a mecânica mas
    -- mudam ligeiramente a redação. Continua O(1) por linha e fica atrás do cache.
    if not translated then
        translated = TranslateCharacterStatGeneric(text)
    end

    if not translated then
        -- Alguns painéis customizados juntam rótulo e valor no mesmo FontString
        -- (ex.: "Strength: 37" ou "Hit Rating 1/31"). Traduz apenas quando a
        -- parte esquerda é um atributo conhecido, preservando o valor exatamente.
        local label, suffix = text:match("^(.-)(:%s*.+)$")
        local ptLabel = label and A.CharacterStatExact[label]
        if ptLabel then translated = ptLabel .. suffix end
        if not translated then
            label, suffix = text:match("^(.-)(%s+[%+%-]?[%d%.,]+%%?.*)$")
            ptLabel = label and A.CharacterStatExact[label]
            if ptLabel then translated = ptLabel .. suffix end
        end
    end

    if not translated then
        local stat = text:match("^Crit Chance scales [Pp]rimarily from Crit Rating, and (.-)%.$")
        if stat then
            stat = A.CharacterStatExact[stat] or stat
            translated = "A chance de acerto crítico é determinada principalmente pelo Índice de Acerto Crítico e por " .. stat .. "."
        end
    end

    if translated then translated = LocalizeStatDecimals(translated) end

    if cacheCount >= CACHE_LIMIT then
        cache = {}
        cacheCount = 0
    end
    cache[text] = translated or false
    cacheCount = cacheCount + 1
    return translated
end

-- Estatísticas de itens do Ascension. Este caminho é acionado apenas quando uma
-- linha de tooltip parece ser um atributo/efeito de equipamento e usa cache.
-- Assim cobrimos os formatos customizados da AscensionDB sem varrer tabelas por frame.
local itemStatCache = {}
local itemStatCacheCount = 0
local ITEM_STAT_CACHE_LIMIT = 4096

local itemStatDirect = {
    ["strength"] = "Força",
    ["agility"] = "Agilidade",
    ["stamina"] = "Vigor",
    ["intellect"] = "Intelecto",
    ["spirit"] = "Espírito",
    ["all stats"] = "Todos os Atributos",
    ["all attributes"] = "Todos os Atributos",
    ["primary stat"] = "Atributo Primário",
    ["armor"] = "Armadura",
    ["bonus armor"] = "Bônus de Armadura",
    ["damage"] = "Dano",
    ["attack power"] = "Poder de Ataque",
    ["melee attack power"] = "Poder de Ataque Corpo a Corpo",
    ["ranged attack power"] = "Poder de Ataque à Distância",
    ["spell power"] = "Poder Mágico",
    ["healing power"] = "Poder de Cura",
    ["healing"] = "Cura",
    ["spell damage"] = "Dano por Feitiços",
    ["spell healing"] = "Cura por Feitiços",
    ["spell damage and healing"] = "Dano e Cura por Feitiços",
    ["fire spell damage"] = "Dano de Feitiço de Fogo",
    ["fire spell power"] = "Poder de Feitiço de Fogo",
    ["frost spell damage"] = "Dano de Feitiço de Gelo",
    ["frost spell power"] = "Poder de Feitiço de Gelo",
    ["nature spell damage"] = "Dano de Feitiço de Natureza",
    ["nature spell power"] = "Poder de Feitiço de Natureza",
    ["shadow spell damage"] = "Dano de Feitiço de Sombra",
    ["shadow spell power"] = "Poder de Feitiço de Sombra",
    ["arcane spell damage"] = "Dano de Feitiço Arcano",
    ["arcane spell power"] = "Poder de Feitiço Arcano",
    ["holy spell damage"] = "Dano de Feitiço Sagrado",
    ["holy spell power"] = "Poder de Feitiço Sagrado",
    ["health"] = "Vida",
    ["mana"] = "Mana",
    ["mana per 5 sec"] = "Mana a cada 5 s",
    ["mana per 5 seconds"] = "Mana a cada 5 s",
    ["mana every 5 sec"] = "Mana a cada 5 s",
    ["health per 5 sec"] = "Vida a cada 5 s",
    ["health per 5 seconds"] = "Vida a cada 5 s",
    ["hit rating"] = "Índice de Acerto",
    ["melee hit rating"] = "Índice de Acerto Corpo a Corpo",
    ["ranged hit rating"] = "Índice de Acerto à Distância",
    ["spell hit rating"] = "Índice de Acerto com Feitiços",
    ["hit avoidance rating"] = "Índice de Evasão de Acerto",
    ["melee hit avoidance rating"] = "Índice de Evasão de Acerto Corpo a Corpo",
    ["ranged hit avoidance rating"] = "Índice de Evasão de Acerto à Distância",
    ["spell hit avoidance rating"] = "Índice de Evasão de Acerto com Feitiços",
    ["critical strike rating"] = "Índice de Acerto Crítico",
    ["crit rating"] = "Índice de Acerto Crítico",
    ["melee critical strike rating"] = "Índice de Acerto Crítico Corpo a Corpo",
    ["ranged critical strike rating"] = "Índice de Acerto Crítico à Distância",
    ["spell critical strike rating"] = "Índice de Acerto Crítico com Feitiços",
    ["critical avoidance rating"] = "Índice de Evasão de Acerto Crítico",
    ["critical strike avoidance rating"] = "Índice de Evasão de Acerto Crítico",
    ["melee critical avoidance rating"] = "Índice de Evasão de Crítico Corpo a Corpo",
    ["ranged critical avoidance rating"] = "Índice de Evasão de Crítico à Distância",
    ["spell critical avoidance rating"] = "Índice de Evasão de Crítico com Feitiços",
    ["haste rating"] = "Índice de Aceleração",
    ["melee haste rating"] = "Índice de Aceleração Corpo a Corpo",
    ["ranged haste rating"] = "Índice de Aceleração à Distância",
    ["spell haste rating"] = "Índice de Aceleração com Feitiços",
    ["expertise rating"] = "Índice de Aptidão",
    ["resilience rating"] = "Índice de Resiliência",
    ["resilience"] = "Resiliência",
    ["defense rating"] = "Índice de Defesa",
    ["dodge rating"] = "Índice de Esquiva",
    ["parry rating"] = "Índice de Aparo",
    ["block rating"] = "Índice de Bloqueio",
    ["shield block rating"] = "Índice de Bloqueio com Escudo",
    ["block value"] = "Valor de Bloqueio",
    ["armor penetration rating"] = "Índice de Penetração de Armadura",
    ["spell penetration"] = "Penetração de Feitiço",
    ["fire resistance"] = "Resistência ao Fogo",
    ["frost resistance"] = "Resistência ao Gelo",
    ["nature resistance"] = "Resistência à Natureza",
    ["shadow resistance"] = "Resistência à Sombra",
    ["arcane resistance"] = "Resistência ao Arcano",
    ["holy resistance"] = "Resistência ao Sagrado",
    ["all resistances"] = "Todas as Resistências",
    ["beast slaying"] = "Abate de Feras",
    ["demon slaying"] = "Abate de Demônios",
    ["undead slaying"] = "Abate de Mortos-vivos",
    ["weapon damage"] = "Dano da Arma",
    ["ranged damage"] = "Dano à Distância",
    ["health regeneration"] = "Regeneração de Vida",
    ["mana regeneration"] = "Regeneração de Mana",
}

local itemStatObject = {
    ["critical strike rating"] = "o índice de acerto crítico",
    ["crit rating"] = "o índice de acerto crítico",
    ["melee critical strike rating"] = "o índice de acerto crítico corpo a corpo",
    ["ranged critical strike rating"] = "o índice de acerto crítico à distância",
    ["spell critical strike rating"] = "o índice de acerto crítico com feitiços",
    ["critical avoidance rating"] = "o índice de evasão de acerto crítico",
    ["critical strike avoidance rating"] = "o índice de evasão de acerto crítico",
    ["melee critical avoidance rating"] = "o índice de evasão de crítico corpo a corpo",
    ["ranged critical avoidance rating"] = "o índice de evasão de crítico à distância",
    ["spell critical avoidance rating"] = "o índice de evasão de crítico com feitiços",
    ["haste rating"] = "o índice de aceleração",
    ["melee haste rating"] = "o índice de aceleração corpo a corpo",
    ["ranged haste rating"] = "o índice de aceleração à distância",
    ["spell haste rating"] = "o índice de aceleração com feitiços",
    ["hit rating"] = "o índice de acerto",
    ["melee hit rating"] = "o índice de acerto corpo a corpo",
    ["ranged hit rating"] = "o índice de acerto à distância",
    ["spell hit rating"] = "o índice de acerto com feitiços",
    ["hit avoidance rating"] = "o índice de evasão de acerto",
    ["melee hit avoidance rating"] = "o índice de evasão de acerto corpo a corpo",
    ["ranged hit avoidance rating"] = "o índice de evasão de acerto à distância",
    ["spell hit avoidance rating"] = "o índice de evasão de acerto com feitiços",
    ["expertise rating"] = "o índice de aptidão",
    ["resilience rating"] = "o índice de resiliência",
    ["defense rating"] = "o índice de defesa",
    ["dodge rating"] = "o índice de esquiva",
    ["parry rating"] = "o índice de aparo",
    ["block rating"] = "o índice de bloqueio",
    ["shield block rating"] = "o índice de bloqueio com escudo",
    ["armor penetration rating"] = "o índice de penetração de armadura",
    ["spell penetration"] = "a penetração de feitiço",
    ["attack power"] = "o poder de ataque",
    ["melee attack power"] = "o poder de ataque corpo a corpo",
    ["ranged attack power"] = "o poder de ataque à distância",
    ["spell power"] = "o poder mágico",
    ["healing power"] = "o poder de cura",
    ["block value"] = "o valor de bloqueio",
    ["armor"] = "a armadura",
    ["bonus armor"] = "o bônus de armadura",
    ["fire spell power"] = "o poder de feitiço de Fogo",
    ["frost spell power"] = "o poder de feitiço de Gelo",
    ["nature spell power"] = "o poder de feitiço de Natureza",
    ["shadow spell power"] = "o poder de feitiço de Sombra",
    ["arcane spell power"] = "o poder de feitiço Arcano",
    ["holy spell power"] = "o poder de feitiço Sagrado",
}

local statWordPT = {
    ["Strength"] = "Força", ["Agility"] = "Agilidade", ["Stamina"] = "Vigor",
    ["Intellect"] = "Intelecto", ["Spirit"] = "Espírito",
    ["Attack Power"] = "Poder de Ataque", ["Ranged Attack Power"] = "Poder de Ataque à Distância",
    ["Critical Strike Rating"] = "Índice de Acerto Crítico", ["Haste Rating"] = "Índice de Aceleração",
    ["Hit Rating"] = "Índice de Acerto", ["Defense Rating"] = "Índice de Defesa",
}

local creaturePT = {
    ["Undead"] = "Mortos-vivos", ["Demons"] = "Demônios", ["Demon"] = "Demônios",
    ["Beasts"] = "Feras", ["Beast"] = "Feras", ["Dragonkin"] = "Draconianos",
    ["Humanoids"] = "Humanoides", ["Giants"] = "Gigantes", ["Elementals"] = "Elementais",
}

local function NormalizeStatKey(stat)
    return stat:lower():gsub("[%s\194\160]+", " "):gsub("^%s+", ""):gsub("%s+$", ""):gsub("%.$", "")
end

local function CleanStatNumber(value)
    if type(value) ~= "string" then return value end
    return value:gsub("%.$", "")
end

local function ItemStatLevelSuffix(value, level, isPercent)
    if not (value and level) then return "" end
    value = CleanStatNumber(value):gsub("%.", ",")
    return " (" .. value .. (isPercent and "%" or "") .. " no nível " .. level .. ")"
end

local function RenderDirectItemStat(sign, amount, stat)
    local lower = NormalizeStatKey(stat)
    if lower == "all stats" or lower == "all attributes" then
        return sign .. amount .. " em todos os atributos"
    end
    if lower == "pve power" then return sign .. amount .. " de Poder JxA" end
    if lower == "pvp power" then return sign .. amount .. " de Poder JxJ" end
    local pt = itemStatDirect[lower]
    if not pt then return nil end
    return sign .. amount .. " de " .. pt
end

local function TranslateDirectItemStatList(text)
    local work = text:gsub("%s+and%s+([%+%-])", "\31%1")
    work = work:gsub(",%s+([%+%-])", "\31%1")
    local out = {}
    for part in (work .. "\31"):gmatch("(.-)\31") do
        part = part:gsub("^%s+", ""):gsub("%s+$", "")
        if part ~= "" then
            local sign, amount, stat = part:match("^([%+%-])%s*([%d%.,]+)%s+(.+)$")
            if not sign then return nil end
            local rendered = RenderDirectItemStat(sign, amount, stat)
            if not rendered then return nil end
            out[#out + 1] = rendered
        end
    end
    if #out == 0 then return nil end
    return table.concat(out, ", ")
end

local function TranslateItemStatCore(core)
    core = core:gsub("\194\160", " "):gsub("%s+$", "")

    local amount = core:match("^Increases PvE Power by ([%d%.,]+)%.?$")
        or core:match("^Increases PVE Power by ([%d%.,]+)%.?$")
        or core:match("^Increases your PvE Power by ([%d%.,]+)%.?$")
        or core:match("^Increases your PVE Power by ([%d%.,]+)%.?$")
    if amount then return "Aumenta o Poder JxA em " .. CleanStatNumber(amount) .. "." end

    amount = core:match("^Increases PvP Power by ([%d%.,]+)%.?$")
        or core:match("^Increases PVP Power by ([%d%.,]+)%.?$")
        or core:match("^Increases your PvP Power by ([%d%.,]+)%.?$")
        or core:match("^Increases your PVP Power by ([%d%.,]+)%.?$")
    if amount then return "Aumenta o Poder JxJ em " .. CleanStatNumber(amount) .. "." end

    local value = core:match("^PvE Power%s*([%+%-]?[%d%.,]+)$") or core:match("^PVE Power%s*([%+%-]?[%d%.,]+)$")
    if value then return "Poder JxA " .. value end
    value = core:match("^PvP Power%s*([%+%-]?[%d%.,]+)$") or core:match("^PVP Power%s*([%+%-]?[%d%.,]+)$")
    if value then return "Poder JxJ " .. value end

    local wrapped = core:match("^PvE Power%s*%(([%+%-]?[%d%.,]+)%)$") or core:match("^PVE Power%s*%(([%+%-]?[%d%.,]+)%)$")
    if wrapped then return "Poder JxA (" .. wrapped .. ")" end
    wrapped = core:match("^PvP Power%s*%(([%+%-]?[%d%.,]+)%)$") or core:match("^PVP Power%s*%(([%+%-]?[%d%.,]+)%)$")
    if wrapped then return "Poder JxJ (" .. wrapped .. ")" end

    -- Ex.: +20 (0.72% @ L58) Resilience e variantes sem símbolo %.
    local sign, directAmount, ratingValue, percentMark, level, stat = core:match(
        "^([%+%-])%s*([%d%.,]+)%s*%(([%d%.,]+)(%%?)%s*@%s*L(%d+)%)%s+(.+)%.?$")
    if sign then
        local rendered = RenderDirectItemStat(sign, directAmount, stat)
        if rendered then return rendered .. ItemStatLevelSuffix(ratingValue, level, percentMark == "%") end
    end

    -- Ex.: Improves critical strike rating by 13 (0.93% @ L60).
    -- Defesa em alguns itens vem como (2.00 @ L60), sem %.
    local statName, statAmount, statValue, statPercent, statLevel = core:match(
        "^Improves%s+your%s+(.-)%s+by%s+([%d%.,]+)%s*%(([%d%.,]+)(%%?)%s*@%s*L(%d+)%)%.?$")
    if not statName then
        statName, statAmount, statValue, statPercent, statLevel = core:match(
            "^Improves%s+(.-)%s+by%s+([%d%.,]+)%s*%(([%d%.,]+)(%%?)%s*@%s*L(%d+)%)%.?$")
    end
    if not statName then
        statName, statAmount, statValue, statPercent, statLevel = core:match(
            "^Increases%s+your%s+(.-)%s+by%s+([%d%.,]+)%s*%(([%d%.,]+)(%%?)%s*@%s*L(%d+)%)%.?$")
    end
    if not statName then
        statName, statAmount, statValue, statPercent, statLevel = core:match(
            "^Increases%s+(.-)%s+by%s+([%d%.,]+)%s*%(([%d%.,]+)(%%?)%s*@%s*L(%d+)%)%.?$")
    end
    if statName then
        local obj = itemStatObject[NormalizeStatKey(statName)]
        if obj then
            return "Aumenta em " .. CleanStatNumber(statAmount) .. " " .. obj
                .. ItemStatLevelSuffix(statValue, statLevel, statPercent == "%") .. "."
        end
    end

    -- Mesmos bônus sem conversão de nível. O cliente usa tanto "your" quanto
    -- a forma curta (ex.: Improves critical strike rating by 13).
    statName, statAmount = core:match("^Improves%s+your%s+(.-)%s+by%s+([%d%.,]+)%.?$")
    if not statName then statName, statAmount = core:match("^Improves%s+(.-)%s+by%s+([%d%.,]+)%.?$") end
    if not statName then statName, statAmount = core:match("^Increases%s+your%s+(.-)%s+by%s+([%d%.,]+)%.?$") end
    if not statName then statName, statAmount = core:match("^Increases%s+(.-)%s+by%s+([%d%.,]+)%.?$") end
    if statName then
        local obj = itemStatObject[NormalizeStatKey(statName)]
        if obj then return "Aumenta " .. obj .. " em " .. CleanStatNumber(statAmount) .. "." end
    end

    -- Random enchants e joias da AscensionDB.
    local regen = core:match("^Restores ([%d%.,]+) mana per 5 sec%.?$")
    if regen then return "Restaura " .. regen .. " de mana a cada 5 s." end
    regen = core:match("^Restores ([%d%.,]+) health per 5 sec%.?$")
    if regen then return "Restaura " .. regen .. " de vida a cada 5 s." end
    regen = core:match("^%+([%d%.,]+) Mana Per 5 sec%.?$")
    if regen then return "+" .. regen .. " de Mana a cada 5 s" end
    regen = core:match("^%+([%d%.,]+) mana every 5 sec%.?$")
    if regen then return "+" .. regen .. " de Mana a cada 5 s" end

    local school, power = core:match("^Increases ([%a]+) spell power by ([%d%.,]+)%.?$")
    if school then
        local schoolPT = { arcane="Arcano", fire="Fogo", frost="Gelo", holy="Sagrado", nature="Natureza", shadow="Sombra" }
        local schoolName = schoolPT[school:lower()]
        if schoolName then
            return "Aumenta o poder de feitiço de " .. schoolName .. " em " .. CleanStatNumber(power) .. "."
        end
    end

    local ap, creature = core:match("^Increases attack power by ([%d%.,]+) when fighting (.+)%.?$")
    if ap and creature then
        creature = creature:gsub("%.$", "")
        return "Aumenta o poder de ataque em " .. CleanStatNumber(ap) .. " ao enfrentar " .. (creaturePT[creature] or creature) .. "."
    end

    local target, share, source = core:match("^Increases your (.-) by ([%d%.,]+)%% of your (.-)%.?$")
    if target and share and source then
        local targetPT = statWordPT[target] or itemStatDirect[NormalizeStatKey(target)] or target
        local sourcePT = statWordPT[source] or itemStatDirect[NormalizeStatKey(source)] or source
        return "Aumenta seu " .. targetPT .. " em " .. share .. "% da sua " .. sourcePT .. "."
    end

    local pstat, gainPct, gainSource, gainTarget = core:match(
        "^If your Primary Stat is (.-), you gain ([%d%.,]+)%% of your (.-) as (.-)%.?$")
    if pstat then
        return "Se seu Atributo Primário for " .. (statWordPT[pstat] or pstat)
            .. ", você recebe " .. gainPct .. "% da sua " .. (statWordPT[gainSource] or gainSource)
            .. " como " .. (statWordPT[gainTarget] or itemStatDirect[NormalizeStatKey(gainTarget)] or gainTarget) .. "."
    end

    local red = core:match("^Physical damage taken reduced by ([%d%.,]+)%%%.?$")
    if red then return "Dano físico recebido reduzido em " .. red .. "%." end
    red = core:match("^Magic [Dd]amage taken reduced by ([%d%.,]+)%%%.?$")
    if red then return "Dano mágico recebido reduzido em " .. red .. "%." end
    red = core:match("^Damage taken reduced by ([%d%.,]+)%%%.?$")
    if red then return "Dano recebido reduzido em " .. red .. "%." end

    local petAP = core:match("^Increases you and your pet's Attack Power by ([%d%.,]+)%%%.?$")
    if petAP then return "Aumenta em " .. petAP .. "% o Poder de Ataque seu e do seu mascote." end

    if core:sub(1, 1) == "+" or core:sub(1, 1) == "-" then
        local direct = TranslateDirectItemStatList(core)
        if direct then return direct end
    end

    if A.TranslateCharacterStatLine then
        local general = A.TranslateCharacterStatLine(core)
        if general and general ~= core then return general end
    end
    return nil
end
A.TranslateItemStatCore = TranslateItemStatCore

local itemStatPrefix = {
    ["Equip: "] = "Equipar: ",
    ["Equipar: "] = "Equipar: ",
    ["Equipado: "] = "Equipar: ",
    ["Use: "] = "Usar: ",
    ["Usar: "] = "Usar: ",
    ["Uso: "] = "Usar: ",
    ["Set: "] = "Conjunto: ",
    ["Conjunto: "] = "Conjunto: ",
    ["Socket Bonus: "] = "Bônus de engaste: ",
    ["Bônus de engaste: "] = "Bônus de engaste: ",
    ["Chance on hit: "] = "Chance ao acertar: ",
    ["Chance ao acertar: "] = "Chance ao acertar: ",
}

local plausibleFirst = {
    ["+"]=true, ["-"]=true, ["A"]=true, ["B"]=true, ["C"]=true, ["D"]=true,
    ["H"]=true, ["I"]=true, ["M"]=true, ["P"]=true, ["R"]=true, ["S"]=true,
    ["Y"]=true,
}

function A.TranslateItemStatLine(text)
    if type(text) ~= "string" or text == "" then return nil end
    local cached = itemStatCache[text]
    if cached ~= nil then return cached ~= false and cached or nil end

    local prefix, core = "", text

    local headerPieces = text:match("^%((%d+)%) Set:%s*$")
    if headerPieces then
        local onlyHeader = "(" .. headerPieces .. ") Conjunto:"
        itemStatCache[text] = onlyHeader
        itemStatCacheCount = itemStatCacheCount + 1
        return onlyHeader
    end
    headerPieces = text:match("^%((%d+)%) Set Bonus:%s*$")
    if headerPieces then
        local onlyHeader = "(" .. headerPieces .. ") Bônus de conjunto:"
        itemStatCache[text] = onlyHeader
        itemStatCacheCount = itemStatCacheCount + 1
        return onlyHeader
    end

    local pieces, body = text:match("^%((%d+)%) Set:%s*(.+)$")
    if pieces then
        prefix, core = "(" .. pieces .. ") Conjunto: ", body
    else
        pieces, body = text:match("^%((%d+)%) Set Bonus:%s*(.+)$")
        if pieces then
            prefix, core = "(" .. pieces .. ") Bônus de conjunto: ", body
        else
            for enPrefix, ptPrefix in pairs(itemStatPrefix) do
                if text:sub(1, #enPrefix) == enPrefix then
                    prefix, core = ptPrefix, text:sub(#enPrefix + 1)
                    break
                end
            end
        end
    end

    -- Filtra depois de remover Equip/Set. Evita a falha da 1.5.5 em linhas que
    -- começam diretamente por "Increases", "Restores", "Damage" etc.
    local first = core:sub(1, 1)
    local translated
    if plausibleFirst[first] or core:find("PvE Power", 1, true) or core:find("PvP Power", 1, true) then
        translated = TranslateItemStatCore(core)
        if translated then translated = prefix .. translated end
    end

    if translated then translated = LocalizeStatDecimals(translated) end

    if itemStatCacheCount >= ITEM_STAT_CACHE_LIMIT then
        itemStatCache = {}
        itemStatCacheCount = 0
    end
    itemStatCache[text] = translated or false
    itemStatCacheCount = itemStatCacheCount + 1
    return translated
end



-- 1.5.1 item effects / procs / set bonuses (AscensionDB sweep)
--
-- Esta camada existe porque os efeitos do Ascension não são simples atributos:
-- muitos itens montam frases como "Your ... has a chance...", bônus de conjunto
-- e procs custom. O parser é sob demanda, possui cache limitado e NÃO usa OnUpdate.
local ITEM_EFFECT_CACHE_LIMIT = 4096
local itemEffectCache, itemEffectCacheCount = {}, 0

local effectStatPT = {
    ["Strength"]="Força", ["Agility"]="Agilidade", ["Stamina"]="Vigor",
    ["Intellect"]="Intelecto", ["Spirit"]="Espírito", ["Armor"]="Armadura",
    ["Block Value"]="Valor de Bloqueio", ["Block Rating"]="Índice de Bloqueio",
    ["Attack Power"]="Poder de Ataque", ["Ranged Attack Power"]="Poder de Ataque à Distância",
    ["Spell Power"]="Poder Mágico", ["Healing Power"]="Poder de Cura",
    ["Critical Strike Rating"]="Índice de Acerto Crítico", ["Haste Rating"]="Índice de Aceleração",
    ["Hit Rating"]="Índice de Acerto", ["Armor Penetration"]="Penetração de Armadura",
    ["Armor Penetration Rating"]="Índice de Penetração de Armadura",
    ["Spell Penetration"]="Penetração de Feitiço", ["Resilience"]="Resiliência",
    ["PvE Power"]="Poder JxA", ["PvP Power"]="Poder JxJ",
    ["critical strike chance"]="chance de acerto crítico", ["chance to hit"]="chance de acerto",
    ["healing done"]="cura realizada", ["damage done"]="dano causado",
}

local function EffectSpellPT(name)
    if type(name) ~= "string" or name == "" then return name end
    name = name:gsub("^%s+", ""):gsub("%s+$", "")
    local pt = A.SpellNameEN2ES and A.SpellNameEN2ES[name]
    if type(pt) == "string" and pt ~= "" and pt ~= name then return pt end
    if A.TranslateSpellNameText then
        local ok, value = pcall(A.TranslateSpellNameText, name)
        if ok and type(value) == "string" and value ~= "" and value ~= name then return value end
    end
    return name
end

local function EffectAbilityListPT(text)
    if type(text) ~= "string" then return text end
    local out = text
    -- Primeiro tenta a expressão inteira; vários nomes custom possuem "and" no nome.
    local whole = EffectSpellPT(out)
    if whole ~= out then return whole end
    out = out:gsub("([^,]+) and ([^,]+)$", function(a, b)
        return EffectSpellPT(a) .. " e " .. EffectSpellPT(b)
    end)
    return out
end

local function EffectStatNamePT(name)
    if type(name) ~= "string" then return name end
    return effectStatPT[name] or effectStatPT[name:gsub("^your%s+", "")] or name
end

local function EffectSeconds(v)
    return CleanStatNumber(v) .. " s"
end

local function TranslateItemEffectCore(core)
    if type(core) ~= "string" or core == "" then return nil end
    core = core:gsub("\194\160", " "):gsub("%s+$", "")

    -- AscensionDB: Eye of Magtheridon e procs modernos semelhantes.
    local power, dur, stacks, icd = core:match(
        "^Your direct healing and damaging spells grant ([%d%.,]+) spell power for ([%d%.,]+) sec%. Stacks up to ([%d%.,]+)%. This cannot occur more than once every ([%d%.,]+) seconds?%.?$")
    if power then
        return "Seus feitiços de cura direta e de dano concedem " .. CleanStatNumber(power)
            .. " de Poder Mágico por " .. EffectSeconds(dur) .. ". Acumula até "
            .. CleanStatNumber(stacks) .. " vezes. Isso não pode ocorrer mais de uma vez a cada "
            .. EffectSeconds(icd) .. "."
    end

    local rap
    rap, dur, stacks, icd = core:match(
        "^Your damaging melee and ranged abilities grant you ([%d%.,]+) Ranged Attack Power for ([%d%.,]+) sec, stacks up to ([%d%.,]+) times%. This can only occur every ([%d%.,]+) sec%.?$")
    if rap then
        return "Suas habilidades corpo a corpo e à distância que causam dano concedem "
            .. CleanStatNumber(rap) .. " de Poder de Ataque à Distância por " .. EffectSeconds(dur)
            .. ", acumulando até " .. CleanStatNumber(stacks) .. " vezes. Isso só pode ocorrer a cada "
            .. EffectSeconds(icd) .. "."
    end

    local pct
    pct, stacks, dur = core:match(
        "^Whenever a nearby enemy dies, your critical strike chance increases by ([%d%.,]+)%%%. Stacks up to ([%d%.,]+) times and lasts ([%d%.,]+) sec%.?$")
    if pct then
        return "Sempre que um inimigo próximo morrer, sua chance de acerto crítico aumenta em " .. CleanStatNumber(pct)
            .. "%. Acumula até " .. CleanStatNumber(stacks) .. " vezes e dura " .. EffectSeconds(dur) .. "."
    end

    local proc, school
    proc, school = core:match("^Casting damaging spells has a chance to unleash (.-), dealing (.-) damage to all enemies in combat%.?$")
    if proc then
        local schoolPT = ({ Chaos="Caos", Physical="Físico", Arcane="Arcano", Fire="Fogo", Frost="Gelo", Nature="Natureza", Shadow="Sombra", Holy="Sagrado" })[school] or school
        return "Lançar feitiços de dano tem uma chance de liberar " .. EffectSpellPT(proc)
            .. ", causando dano de " .. schoolPT .. " a todos os inimigos em combate."
    end

    proc = core:match("^Damaging melee abilities have a chance to unleash (.-), dealing physical damage to all enemies around you%.?$")
    if proc then
        return "Habilidades corpo a corpo que causam dano têm uma chance de liberar " .. EffectSpellPT(proc)
            .. ", causando dano Físico a todos os inimigos ao seu redor."
    end

    local armor, seconds = core:match("^Immobilizes the target and lowers their armor by ([%d%.,]+) for ([%d%.,]+) sec%.?$")
    if armor then
        return "Imobiliza o alvo e reduz a Armadura dele em " .. CleanStatNumber(armor) .. " por " .. EffectSeconds(seconds) .. "."
    end

    pct = core:match("^Increases your physical damage dealt, critical strike chance and chance to hit by ([%d%.,]+)%%%.?$")
    if pct then
        return "Aumenta em " .. CleanStatNumber(pct) .. "% o dano Físico causado, a chance de acerto crítico e a chance de acerto."
    end

    local markDur, markStacks
    pct, markDur, markStacks = core:match(
        "^Your melee attacks and abilities have a chance to mark your target%s*,? causing it to take ([%d%.,]+)%% more damage from your attacks and abilities for up to ([%d%.,]+) sec%. Stacking up to ([%d%.,]+) times%. Once fully stacked, this effect can'?t be refreshed%.?$")
    if pct then
        return "Seus ataques e habilidades corpo a corpo têm uma chance de marcar o alvo, fazendo-o receber "
            .. CleanStatNumber(pct) .. "% a mais de dano dos seus ataques e habilidades por até " .. EffectSeconds(markDur)
            .. ". Acumula até " .. CleanStatNumber(markStacks) .. " vezes. Ao atingir o máximo de acúmulos, o efeito não pode ser renovado."
    end

    local a1, a2, amount
    a1, a2, amount, dur = core:match(
        "^Your (.-) and (.-) abilities have a chance to grant you ([%d%.,]+) additional [Ss]trength for ([%d%.,]+) sec%.?$")
    if a1 then
        return "Suas habilidades " .. EffectSpellPT(a1) .. " e " .. EffectSpellPT(a2)
            .. " têm uma chance de conceder " .. CleanStatNumber(amount) .. " de Força adicional por " .. EffectSeconds(dur) .. "."
    end

    local ability = core:match("^Your (.-) ability now has a chance for its damage to be critical strikes%.?$")
    if ability then
        return "O dano da sua habilidade " .. EffectSpellPT(ability) .. " agora tem uma chance de causar acertos críticos."
    end

    local mana
    pct, mana = core:match("^Increases your healing done by ([%d%.,]+)%% while your mana is above ([%d%.,]+)%%%.?$")
    if pct then
        return "Aumenta em " .. CleanStatNumber(pct) .. "% a cura realizada enquanto sua Mana estiver acima de " .. CleanStatNumber(mana) .. "%."
    end

    local spirit, crit, heals, cooldown = core:match(
        "^When you bring a target to full health with a direct heal you gain ([%d%.,]+)%% of Spirit as healing power and ([%d%.,]+)%% critical effect chance for your next ([%d%.,]+) heals%. This effect can only occur once every ([%d%.,]+) seconds?%.?$")
    if spirit then
        return "Ao levar um alvo à vida máxima com uma cura direta, você recebe " .. CleanStatNumber(spirit)
            .. "% do seu Espírito como Poder de Cura e " .. CleanStatNumber(crit)
            .. "% de chance de efeito crítico nas próximas " .. CleanStatNumber(heals)
            .. " curas. Esse efeito só pode ocorrer uma vez a cada " .. EffectSeconds(cooldown) .. "."
    end

    amount = core:match("^Generate an additional Rage point whenever you take direct damage and your Block Value is increased by ([%d%.,]+)%.?$")
    if amount then
        return "Gera 1 ponto adicional de Raiva sempre que você recebe dano direto e aumenta seu Valor de Bloqueio em "
            .. CleanStatNumber(amount) .. "."
    end

    local armorPct, blockPct = core:match("^Increases the armor value from your equipped Shield by ([%d%.,]+)%% and your chance to block by ([%d%.,]+)%%%.?$")
    if armorPct then
        return "Aumenta em " .. CleanStatNumber(armorPct) .. "% a Armadura concedida pelo Escudo equipado e em "
            .. CleanStatNumber(blockPct) .. "% sua chance de bloqueio."
    end

    local rating, ratingPct, level, block = core:match(
        "^Block rating increased by ([%d%.,]+)%s*%(([%d%.,]+)%%%s*@%s*L(%d+)%) and block value increased by ([%d%.,]+)%.?$")
    if rating then
        return "Índice de Bloqueio aumentado em " .. CleanStatNumber(rating) .. " (" .. CleanStatNumber(ratingPct)
            .. "% no nível " .. level .. ") e Valor de Bloqueio aumentado em " .. CleanStatNumber(block) .. "."
    end

    local chance, str, blockValue
    chance, str, blockValue, dur, cooldown = core:match(
        "^Blocking an attack has a ([%d%.,]+)%% chance to enrage you, increasing your Strength by ([%d%.,]+) and Block Value by ([%d%.,]+) for ([%d%.,]+) sec seconds?%. %%(This effect can only occur once every ([%d%.,]+) seconds?%)%.?$")
    if chance then
        return "Bloquear um ataque tem " .. CleanStatNumber(chance) .. "% de chance de enfurecer você, aumentando sua Força em "
            .. CleanStatNumber(str) .. " e seu Valor de Bloqueio em " .. CleanStatNumber(blockValue) .. " por "
            .. EffectSeconds(dur) .. ". (Esse efeito só pode ocorrer uma vez a cada " .. EffectSeconds(cooldown) .. ".)"
    end

    local manaPct
    chance, manaPct = core:match("^Casting Nature Healing Spells has a ([%d%.,]+)%% chance to gain Mana equal to ([%d%.,]+)%% of the base cost of the spell%.?$")
    if chance then
        return "Lançar feitiços de cura de Natureza tem " .. CleanStatNumber(chance)
            .. "% de chance de restaurar Mana equivalente a " .. CleanStatNumber(manaPct) .. "% do custo básico do feitiço."
    end

    pct = core:match("^Your direct Healing spells will now trigger an additional heal on nearby ally, equivalent to ([%d%.,]+)%% of the original healing amount%.?$")
    if pct then
        return "Seus feitiços de cura direta agora acionam uma cura adicional em um aliado próximo equivalente a "
            .. CleanStatNumber(pct) .. "% da cura original."
    end

    pct, dur = core:match(
        "^Your spells are imbued with the power of the elements, giving successful casts a chance to grant you ([%d%.,]+)%% increased spell cr?tical strike chance on your next spell cast within ([%d%.,]+) seconds?%.?$")
    if pct then
        return "Seus feitiços são imbuídos com o poder dos elementos. Lançamentos bem-sucedidos têm uma chance de aumentar em "
            .. CleanStatNumber(pct) .. "% a chance de acerto crítico do próximo feitiço lançado em até " .. EffectSeconds(dur) .. "."
    end

    -- Set do Striker/Aspectos (o cliente pode concatenar as frases sem espaços).
    local aspects = core:match("^Aspects are empowered:(.+)$")
    if aspects then
        local out = aspects
        out = out:gsub("Aspect of the Beast:", "Aspecto da Fera: ")
        out = out:gsub("Aspect of the Hawk:", " Aspecto do Falcão: ")
        out = out:gsub("Aspect of the Monkey:", " Aspecto do Macaco: ")
        out = out:gsub("Aspect of the Wild:", " Aspecto da Natureza: ")
        out = out:gsub("Aspect of the Cheetah/Pack:", " Aspecto do Guepardo/Matilha: ")
        out = out:gsub("Attack power increased by ([%d%.,]+)%.?", "Poder de Ataque aumentado em %1. ")
        out = out:gsub("Increases you and your pet's Attack Power by ([%d%.,]+)%%%.?", "Aumenta em %1%% o Poder de Ataque seu e do seu mascote. ")
        out = out:gsub("Physical damage taken reduced by ([%d%.,]+)%%%.?", "Dano Físico recebido reduzido em %1%%. ")
        out = out:gsub("Magic Damage taken reduced by ([%d%.,]+)%%%.?", "Dano mágico recebido reduzido em %1%%. ")
        out = out:gsub("You are untrackable%.?", "Você não pode ser rastreado.")
        return "Aspectos fortalecidos: " .. out:gsub("%s+", " "):gsub("%s+$", "")
    end

    -- Conjuntos de raide/PvP confirmados na AscensionDB (T1-T6 e custom).
    pct = core:match("^Increase your spell critical strike chance by ([%d%.,]+)%%%.?$")
    if pct then
        return "Aumenta em " .. CleanStatNumber(pct) .. "% sua chance de acerto crítico com feitiços."
    end

    local hastePct, intellectPct, lasts = core:match(
        "^Your direct damaging spells have a chance to increase your Spell Haste by ([%d%.,]+)%% and Spell Power by ([%d%.,]+)%% of your Intellect%. Lasts ([%d%.,]+) sec%.?$")
    if hastePct then
        return "Seus feitiços de dano direto têm uma chance de aumentar sua Aceleração de Feitiços em "
            .. CleanStatNumber(hastePct) .. "% e seu Poder Mágico em " .. CleanStatNumber(intellectPct)
            .. "% do seu Intelecto. Dura " .. EffectSeconds(lasts) .. "."
    end

    local manaRestore, manaICD = core:match(
        "^Your melee attacks have a chance of restoring ([%d%.,]+)%% base mana%. This effect can only occur once every ([%d%.,]+) seconds?%.?$")
    if manaRestore then
        return "Seus ataques corpo a corpo têm uma chance de restaurar " .. CleanStatNumber(manaRestore)
            .. "% da Mana base. Esse efeito só pode ocorrer uma vez a cada " .. EffectSeconds(manaICD) .. "."
    end

    local critRating, critPct, critLevel, critDur, critICD = core:match(
        "^Periodic Damage has a chance to increase critical strike rating by ([%d%.,]+)%s*%(([%d%.,]+)%%%s*@%s*L(%d+)%) for ([%d%.,]+) sec%. This can only occur once every ([%d%.,]+) seconds?%.?$")
    if critRating then
        return "O dano periódico tem uma chance de aumentar o Índice de Acerto Crítico em "
            .. CleanStatNumber(critRating) .. " (" .. CleanStatNumber(critPct) .. "% no nível " .. critLevel
            .. ") por " .. EffectSeconds(critDur) .. ". Isso só pode ocorrer uma vez a cada " .. EffectSeconds(critICD) .. "."
    end

    pct = core:match("^Increases your melee and ranged attack speed by ([%d%.,]+)%%%.?$")
    if pct then
        return "Aumenta em " .. CleanStatNumber(pct) .. "% sua velocidade de ataque corpo a corpo e à distância."
    end

    pct = core:match("^Reduces the cost of spells and abilities by ([%d%.,]+)%%%.?$")
    if pct then
        return "Reduz em " .. CleanStatNumber(pct) .. "% o custo de feitiços e habilidades."
    end

    local base, ppl, scale, attackICD = core:match(
        "^Your attacks have a chance to strike the target for ([%d%.,]+)%+([%d%.,]+) Points Per Level%+%(SP%+AP%)%*([%d%.,]+)%. This effect can not occur more than once every ([%d%.,]+) seconds?%.?$")
    if base then
        return "Seus ataques têm uma chance de atingir o alvo causando " .. CleanStatNumber(base) .. " + "
            .. CleanStatNumber(ppl) .. " por nível + (Poder Mágico + Poder de Ataque) × " .. CleanStatNumber(scale)
            .. " de dano. Esse efeito não pode ocorrer mais de uma vez a cada " .. EffectSeconds(attackICD) .. "."
    end

    pct = core:match("^Increases your spell damage by ([%d%.,]+)%% of your Spirit%.?$")
    if pct then
        return "Aumenta o dano dos seus feitiços em " .. CleanStatNumber(pct) .. "% do seu Espírito."
    end

    local manaThreshold, soulName, school, damagePct, soulDur, drainPct = core:match(
        "^While above ([%d%.,]+)%% mana, your direct damage spells have a chance to trigger a (.-), dealing (.-) damage to the target and increasing your damage done by ([%d%.,]+)%% for ([%d%.,]+) seconds? but draining ([%d%.,]+)%% of your mana each second%.?$")
    if manaThreshold then
        local schoolPT = ({ Chaos="Caos", Physical="Físico", Arcane="Arcano", Fire="Fogo", Frost="Gelo", Nature="Natureza", Shadow="Sombra", Holy="Sagrado" })[school] or school
        return "Enquanto estiver acima de " .. CleanStatNumber(manaThreshold) .. "% de Mana, seus feitiços de dano direto têm uma chance de ativar "
            .. EffectSpellPT(soulName) .. ", causando dano de " .. schoolPT .. " ao alvo e aumentando em " .. CleanStatNumber(damagePct)
            .. "% o dano que você causa por " .. EffectSeconds(soulDur) .. ", mas drenando " .. CleanStatNumber(drainPct) .. "% da sua Mana a cada segundo."
    end

    local opposite, bonus, bonusSchool, bonusDur = core:match(
        "^Your direct damage (.-) spells have a chance to grant you ([%d%.,]+) bonus (.-) damage for ([%d%.,]+) sec%.?$")
    if opposite then
        local schools = { Fire="Fogo", Shadow="Sombra", Frost="Gelo", Arcane="Arcano", Nature="Natureza", Holy="Sagrado" }
        return "Seus feitiços de dano direto de " .. (schools[opposite] or opposite) .. " têm uma chance de conceder "
            .. CleanStatNumber(bonus) .. " de bônus de dano de " .. (schools[bonusSchool] or bonusSchool)
            .. " por " .. EffectSeconds(bonusDur) .. "."
    end

    local corruptionDur = core:match("^Increases the duration of your (.-) by ([%d%.,]+) sec%.?$")
    if corruptionDur then
        local spell, sec = core:match("^Increases the duration of your (.-) by ([%d%.,]+) sec%.?$")
        return "Aumenta em " .. EffectSeconds(sec) .. " a duração de " .. EffectSpellPT(spell) .. "."
    end

    local seedDelay = core:match(
        "^Your damage and healing spells have a chance to plant a seed in the target, which will heal friendly or damage enemy target after ([%d%.,]+) seconds?%. These effect share a cooldown%.?$")
    if seedDelay then
        return "Seus feitiços de dano e cura têm uma chance de plantar uma semente no alvo, que após " .. EffectSeconds(seedDelay)
            .. " cura um alvo aliado ou causa dano a um alvo inimigo. Esses efeitos compartilham a recarga."
    end

    pct = core:match("^Spell haste increased by ([%d%.,]+)%%%.?$")
    if pct then return "Aceleração de Feitiços aumentada em " .. CleanStatNumber(pct) .. "%." end

    local hpPct, hpEvery = core:match("^While shapeshifted you gain ([%d%.,]+)%% of your health every ([%d%.,]+) sec%.?$")
    if hpPct then
        return "Enquanto estiver em forma metamorfoseada, você recupera " .. CleanStatNumber(hpPct)
            .. "% da sua vida a cada " .. EffectSeconds(hpEvery) .. "."
    end

    local beamRating, beamPct, beamLevel, beamHeal, beamDur = core:match(
        "^Your damage and healing spells have a chance to summon a beam of light at your location, which increases your spell haste rating by ([%d%.,]+)%s*%(([%d%.,]+)%%%s*@%s*L(%d+)%) and your healing done by ([%d%.,]+)%% for ([%d%.,]+) sec%.?$")
    if beamRating then
        return "Seus feitiços de dano e cura têm uma chance de invocar um feixe de luz na sua posição, aumentando seu Índice de Aceleração de Feitiços em "
            .. CleanStatNumber(beamRating) .. " (" .. CleanStatNumber(beamPct) .. "% no nível " .. beamLevel .. ") e a cura realizada em "
            .. CleanStatNumber(beamHeal) .. "% por " .. EffectSeconds(beamDur) .. "."
    end

    local targetHealth, spellDamage = core:match("^You deal ([%d%.,]+)%% increased spell damage to targets above ([%d%.,]+)%% health%.?$")
    if targetHealth then -- captures are damage first, health second
        local dmg, hp = core:match("^You deal ([%d%.,]+)%% increased spell damage to targets above ([%d%.,]+)%% health%.?$")
        return "Você causa " .. CleanStatNumber(dmg) .. "% a mais de dano com feitiços contra alvos acima de " .. CleanStatNumber(hp) .. "% de vida."
    end

    local spiritDamage, spiritCrit, sharedCD, sharedDur = core:match(
        "^Your non%-periodic spell criticals have a chance to increase your spell damage by ([%d%.,]+)%% of your Spirit%. Your non%-periodic non%-critical spells have a chance to increase your critical strike rating by ([%d%.,]+)%% of your Spirit%. Both effects share a ([%d%.,]+) second cooldown and last for ([%d%.,]+) seconds%.?$")
    if spiritDamage then
        return "Seus acertos críticos de feitiços não periódicos têm uma chance de aumentar o dano dos seus feitiços em "
            .. CleanStatNumber(spiritDamage) .. "% do seu Espírito. Seus feitiços não periódicos que não forem críticos têm uma chance de aumentar seu Índice de Acerto Crítico em "
            .. CleanStatNumber(spiritCrit) .. "% do seu Espírito. Os dois efeitos compartilham uma recarga de " .. EffectSeconds(sharedCD)
            .. " e duram " .. EffectSeconds(sharedDur) .. "."
    end

    local lowHp, healingInc = core:match("^Increases your healing done to targets below ([%d%.,]+)%% health by ([%d%.,]+)%%%.?$")
    if lowHp then
        return "Aumenta em " .. CleanStatNumber(healingInc) .. "% a cura realizada em alvos abaixo de " .. CleanStatNumber(lowHp) .. "% de vida."
    end

    local spiritPct, healingSpiritPct, healDur, healICD = core:match(
        "^When you bring a target to full health with a periodic heal you have a chance to increase your Spirit by ([%d%.,]+)%% and your healing power by ([%d%.,]+)%% of your Spirit for ([%d%.,]+) sec%. This effect can only occur every ([%d%.,]+) seconds?%.?$")
    if spiritPct then
        return "Ao levar um alvo à vida máxima com uma cura periódica, você tem uma chance de aumentar seu Espírito em "
            .. CleanStatNumber(spiritPct) .. "% e seu Poder de Cura em " .. CleanStatNumber(healingSpiritPct) .. "% do seu Espírito por "
            .. EffectSeconds(healDur) .. ". Esse efeito só pode ocorrer a cada " .. EffectSeconds(healICD) .. "."
    end

    local aboveHealth, healEff, belowHealth, castSpeed = core:match(
        "^While above ([%d%.,]+)%% health your healing spells are ([%d%.,]+)%% more effective and while below ([%d%.,]+)%% health you gain ([%d%.,]+)%% increased cast speed%.?$")
    if aboveHealth then
        return "Enquanto estiver acima de " .. CleanStatNumber(aboveHealth) .. "% de vida, seus feitiços de cura são "
            .. CleanStatNumber(healEff) .. "% mais eficazes; enquanto estiver abaixo de " .. CleanStatNumber(belowHealth)
            .. "% de vida, sua velocidade de lançamento aumenta em " .. CleanStatNumber(castSpeed) .. "%."
    end

    local selfHealPct = core:match("^You heal yourself for ([%d%.,]+)%% of your healing done to others when your target is at a health deficit%.?$")
    if selfHealPct then
        return "Você se cura em " .. CleanStatNumber(selfHealPct)
            .. "% da cura realizada em outros quando seu alvo não está com a vida máxima."
    end

    local consecrateDur, yards, tick = core:match(
        "^Your direct healing spells have a chance to consecrate the ground at your target's feet for ([%d%.,]+) sec in an ([%d%.,]+) yard radius, healing all allies standing within every ([%d%.,]+) sec%.?$")
    if consecrateDur then
        return "Seus feitiços de cura direta têm uma chance de consagrar o chão aos pés do alvo por " .. EffectSeconds(consecrateDur)
            .. " em um raio de " .. CleanStatNumber(yards) .. " m, curando todos os aliados na área a cada " .. EffectSeconds(tick) .. "."
    end

    local poisonName, mixName = core:match("^Your melee attacks have a chance to poison your target with (.-) or inject you with (.-)%.?$")
    if poisonName then
        return "Seus ataques corpo a corpo têm uma chance de envenenar o alvo com " .. EffectSpellPT(poisonName)
            .. " ou injetar em você " .. EffectSpellPT(mixName) .. "."
    end

    -- Encantamentos de arma custom do AscensionDB.
    local enchantName, apen = core:match("^(.-) %- Armor Penetration increased by ([%d%.,]+)%.?$")
    if enchantName then
        return EffectSpellPT(enchantName) .. " — Penetração de Armadura aumentada em " .. CleanStatNumber(apen) .. "."
    end

    local sp, ap
    enchantName, sp, ap = core:match("^(.-) %- Spell Power increased by ([%d%.,]+)%. Attack Power increased by ([%d%.,]+)%.?$")
    if enchantName then
        return EffectSpellPT(enchantName) .. " — Poder Mágico aumentado em " .. CleanStatNumber(sp)
            .. ". Poder de Ataque aumentado em " .. CleanStatNumber(ap) .. "."
    end

    local energy, agi, enchantDur = core:match(
        "^Permanently enchant a melee weapon to have a chance to regenerate ([%d%.,]+) energy and increase your Agility by ([%d%.,]+) for ([%d%.,]+) seconds? when dealing melee damage%.?$")
    if energy then
        return "Encanta permanentemente uma arma corpo a corpo para ter uma chance, ao causar dano corpo a corpo, de regenerar "
            .. CleanStatNumber(energy) .. " de Energia e aumentar sua Agilidade em " .. CleanStatNumber(agi) .. " por " .. EffectSeconds(enchantDur) .. "."
    end

    -- Famílias genéricas frequentes de procs. Só retornam quando a estrutura é conhecida.
    local stat, value
    stat, value, dur = core:match("^Increases your (.-) by ([%d%.,]+)%% for ([%d%.,]+) sec%.?$")
    if stat then
        return "Aumenta " .. EffectStatNamePT(stat) .. " em " .. CleanStatNumber(value) .. "% por " .. EffectSeconds(dur) .. "."
    end

    stat, value, dur = core:match("^Increases your (.-) by ([%d%.,]+) for ([%d%.,]+) sec%.?$")
    if stat then
        return "Aumenta " .. EffectStatNamePT(stat) .. " em " .. CleanStatNumber(value) .. " por " .. EffectSeconds(dur) .. "."
    end

    stat, value, dur = core:match("^Grants? ([%d%.,]+) (.-) for ([%d%.,]+) sec%.?$")
    if stat then -- captures are amount, stat, duration due Lua assignment order below corrected by rematch
        local v, s, d = core:match("^Grants? ([%d%.,]+) (.-) for ([%d%.,]+) sec%.?$")
        return "Concede " .. CleanStatNumber(v) .. " de " .. EffectStatNamePT(s) .. " por " .. EffectSeconds(d) .. "."
    end

    local heal = core:match("^Heals you for ([%d%.,]+)%.?$")
    if heal then return "Cura você em " .. CleanStatNumber(heal) .. "." end

    local healAmount, strength, effectDur = core:match("^Chance to heal self for ([%d%.,]+) and increase Strength by ([%d%.,]+) for ([%d%.,]+) sec%.?$")
    if healAmount then
        return "Chance de curar você em " .. CleanStatNumber(healAmount) .. " e aumentar sua Força em "
            .. CleanStatNumber(strength) .. " por " .. EffectSeconds(effectDur) .. "."
    end

    local s1, v1, s2, v2 = core:match("^Chance to increase (.-) by ([%d%.,]+) and (.-) by ([%d%.,]+)%.?$")
    if s1 then
        return "Chance de aumentar " .. EffectStatNamePT(s1) .. " em " .. CleanStatNumber(v1)
            .. " e " .. EffectStatNamePT(s2) .. " em " .. CleanStatNumber(v2) .. "."
    end

    local source, gain, gainStat, gainDur = core:match("^Your (.-) grants? you ([%d%.,]+) (.-) for ([%d%.,]+) sec%.?$")
    if source then
        return EffectAbilityListPT(source) .. " concede " .. CleanStatNumber(gain) .. " de "
            .. EffectStatNamePT(gainStat) .. " por " .. EffectSeconds(gainDur) .. "."
    end

    local trigger, targetStat, targetGain, targetDur = core:match(
        "^Your (.-) has a chance to increase your (.-) by ([%d%.,]+) for ([%d%.,]+) sec%.?$")
    if trigger then
        return EffectAbilityListPT(trigger) .. " tem uma chance de aumentar " .. EffectStatNamePT(targetStat)
            .. " em " .. CleanStatNumber(targetGain) .. " por " .. EffectSeconds(targetDur) .. "."
    end

    -- Sentenças auxiliares que aparecem isoladas em tooltips custom.
    stacks = core:match("^Stacks up to ([%d%.,]+) times%.?$")
    if stacks then return "Acumula até " .. CleanStatNumber(stacks) .. " vezes." end
    stacks = core:match("^Stacks up to ([%d%.,]+)%.?$")
    if stacks then return "Acumula até " .. CleanStatNumber(stacks) .. " vezes." end
    icd = core:match("^This can only occur every ([%d%.,]+) sec%.?$")
    if icd then return "Isso só pode ocorrer a cada " .. EffectSeconds(icd) .. "." end
    icd = core:match("^This effect can only occur once every ([%d%.,]+) seconds?%.?$")
    if icd then return "Esse efeito só pode ocorrer uma vez a cada " .. EffectSeconds(icd) .. "." end
    icd = core:match("^This cannot occur more than once every ([%d%.,]+) seconds?%.?$")
    if icd then return "Isso não pode ocorrer mais de uma vez a cada " .. EffectSeconds(icd) .. "." end
    if core:match("^Once fully stacked, this effect can'?t be refreshed%.?$") then
        return "Ao atingir o máximo de acúmulos, esse efeito não pode ser renovado."
    end

    return nil
end
A.TranslateItemEffectCore = TranslateItemEffectCore

local itemEffectPrefixes = {
    ["Equip: "]="Equipar: ", ["Equipar: "]="Equipar: ", ["Equipado: "]="Equipar: ",
    ["Use: "]="Usar: ", ["Usar: "]="Usar: ", ["Uso: "]="Usar: ",
    ["Set: "]="Conjunto: ", ["Conjunto: "]="Conjunto: ",
    ["Chance on hit: "]="Chance ao acertar: ", ["Chance on Hit: "]="Chance ao acertar: ",
    ["Chance ao acertar: "]="Chance ao acertar: ",
}

function A.TranslateItemEffectLine(text)
    if type(text) ~= "string" or text == "" then return nil end
    local cached = itemEffectCache[text]
    if cached ~= nil then return cached ~= false and cached or nil end

    local prefix, core = "", text
    local pieces, body = text:match("^%((%d+)%) Set:%s*(.+)$")
    if pieces then
        prefix, core = "(" .. pieces .. ") Conjunto: ", body
    else
        pieces, body = text:match("^%((%d+)%) Set Bonus:%s*(.+)$")
        if pieces then
            prefix, core = "(" .. pieces .. ") Bônus de conjunto: ", body
        else
            for enPrefix, ptPrefix in pairs(itemEffectPrefixes) do
                if text:sub(1, #enPrefix) == enPrefix then
                    prefix, core = ptPrefix, text:sub(#enPrefix + 1)
                    break
                end
            end
        end
    end

    local translated = TranslateItemEffectCore(core)
    if translated then translated = LocalizeStatDecimals(prefix .. translated) end

    if itemEffectCacheCount >= ITEM_EFFECT_CACHE_LIMIT then
        itemEffectCache, itemEffectCacheCount = {}, 0
    end
    itemEffectCache[text] = translated or false
    itemEffectCacheCount = itemEffectCacheCount + 1
    return translated
end
