AscensionPTBR = AscensionPTBR or {}

local A = AscensionPTBR

-- Endgame fica separado porque muda bastante no Ascension e assim e mais facil revisar sem mexer no core.
do
    local titles = A.QuestTitle
    local english = A.QuestTitleEN

    if titles and english then
        local places = {
            ["Stratholme - Main Gate"] = "Stratholme — Portão Principal",
            ["Stratholme - Service Entrance"] = "Stratholme — Entrada de Serviço",
            ["Scholomance"] = "Scolomântia",
            ["Lower Scholomance"] = "Scolomântia Inferior",
            ["Upper Scholomance"] = "Scolomântia Superior",
            ["Blackrock Depths"] = "Abismo Rocha Negra",
            ["Blackrock Depths Upper City"] = "Cidade Superior do Abismo Rocha Negra",
            ["Lower Blackrock Spire"] = "Pico da Rocha Negra Inferior",
            ["Upper Blackrock Spire"] = "Pico da Rocha Negra Superior",
            ["Dire Maul East"] = "Gládio Cruel — Leste",
            ["Dire Maul North"] = "Gládio Cruel — Norte",
            ["Dire Maul West"] = "Gládio Cruel — Oeste",
            ["The Auchenai Crypts"] = "Catacumbas Auchenai",
            ["The Mana Tombs"] = "Tumbas de Mana",
            ["The Sethekk Halls"] = "Salões dos Sethekk",
            ["The Shadow Labyrinth"] = "Labirinto Soturno",
            ["The Mechanar"] = "Mecanar",
            ["The Botanica"] = "Jardim Botânico",
            ["The Arcatraz"] = "Arcatraz",
            ["The Slave Pens"] = "Pátio dos Escravos",
            ["The Underbog"] = "Brejo Oculto",
            ["The Steamvault"] = "Câmara dos Vapores",
            ["The Hellfire Ramparts"] = "Muralha Fogo do Inferno",
            ["The Blood Furnace"] = "Fornalha de Sangue",
            ["The Shattered Halls"] = "Salões Despedaçados",
            ["The Old Hillsbrad Foothills"] = "Antigo Contraforte de Eira dos Montes",
            ["The Black Morass"] = "Lamaçal Negro",
            ["The Wailing Caverns"] = "Caverna Ululante",
            ["Shadowfang Keep"] = "Bastilha da Presa Negra",
            ["The Deadmines"] = "Minas Mortas",
            ["Gnomeregan"] = "Gnomeregan",
            ["Razorfen Kraul"] = "Urzal dos Tuscos",
            ["Blackfathom Deeps"] = "Profundezas Negras",
            ["The Scarlet Library"] = "Biblioteca Escarlate",
            ["The Scarlet Cathedral"] = "Catedral Escarlate",
            ["Razorfen Downs"] = "Urzal dos Mortos",
            ["Zul'Farrak"] = "Zul'Farrak",
            ["Maraudon"] = "Maraudon",
            ["Uldaman"] = "Uldaman",
            ["The Magister's Terrace"] = "Terraço dos Magísteres",

            ["Ruins of Ahn'Qiraj"] = "Ruínas de Ahn'Qiraj",
            ["Zul'Gurub"] = "Zul'Gurub",
            ["Blackwing Lair"] = "Covil Asa Negra",
            ["Molten Core"] = "Núcleo Derretido",
            ["Onyxia's Lair"] = "Covil da Onyxia",
            ["Temple of Ahn'Qiraj"] = "Templo de Ahn'Qiraj",
            ["Naxxramas"] = "Naxxramas",
            ["Karazhan"] = "Karazhan",
            ["Zul'Aman"] = "Zul'Aman",
            ["Gruul's Lair"] = "Covil de Gruul",
            ["Magtheridon's Lair"] = "Covil de Magtheridon",
            ["Serpentshrine Cavern"] = "Caverna do Serpentário",
            ["Tempest Keep"] = "Bastilha da Tormenta",
            ["Battle for Mount Hyjal"] = "Batalha pelo Monte Hyjal",
            ["The Black Temple"] = "Templo Negro",
            ["Sunwell Plateau"] = "Platô da Nascente do Sol",
            ["Vault of Archavon"] = "Abóbada de Arcavon",
            ["The Obsidian Sanctum"] = "Santuário Obsidiano",
            ["The Eye of Eternity"] = "Olho da Eternidade",
            ["Trial of the Crusader"] = "Prova do Cruzado",
            ["Icecrown Citadel"] = "Cidadela da Coroa de Gelo",
            ["The Ruby Sanctum"] = "Santuário Rubi"
        }

        local cities = {
            ["Stormwind"] = "Ventobravo",
            ["Ironforge"] = "Altaforja",
            ["Darnassus"] = "Darnassus",
            ["Orgrimmar"] = "Orgrimmar",
            ["Undercity"] = "Entranhas",
            ["Thunder Bluff"] = "Penhasco do Trovão"
        }

        local function placeName(name)
            return places[name] or name
        end

        for id, en in pairs(english) do
            if type(id) == "number" and id >= 80600 and id <= 81381 and type(en) == "string" then
                local name = en:match("^Mythic Dungeon: (.+)$")
                if name then
                    titles[id] = "Masmorra Mítica: " .. placeName(name)
                else
                    name = en:match("^Dungeon Diving: (.-) %(Heroic%)$")
                    if name then
                        titles[id] = "Mergulho em Masmorras: " .. placeName(name) .. " (Heroica)"
                    else
                        name = en:match("^Dungeon Diving: (.-) %(Mythic%)$")
                        if name then
                            titles[id] = "Mergulho em Masmorras: " .. placeName(name) .. " (Mítica)"
                        else
                            name = en:match("^Dungeon Diving: (.+)$")
                            if name then
                                titles[id] = "Mergulho em Masmorras: " .. placeName(name)
                            else
                                name = en:match("^Timewalking Dungeon: (.+)$")
                                if name then
                                    titles[id] = "Masmorra de Caminhada Temporal: " .. placeName(name)
                                else
                                    name = en:match("^Timewalking Raid: (.+)$")
                                    if name then
                                        titles[id] = "Raide de Caminhada Temporal: " .. placeName(name)
                                    else
                                        name = en:match("^Timewalking: (.+)$")
                                        if name then
                                            titles[id] = "Caminhada Temporal: " .. placeName(name)
                                        else
                                            name = en:match("^Hero's Call: (.+)$")
                                            if name then
                                                titles[id] = "Chamado do Herói: " .. placeName(name)
                                            else
                                                name = en:match("^City Siege: Battle for (.+)$")
                                                if name then
                                                    titles[id] = "Cerco à Cidade: Batalha por " .. (cities[name] or name)
                                                else
                                                    name = en:match("^Proving Grounds: Rated (.+)$")
                                                    if name then
                                                        titles[id] = "Campo de Provas: Ranqueado " .. name
                                                    else
                                                        name = en:match("^Proving Grounds: Skirmish (.+)$")
                                                        if name then
                                                            titles[id] = "Campo de Provas: Escaramuça " .. name
                                                        elseif en == "Proving Grounds: Wargame" then
                                                            titles[id] = "Campo de Provas: Jogo de Guerra"
                                                        elseif en == "Dungeon Diving" then
                                                            titles[id] = "Mergulho em Masmorras"
                                                        elseif en == "Heroic Dungeon Diving" then
                                                            titles[id] = "Mergulho em Masmorras Heroicas"
                                                        elseif en == "Mythic Dungeon Diving" then
                                                            titles[id] = "Mergulho em Masmorras Míticas"
                                                        elseif en == "Mythic+ Dungeon Diving" then
                                                            titles[id] = "Mergulho em Masmorras Mítico+"
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        titles[80651] = "Duelo!"
        titles[80653] = "Baú do Apoiador"
        titles[80762] = "Negociante de Armas: Sopa Viva Fundida"
        titles[80992] = "Aleatória Mítica Clássica 60 (subsequente) (Tanques e Curadores)"
        titles[81256] = "Conclusão de Manastorm"
        titles[81357] = "Bens Mal-Adquiridos: Raiz Retorcida Saudável"
        titles[81358] = "Bens Mal-Adquiridos: Lótus do Terror Saudável"
        titles[81359] = "Bens Mal-Adquiridos: Flor do Vazio Saudável"
        titles[81360] = "Bens Mal-Adquiridos: Metal Retorcido Corrompido"
        titles[81361] = "Bens Mal-Adquiridos: Metal do Terror Corrompido"
        titles[81362] = "Bens Mal-Adquiridos: Metal do Vazio Corrompido"
        titles[81363] = "Bens Mal-Adquiridos: Estilhaço Etéreo Malicioso"
        titles[81364] = "Bens Mal-Adquiridos: Pó Retorcido Malicioso"
        titles[81365] = "Bens Mal-Adquiridos: Pó do Terror Malicioso"
        titles[81366] = "Bens Mal-Adquiridos: Pó do Vazio Malicioso"
        titles[81367] = "Bens Mal-Adquiridos: Carne Curada com Infusão Etérea"
        titles[81368] = "Bens Mal-Adquiridos: Carne Curada com Infusão Retorcida"
        titles[81369] = "Bens Mal-Adquiridos: Carne Curada com Infusão do Terror"
        titles[81370] = "Bens Mal-Adquiridos: Carne Curada com Infusão do Vazio"
        titles[81371] = "Bens Mal-Adquiridos: Vinha Etérea Saudável"
        titles[81372] = "Bens Mal-Adquiridos: Metal Etéreo Corrompido"
        titles[81373] = "Bens Mal-Adquiridos: Couro Etéreo Reforçado"
        titles[81374] = "Bens Mal-Adquiridos: Couro Retorcido Reforçado"
        titles[81375] = "Bens Mal-Adquiridos: Couro do Terror Reforçado"
        titles[81376] = "Bens Mal-Adquiridos: Couro do Vazio Reforçado"
        titles[81377] = "Bens Mal-Adquiridos: Fio Etéreo Tecido"
        titles[81378] = "Bens Mal-Adquiridos: Fio Retorcido Tecido"
        titles[81379] = "Bens Mal-Adquiridos: Fio do Terror Tecido"
        titles[81380] = "Bens Mal-Adquiridos: Fio do Vazio Tecido"
        titles[81381] = "Negociante de Armas: Frasco Impuro de Poder Manifestado"
    end
