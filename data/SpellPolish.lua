AscensionPTBR = AscensionPTBR or {}

local A = AscensionPTBR

-- Acertos de habilidades custom e termos que ainda estavam com espanhol/portunhol.
-- Proc/CDR/SLS/Stacker continuam em inglês de propósito: são rótulos internos do Ascension.
do
    local T = A.SpellNameEN2ES
    if T then
        local fixed = {
            ["Temporal Contract: Adventurers Needed"] = "Contrato Temporal: Procuram-se Aventureiros",
            ["Temporal Contract: City Siege"] = "Contrato Temporal: Cerco à Cidade",
            ["Temporal Contract: Death to the Felforged!"] = "Contrato Temporal: Morte aos Forjados pelo Vil!",
            ["Temporal Contract: Dungeon Crawling"] = "Contrato Temporal: Exploração de Masmorras",
            ["Temporal Contract: High Risk Adventurer's Contact"] = "Contrato Temporal: Contrato de Aventureiro de Alto Risco",
            ["Temporal Contract: High Risk Keeping Evil at Bay"] = "Contrato Temporal: Alto Risco — Mantendo o Mal à Distância",
            ["Temporal Contract: High Risk Lesser Known Issue"] = "Contrato Temporal: Alto Risco — Problema Menos Conhecido",
            ["Temporal Contract: High Risk Threat to Azeroth"] = "Contrato Temporal: Alto Risco — Ameaça a Azeroth",
            ["Temporal Contract: Honorable Combat"] = "Contrato Temporal: Combate Honroso",
            ["Temporal Contract: Keeping Evil At Bay"] = "Contrato Temporal: Mantendo o Mal à Distância",
            ["Temporal Contract: Keeping Evil at Bay"] = "Contrato Temporal: Mantendo o Mal à Distância",
            ["Temporal Contract: Lesser Known Issue"] = "Contrato Temporal: Problema Menos Conhecido",
            ["Temporal Contract: Population Control"] = "Contrato Temporal: Controle Populacional",
            ["Temporal Contract: Proving Grounds"] = "Contrato Temporal: Campo de Provas",
            ["Temporal Contract: Raid Timewalking"] = "Contrato Temporal: Raide de Caminhada Temporal",
            ["Temporal Contract: Threat to Azeroth"] = "Contrato Temporal: Ameaça a Azeroth",
            ["Temporal Contract: [High-Risk] Keeping Evil at Bay"] = "Contrato Temporal: [Alto Risco] Mantendo o Mal à Distância",
            ["Temporal Contract: [High-Risk] Population Control"] = "Contrato Temporal: [Alto Risco] Controle Populacional",
            ["Temporal Haste Charge Removal"] = "Aceleração Temporal — Remoção de Carga",
            ["Temporal Haste Surge of Light condition"] = "Aceleração Temporal — Condição de Onda de Luz",
            ["Temporal Phase Modulator"] = "Modulador de Fase Temporal",
            ["Temporal Shift Eclipse (Lunar)"] = "Deslocamento Temporal — Eclipse Lunar",
            ["Temporal Shift Stacks (Invisible)"] = "Acúmulos de Deslocamento Temporal (Invisível)",
            ["Temporal Shift While Casting Stacker Aura"] = "Aura Stacker de Deslocamento Temporal Durante Conjuração",
            ["Temporal Shift lunar eclipse buff"] = "Bônus de Eclipse Lunar — Deslocamento Temporal",
            ["Temporal Shockwave Mana Bomb"] = "Bomba de Mana da Onda de Choque Temporal",
            ["Temporal Swiftness"] = "Rapidez Temporal",
            ["Temporal duration mod"] = "Modificador de Duração Temporal",
            ["Temporally Warped"] = "Distorcido Temporalmente",

            ["Chrono Herald"] = "Arauto Cronal",
            ["Chrono Mend"] = "Recomposição Cronal",
            ["Chrono Nova"] = "Nova Cronal",
            ["Chrono Sorcery"] = "Feitiçaria Cronal",
            ["Chrono Spike"] = "Espinho Cronal",
            ["Chrono-Mend"] = "Recomposição Cronal",
            ["Chronobeam"] = "Raio Cronal",
            ["Chronobeam Passive"] = "Raio Cronal — Passivo",
            ["Chronological"] = "Cronológico",
            ["Chronomancer (Infinite)"] = "Cronomante (Infinito)",
            ["Chronometric Pressure"] = "Pressão Cronométrica",
            ["Chronosphere"] = "Cronosfera",
            ["Chronotrapped"] = "Preso no Tempo",
            ["Conjure Chrono-Beacon"] = "Conjurar Sinalizador Cronal",
            ["Sigil of Chrono Lord Deja"] = "Selo do Crono-lorde Deja",
            ["Sigil of Chrono-Lord Epoch"] = "Selo do Crono-lorde Éon",

            ["Fel Cleave"] = "Cutilada Vil",
            ["Fel Cleave cdr - Annihilian Momentum"] = "Cutilada Vil — CDR de Ímpeto Aniquilano",
            ["Fel Corruption"] = "Corrupção Vil",
            ["Fel Corruption Felblade"] = "Corrupção Vil — Lâmina Vil",
            ["Fel Corruption fel cleave CDR"] = "Corrupção Vil — CDR de Cutilada Vil",
            ["Fel Corruption felblade"] = "Corrupção Vil — Lâmina Vil",
            ["Fel Hunger"] = "Fome Vil",
            ["Fel Hunger CDR"] = "Fome Vil — CDR",
            ["Fel Hunger Duration increase"] = "Fome Vil — Aumento de Duração",
            ["Fel Shock"] = "Choque Vil",
            ["Fel Shock CDR"] = "Choque Vil — CDR",
            ["Felblade"] = "Lâmina Vil",
            ["Felblade cdr - Warping Felblade"] = "Lâmina Vil — CDR de Lâmina Vil Distorcida",
            ["Felfire"] = "Fogo Vil",
            ["Felfire Adept"] = "Adepto do Fogo Vil",
            ["Felfire Aura"] = "Aura de Fogo Vil",
            ["Felfire Blast"] = "Explosão de Fogo Vil",
            ["Felfire Breath"] = "Sopro de Fogo Vil",
            ["Felfire Cascade"] = "Cascata de Fogo Vil",
            ["Felfire Fission"] = "Fissão de Fogo Vil",
            ["Felfire Hawk"] = "Falcão de Fogo Vil",
            ["Felfire Hound"] = "Cão de Fogo Vil",
            ["Felfire Impling"] = "Diabrete de Fogo Vil",
            ["Felfire Infusion"] = "Infusão de Fogo Vil",
            ["Felfire Portal"] = "Portal de Fogo Vil",
            ["Felfire Proc"] = "Proc de Fogo Vil",
            ["Felfire Scope"] = "Mira de Fogo Vil",
            ["Felfire Shield"] = "Escudo de Fogo Vil",
            ["Felfire Shock"] = "Choque de Fogo Vil",
            ["Felfire Spirehawk"] = "Falcão-agulha de Fogo Vil",
            ["Felfire Sprint"] = "Arrancada de Fogo Vil",
            ["Felfire Steed"] = "Corcel de Fogo Vil",
            ["Felfire Wings"] = "Asas de Fogo Vil",
            ["Wild Felfire"] = "Fogo Vil Selvagem",
            ["Wild Felfire Chaos Bolt CDR"] = "Fogo Vil Selvagem — CDR de Seta do Caos",
            ["Wild Felfire Chaos Bolt CDR "] = "Fogo Vil Selvagem — CDR de Seta do Caos",
            ["Wild Felfire Chaos Bolt CDR SLS (Fire Spells Mage)"] = "Fogo Vil Selvagem — CDR de Seta do Caos SLS (Feitiços de Fogo do Mago)",
            ["Wild Felfire Dispel"] = "Fogo Vil Selvagem — Dissipar",
            ["Wild Felfire SLS learn"] = "Fogo Vil Selvagem — Aprender SLS",

            ["Twin Fang"] = "Presas Gêmeas",
            ["Twin Fangs"] = "Presas Gêmeas",
            ["Twin Fang -  Mongoose Bite, Raptor Strike and Glaive Toss cdr"] = "Presas Gêmeas — CDR de Mordida de Mangusto, Golpe do Raptor e Arremesso de Glaive",
            ["Arcanesworn"] = "Juramentado Arcano",
            ["Arcanesworn - Arcane Zealotry proc sls"] = "Juramentado Arcano — Proc de Fanatismo Arcano SLS",
            ["Arcanesworn - Missile Barrage consumption and Avenging Wrath CDR"] = "Juramentado Arcano — Consumo de Barragem de Mísseis e CDR de Ira Vingativa",
            ["Annihilan Decimation - Felblade and Fel Cleave CDR"] = "Dizimação Annihilan — CDR de Lâmina Vil e Cutilada Vil",
            ["Mana-forged Barrier"] = "Barreira Forjada em Mana",
            ["Mana-forged Barrier Passive"] = "Barreira Forjada em Mana — Passivo",
            ["Mana-forged Mindset"] = "Mentalidade Forjada em Mana",
            ["Mystic Thunder"] = "Trovão Místico",
            ["Mystical Disjunction"] = "Disjunção Mística",
        }

        for en, pt in pairs(fixed) do
            T[en] = pt
        end
    end