end

do
    local Q = A.QuestData

    if Q then
        local function patch(id, data)
            local q = Q[id]
            if not q then return end
            for field, value in pairs(data) do
                q[field] = value
            end
        end

        patch(80651, {
            d = "O guerreiro sem prática é o primeiro a cair. Duele com outros jogadores e aperfeiçoe suas habilidades de combate. Aproveite a experiência e leve o que aprender para as próximas batalhas.",
            o = "Duele com cinco outros heróis.",
            p = "Você foi desafiado a duelar com cinco outros heróis.",
            c = "Desafio concluído. Cada duelo deixa você mais preparado para a próxima batalha."
        })

        patch(80653, {
            o = "Conclua a missão para receber seu Baú do Apoiador."
        })

        patch(80762, {
            d = "Foi emitida uma requisição de 5 Sopas Vivas Fundidas. Somente um artesão experiente, usando materiais obtidos em Alto Risco, consegue produzir itens tão valiosos.",
            o = "Colete 5 Sopas Vivas Fundidas."
        })

        patch(80999, {
            p = "Escolha seu caminho, herói. Cada decisão molda o seu destino.",
            c = "Seu caminho foi escolhido. Que ele conduza você à glória, herói."
        })

        local function diving(id, difficulty)
            local label = difficulty
            patch(id, {
                d = "O Quadro de Chamados oferece recompensas valiosas a aventureiros de elite capazes de concluir uma masmorra " .. label .. ". Use o Localizador de Masmorras e entre em um grupo para provar seu valor. Depois, leve a comprovação da vitória ao Quadro de Chamados para receber sua recompensa.",
                o = "Leve ao Quadro de Chamados, em qualquer cidade principal, uma prova de que concluiu com sucesso uma masmorra " .. label .. ".",
                c = "Muito bem, $n! Sua conquista de uma masmorra " .. label .. " provou suas habilidades como aventureiro. Receba estas recompensas como reconhecimento e continue buscando desafios à altura do seu talento!"
            })
        end

        for _, id in ipairs({ 81244, 81247 }) do diving(id, "Normal") end
        for _, id in ipairs({ 81245, 81248 }) do diving(id, "Heroica") end
        for _, id in ipairs({ 81246, 81249 }) do diving(id, "Mítica") end
        for _, id in ipairs({ 81341, 81342, 81343 }) do diving(id, "Mítico+") end

        local siegePending = "Os líderes inimigos ainda resistem. Invada a fortaleza deles e derrube-os."
        local siegeDone = "A liderança inimiga foi abatida! Um golpe decisivo para a nossa causa. Vitória!"

        local sieges = {
            { { 81250, 81319 }, "Chamado a todos os guerreiros!\n\nEntre as colinas verdejantes da Floresta de Elwynn ergue-se a nação humana de Ventobravo. Invada a cidade e derrube o atual líder dos humanos, Bolvar Fordragon!", "Mate Bolvar Fordragon em Ventobravo." },
            { { 81251, 81320 }, "Nas montanhas geladas de Dun Morogh vivem os anões. Sua grande cidade subterrânea é Altaforja. Cerque a cidade e derrube o líder anão Magni Barbabronze!", "Mate Magni Barbabronze e o Grão-Faz-Tudo Mekkatorque em Altaforja." },
            { { 81252, 81321 }, "No noroeste de Kalimdor, em meio ao Mar Velado, ergue-se a árvore do mundo Teldrassil. Em sua copa fica Darnassus, lar dos elfos noturnos. Suba Teldrassil, invada Darnassus e derrube Tyrande Murmuréolo!", "Mate Tyrande Murmuréolo em Darnassus." },
            { { 81253, 81322 }, "Nos desertos vermelhos de Durotar, os orcs construíram uma cidade formidável. Cerque Orgrimmar e derrube o líder orc Thrall.", "Mate Thrall em Orgrimmar." },
            { { 81254, 81323 }, "Nas profundezas das ruínas de Lordaeron fica a Cidade Baixa, lar dos mortos-vivos libertos do domínio do Lich Rei. Ataque a Cidade Baixa e derrube Sylvana Correventos!", "Mate Sylvana Correventos na Cidade Baixa." },
            { { 81255, 81324 }, "No alto das grandes elevações de Mulgore, os taurens ergueram seu lar. Penhasco do Trovão é uma cidade como nenhuma outra. Invada-a e derrube Cairne Casco Sangrento.", "Mate Cairne Casco Sangrento no Penhasco do Trovão." }
        }

        for _, entry in ipairs(sieges) do
            for _, id in ipairs(entry[1]) do
                patch(id, { d = entry[2], o = entry[3], p = siegePending, c = siegeDone })
            end
        end

        local skirmish = "Ainda não está pronto para entrar nas arenas ranqueadas? Quer ajustar sua build antes de encarar as grandes ligas? As arenas de escaramuça permitem colocar suas habilidades à prova!\n\nEscaramuças não causam perda de pontuação e são uma ótima forma de testar sua build em Arena."
        for _, id in ipairs({ 81261, 81330 }) do
            patch(id, { d = skirmish, o = "Participe de 10 partidas de Arena de Escaramuça 1v1." })
        end
        for _, id in ipairs({ 81262, 81331 }) do
            patch(id, { d = skirmish, o = "Participe de 10 partidas de Arena de Escaramuça 2v2." })
        end

        local twPending = "Os inimigos da masmorra ainda resistem. Volte quando tiver concluído sua missão através das linhas temporais."
        local twDone = "Os ecos do passado voltam a silenciar. Sua bravura através das linhas temporais é lendária, herói. Receba sua recompensa."

        patch(81265, {
            d = "Nefarian, filho de Asa da Morte, está mobilizando seus exércitos no alto da Montanha Rocha Negra: orcs Rocha Negra, ogros Agulhapétrea, trolls Fumacardo e criaturas dracônicas de todo tipo. Seus experimentos para criar a revoada perfeita saíram completamente do controle.\n\nPrecisamos acabar com essa loucura e com seu exército de abominações dracônicas.\n\nReúna seus aliados, entre no Covil Asa Negra e mate Nefarian.",
            o = "Mate Nefarian!",
            p = twPending,
            c = twDone
        })

        patch(81284, {
            d = "Tenho outra tarefa perigosa para você, herói. Espero que tenha companheiros de confiança ao seu lado.\n\nAlgo está despertando nas Profundezas Negras e jamais deveria ter sido perturbado. Não permita que Aku'mai alcance a superfície.",
            o = "Entre nas Profundezas Negras e mate Aku'mai.",
            p = twPending,
            c = twDone
        })

        patch(81285, {
            d = "Você ficou mais forte, herói. Quase parece que desta vez não estou mandando você para uma missão suicida... quase.\n\nO Arcanista Doan ainda tem multas atrasadas da biblioteca. Isso é totalmente inaceitável. Vá ao Monastério Escarlate e aplique a punição justa e absolutamente proporcional: morte.",
            o = "Entre no Monastério Escarlate e mate o Arcanista Doan.",
            p = twPending,
            c = twDone
        })

        patch(81289, {
            d = "Estou começando a achar que você tem potencial. Quer provar que estou certo?\n\nEsta não veio dos meus superiores, mas... você não vai acreditar! Um centauro chamou minha mãe de gorda! Já sei como dar o troco. Vá até Maraudon... e mate a mãe dele! É a grandona. Isso vai ensiná-lo.",
            o = "Entre em Maraudon e mate a Princesa Theradras.",
            p = twPending,
            c = twDone
        })

        patch(81291, {
            d = "Estamos quase prontos para desferir o golpe final contra a Legião Ardente. Para lançar um ataque bem-sucedido ao Platô da Nascente do Sol, precisamos saber o que nos espera. Ataque o Terraço dos Magísteres. Precisamos controlar o Orbe de Vidência para seguir em frente.",
            o = "Conquiste o Terraço dos Magísteres e mate Kael'thas Andassol.",
            p = twPending,
            c = twDone
        })

        patch(81308, {
            d = "Os trolls da floresta Amani são famosos por seus ataques ousados. Zul'jin é o senhor da guerra responsável pelas incursões contra Quel'Thalas, mesmo depois das enormes perdas sofridas diante dos altos elfos. Agora ele volta a reunir seu exército em Zul'Aman. Não se engane: se Zul'jin retomar os ataques, as consequências serão devastadoras. Mate Zul'jin! Sem seu senhor da guerra, o exército troll deixará de ser uma ameaça.",
            o = "Derrote Zul'jin!",
            p = twPending,
            c = twDone
        })

        patch(81311, {
            d = "Existe apenas um grande reservatório em toda Terralém. Se não controlarmos a água, não controlaremos Terralém. Lady Vashj é uma das tenentes de maior confiança de Illidan e garante que o exército dele mantenha o domínio sobre o abastecimento de água. Se quisermos abrir nossas linhas de suprimento e avançar pela região, precisamos tomar o reservatório. Derrote Lady Vashj e reivindique o controle das águas!",
            o = "Derrote Lady Vashj e tome o reservatório.",
            p = twPending,
            c = twDone
        })

        patch(81313, {
            d = "Já desferimos golpes pesados contra a Legião Ardente e estamos quase prontos para atacar o Templo Negro. Agora nossos inimigos tentam reescrever a história na Batalha pelo Monte Hyjal. Se conseguirem, talvez tenhamos de enfrentar Arquimonde novamente aqui em Terralém e seríamos empurrados de volta pelo Portal Negro. Precisamos enviar nossos heróis mais capazes ao passado para garantir a vitória em Hyjal!",
            o = "Derrote Arquimonde no passado.",
            p = twPending,
            c = twDone
        })

        patch(81315, {
            d = "Durante milênios, a Nascente do Sol alimentou a poderosa magia dos altos elfos. A Legião Ardente lançou todas as suas forças contra essa antiga fonte de poder, pois pretende usá-la para trazer Kil'jaeden a Azeroth. Se Kil'jaeden entrar em campo, estaremos condenados. Mas a Legião também nos deu a oportunidade de desferir um golpe decisivo nesta guerra. É agora, herói. Derrote a Legião Ardente.",
            o = "Expulse Kil'jaeden.",
            p = twPending,
            c = twDone
        })

        local heroPending = "O inimigo ainda resiste. Prepare-se e volte quando tiver cumprido seu dever, herói."
        local heroDone = "Vitória! As forças das trevas sofreram um golpe devastador. Seu heroísmo será lembrado por toda Azeroth."

        patch(81333, {
            d = "Bravo herói, chegou a hora de atacar o coração do poder da Praga. Kel'Thuzad, senhor lich e braço direito do Lich Rei, reside em Naxxramas e de lá orquestra horrores incontáveis contra nosso mundo.\n\nPrecisamos pôr fim à existência vil dele e devolver esperança às terras assoladas. Reúna seus aliados, invada Naxxramas e mate Kel'Thuzad de uma vez por todas.",
            o = "Acabe com Kel'Thuzad!",
            p = heroPending,
            c = heroDone
        })

        patch(81338, {
            d = "Nossos batedores informam que Onyxia, filha de Asa da Morte, está escondida em seu covil nas profundezas do Pântano Vadeoso. Ela fugiu para lá depois que sua identidade como Lady Katrana Prestor foi descoberta, assim como seu envolvimento no desaparecimento de Varian Wrynn, rei de Ventobravo.\n\nPrecisamos atacar agora, enquanto ela está vulnerável!\n\nReúna aventureiros capazes, vá ao Covil da Onyxia e elimine-a.",
            o = "Mate Onyxia!",
            p = heroPending,
            c = heroDone
        })

        patch(81339, {
            d = "Aventureiro, chegou a hora de enfrentar a maior ameaça que Azeroth já conheceu. O Lich Rei, Arthas Menethil, aguarda em seu Trono de Gelo no coração da Cidadela da Coroa de Gelo.\n\nSua Praga de mortos-vivos ameaça consumir o mundo em uma maré de morte e desespero. Precisamos atacar agora, enquanto ainda temos forças para enfrentá-lo.",
            o = "Mate o Lich Rei!",
            p = heroPending,
            c = heroDone
        })

        patch(81340, {
            d = "Aventureiro, uma nova ameaça surgiu das profundezas do Santuário Rubi. Halion, um poderoso dragão crepuscular, invadiu o santuário e pretende mergulhar Azeroth na escuridão.\n\nEssa ameaça precisa ser detida antes que a corrupção se espalhe. Reúna seus aliados e enfrente Halion dentro do Santuário Rubi.",
            o = "Derrote Halion!",
            p = heroPending,
            c = heroDone
        })

        local requisitionPending = "A requisição ainda não foi atendida. Volte com os materiais necessários."
        local requisitionDone = "Os materiais foram recebidos e contabilizados. Sua contribuição para a causa foi registrada, herói."

        local materials = {
            [81357] = { "Raiz Retorcida Saudável", "eventos de coleta de ervas em zonas de Alto Risco" },
            [81358] = { "Lótus do Terror Saudável", "eventos de coleta de ervas em zonas de Alto Risco" },
            [81359] = { "Flor do Vazio Saudável", "eventos de coleta de ervas em zonas de Alto Risco" },
            [81360] = { "Metal Retorcido Corrompido", "eventos de mineração em zonas de Alto Risco" },
            [81361] = { "Metal do Terror Corrompido", "eventos de materiais em zonas de Alto Risco" },
            [81362] = { "Metal do Vazio Corrompido", "eventos de materiais em zonas de Alto Risco" },
            [81364] = { "Pó Retorcido Malicioso", "eventos de materiais em zonas de Alto Risco" },
            [81365] = { "Pó do Terror Malicioso", "eventos de materiais em zonas de Alto Risco" },
            [81366] = { "Pó do Vazio Malicioso", "eventos de materiais em zonas de Alto Risco" },
            [81367] = { "Carne Curada com Infusão Etérea", "eventos de materiais em zonas de Alto Risco" },
            [81368] = { "Carne Curada com Infusão Retorcida", "eventos de materiais em zonas de Alto Risco" },
            [81369] = { "Carne Curada com Infusão do Terror", "eventos de materiais em zonas de Alto Risco" },
            [81370] = { "Carne Curada com Infusão do Vazio", "eventos de materiais em zonas de Alto Risco" },
            [81371] = { "Vinha Etérea Saudável", "eventos de coleta de ervas em zonas de Alto Risco" },
            [81372] = { "Metal Etéreo Corrompido", "eventos de materiais em zonas de Alto Risco" },
            [81373] = { "Couro Etéreo Reforçado", "eventos de materiais em zonas de Alto Risco" },
            [81374] = { "Couro Retorcido Reforçado", "eventos de materiais em zonas de Alto Risco" },
            [81375] = { "Couro do Terror Reforçado", "eventos de materiais em zonas de Alto Risco" },
            [81376] = { "Couro do Vazio Reforçado", "eventos de materiais em zonas de Alto Risco" },
            [81377] = { "Fio Etéreo Tecido", "eventos de materiais em zonas de Alto Risco" },
            [81378] = { "Fio Retorcido Tecido", "eventos de materiais em zonas de Alto Risco" },
            [81379] = { "Fio do Terror Tecido", "eventos de materiais em zonas de Alto Risco" },
            [81380] = { "Fio do Vazio Tecido", "eventos de materiais em zonas de Alto Risco" }
        }

        for id, info in pairs(materials) do
            patch(id, {
                d = "Você pode obter " .. info[1] .. " em " .. info[2] .. ", procurando na Casa de Leilões ou negociando com outros jogadores.",
                o = "Colete 5 unidades de " .. info[1] .. ".",
                p = requisitionPending,
                c = requisitionDone
            })
        end

        patch(81363, {
            d = "Você pode obter Estilhaço Etéreo Malicioso desencantando equipamentos Forjados em Sangue de nível máximo, procurando na Casa de Leilões ou negociando com outros jogadores.",
            o = "Atenda à requisição de Estilhaço Etéreo Malicioso.",
            p = requisitionPending,
            c = requisitionDone
        })

        patch(81381, {
            d = "Foi emitida uma requisição de 1 Frasco Impuro de Poder Manifestado. Somente um artesão experiente, usando materiais obtidos em Alto Risco, consegue produzir um item tão valioso.",
            o = "Colete 1 Frasco Impuro de Poder Manifestado.",
            p = requisitionPending,
            c = requisitionDone
        })
    end
end

do
    local T = A.SpellNameEN2ES

    if T then
        local fixed = {
            ["Activate Keystone"] = "Ativar Pedra-chave",
            ["Ascended Chain Lighting"] = "Cadeia de Raios Ascendida",
            ["Ascended Holy Nova"] = "Nova Sagrada Ascendida",
            ["Ascended Holy Shock"] = "Choque Sagrado Ascendido",
            ["Ascended Smite"] = "Punição Ascendida",
            ["Ascended Stormstrike"] = "Golpe da Tempestade Ascendido",
            ["Ascended Stormstrike (Off-Hand)"] = "Golpe da Tempestade Ascendido (Mão Secundária)",
            ["Call Ascended Anathema"] = "Invocar Anátema Ascendido",
            ["Call Ascended Benediction"] = "Invocar Bênção Ascendida",
            ["Call Heroic Raid Anathema"] = "Invocar Anátema — Raide Heroico",
            ["Call Heroic Raid Benediction"] = "Invocar Bênção — Raide Heroico",
            ["Call Mythic Raid Anathema"] = "Invocar Anátema — Raide Mítico",
            ["Call Mythic Raid Benediction"] = "Invocar Bênção — Raide Mítico",
            ["Call Mythic Raid Shadowstrike"] = "Invocar Golpe Sombrio — Raide Mítico",
            ["Champion Affix"] = "Afixo de Campeão",
            ["Creature Affix"] = "Afixo de Criatura",
            ["Creature Affix "] = "Afixo de Criatura",
            ["Player Affix"] = "Afixo de Jogador",
            ["High-Risk"] = "Alto Risco",
            ["High-Risk (PvP)"] = "Alto Risco (JxJ)",
            ["Mythic+ Melee AoE DR"] = "Redução de Dano Corpo a Corpo em Área — Mítico+",
            ["Mythic+ Preparation"] = "Preparação para Mítico+",
            ["Mythical Cache"] = "Baú Mítico",
            ["Mythical Corruption"] = "Corrupção Mítica",
            ["Mythical Defender"] = "Defensor Mítico",
            ["Mythical Defense"] = "Defesa Mítica",
            ["Mythical Discharge"] = "Descarga Mítica",
            ["Mythical Discharge Zone"] = "Zona de Descarga Mítica",
            ["Mythical Missiles"] = "Mísseis Míticos",
            ["Mythical Outburst"] = "Erupção Mítica",
            ["Mythical Protector"] = "Protetor Mítico",
            ["Mythical Rot"] = "Putrefação Mítica",
            ["Mythical Scarring"] = "Cicatriz Mítica",
            ["Mythical Scarring "] = "Cicatriz Mítica",
            ["Mythical Throw"] = "Arremesso Mítico",
            ["Mythical Volley"] = "Saraivada Mítica",
            ["Mythical Whirl"] = "Turbilhão Mítico",
            ["Cadaverous Mythic 5 set bonus"] = "Bônus Mítico de 5 Peças — Cadavérico",
            ["Elements Mythic 5 set bonus"] = "Bônus Mítico de 5 Peças — Elementos",
            ["Magister's Mythic 5 set bonus"] = "Bônus Mítico de 5 Peças — Magíster",
            ["Mythic 5 set bonus Bloodmail CDR"] = "Bônus Mítico de 5 Peças — Redução de Recarga Bloodmail",
            ["Mythic 5 set bonus Deathbone CDR"] = "Bônus Mítico de 5 Peças — Redução de Recarga Deathbone",
            ["Mythic 5 set bonus bear CDR"] = "Bônus Mítico de 5 Peças — Redução de Recarga (Urso)",
            ["Mythic Channeling 3 Set Bonus"] = "Bônus Mítico de 3 Peças — Canalização",
            ["Mythic Spell Channeling 8 set Eruption"] = "Bônus Mítico de 8 Peças — Canalização: Erupção",
            ["Mythic Spell Channeling 8 set Regen Haste"] = "Bônus Mítico de 8 Peças — Canalização: Regeneração e Aceleração",
            ["Portal: Molten Core"] = "Portal: Núcleo Derretido",
            ["Portal: Onyxia's Lair"] = "Portal: Covil da Onyxia"
        }

        for en, pt in pairs(fixed) do
            T[en] = pt
        end

        local boons = {
            ["Mythical Boon: Adaptation"] = "Bônus Mítico: Adaptação",
            ["Mythical Boon: Ascension"] = "Bônus Mítico: Ascensão",
            ["Mythical Boon: Bloodlust"] = "Bônus Mítico: Sede de Sangue",
            ["Mythical Boon: Bountiful"] = "Bônus Mítico: Abundância",
            ["Mythical Boon: Critical"] = "Bônus Mítico: Crítico",
            ["Mythical Boon: Infinity"] = "Bônus Mítico: Infinito",
            ["Mythical Boon: Inquisition"] = "Bônus Mítico: Inquisição",
            ["Mythical Boon: Momentum"] = "Bônus Mítico: Ímpeto",
            ["Mythical Boon: Phasewalk"] = "Bônus Mítico: Caminhada de Fase",
            ["Mythical Boon: Piercing"] = "Bônus Mítico: Perfurante",
            ["Mythical Boon: Ruthlessness"] = "Bônus Mítico: Impiedade",
            ["Mythical Boon: Sactuary"] = "Bônus Mítico: Santuário",
            ["Mythical Boon: Sanctified"] = "Bônus Mítico: Santificado",
            ["Mythical Boon: Sanctuary"] = "Bônus Mítico: Santuário",
            ["Mythical Boon: Skulking"] = "Bônus Mítico: Furtivo",
            ["Mythical Boon: Wrathful"] = "Bônus Mítico: Iracundo"
        }

        for en, pt in pairs(boons) do
            T[en] = pt
        end

        local raidNames = {
            ["Ahn'Qiraj Temple"] = "Templo de Ahn'Qiraj",
            ["Black Temple"] = "Templo Negro",
            ["Blackwing Lair"] = "Covil Asa Negra",
            ["Gruul's Lair"] = "Covil de Gruul",
            ["Icecrown Citadel"] = "Cidadela da Coroa de Gelo",
            ["Karazhan"] = "Karazhan",
            ["Magtheridon's Lair"] = "Covil de Magtheridon",
            ["Molten Core"] = "Núcleo Derretido",
            ["Naxxramas"] = "Naxxramas",
            ["Onyxia's Lair"] = "Covil da Onyxia",
            ["Ruins of Ahn'Qiraj"] = "Ruínas de Ahn'Qiraj",
            ["Serpentshrine Cavern"] = "Caverna do Serpentário",
            ["Sunwell Plateau"] = "Platô da Nascente do Sol",
            ["Tempest Keep"] = "Bastilha da Tormenta",
            ["The Battle for Mount Hyjal"] = "Batalha pelo Monte Hyjal",
            ["The Eye of Eternity"] = "Olho da Eternidade",
            ["The Obsidian Sanctum"] = "Santuário Obsidiano",
            ["The Ruby Sanctum"] = "Santuário Rubi",
            ["Trial of the Crusader"] = "Prova do Cruzado",
            ["Ulduar"] = "Ulduar",
            ["Vault of Archavon"] = "Abóbada de Arcavon",
            ["Zul'Aman"] = "Zul'Aman",
            ["Zul'Gurub"] = "Zul'Gurub"
        }

        for en in pairs(T) do
            if type(en) == "string" then
                local raid, level = en:match("^Raid Trial %- (.-) %(Level (%d+)%)$")
                if raid and level and raidNames[raid] then
                    T[en] = "Prova de Raide — " .. raidNames[raid] .. " (Nível " .. level .. ")"
                else
                    local marker = en:match("^Raid Marker %- (.+)$")
                    if marker then
                        local markerNames = {
                            Circle = "Círculo",
                            Cross = "Cruz",
                            Diamond = "Diamante",
                            Moon = "Lua",
                            Removal = "Remover",
                            Skull = "Caveira",
                            Square = "Quadrado",
                            Star = "Estrela",
                            Triangle = "Triângulo"
                        }
                        if markerNames[marker] then
                            T[en] = "Marcador de Raide — " .. markerNames[marker]
                        end
                    end

                    local mythicLevel = en:match("^Idol of Brutality %(Mythic ([%d]+)%)$")
                    if mythicLevel then
                        T[en] = "Ídolo da Brutalidade (Mítico " .. mythicLevel .. ")"
                    elseif en == "Idol of Brutality (Mythic)" then
                        T[en] = "Ídolo da Brutalidade (Mítico)"
                    end
                end
            end
        end

        local aoeRaids = {
            ["Ascension Raid AoE Reduction"] = "Redução de Dano em Área de Raide do Ascension",
            ["Ascension Raid AoE Reduction - Black Temple"] = "Redução de Dano em Área de Raide do Ascension — Templo Negro",
            ["Ascension Raid AoE Reduction - Blackwing Lair"] = "Redução de Dano em Área de Raide do Ascension — Covil Asa Negra",
            ["Ascension Raid AoE Reduction - Gruul's Lair"] = "Redução de Dano em Área de Raide do Ascension — Covil de Gruul",
            ["Ascension Raid AoE Reduction - Karazhan"] = "Redução de Dano em Área de Raide do Ascension — Karazhan",
            ["Ascension Raid AoE Reduction - Magtheridon"] = "Redução de Dano em Área de Raide do Ascension — Magtheridon",
            ["Ascension Raid AoE Reduction - Molten Core"] = "Redução de Dano em Área de Raide do Ascension — Núcleo Derretido",
            ["Ascension Raid AoE Reduction - Mount Hyjal"] = "Redução de Dano em Área de Raide do Ascension — Monte Hyjal",
            ["Ascension Raid AoE Reduction - Naxxramas"] = "Redução de Dano em Área de Raide do Ascension — Naxxramas",
            ["Ascension Raid AoE Reduction - Onyxia"] = "Redução de Dano em Área de Raide do Ascension — Onyxia",
            ["Ascension Raid AoE Reduction - Ruins of Ahn’Qiraj"] = "Redução de Dano em Área de Raide do Ascension — Ruínas de Ahn'Qiraj",
            ["Ascension Raid AoE Reduction - Serpentshrine Cavern"] = "Redução de Dano em Área de Raide do Ascension — Caverna do Serpentário",
            ["Ascension Raid AoE Reduction - Sunwell Plateau"] = "Redução de Dano em Área de Raide do Ascension — Platô da Nascente do Sol",
            ["Ascension Raid AoE Reduction - Tempest Keep"] = "Redução de Dano em Área de Raide do Ascension — Bastilha da Tormenta",
            ["Ascension Raid AoE Reduction - Temple of Ahn’Qiraj"] = "Redução de Dano em Área de Raide do Ascension — Templo de Ahn'Qiraj",
            ["Ascension Raid AoE Reduction - Zul'Gurub"] = "Redução de Dano em Área de Raide do Ascension — Zul'Gurub"
        }

        for en, pt in pairs(aoeRaids) do
            T[en] = pt
        end
    end