end

-- Descrições de talentos/habilidades que ainda estavam com frases quebradas.
do
    local D = A.DescPairs
    if D then
        local fixed = {
            [98068] = "Aumenta em {{1}}% o dano causado por Garrote e Ruptura.",
            [98071] = "Seus acertos com Emboscar e Punhalada pelas Costas podem desequilibrar o alvo, aumentando em {{1}}% o intervalo entre os ataques corpo a corpo e à distância dele e reduzindo sua velocidade de movimento em {{2}}% durante {{3}}.",
            [98072] = "Reduz em {{1}} o custo de Energia de Punhalada pelas Costas e Emboscar, reduz em {{2}} o custo de Energia de Hemorragia e aumenta em {{3}}% todo o dano causado.",
            [98073] = "Incapacita o alvo por até {{1}}. Requer Furtividade. Funciona apenas contra Humanoides, Feras, Demônios e Draconianos que não estejam em combate. Qualquer dano desperta o alvo. Apenas um alvo pode ser afetado por Nocautear por vez.",
            [98074] = "Quando seu mascote está com menos de 35% de vida, ele causa {{1}}% a mais de dano e tem a chance de receber acertos críticos reduzida em {{2}}%.",
            [98075] = "Seus ataques corpo a corpo têm uma chance de permitir o uso de Executar independentemente da vida atual do alvo.",
            [98077] = "Depois de lançar Palavra de Poder: Escudo, seu próximo feitiço recebe {{1}}% de aceleração. A absorção de Palavra de Poder: Escudo também aumenta em um valor equivalente a {{2}}% do seu poder mágico.",
            [98078] = "Seu mascote investe contra um inimigo, imobilizando-o e adicionando poder de ataque corpo a corpo ao próximo ataque do mascote.",
            [98080] = "O Rosnar do seu mascote gera {{1}}% a mais de ameaça e restaura 10% da felicidade total dele.",
            [98081] = "Reduz em {{1}}% a penalidade de velocidade de movimento causada por Agachar no seu mascote.",
            [98083] = "Os ataques do seu mascote têm 10% de chance de aumentar a felicidade em 5% e restaurar 5% da vida total dele.",
            [98084] = "Os ataques do seu mascote têm 20% de chance de aumentar a felicidade em 5% e restaurar 5% da vida total dele.",
            [98085] = "Aumenta em {{1}}% o dano dos seus disparos e das habilidades especiais do mascote contra alvos marcados. Também aumenta em {{2}}% o bônus de dano crítico de Tiro Certo, Tiro Arcano, Tiro Firme, Tiro Mortal e Tiro Quimérico.",
            [98086] = "Ao causar um acerto crítico com Tiro Arcano, Tiro Firme ou Tiro Mortal, você tem {{1}}% de chance de fazer com que os próximos 2 ataques especiais do seu mascote sejam críticos.",
            [98087] = "Ao causar um acerto crítico com Tiro Arcano, Tiro Firme ou Tiro Mortal, você pode fazer com que os próximos 2 ataques especiais do seu mascote sejam críticos.",
            [98088] = "Reduz em {{1}}% a recarga de Ira Bestial, Intimidação e das habilidades especiais do seu mascote.",
            [98089] = "Você domina a arte de treinar feras, aprendendo a domar mascotes Exóticos e aumentando em {{1}} o total de Pontos de Habilidade do seu mascote.",
            [98090] = "Se Picada de Mantícora for dissipada, quem a dissipou também será afetado por ela durante {{1}}% do tempo restante. Além disso, você causa {{2}}% a mais de dano contra alvos afetados por Picada de Serpente.",
            [98091] = "Aumenta em {{1}}% a chance de acerto crítico de todos os seus ataques contra alvos afetados por Armadilha de Gelo, Armadilha Congelante e Flecha Congelante.",
            [98092] = "Enquanto estiver ativo, sempre que um inimigo atingir o conjurador ele terá {{1}}% de chance de ser afetado por Raízes Enredantes (Grau 8). Possui {{2}} cargas. Dura {{3}}.",
            [98093] = "Tenta finalizar um alvo ferido com um disparo de longo alcance que causa {{1}}% do dano da arma mais {{2}}. Tiro Mortal só pode ser usado contra inimigos com 20% de vida ou menos.",
            [98094] = "Reduz em {{1}}% a duração dos efeitos de Atordoamento e Medo aplicados ao seu mascote.",
            [98095] = "Enquanto canaliza, seu mascote restaura {{1}}% da vida total ao longo de {{2}}.",
            [98097] = "Seu mascote ruge, aumentando em {{1}}% o poder de ataque corpo a corpo e à distância dele e o seu. Dura {{2}}.",
            [98098] = "Reduz em {{1}}% a chance de seu mascote receber um acerto crítico de ataques corpo a corpo.",
            [98099] = "Aumenta em {{1}}% o Vigor total do seu mascote e em {{2}}% toda a cura recebida por ele.",
            [98100] = "Reduz em {{1}} s a recarga da habilidade Velocidade do seu mascote.",
            [98101] = "Aumenta em {{1}}% o dano de Julgamento, Golpe do Cruzado e Tempestade Divina. Quando um ataque corpo a corpo seu causa um acerto crítico, o próximo Clarão de Luz ou Exorcismo é lançado instantaneamente.",
            [98189] = "Aumenta em {{1}}% o dano de Multidisparo, Tiro Certo e Saraivada.",
            [98191] = "Aumenta todas as resistências em 0,5 por nível. Sempre que você resistir completamente a um feitiço, restaura {{1}}% da sua mana total. Recarga de 1 s.",
            [98192] = "Aumenta todas as resistências em 1 por nível. Sempre que você resistir completamente a um feitiço, restaura {{1}}% da sua mana total. Recarga de 1 s.",
            [98193] = "Aumenta em {{1}}% a eficácia de Armadura Demoníaca e Armadura Vil.",
            [98194] = "Aumenta sua perícia em {{1}} e aumenta em {{2}}% o poder de ataque dos membros do grupo e da raide em um raio de {{3}} m do xamã.",
            [98196] = "Depois de receber Lançamento Livre ou Presença de Espírito, a chance de acerto crítico do seu próximo feitiço de dano aumenta em {{1}}%.",
            [98197] = "Aumenta sua perícia em {{1}} e aumenta em {{2}}% seu Vigor total e sua chance de acerto crítico.",
            [98198] = "Aumenta em {{1}}% seu dano com feitiços e em {{2}}% a chance de acerto crítico periódico de Corrupção e Aflição Instável.",
            [98199] = "Fogo Estelar recebe mais {{1}}% dos seus efeitos de bônus de dano, e Ira recebe mais {{2}}%.",
            [98200] = "Aumenta em {{1}}% a chance de acerto crítico de Multidisparo e Tiro Certo e reduz em {{2}}% o atraso de canalização sofrido por dano enquanto você usa Saraivada.",
            [98201] = "Aumenta em {{1}}% a chance de acerto crítico de Ira, Fogo Estelar, Chuva Estelar, Nutrir e Toque de Cura.",
            [98202] = "Aumenta sua perícia em {{1}}. Se um finalizador errar o alvo, você recupera {{2}}% do custo de Energia dele.",
            [98203] = "Seus feitiços e habilidades causam 2% a mais de dano contra alvos afetados por Peste de Sangue. Também aumenta sua perícia em {{1}}.",
            [98204] = "Quando você é atordoado, amedrontado ou silenciado, desloca-se para o Plano Astral e recebe {{1}}% menos dano enquanto durar o efeito.",
            [98205] = "Seus ataques e habilidades corpo a corpo têm {{1}}% de chance de atingir o alvo com uma carga de orbe de Escudo de Raios. Escudo de Raios também recebe {{2}} cargas adicionais.",
            [98206] = "Aumenta seu Poder de Ataque em um valor equivalente a {{1}}% do seu Intelecto.",
            [98211] = "Onda Explosiva e Sopro do Dragão têm uma chance de fazer com que sua próxima Coluna de Chamas seja instantânea e não custe mana.",
            [98212] = "Aumenta o poder de ataque corpo a corpo e à distância seu e do seu mascote em um valor equivalente a {{1}}% do seu Vigor total.",
            [98214] = "Reduz em {{1}}% a recarga de Empoderamento Demoníaco, Metamorfose e Dominação Vil.",
            [98215] = "Reduz em mais {{1}} s a recarga de Choque Flamejante e Choque Congelante e aumenta em mais {{2}}% o dano direto causado por esses feitiços.",
        }

        for index, pt in pairs(fixed) do
            local pair = D[index]
            if type(pair) == "table" and type(pair[1]) == "string" then
                pair[2] = pt
            end
        end
    end
end