end

do
    local D = A.DescPairs

    if D then
        if D[22742] then
            D[22742][2] = "Ative esta Pedra-chave.\n\n|cFFFFCC00Ao ativá-la, você será teletransportado para o início da masmorra.|r\n\n|cFFCC3300Derrotar criaturas impedirá a ativação desta Pedra-chave.|r\n\n|cFFFFCC00Pedras-chave Míticas de nível 1 são obtidas ao derrotar o chefe final de Masmorras Míticas.|r"
        end

        local replacements = {
            [58713] = "|cffFFFFF0Mítico 14+|r\n\n|cffFF9900Magma|r\nCria áreas de fogo em seu caminho.",
            [58714] = "|cff4D85E6Mítico 14+|r\nCria áreas de fogo em seu caminho que causam |cffFF8000{{1}}|r de |cffFF8040dano de Fogo|r aos inimigos que entrarem em contato com elas.",
            [58715] = "|cffFFFFF0Mítico 17+|r\n\n|cffFF9900Morteiro|r\nLança magma derretido pelo ar.",
            [58716] = "|cff4D85E6Mítico 17+|r\nLança magma derretido pelo ar, causando |cffFF9000{{1}}|r de |cffFF8040dano de Fogo|r aos inimigos próximos ao ponto de impacto.",
            [58717] = "|cffFFFFF0Mítico 20+|r\n\n|cffFF9900Fusão|r\nAo morrer, provoca uma explosão devastadora.|r",
            [58718] = "Uma reação volátil acontece dentro do corpo da criatura...\n\nÉ melhor procurar cobertura.",
            [58719] = "|cff4D85E6Mítico 20+|r\nAo morrer, provoca uma explosão devastadora que causa |cffFF8000{{1}}|r de |cffFF8040dano de Fogo|r a todos os inimigos em um raio de |cffFF800040 metros|r e em linha de visão.\n\nO dano diminui conforme a distância da explosão aumenta.",
            [58721] = "|cffFFFFF0Mítico 14+|r\n\n|cffFF9900Glacial|r\nReduz rapidamente a temperatura ao redor.",
            [58722] = "Um frio cortante toma conta do seu corpo.\n\nCausa {{1}} de dano de Gelo a cada {{2}} s.\nReduz a velocidade de movimento em {{3}}%.\nMover-se enfraquece este efeito.",
            [58723] = "|cff4D85E6Mítico 14+|r\nReduz rapidamente a temperatura ao redor, causando |cffB5FFEBdano de Gelo|r periódico crescente a inimigos parados e reduzindo a velocidade de movimento.\n\nMover-se enfraquece este efeito.",
            [58724] = "|cff4D85E6Mítico 17+|r\nEvoca periodicamente |cffFF8000Orbes Congelados|r perto do Campeão. Eles causam |cffFF8000{{1}}|r de |cffB5FFEBdano de Gelo|r aos inimigos em um raio de |cffFF80005 metros|r e os congelam no lugar por |cffFF8000{{2}}|r.",
            [58725] = "Congela periodicamente os inimigos próximos.",
            [58726] = "Causa {{1}} de dano de Gelo aos inimigos em um raio de 5 metros e os congela no lugar por {{2}}.",
            [58727] = "|cffFFFFF0Mítico 20+|r\n\n|cffFF9900Criostase|r\nQuando está perto da morte, prolonga a própria vida entrando em criostase.",
            [58728] = "|cff4D85E6Mítico 20+|r\nPerto da morte, o Campeão entra em Criostase e absorve até |cffFF80005000|r de dano por nível Mítico.\nRegenera |cffFF8000{{1}}%|r da vida máxima por segundo enquanto estiver em Criostase.",
            [58729] = "Não pode entrar em Criostase novamente.",
            [58731] = "|cff4D85E6Mítico 14+|r\nEvoca periodicamente |cffFF8000Proles do Vazio|r.",
            [58732] = "|cff4D85E6Mítico 17+|r\nEvoca periodicamente |cffFF8000Singularidades|r, causando |cff80528Cdano de Sombra|r aos jogadores próximos.",
            [58733] = "Evoca uma Singularidade perto do conjurador.",
            [58735] = "|cffFFFFF0Mítico 14+|r\n\n|cffFF9900Devoção|r\nAtaques realizados por aliados próximos causam |cffFF800015% do dano da arma como dano Sagrado|r.",
            [58736] = "|cff4D85E6Mítico 14+|r\nFortalece os ataques dos aliados próximos.\nOs ataques causam |cffFF8000{{1}}% do dano da arma como dano Sagrado|r.",
            [58737] = "|cffFFFFF0Mítico 17+|r\n\n|cffFF9900Consagração Divina|r\nCria uma Consagração Divina que causa |cffFF8000dano Sagrado|r aos inimigos próximos e aumenta em |cffFF80003%|r o dano Sagrado recebido por |cffFF80008 segundos|r.",
            [58738] = "|cff4D85E6Mítico 17+|r\nCria periodicamente uma Consagração Divina que causa |cffFF8000dano Sagrado|r aos inimigos próximos e aumenta em |cffFF80003%|r o dano Sagrado recebido por |cffFF80008 segundos|r.",
            [58739] = "|cffFFFFF0Mítico 20+|r\n\n|cffFF9900Intervenção|r\nQuando está perto da morte, profere uma Oração Divina.",
            [58740] = "|cff4D85E6Mítico 20+|r\nPerto da morte, o Campeão profere uma Oração Divina que o protege de todo dano.\nSe a oração for concluída, restaura |cffFF8000{{1}}%|r da vida máxima do Campeão e de todos os aliados em um raio de |cffFF800040 metros|r.",
            [58741] = "Invoca magia Sagrada e causa dano Sagrado massivo se a Ira Divina for lançada com sucesso.",
            [58742] = "Causa {{1}}% de dano Sagrado ao atacar.",
            [58743] = "Aumenta o dano Sagrado recebido em {{1}}%."
        }

        for id, text in pairs(replacements) do
            if D[id] then D[id][2] = text end
        end

        for _, pair in pairs(D) do
            if type(pair) == "table" and type(pair[1]) == "string" then
                local en = pair[1]

                if en:find("Champion Affix", 1, true) and en:find("Molten infused creatures are present", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo de Campeão|r\nCriaturas infundidas com magma estão presentes por toda a masmorra."
                elseif en:find("Champion Affix", 1, true) and en:find("Additional Molten Infused Champions", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo de Campeão|r\nCampeões adicionais infundidos com magma estão presentes por toda a masmorra."
                elseif en:find("Champion Affix", 1, true) and en:find("Frostborn creatures are present", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo de Campeão|r\nCriaturas Nascidas do Gelo estão presentes por toda a masmorra."
                elseif en:find("Champion Affix", 1, true) and en:find("Creatures empowered by the Void", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo de Campeão|r\nCriaturas fortalecidas pelo Vazio estão presentes por toda a masmorra."
                elseif en:find("Champion Affix", 1, true) and en:find("Creatures blessed by divine light", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo de Campeão|r\nCriaturas abençoadas pela Luz divina estão presentes por toda a masmorra."
                elseif en:find("Creature Affix", 1, true) and en:find("Non%-boss enemy health increased", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo de Criatura|r\nVida dos inimigos que não são chefes aumentada em |cffFF8000{{1}}%|r.\nDano dos inimigos que não são chefes aumentado em |cffFF8000{{2}}%|r."
                elseif en:find("Boss Affix", 1, true) and en:find("Boss health increased", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo de Chefe|r\nVida dos chefes aumentada em |cffFF8000{{1}}%|r.\nDano dos chefes aumentado em |cffFF8000{{2}}%|r."
                elseif en:find("Creature Affix", 1, true) and en:find("Enemies drain", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo de Criatura|r\nOs inimigos drenam |cffFF8000{{1}}%|r de vida ao acertar ataques."
                elseif en:find("Creature Affix", 1, true) and en:find("Enemies fight as a horde", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo de Criatura|r\nOs inimigos lutam como uma horda, causando mais dano e recebendo menos dano para cada aliado próximo."
                elseif en:find("Player Affix", 1, true) and en:find("Players must hunt in a pack", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo de Jogador|r\nOs jogadores precisam caçar em grupo.\nO dano causado é reduzido e o dano recebido aumenta para cada aliado que não estiver em um raio de |cffFF8000{{1}} metros|r."
                elseif en:find("Environmental Affix", 1, true) and en:find("Killer Bees", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo Ambiental|r\nAbelhas Assassinas furiosas infestaram a masmorra! Elas têm maior chance de atacar jogadores parados."
                elseif en:find("Creature Affix", 1, true) and en:find("lingering pool of ichor", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo de Criatura|r\nAo morrer, os inimigos deixam uma poça persistente de icor que cura seus aliados e causa dano aos jogadores."
                elseif en:find("Creature Affix", 1, true) and en:find("Unrelenting Spirits", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo de Criatura|r\n|cffFF9000Espíritos Implacáveis|r surgem dos cadáveres de inimigos que não são chefes e perseguem um jogador aleatório."
                elseif en:find("Creature Affix", 1, true) and en:find("non%-boss enemies explode", 1, true) then
                    pair[2] = "|cffFFFFFFAfixo de Criatura|r\nAo morrer, inimigos que não são chefes explodem, causando uma porcentagem da vida máxima deles como |cff85FF85dano de Natureza|r, dividida entre todos os jogadores próximos.\n\nOs jogadores ficam cobertos por |cff67BCFFSuco de Cadáver|r."
                elseif en:find("This Mythical Boon empowers your party's", 1, true) and en:find("Healing done", 1, true) then
                    pair[2] = "Este Bônus Mítico aumenta em |cffFF9900{{1}}%|r o |cffFF9900dano|r e a |cffFF9900cura realizada|r do seu grupo por |cffFF9900{{2}}|r."
                elseif en:find("While under the effect of this Mythical Boon", 1, true) then
                    pair[2] = "Enquanto estiver sob o efeito deste Bônus Mítico, todos os seus feitiços e habilidades recebem |cffFF9900{{1}}% de Redução de Recarga|r e têm o |cffFF9900Custo|r reduzido em |cffFF9900{{2}}%|r por |cffFF9900{{3}}|r."
                elseif en:find("Mythical Barrier", 1, true) then
                    pair[2] = "Este Bônus Mítico fortalece o grupo e cria uma |cffFF9900Barreira Mítica|r ao redor de todos os integrantes, causando dano aos inimigos próximos por |cffFF9900{{1}}|r."
                elseif en:find("This Mythical Boon empowers your party reducing all", 1, true) then
                    pair[2] = "Este Bônus Mítico fortalece o grupo, reduzindo todo o |cffFF9900dano recebido|r em |cffFF9900{{1}}%|r por |cffFF9900{{2}}|r."
                elseif en:find("Strength, Agility, Stamina, Spirit and Intellect", 1, true) then
                    pair[2] = "Este Bônus Mítico aumenta em |cffFF9900{{1}}%|r a |cffFF9900Força, Agilidade, Vigor, Espírito e Intelecto|r do grupo por |cffFF9900{{2}}|r."
                elseif en:find("Armor Penetration", 1, true) and en:find("This Mythical Boon", 1, true) then
                    pair[2] = "Este Bônus Mítico aumenta a |cffFF9900Penetração de Armadura|r do grupo em |cffFF9900{{1}}%|r por |cffFF9900{{2}}|r."
                elseif en:find("Critical Strike Chance", 1, true) and en:find("This Mythical Boon", 1, true) then
                    pair[2] = "Este Bônus Mítico aumenta a |cffFF9900chance de Acerto Crítico|r do grupo em |cffFF9900{{1}}%|r por |cffFF9900{{2}}|r."
                elseif en:find("Restoring", 1, true) and en:find("health every", 1, true) and en:find("Mythical Boon", 1, true) then
                    pair[2] = "Este Bônus Mítico fortalece o grupo, |cffFF9900restaurando {{1}}% de vida a cada {{2}} milissegundos|r por |cffFF9900{{3}}|r."
                elseif en:find("Spell Damage", 1, true) and en:find("Spell Healing", 1, true) and en:find("Attack Power", 1, true) and en:find("Mythical Boon", 1, true) then
                    pair[2] = "Este Bônus Mítico aumenta o |cffFF9900Dano de Feitiço|r e a |cffFF9900Cura de Feitiço|r do grupo em |cffFF9900{{1}}% do Poder de Ataque|r por |cffFF9900{{2}}|r."
                elseif en:find("Spell Damage", 1, true) and en:find("Attack Power", 1, true) and en:find("This Mythical Boon empowers your party", 1, true) then
                    pair[2] = "Este Bônus Mítico fortalece o grupo. O |cffFF9900Dano de Feitiço|r aumenta em |cffFF9900{{1}}|r e o |cffFF9900Poder de Ataque|r aumenta em |cffFF9900{{2}}|r por |cffFF9900{{3}}|r."
                elseif en:find("shifts your party to another plane", 1, true) then
                    pair[2] = "Este Bônus Mítico leva o grupo para outro plano por até |cffFF9900{{1}}|r, permitindo passar pelos inimigos sem ser percebido."
                elseif en:find("Grants your party the Bloodlust effect", 1, true) then
                    pair[2] = "Concede ao seu grupo o efeito Sede de Sangue."
                elseif en == "^Wormhole%s*$" then
                    pair[2] = "Buraco de Minhoca"
                end
            end
        end
    end
end

do
    local U = A.ServerUI

    if U then
        U["Mythic Plus"] = "Mítico+"
        U["Mythic+ dungeons are not\ncurrently active"] = "As masmorras Mítico+ não estão\nativas no momento"
        U["Mythic+& Raid Services"] = "Serviços de Mítico+ e Raide"
        U["Mythic: Zul'Gurub"] = "Mítico: Zul'Gurub"

        for en in pairs(U) do
            if type(en) == "string" and en:find("Mythic+ dungeons are a high-level, repeatable challenge mode", 1, true) == 1 then
                U[en] = "As masmorras Mítico+ são um modo de desafio repetível de alto nível, criado para testar habilidade, coordenação e eficiência. Para iniciar uma tentativa Mítico+, você precisa de uma Pedra-chave Mítica, obtida ao concluir uma |cFF00CCFF|Hkeyword:88|hMasmorra|h|r na dificuldade Mítica. Com a Pedra-chave em mãos, ative-a na entrada da |cFF00CCFF|Hkeyword:88|hMasmorra|h|r para começar.\r\n\r\nDiferente das masmorras Míticas comuns, as Mítico+ são cronometradas e escalam conforme o nível da Pedra-chave. Quanto maior o nível, mais fortes ficam os inimigos e novos afixos — modificadores especiais da |cFF00CCFF|Hkeyword:88|hMasmorra|h|r — adicionam mecânicas como perigos ambientais, bônus para inimigos ou pressão sobre todo o grupo. Os afixos mudam semanalmente e também variam conforme o nível da chave.\r\n\r\nAo final de cada tentativa, a Pedra-chave muda de acordo com seu desempenho, podendo subir de nível ou apontar para outra |cFF00CCFF|Hkeyword:88|hMasmorra|h|r. Concluir a masmorra rapidamente pode melhorar sua chave e suas recompensas; ultrapassar o cronômetro pode reduzir a dificuldade.\r\n\r\nNíveis mais altos de Mítico+ oferecem recompensas melhores, incluindo equipamentos épicos, |cFF00CCFF|Hkeyword:82|hMoedas|h|r e progresso em conquistas e tabelas de classificação."
            end
        end
    end
end


-- Restos de portunhol que aparecem em varias copias das mesmas dailies.
do
    local Q = A.QuestData
    if Q then
        local lowerSpire = "A todos os aventureiros em busca de riqueza e glória! Lorde Supremo Wyrmthalak, uma criação dracônica de Nefarian que atualmente habita o Pico da Rocha Negra Inferior, é procurado por crimes hediondos contra todas as raças. Seus experimentos e sua própria existência desafiam a vida."
        for _, id in ipairs({ 80670, 81007, 81044, 81081, 81272 }) do
            if Q[id] then Q[id].d = lowerSpire end
        end

        local upperSpire = "Recebemos relatos de um aumento repentino de atividade no Pico da Rocha Negra Superior. Tudo indica que o dragão negro Nefarian está mobilizando suas forças orcs para lançar um ataque total contra o domínio do Senhor do Fogo e assumir o controle da Montanha Rocha Negra.\n\nNão podemos permitir isso! Se Nefarian conseguir colocar os anões Ferro Negro sob seu comando, as consequências serão desastrosas.\n\nNo momento, o General Drakkisath lidera a preparação militar. Vá ao Pico da Rocha Negra Superior e mate o General Drakkisath e seus lacaios!"
        for _, id in ipairs({ 80671, 81273 }) do
            if Q[id] then Q[id].d = upperSpire end
        end

        local auchenai = "As Catacumbas Auchenai foram palco de muitos experimentos repulsivos na busca pelo domínio das artes necromânticas. O Exarca Maladaar habita as profundezas das tumbas, entregue à própria loucura. Está na hora de colocar ele e os espíritos que vagam pelas catacumbas para descansar.\n\nAinda assim, lembre-se do aviso dos antigos guardiões da cidade antes de entrar em Auchenai: aqueles que não respeitam os mortos podem acabar sepultados junto deles."
        for _, id in ipairs({ 81025, 81062, 81099, 81292 }) do
            if Q[id] then Q[id].d = auchenai end
        end

        local botanica = "Cientistas elfos sangrentos realizam experimentos com a flora de Terralém, usando tecnologia naaru para criar e manipular seres vivos em busca de novos poderes. Os experimentos parecem ter saído do controle. Precisamos purificar o Jardim Botânico antes que esses Organismos Magicamente Modificados escapem do laboratório e provoquem um colapso ecológico em cadeia!"
        for _, id in ipairs({ 81030, 81067, 81104, 81297 }) do
            if Q[id] then Q[id].d = botanica end
        end

        if Q[80850] then
            Q[80850].d = "Foi emitida uma requisição de 5 Sopas Vivas Imbuídas. Somente um artesão experiente, usando materiais obtidos em Alto Risco, consegue produzir itens tão valiosos."
            Q[80850].o = "Colete 5 Sopas Vivas Imbuídas."
        end

        if Q[81267] then
            Q[81267].o = "Mate Onyxia!"
        end

        local function fixDiving(id, difficulty)
            local q = Q[id]
            if not q then return end
            q.d = "O Quadro de Chamados oferece recompensas valiosas a aventureiros de elite capazes de concluir uma masmorra " .. difficulty .. ". Use o Localizador de Masmorras e entre em um grupo para provar seu valor. Depois, leve a comprovação da vitória ao Quadro de Chamados para receber sua recompensa."
            q.o = "Leve ao Quadro de Chamados, em qualquer cidade principal, uma prova de que concluiu com sucesso uma masmorra " .. difficulty .. "."
            q.c = "Muito bem, $n! Sua conquista de uma masmorra " .. difficulty .. " provou suas habilidades como aventureiro. Receba estas recompensas como reconhecimento e continue buscando desafios à altura do seu talento!"
        end

        fixDiving(81316, "Normal")
        fixDiving(81317, "Heroica")
        fixDiving(81318, "Mítica")

        for id = 80600, 81381 do
            local q = Q[id]
            if q then
                for _, field in ipairs({ "d", "o", "p", "c" }) do
                    if type(q[field]) == "string" then
                        q[field] = q[field]:gsub(" em procure ", " em busca "):gsub(" na procure ", " na busca ")
                    end
                end
            end
        end
    end
end
