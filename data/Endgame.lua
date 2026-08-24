AscensionPTBR = AscensionPTBR or {}

local A = AscensionPTBR

-- Endgame fica separado porque muda bastante no Ascension e assim e mais facil revisar sem mexer no core.
do
    local titles = A.QuestTitle
    local english = A.QuestTitleEN

    if titles and english then
        local places = {
            ["Stratholme - Main Gate"] = "Stratholme: Portão Principal",
            ["Stratholme - Service Entrance"] = "Stratholme: Entrada de Serviço",
            ["Scholomance"] = "Scolomântia",
            ["Lower Scholomance"] = "Scolomântia Inferior",
            ["Upper Scholomance"] = "Scolomântia Superior",
            ["Blackrock Depths"] = "Abismo Rocha Negra",
            ["Blackrock Depths Upper City"] = "Abismo Rocha Negra: Cidade Superior",
            ["Lower Blackrock Spire"] = "Pico da Rocha Negra Inferior",
            ["Upper Blackrock Spire"] = "Pico da Rocha Negra Superior",
            ["Dire Maul East"] = "Gládio Cruel: Leste",
            ["Dire Maul North"] = "Gládio Cruel: Norte",
            ["Dire Maul West"] = "Gládio Cruel: Oeste",
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
            ["The Scarlet Library"] = "Monastério Escarlate: Biblioteca",
            ["The Scarlet Cathedral"] = "Monastério Escarlate: Catedral",
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
                        titles[id] = "Exploração de Masmorras: " .. placeName(name) .. " (Heroica)"
                    else
                        name = en:match("^Dungeon Diving: (.-) %(Mythic%)$")
                        if name then
                            titles[id] = "Exploração de Masmorras: " .. placeName(name) .. " (Mítica)"
                        else
                            name = en:match("^Dungeon Diving: (.+)$")
                            if name then
                                titles[id] = "Exploração de Masmorras: " .. placeName(name)
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
                                                            titles[id] = "Exploração de Masmorras"
                                                        elseif en == "Heroic Dungeon Diving" then
                                                            titles[id] = "Exploração de Masmorras Heroicas"
                                                        elseif en == "Mythic Dungeon Diving" then
                                                            titles[id] = "Exploração de Masmorras Míticas"
                                                        elseif en == "Mythic+ Dungeon Diving" then
                                                            titles[id] = "Exploração de Masmorras Mítico+"
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
        titles[81256] = "Conclusão da Tormenta de Mana"
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
            d = "O guerreiro sem prática é o primeiro a cair. Enfrente outros jogadores em duelos e aperfeiçoe suas habilidades de combate. Aproveite a experiência e leve o que aprender para as próximas batalhas.",
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
            ["Mythical Boon: Adaptation"] = "Dádiva Mítica: Adaptação",
            ["Mythical Boon: Ascension"] = "Dádiva Mítica: Ascensão",
            ["Mythical Boon: Bloodlust"] = "Dádiva Mítica: Sede de Sangue",
            ["Mythical Boon: Bountiful"] = "Dádiva Mítica: Abundância",
            ["Mythical Boon: Critical"] = "Dádiva Mítica: Acerto Crítico",
            ["Mythical Boon: Infinity"] = "Dádiva Mítica: Infinidade",
            ["Mythical Boon: Inquisition"] = "Dádiva Mítica: Inquisição",
            ["Mythical Boon: Momentum"] = "Dádiva Mítica: Ímpeto",
            ["Mythical Boon: Phasewalk"] = "Dádiva Mítica: Caminhada de Fase",
            ["Mythical Boon: Piercing"] = "Dádiva Mítica: Perfuração",
            ["Mythical Boon: Ruthlessness"] = "Dádiva Mítica: Impiedade",
            ["Mythical Boon: Sactuary"] = "Dádiva Mítica: Santuário",
            ["Mythical Boon: Sanctified"] = "Dádiva Mítica: Santificação",
            ["Mythical Boon: Sanctuary"] = "Dádiva Mítica: Santuário",
            ["Mythical Boon: Skulking"] = "Dádiva Mítica: Furtividade",
            ["Mythical Boon: Wrathful"] = "Dádiva Mítica: Ira"
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
                    pair[2] = "Esta Dádiva Mítica aumenta em |cffFF9900{{1}}%|r o |cffFF9900dano|r e a |cffFF9900cura realizada|r do seu grupo por |cffFF9900{{2}}|r."
                elseif en:find("While under the effect of this Mythical Boon", 1, true) then
                    pair[2] = "Enquanto estiver sob o efeito desta Dádiva Mítica, todos os seus feitiços e habilidades recebem |cffFF9900{{1}}% de Redução de Recarga|r e têm o |cffFF9900custo|r reduzido em |cffFF9900{{2}}%|r por |cffFF9900{{3}}|r."
                elseif en:find("Mythical Barrier", 1, true) then
                    pair[2] = "Esta Dádiva Mítica fortalece o grupo e cria uma |cffFF9900Barreira Mítica|r ao redor de todos os integrantes, causando dano aos inimigos próximos por |cffFF9900{{1}}|r."
                elseif en:find("This Mythical Boon empowers your party reducing all", 1, true) then
                    pair[2] = "Esta Dádiva Mítica fortalece o grupo, reduzindo todo o |cffFF9900dano recebido|r em |cffFF9900{{1}}%|r por |cffFF9900{{2}}|r."
                elseif en:find("Strength, Agility, Stamina, Spirit and Intellect", 1, true) then
                    pair[2] = "Esta Dádiva Mítica aumenta em |cffFF9900{{1}}%|r a |cffFF9900Força, Agilidade, Vigor, Espírito e Intelecto|r do grupo por |cffFF9900{{2}}|r."
                elseif en:find("Armor Penetration", 1, true) and en:find("This Mythical Boon", 1, true) then
                    pair[2] = "Esta Dádiva Mítica aumenta a |cffFF9900penetração de armadura|r do grupo em |cffFF9900{{1}}%|r por |cffFF9900{{2}}|r."
                elseif en:find("Critical Strike Chance", 1, true) and en:find("This Mythical Boon", 1, true) then
                    pair[2] = "Esta Dádiva Mítica aumenta a |cffFF9900chance de acerto crítico|r do grupo em |cffFF9900{{1}}%|r por |cffFF9900{{2}}|r."
                elseif en:find("Restoring", 1, true) and en:find("health every", 1, true) and en:find("Mythical Boon", 1, true) then
                    pair[2] = "Esta Dádiva Mítica fortalece o grupo, |cffFF9900restaurando {{1}}% de vida a cada {{2}} milissegundos|r por |cffFF9900{{3}}|r."
                elseif en:find("Spell Damage", 1, true) and en:find("Spell Healing", 1, true) and en:find("Attack Power", 1, true) and en:find("Mythical Boon", 1, true) then
                    pair[2] = "Esta Dádiva Mítica aumenta o |cffFF9900dano de feitiço|r e a |cffFF9900cura de feitiço|r do grupo em |cffFF9900{{1}}% do Poder de Ataque|r por |cffFF9900{{2}}|r."
                elseif en:find("Spell Damage", 1, true) and en:find("Attack Power", 1, true) and en:find("This Mythical Boon empowers your party", 1, true) then
                    pair[2] = "Esta Dádiva Mítica fortalece o grupo. O |cffFF9900dano de feitiço|r aumenta em |cffFF9900{{1}}|r e o |cffFF9900poder de ataque|r aumenta em |cffFF9900{{2}}|r por |cffFF9900{{3}}|r."
                elseif en:find("shifts your party to another plane", 1, true) then
                    pair[2] = "Esta Dádiva Mítica leva o grupo para outro plano por até |cffFF9900{{1}}|r, permitindo passar pelos inimigos sem ser percebido."
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
        U["Mythic+ dungeons are not\ncurrently active"] = "As masmorras Mítico+ não estão\ndisponíveis no momento"
        U["Mythic+& Raid Services"] = "Serviços de Mítico+ e Raide"
        U["Mythic: Zul'Gurub"] = "Mítico: Zul'Gurub"

        for en in pairs(U) do
            if type(en) == "string" and en:find("Mythic+ dungeons are a high-level, repeatable challenge mode", 1, true) == 1 then
                U[en] = "As Masmorras de Pedra-chave Mítica são um modo de desafio repetível de alto nível, criado para testar habilidade, coordenação e eficiência. Para iniciar uma tentativa de Mítico+, você precisa de uma Pedra-chave Mítica, obtida ao concluir uma |cFF00CCFF|Hkeyword:88|hMasmorra|h|r na dificuldade Mítica. Com a Pedra-chave em mãos, ative-a na entrada da |cFF00CCFF|Hkeyword:88|hMasmorra|h|r para começar.\r\n\r\nDiferente das masmorras Míticas comuns, as Masmorras de Pedra-chave Mítica são cronometradas e escalam conforme o nível da Pedra-chave. Quanto maior o nível, mais fortes ficam os inimigos e novos afixos — modificadores especiais da |cFF00CCFF|Hkeyword:88|hMasmorra|h|r — adicionam mecânicas como perigos ambientais, bônus para inimigos ou pressão sobre todo o grupo. Os afixos mudam semanalmente e também variam conforme o nível da chave.\r\n\r\nAo final de cada tentativa, a Pedra-chave muda de acordo com seu desempenho, podendo subir de nível ou apontar para outra |cFF00CCFF|Hkeyword:88|hMasmorra|h|r. Concluir a masmorra rapidamente pode melhorar sua chave e suas recompensas; ultrapassar o cronômetro pode reduzir a dificuldade.\r\n\r\nNíveis mais altos de Pedra-chave Mítica oferecem recompensas melhores, incluindo equipamentos épicos, |cFF00CCFF|Hkeyword:82|hMoedas|h|r e progresso em conquistas e tabelas de classificação."
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

-- UI de endgame ---------------------------------------------------------------
-- A maior parte dos nomes (afixos, masmorras, areas etc.) ja existe nas bases
-- gerais. Aqui ficam apenas rotulos proprios das telas custom e padroes montados
-- em runtime pelo Ascension.
do
    A.EndgameUIExact = A.EndgameUIExact or {}
    local E = A.EndgameUIExact

    local exact = {
        ["Mythic+ Dungeons"] = "Masmorras Mítico+",
        ["Mythic Dungeons"] = "Masmorras Míticas",
        ["Classic Dungeons"] = "Masmorras Clássicas",
        ["Classic dungeons"] = "Masmorras Clássicas",
        ["Best run for this affix set"] = "Melhor tempo com este conjunto de afixos",
        ["Best Run for this Affix Set"] = "Melhor tempo com este conjunto de afixos",
        ["Best run"] = "Melhor tempo",
        ["Current run"] = "Tentativa atual",
        ["Weekly Best"] = "Melhor da Semana",
        ["Season Best"] = "Melhor da Temporada",
        ["Overtime"] = "Fora do tempo",
        ["In Time"] = "Dentro do tempo",
        ["Time Limit"] = "Limite de tempo",
        ["Affix"] = "Afixo",
        ["Affixes"] = "Afixos",
        ["Creature Affix"] = "Afixo de Criatura",
        ["Boss Affix"] = "Afixo de Chefe",
        ["Player Affix"] = "Afixo de Jogador",
        ["Environmental Affix"] = "Afixo Ambiental",
        ["Champion Affix"] = "Afixo de Campeão",
        ["Mythic Level"] = "Nível Mítico+",
        ["Mythic Rating"] = "Classificação Mítica+",
        ["Dungeon Level"] = "Nível da Masmorra",
        ["Mythic Keystone"] = "Pedra-chave Mítica",
        ["Keystone"] = "Pedra-chave",
        ["Leaderboard"] = "Classificação",
        ["Rewards"] = "Recompensas",
        ["Completed"] = "Concluída",
        ["Incomplete"] = "Incompleta",
        ["Start"] = "Iniciar",
        -- Masmorras / localizador
        ["Dungeons & Raids"] = "Masmorras e Raides",
        ["Dungeon Finder"] = "Localizador de Masmorras",
        ["Type"] = "Tipo",
        ["Type:"] = "Tipo:",
        ["Random Dungeon"] = "Masmorra Aleatória",
        ["Random Classic Dungeon"] = "Masmorra Clássica Aleatória",
        ["Random Heroic Dungeon"] = "Masmorra Heroica Aleatória",
        ["Random Mythic Dungeon"] = "Masmorra Mítica Aleatória",
        ["Specific Dungeons"] = "Masmorras Específicas",
        ["Specific Dungeon"] = "Masmorra Específica",
        ["Find a Group"] = "Encontrar Grupo",
        ["Join Queue"] = "Entrar na Fila",
        ["Leave Queue"] = "Sair da Fila",
        ["Queue"] = "Fila",
        ["Estimated Wait Time"] = "Tempo Estimado de Espera",
        ["Time in Queue"] = "Tempo na Fila",
        ["Choose Role"] = "Escolha uma função",
        ["Tank"] = "Tanque",
        ["Healer"] = "Curador",
        ["Damage"] = "Dano",

        -- Mítico+
        ["Mythic Dungeon"] = "Masmorra Mítica",
        ["Weekly Affixes"] = "Afixos da Semana",
        ["Weekly Affix"] = "Afixo da Semana",
        ["Timed Dungeon Runs"] = "Tentativas Cronometradas",
        ["Timed Dungeon Run"] = "Tentativa Cronometrada",
        ["Keystones & Scaling"] = "Pedras-chave e Escalonamento",
        ["Requirements for Completing the Key"] = "Requisitos para concluir a Pedra-chave",
        ["Completion within Time Limit"] = "Conclusão dentro do limite de tempo",
        ["Slaying End Boss"] = "Derrotar o chefe final",
        ["Slaying Additional Bosses"] = "Derrotar chefes adicionais",
        ["Enemy Forces"] = "Forças inimigas",
        ["Bosses Defeated"] = "Chefes derrotados",
        ["Deaths"] = "Mortes",
        ["Time Remaining"] = "Tempo restante",
        ["Mythical Boon"] = "Dádiva Mítica",
        ["Mythical Boons"] = "Dádivas Míticas",
        ["Personal Spoils"] = "Espólios Pessoais",
        ["Mythic Coin"] = "Moeda Mítica",
        ["Mythic Coins"] = "Moedas Míticas",
        ["Mythic Orb"] = "Orbe Mítico",
        ["Mythic Orbs"] = "Orbes Míticos",
        ["Activate Keystone"] = "Ativar Pedra-chave",
        ["Start Keystone"] = "Iniciar Pedra-chave",
        ["Insert Mythic Keystone"] = "Inserir Pedra-chave Mítica",
        ["Upgrade Keystone"] = "Aprimorar Pedra-chave",
        ["Keystone Level"] = "Nível da Pedra-chave",
        ["Keystone Dungeon"] = "Masmorra da Pedra-chave",
        ["Dungeon Complete"] = "Masmorra Concluída",
        ["Dungeon Failed"] = "Masmorra Fracassada",
        ["Agility"] = "Agilidade",
        ["Strength"] = "Força",
        ["Intellect"] = "Intelecto",
        ["Spirit"] = "Espírito",
        ["Miscellaneous"] = "Diversos",

        -- Raides / Provas de Raide
        ["Raid"] = "Raide",
        ["Raids"] = "Raides",
        ["Normal"] = "Normal",
        ["Heroic"] = "Heroico",
        ["Mythic"] = "Mítico",
        ["Ascended"] = "Ascendido",
        ["Ascended Difficulty"] = "Dificuldade Ascendida",
        ["Raid Trial"] = "Prova de Raide",
        ["Raid Trials"] = "Provas de Raide",
        ["Trial UI"] = "Interface de Provas",
        ["Trial Level"] = "Nível da Prova",
        ["Raid Trial Level"] = "Nível da Prova de Raide",
        ["Damage Increase"] = "Aumento de Dano",
        ["Health Increase"] = "Aumento de Vida",
        ["Healing Reduction"] = "Redução de Cura",
        ["First Completion"] = "Primeira Conclusão",
        ["First Completion Reward"] = "Recompensa da Primeira Conclusão",
        ["Ascended Raid Cache"] = "Baú de Raide Ascendido",
        ["Triumphant Raider Token"] = "Ficha do Raideiro Triunfante",
        ["Triumphant Raider Tokens"] = "Fichas do Raideiro Triunfante",
        ["Raider's Commendation"] = "Comenda do Raideiro",
        ["Raider's Commendations"] = "Comendas do Raideiro",
        ["Raiders Commendations"] = "Comendas do Raideiro",
        ["Mark of Triumph"] = "Marca do Triunfo",
        ["Marks of Triumph"] = "Marcas do Triunfo",
        ["Loot Lockout"] = "Bloqueio de Saque",
        ["Raid Lockout"] = "Bloqueio de Raide",
        ["Reset Lockout"] = "Redefinir Bloqueio",
        ["Activate Trial"] = "Ativar Prova",

        -- Tormenta de Mana
        ["Manastorm"] = "Tormenta de Mana",
        ["The Manastorm"] = "Tormenta de Mana",
        ["Potential Rewards"] = "Recompensas possíveis",
        ["Active Manastorm Spells"] = "Feitiços Ativos da Tormenta de Mana",
        ["Earned Currencies"] = "Moedas obtidas",
        ["Manastorm Cache"] = "Baú da Tormenta de Mana",
        ["Manastorm Caches"] = "Baús da Tormenta de Mana",
        ["Manastorm Spell"] = "Feitiço da Tormenta de Mana",
        ["Manastorm Spells"] = "Feitiços da Tormenta de Mana",
        ["Manastorm Checkpoint"] = "Ponto de Controle da Tormenta de Mana",
        ["Manastorm Checkpoints"] = "Pontos de Controle da Tormenta de Mana",
        ["Checkpoint"] = "Ponto de Controle",
        ["Checkpoints"] = "Pontos de Controle",
        ["Floor"] = "Andar",
        ["Current Floor"] = "Andar Atual",
        ["Highest Floor"] = "Andar Mais Alto",
        ["Best Floor"] = "Melhor Andar",
        ["Solo Progress"] = "Progresso solo",
        ["Group Progress"] = "Progresso em Grupo",
        ["Enter the Manastorm"] = "Entrar na Tormenta de Mana",
        ["Enter The Manastorm"] = "Entrar na Tormenta de Mana",
        ["Leave the Manastorm"] = "Sair da Tormenta de Mana",
        ["Leave The Manastorm"] = "Sair da Tormenta de Mana",
        ["Resume Run"] = "Retomar Tentativa",
        ["Start Run"] = "Iniciar Tentativa",
        ["Bonus XP Per Floor"] = "Bônus de EXP por andar",
        ["Checkpoints Every 5 Floors"] = "Pontos de Controle a Cada 5 Andares",
        ["Greedy Goblin"] = "Goblin Ganancioso",
        ["Greedy Goblins"] = "Goblins Gananciosos",
        ["Bedlam Bullion"] = "Lingote de Bedlam",
        ["Bedlam Bullions"] = "Lingotes de Bedlam",
        ["Bonzo Bolt"] = "Parafuso Bonzo",
        ["Bonzo Bolts"] = "Parafusos Bonzo",

        -- Prestígio / Quadro de Chamados
        ["Prestige"] = "Prestígio",
        ["Prestige Mode"] = "Modo Prestígio",
        ["Prestigious Cache"] = "Baú Prestigioso",
        ["Prestigious Caches"] = "Baús Prestigiosos",
        ["Token of Prestige"] = "Ficha de Prestígio",
        ["Tokens of Prestige"] = "Fichas de Prestígio",
        ["Prestige Token"] = "Ficha de Prestígio",
        ["Prestige Tokens"] = "Fichas de Prestígio",
        ["Prestige Level"] = "Nível de Prestígio",
        ["Prestige Daily"] = "Diária de Prestígio",
        ["Prestige Daily:"] = "Diária de Prestígio:",
        ["Rotating Prestige Daily Bonuses"] = "Bônus Diários Rotativos de Prestígio",
        ["Hero's Call Board"] = "Quadro de Chamado do Herói",
        ["Heroes Callboard"] = "Quadro de Chamado do Herói",
        ["Call Board"] = "Quadro de Chamados",
        ["Callboard"] = "Quadro de Chamados",
        ["Callboard Cache"] = "Baú do Quadro de Chamados",
        ["Daily Reset"] = "Reinício Diário",
        ["Weekly Reset"] = "Reinício Semanal",
        ["Reset Timer"] = "Tempo até a reinicialização",
        ["Lockout Timer"] = "Tempo de Bloqueio",
        ["Dungeon Lockout"] = "Bloqueio de Masmorra",
        ["Arena Lockout"] = "Bloqueio de Arena",
        ["Arena Reset"] = "Reinício da Arena",
        ["Daily Quests"] = "Missões Diárias",
        ["Weekly Quests"] = "Missões Semanais",
        ["Timewalking"] = "Caminhada Temporal",
        ["Crafting Quests"] = "Missões de Criação",

        -- Chefes Mundiais
        ["World Boss"] = "Chefe Mundial",
        ["World Bosses"] = "Chefes Mundiais",
        ["World Boss Encounter System"] = "Sistema de Encontros com Chefes Mundiais",
        ["Open World PvPvE"] = "JxJxA em Mundo Aberto",
        ["Instanced PvE"] = "JxA Instanciado",
        ["Instanced World Boss"] = "Chefe Mundial Instanciado",
        ["Boss Shrine"] = "Santuário do Chefe",
        ["Treasures of Azeroth"] = "Tesouros de Azeroth",
        ["Treasures of Azeroth Cache"] = "Baú de Tesouros de Azeroth",
        ["Nightmare Dragons"] = "Dragões do Pesadelo",
        ["Heroic World Boss"] = "Chefe Mundial Heroico",
        ["Mythic World Boss"] = "Chefe Mundial Mítico",
        ["Reaper of Souls"] = "Ceifador de Almas",

        -- Alto Risco
        ["High Risk"] = "Alto Risco",
        ["High-Risk"] = "Alto Risco",
        ["High Risk PvP"] = "JxJ de Alto Risco",
        ["High-Risk PvP"] = "JxJ de Alto Risco",
        ["No Risk"] = "Sem Risco",
        ["No-Risk"] = "Sem Risco",
        ["No Risk PvP"] = "JxJ Sem Risco",
        ["No-Risk PvP"] = "JxJ Sem Risco",
        ["No Risk PvE"] = "JxA Sem Risco",
        ["No-Risk PvE"] = "JxA Sem Risco",
        ["High-Risk Mode"] = "Modo de Alto Risco",
        ["No-Risk Mode"] = "Modo Sem Risco",
        ["Risk Mode"] = "Modo de Risco",
        ["Hybrid Risk"] = "Risco Híbrido",
        ["Criminal Intent"] = "Intenção Criminosa",
        ["Outlaw"] = "Fora da Lei",
        ["Protector"] = "Protetor",
        ["Mercenary for Hire!"] = "Mercenário Disponível!",
        ["Treasure Hunter"] = "Caçador de Tesouros",
        ["Bloodforged"] = "Forjado em Sangue",
        ["Bloodforged Gear"] = "Equipamento Forjado em Sangue",
        ["Loot on Death"] = "Saque ao Morrer",
        ["PvP Power"] = "Poder JxJ",
        ["Crow's Cache"] = "Baú do Corvo",

        -- Eventos mundiais / progressão JxJ
        ["World Event"] = "Evento Mundial",
        ["World Events"] = "Eventos Mundiais",
        ["Glory System"] = "Sistema de Glória",
        ["Glory"] = "Glória",
        ["Glory Points"] = "Pontos de Glória",
        ["Glory Rank"] = "Grau de Glória",
        ["Current Glory Rank"] = "Grau de Glória Atual",
        ["Next Glory Rank"] = "Próximo Grau de Glória",
        ["PvP Progression"] = "Progressão JxJ",

        -- Encantamento Místico
        ["Mystic Enchant"] = "Encantamento Místico",
        ["Mystic Enchants"] = "Encantamentos Místicos",
        ["Mystic Enchanting"] = "Encantamento Místico",
        ["Mystic Enchant Collection"] = "Coleção de Encantamentos Místicos",
        ["Mystic Enchants Collection"] = "Coleção de Encantamentos Místicos",
        ["Mystic Enchant Preset"] = "Predefinição de Encantamentos Místicos",
        ["Mystic Enchanting Altar"] = "Altar de Encantamento Místico",
        ["Mystic Extract"] = "Extrato Místico",
        ["Mystic Extracts"] = "Extratos Místicos",
        ["Runes of Ascension"] = "Runas de Ascensão",
        ["Reforge"] = "Reforjar",
        ["Reforging"] = "Reforja",
        ["Collection"] = "Coleção",
        ["Preset"] = "Predefinição",
        ["Presets"] = "Predefinições",
        ["Ember Court"] = "Corte das Brasas",
        ["Ember Court Reputation"] = "Reputação com a Corte das Brasas",
        ["Reputation"] = "Reputação",
        ["Traits"] = "Características",
        ["Trait"] = "Característica",
        ["Progress"] = "Progresso",
        ["Level"] = "Nível",
        ["King"] = "Rei",
        ["Queen"] = "Rainha",
        ["Prince"] = "Príncipe",
        ["Rare Armor Cache"] = "Baú de Armadura Rara",
        ["Epic Armor Cache"] = "Baú de Armadura Épica",
        ["Legendary Armor Cache"] = "Baú de Armadura Lendária",
        ["Rare Weapon Cache"] = "Baú de Arma Rara",
        ["Epic Weapon Cache"] = "Baú de Arma Épica",
        ["Legendary Weapon Cache"] = "Baú de Arma Lendária",
        ["Rare Ability Cache"] = "Baú de Habilidade Rara",
        ["Epic Ability Cache"] = "Baú de Habilidade Épica",
        ["Legendary Ability Cache"] = "Baú de Habilidade Lendária",
        ["Rare Module Cache"] = "Baú de Módulo Raro",
        ["Epic Module Cache"] = "Baú de Módulo Épico",
        ["Legendary Module Cache"] = "Baú de Módulo Lendário",
    }

    for en, pt in pairs(exact) do E[en] = pt end


    -- Cobertura extra baseada na Wiki do Project Ascension.
    -- Sao rotulos/textos curtos que aparecem nas UIs proprias do servidor e
    -- tambem servem para corrigir as entradas antigas do ServerUI mais abaixo.
    local wikiExact = {
        -- Localizador de Masmorras / atividades
        ["5 Player (Mythic)"] = "5 jogadores (Mítico)",
        ["REWARDS"] = "RECOMPENSAS",
        ["Rune of Ascension"] = "Runa de Ascensão",
        ["Random Dungeons"] = "Masmorras Aleatórias",
        ["Random Classic Dungeons"] = "Masmorras Clássicas Aleatórias",
        ["Random Heroic Dungeons"] = "Masmorras Heroicas Aleatórias",
        ["Random Mythic Dungeons"] = "Masmorras Míticas Aleatórias",
        ["Click this button to join or leave the Dungeon Finder queue"] = "Clique para entrar ou sair da fila do Localizador de Masmorras",
        ["Toggle Dungeon Finder Frame"] = "Alternar Localizador de Masmorras",
        ["Ready Check"] = "Verificação de Prontidão",
        ["Role Check"] = "Verificação de Função",
        ["Find Group"] = "Encontrar Grupo",
        ["Queue Status"] = "Status da fila",
        ["Group Finder"] = "Localizador de Grupos",
        ["Scarlet Monastery"] = "Monastério Escarlate",
        ["Scarlet Monastery - Graveyard"] = "Monastério Escarlate: Cemitério",
        ["Scarlet Monastery - Library"] = "Monastério Escarlate: Biblioteca",
        ["Scarlet Monastery - Armory"] = "Monastério Escarlate: Arsenal",
        ["Scarlet Monastery - Cathedral"] = "Monastério Escarlate: Catedral",
        ["Alterac Valley"] = "Vale Alterac",
        ["Damage Dealer"] = "Dano",
        ["Damage Dealers"] = "Dano",

        -- Mítico / Mítico+
        ["Gear Up for Mythic Dungeons"] = "Equipe-se para Masmorras Míticas",
        ["Mythic Plus"] = "Mítico+",
        ["Mythic (10-25 Players)"] = "Mítico (10-25 jogadores)",
        ["Mythic+ dungeons are not\ncurrently active"] = "As masmorras Mítico+ não estão\ndisponíveis no momento",
        ["Mythic+& Raid Services"] = "Serviços de Mítico+ e Raide",
        ["Show Mythic Boons"] = "Mostrar Dádivas Míticas",
        ["These options allow you to configure interface elements relating to Mythic Plus."] = "Estas opções controlam os elementos da interface relacionados ao Mítico+.",
        ["Complete a Keystone Dungeon!"] = "Conclua uma Masmorra de Pedra-chave Mítica!",
        ["Mythic+ Cache"] = "Baú de Mítico+",
        ["Mythic+ Caches"] = "Baús de Mítico+",
        ["Mythic+ Coin"] = "Moeda de Mítico+",
        ["Mythic+ Coins"] = "Moedas de Mítico+",
        ["Spoils Cache"] = "Baú de Espólios",
        ["Personal Spoils Cache"] = "Baú de Espólios Pessoais",
        ["Personal Spoils Chest"] = "Baú de Espólios Pessoais",
        ["Timer"] = "Cronômetro",
        ["Dungeon Timer"] = "Cronômetro da Masmorra",
        ["Beat the Timer"] = "Conclua dentro do tempo",
        ["Keystone Rank"] = "Nível da Pedra-chave",
        ["Reroll Keystone"] = "Sortear Outra Masmorra da Pedra-chave",
        ["Downgrade Keystone"] = "Reduzir Nível da Pedra-chave",
        ["Upgrade Mythic Gear"] = "Aprimorar Equipamento Mítico",
        ["Recycle Mythic Gear"] = "Reciclar Equipamento Mítico",
        ["Ascended Raiding"] = "Raides Ascendidos",
        ["Mythic Champions"] = "Campeões Míticos",
        ["Mythic Champion"] = "Campeão Mítico",
        ["Champion Affixes"] = "Afixos de Campeão",
        ["Mythic Recycling"] = "Reciclagem Mítica",
        ["Mythic Coin Cap"] = "Limite de Moedas Míticas",
        ["Mythic Cache Cap"] = "Limite de Baús Míticos",
        ["Mythic Item"] = "Item Mítico",
        ["Mythic Items"] = "Itens Míticos",
        ["Keystone Rewards"] = "Recompensas da Pedra-chave",
        ["Bonus Rewards"] = "Recompensas Bônus",
        ["Dungeon Requirements"] = "Requisitos da Masmorra",
        ["Enemy Forces"] = "Forças inimigas",
        ["Time Remaining"] = "Tempo restante",
        ["Time Limit"] = "Limite de tempo",
        ["Completed in Time"] = "Concluída dentro do tempo",
        ["Completed Overtime"] = "Concluída fora do tempo",
        ["Mythic Cache"] = "Baú Mítico",
        ["Mythic Caches"] = "Baús Míticos",
        ["Expanded Mythic+ Dungeon Loot"] = "Saque ampliado das masmorras Mítico+",
        ["Mythic Coin and Cache Increase"] = "Aumento do Limite de Moedas e Baús Míticos",
        ["Mythic 11-15 Unlocked"] = "Mítico 11-15 Desbloqueado",
        ["Mythic Champion Affix"] = "Afixo de Campeão Mítico",
        ["Mythic Item Recycling"] = "Reciclagem de Itens Míticos",
        ["Recycle Mythic Item"] = "Reciclar Item Mítico",
        ["Recycle Mythic Items"] = "Reciclar Itens Míticos",

        -- Afixos da HUD Mítica. Ficam aqui também para não depender da opção geral de spells.
        ["Resistant"] = "Resistente",
        ["Pack Tactics"] = "Táticas de Matilha",
        ["True Sight"] = "Visão Verdadeira",
        ["Avenger"] = "Vingador",
        ["Fortified"] = "Fortificada",
        ["Tyrannical"] = "Tirânica",
        ["Raging"] = "Enraivecedora",
        ["Enraged"] = "Enfurecido",
        ["Life Stealing"] = "Dreno de Vida",
        ["Killer Bees"] = "Abelhas Assassinas",
        ["Sanguine"] = "Sanguínea",
        ["Erupting Flames"] = "Chamas Eruptivas",
        ["Vulnerability"] = "Vulnerabilidade",

        -- Tormenta de Mana
        ["A Group member has recently entered The Manastorm and must wait before doing so again."] = "Um membro do grupo entrou recentemente na Tormenta de Mana e precisa esperar antes de entrar novamente.",
        ["A group member's current challenge does not allow entering The Manastorm!"] = "O desafio atual de um membro do grupo não permite entrar na Tormenta de Mana!",
        ["Are you sure you want to leave The Manastorm? "] = "Tem certeza de que deseja sair da Tormenta de Mana? ",
        ["Bonus Manastorm Caches"] = "Baús Bônus da Tormenta de Mana",
        ["Cannot enter The Manastorm"] = "Não é possível entrar na Tormenta de Mana",
        ["Choose which Manastorm spells will be available for you to use while in The Manastorm."] = "Escolha quais feitiços da Tormenta de Mana ficarão disponíveis durante a tentativa.",
        ["Endless Manastorm Potion"] = "Poção Infinita da Tormenta de Mana",
        ["Enter Duo Manastorm"] = "Entrar na Tormenta de Mana em Dupla",
        ["Enter Group Manastorm"] = "Entrar na Tormenta de Mana em Grupo",
        ["Enter Solo Manastorm"] = "Entrar na Tormenta de Mana (Solo)",
        ["Enter Trio Manastorm"] = "Entrar na Tormenta de Mana em Trio",
        ["Enter The Manastorm!"] = "Entrar na Tormenta de Mana!",
        ["Full Active Manastorm Spells"] = "Todos os Feitiços Ativos da Tormenta de Mana",
        ["Manastorm Cast While Moving"] = "Tormenta de Mana: Lançar em Movimento",
        ["Manastorm Checkpoint Unlocked"] = "Ponto de Controle da Tormenta de Mana Desbloqueado",
        ["Manastorm Complete"] = "Tormenta de Mana Concluída",
        ["Manastorm Defense"] = "Defesa da Tormenta de Mana",
        ["Manastorm Healing"] = "Cura da Tormenta de Mana",
        ["Manastorm Interrupt Rod"] = "Bastão de Interrupção da Tormenta de Mana",
        ["Manastorm Sprint Serum"] = "Soro de Corrida da Tormenta de Mana",
        ["Manastorm Upgrades"] = "Aprimoramentos da Tormenta de Mana",
        ["The Manastorm is not available at this time"] = "A Tormenta de Mana não está disponível no momento",
        ["Unable to leave The Manastorm"] = "Não é possível sair da Tormenta de Mana",
        ["You are already in the Manastorm!"] = "Você já está na Tormenta de Mana!",
        ["You are not in The Manastorm"] = "Você não está na Tormenta de Mana",
        ["You are participating in a Trial that cannot enter The Manastorm."] = "Você está participando de uma Prova que não permite entrar na Tormenta de Mana.",
        ["You have recently entered The Manastorm and must wait a few minutes before doing so again."] = "Você entrou recentemente na Tormenta de Mana e precisa esperar alguns minutos antes de entrar novamente.",
        ["Your death ejected you from the Manastorm"] = "Sua morte expulsou você da Tormenta de Mana",
        ["Your group members must all be at least level 15 to enter The Manastorm."] = "Todos os membros do grupo precisam estar pelo menos no nível 15 para entrar na Tormenta de Mana.",
        ["You must be at least level 15 to enter The Manastorm."] = "Você precisa estar pelo menos no nível 15 para entrar na Tormenta de Mana.",
        ["You must select your Stat Path in Character Advancement to enter The Manastorm."] = "Selecione seu Caminho de Atributos na Progressão do Personagem para entrar na Tormenta de Mana.",
        ["Bedlam Bullion & Bonzo Bolts"] = "Lingotes de Bedlam e Parafusos Bonzo",
        ["Exchange your Bedlam Bullion & Bonzo Bolts."] = "Troque seus Lingotes de Bedlam e Parafusos Bonzo.",

        -- Prestígio
        ["Account Prestige Level"] = "Nível de Prestígio da Conta",
        ["Activate Prestige Mode and go back to level 1"] = "Ativar o Modo Prestígio e voltar ao nível 1",
        ["Are you ready to Prestige?"] = "Pronto para entrar em Prestígio?",
        ["Gain Tokens of Prestige to spend them on unique rewards!"] = "Ganhe Fichas de Prestígio e troque por recompensas exclusivas!",
        ["Gain |cffFFFFFFTokens of Prestige|r to spend them on unique rewards!"] = "Ganhe |cffFFFFFFFichas de Prestígio|r e troque por recompensas exclusivas!",
        ["I would like to purchase Prestige items!"] = "Quero comprar itens de Prestígio!",
        ["Non-Prestige"] = "Sem Prestígio",
        ["Prestige and get following rewards!"] = "Entre em Prestígio e receba as seguintes recompensas!",
        ["Prestige: Open World"] = "Prestígio: Mundo Aberto",
        ["Scroll of Fortune Progress resets in Prestige Mode"] = "O progresso do Pergaminho da Fortuna é reiniciado no Modo Prestígio",
        ["Hand of Fate Progress resets in Prestige Mode"] = "O progresso da Mão do Destino é reiniciado no Modo Prestígio",
        ["Wildcard: Prestige Rerolling!"] = "Curinga: Novas Rolagens de Prestígio!",
        ["Prestige Rewards"] = "Recompensas de Prestígio",
        ["Prestige Items"] = "Itens de Prestígio",
        ["Prestige Titles"] = "Títulos de Prestígio",
        ["Prestige Bonus Experience"] = "Bônus de Experiência de Prestígio",
        ["Reset Specialization"] = "Redefinir Especialização",
        ["Activate Prestige Mode"] = "Ativar Modo Prestígio",

        -- Quadro de Chamados
        ["Call Board Caches"] = "Baús do Quadro de Chamados",
        ["Call Board Quests"] = "Missões do Quadro de Chamados",
        ["Call Boards"] = "Quadros de Chamados",
        ["Callboard Caches"] = "Baús do Quadro de Chamados",
        ["Callboard Quests"] = "Missões do Quadro de Chamados",
        ["I would like to purchase Temporal contracts to complete my Callboard Quests!"] = "Quero comprar Contratos Temporais para concluir minhas missões do Quadro de Chamados!",
        ["Running out of time? Complete Call Board Quests for gold instead!"] = "Sem tempo? Conclua as missões do Quadro de Chamados usando ouro!",
        ["Temporal Contract"] = "Contrato Temporal",
        ["Temporal Contracts"] = "Contratos Temporais",
        ["Arena Lockout"] = "Bloqueio de Arena",
        ["Raid Lockouts"] = "Bloqueios de Raide",
        ["Dungeon Lockouts"] = "Bloqueios de Masmorra",

        -- Provas de Raide
        ["Raid Trial Leaderboard"] = "Classificação das Provas de Raide",
        ["Raid Trial Leaderboards"] = "Classificações das Provas de Raide",
        ["Trial Difficulty"] = "Dificuldade da Prova",
        ["Monster Health"] = "Vida dos inimigos",
        ["Monster Damage"] = "Dano dos inimigos",
        ["Player Healing"] = "Cura dos Jogadores",
        ["First-Time Rewards"] = "Recompensas da Primeira Conclusão",
        ["Ascended Lockout"] = "Bloqueio Ascendido",
        ["Triumphant Raider Rewards"] = "Recompensas do Raideiro Triunfante",
        ["Raid Trial Vendor"] = "Comerciante de Provas de Raide",
        ["Realm First"] = "Primeiro do Reino",
        ["Realm Firsts"] = "Primeiros do Reino",
        ["Triumphant Raider Token"] = "Ficha do Raideiro Triunfante",
        ["Triumphant Raider Tokens"] = "Fichas do Raideiro Triunfante",
        ["Ascended Raid Cache"] = "Baú de Raide Ascendido",
        ["Hall of Legends"] = "Salão das Lendas",
        ["Trial UI"] = "Interface de Provas",
        ["Raid Difficulty"] = "Dificuldade de Raide",
        ["Healing Reduction"] = "Redução de Cura",
        ["Bonus Runes of Ascension"] = "Runas de Ascensão adicionais",
        ["Exclusive Cosmetic Rewards"] = "Recompensas Cosméticas Exclusivas",
        ["Raid Trial Cache"] = "Baú da Prova de Raide",
        ["Raid Trial Caches"] = "Baús das Provas de Raide",
        ["Case of Fortune"] = "Caixa de Fortuna",
        ["Cases of Fortune"] = "Caixas de Fortuna",
        ["Talent Case of Fortune"] = "Caixa de Fortuna de Talento",
        ["Talent Cases of Fortune"] = "Caixas de Fortuna de Talento",
        ["Remote of Retreat"] = "Controle Remoto de Retirada",
        ["Unique Cosmetic Set"] = "Conjunto Cosmético Exclusivo",
        ["Unique Cosmetic Weapon"] = "Arma Cosmética Exclusiva",
        ["Unique Vendor Cosmetics"] = "Cosméticos Exclusivos do Comerciante",
        ["Leaderboard"] = "Classificação",
        ["Leaderboards"] = "Classificações",

        -- Chefes Mundiais / eventos
        ["Take Down a World Boss"] = "Derrote um Chefe Mundial",
        ["World Boss Encounter"] = "Encontro com Chefe Mundial",
        ["World Boss Difficulty"] = "Dificuldade do Chefe Mundial",
        ["World Boss Rewards"] = "Recompensas do Chefe Mundial",
        ["Heroic World Bosses"] = "Chefes Mundiais Heroicos",
        ["Mythic World Bosses"] = "Chefes Mundiais Míticos",
        ["World Event Rewards"] = "Recompensas de Evento Mundial",
        ["Event Rewards"] = "Recompensas do Evento",
        ["Event Active"] = "Evento Ativo",
        ["Event Inactive"] = "Evento Inativo",
        ["Boss Shrine"] = "Santuário do Chefe",
        ["World Boss Shrine"] = "Santuário do Chefe Mundial",
        ["Instanced World Boss"] = "Chefe Mundial Instanciado",
        ["Instanced World Bosses"] = "Chefes Mundiais Instanciados",
        ["Open World World Boss"] = "Chefe Mundial em Mundo Aberto",
        ["PvPvE Open World"] = "Mundo Aberto JxJxA",
        ["PvE Instanced Version"] = "Versão JxA Instanciada",
        ["PvPvE Open World Version"] = "Versão JxJxA em Mundo Aberto",
        ["Worldforged Upgrades"] = "Aprimoramentos Forjados pelo Mundo",
        ["Worldforged Item Upgrades"] = "Aprimoramentos de Itens Forjados pelo Mundo",
        ["Blackrock Caverns"] = "Cavernas Rocha Negra",
        ["Vanilla Heroic Dungeons!"] = "Masmorras Heroicas Clássicas!",
        ["Classic: Crow's Cache"] = "Clássico: Baú do Corvo",
        ["Nightmare Dragons - Heroic"] = "Dragões do Pesadelo — Heroico",
        ["Dragons of Nightmare"] = "Dragões do Pesadelo",
        ["Heroic Dragons of Nightmare"] = "Dragões do Pesadelo Heroicos",
        ["Heroic Treasure"] = "Tesouro Heroico",
        ["No Loot Lockout"] = "Sem Bloqueio de Saque",
        ["7 Day Loot Lockout"] = "Bloqueio de Saque de 7 Dias",
        ["10-40 Players"] = "10-40 jogadores",
        ["A Call to Arms - Alterac Valley Unleashed"] = "Chamado às Armas — Vale Alterac Liberado",
        ["Blood Bowl"] = "Copa Sangrenta",
        ["Enter the Blood Bowl"] = "Entrar na Copa Sangrenta",
        ["Spectator Rewards"] = "Recompensas de Espectador",
        ["Worldforged Item"] = "Item Forjado pelo Mundo",
        ["Worldforged Items"] = "Itens Forjados pelo Mundo",
        ["Worldforged Upgrade"] = "Aprimoramento Forjado pelo Mundo",

        -- Alto Risco / Forjado em Sangue
        ["End-Game High-Risk"] = "Alto Risco de Nível Máximo",
        ["High-Risk Bonuses"] = "Bônus de Alto Risco",
        ["High-Risk Events"] = "Eventos de Alto Risco",
        ["High-Risk Materials: Cloth"] = "Materiais de Alto Risco: Tecido",
        ["High-Risk Materials: Enchanting Dust"] = "Materiais de Alto Risco: Poeira de Encantamento",
        ["High-Risk Materials: Herbs"] = "Materiais de Alto Risco: Ervas",
        ["High-Risk Materials: Meat and Leather"] = "Materiais de Alto Risco: Carne e Couro",
        ["High-Risk Materials: Metals"] = "Materiais de Alto Risco: Metais",
        ["High-Risk Open World"] = "Alto Risco em Mundo Aberto",
        ["High-Risk PvP"] = "JxJ de Alto Risco",
        ["High-Risk PvP Mode"] = "Modo JxJ de Alto Risco",
        ["High-Risk Recipe"] = "Receita de Alto Risco",
        ["High-Risk Tier 1"] = "Alto Risco — Nível 1",
        ["High-Risk Tier 2"] = "Alto Risco — Nível 2",
        ["High-Risk Tier 3"] = "Alto Risco — Nível 3",
        ["Collect High-Risk crafting materials"] = "Colete materiais de criação de Alto Risco",
        ["Craft High-Risk material recipes."] = "Crie receitas com materiais de Alto Risco.",
        ["Find High Risk Crafting Materials in end-game zones"] = "Encontre materiais de criação de Alto Risco em zonas de nível máximo",
        ["Only show recipes obtained in High-Risk."] = "Mostrar apenas receitas obtidas em Alto Risco.",
        ["Show High-Risk Events"] = "Mostrar eventos de Alto Risco",
        ["Find Bloodforged Gear"] = "Obtenha Equipamento Forjado em Sangue",
        ["Find Bloodforged gear"] = "Obtenha Equipamento Forjado em Sangue",
        ["Find Bloodforged Gear from Creatures"] = "Obtenha Equipamento Forjado em Sangue de criaturas",
        ["Find Heroic Bloodforged gear"] = "Obtenha Equipamento Heroico Forjado em Sangue",
        ["Heroic Bloodforged Gear"] = "Equipamento Heroico Forjado em Sangue",
        ["Equipped gear is insured in High-Risk"] = "O equipamento equipado está protegido no Alto Risco",
        ["Failed in High-Risk"] = "Fracassou no Alto Risco",
        ["You've Entered High-Risk PvP"] = "Você entrou no JxJ de Alto Risco",
        ["Fel Commutation"] = "Comutação Vil",
        ["Fel Commuted"] = "Protegido por Comutação Vil",
        ["War Mode"] = "Modo de Guerra",
        ["Mercenary Mode"] = "Modo Mercenário",

        -- Encantamentos Místicos
        ["Bind Mystic Enchant Preset"] = "Vincular Predefinição de Encantamentos Místicos",
        ["Click to link a Mystic Enchant Preset"] = "Clique para vincular uma Predefinição de Encantamentos Místicos",
        ["Click to view more info about the Mystic Enchanting Interface"] = "Clique para ver mais informações sobre a interface de Encantamentos Místicos",
        ["Choose Mystic Enchants to add to your build"] = "Escolha Encantamentos Místicos para adicionar à sua composição",
        ["Empty Mystic Enchant Slot"] = "Espaço vazio para Encantamento Místico",
        ["Epic Mystic Enchant"] = "Encantamento Místico Épico",
        ["Legendary Mystic Enchant"] = "Encantamento Místico Lendário",
        ["Rare Mystic Enchant"] = "Encantamento Místico Raro",
        ["Uncommon Mystic Enchant"] = "Encantamento Místico Incomum",
        ["Worldforged Mystic Enchant"] = "Encantamento Místico Forjado pelo Mundo",
        ["Worldforged Mystic Enchants"] = "Encantamentos Místicos Forjados pelo Mundo",
        ["Show Not Worldforged Mystic Enchants"] = "Mostrar Encantamentos Místicos que não são Forjados pelo Mundo",
        ["Show Worldforged Mystic Enchants"] = "Mostrar Encantamentos Místicos Forjados pelo Mundo",
        ["Mystic Enchanting Level"] = "Nível de Encantamentos Místicos",
        ["Mystic Altar"] = "Altar Místico",
        ["Active Enchants"] = "Encantamentos Ativos",
        ["Enchant Collection"] = "Coleção de Encantamentos",
        ["Enchant Scrolls"] = "Pergaminhos de Encantamento",
        ["Save to Collection"] = "Salvar na Coleção",
        ["Extract"] = "Extrair",
        ["Extract Enchant"] = "Extrair Encantamento",
        ["Untarnished Mystic Scroll"] = "Pergaminho Místico Imaculado",
        ["Reforge or Extract Mystic Enchants for the current item here"] = "Reforje ou extraia os Encantamentos Místicos do item atual aqui",
        ["Requires Mystic Enchanting Altar"] = "Requer um Altar de Encantamento Místico",
        ["Right Click to Remove Mystic Enchant"] = "Clique com o botão direito para remover o Encantamento Místico",
        ["Right Click to |cffFFFFFFRemove|r Mystic Enchant"] = "Clique com o botão direito para |cffFFFFFFremover|r o Encantamento Místico",
        ["Switch between the various categories of Mystic Enchants here"] = "Alterne aqui entre as categorias de Encantamentos Místicos",
        ["The current Mystic Enchant category is visible here"] = "A categoria atual de Encantamentos Místicos aparece aqui",
        ["View your currently active Mystic Enchants."] = "Veja seus Encantamentos Místicos ativos.",
        ["View your currently equipped items and their Mystic Enchants here"] = "Veja aqui seus itens equipados e os Encantamentos Místicos deles",
        ["Please choose a Mystic Enchant from your Collection to apply it to"] = "Escolha um Encantamento Místico da sua Coleção para aplicá-lo",
        ["You can not apply this Mystic Enchant to that slot"] = "Você não pode aplicar este Encantamento Místico nesse espaço",
        ["This Mystic Enchant cannot be applied to your class"] = "Este Encantamento Místico não pode ser usado pela sua classe",
        ["Mystic Enchant has an invalid note."] = "O Encantamento Místico possui uma nota inválida.",
        ["Mystic Enchant notes cannot contain profanity."] = "As notas dos Encantamentos Místicos não podem conter linguagem imprópria.",
        ["Mystic Orb"] = "Orbe Místico",
        ["Mystic Orbs"] = "Orbes Místicos",
        ["Mystic Rune"] = "Runa Mística",
        ["Mystic Runes"] = "Runas Místicas",

        -- Arena / Glória
        ["1v1 Arena Battles"] = "Batalhas de Arena 1x1",
        ["1v1 Arena Team"] = "Equipe de Arena 1x1",
        ["2v2 Arena Battles"] = "Batalhas de Arena 2x2",
        ["3v3 Arena Battles"] = "Batalhas de Arena 3x3",
        ["Arena (Group Queue)"] = "Arena (Fila em Grupo)",
        ["Arena (Solo Queue)"] = "Arena (Fila solo)",
        ["Arena Completed!"] = "Arena Concluída!",
        ["Arena Frenzy"] = "Frenesi de Arena",
        ["Arena Rating"] = "Índice de Arena",
        ["Arena Season"] = "Temporada de Arena",
        ["Arena Skirmish"] = "Escaramuça de Arena",
        ["Arena Solo Queue"] = "Fila solo de Arena",
        ["Honor & Arena Quartermaster"] = "Intendente de Honra e Arena",
        ["Talk to an Arena Vendor"] = "Fale com um Comerciante de Arena",
        ["Glory Rewards"] = "Recompensas de Glória",
        ["Glory Progress"] = "Progresso de Glória",
        ["Next Glory Rank"] = "Próximo Grau de Glória",
        ["Honor Points"] = "Pontos de Honra",
        ["Arena Points"] = "Pontos de Arena",
        ["Battleground Objectives"] = "Objetivos de Campo de Batalha",
        ["PvP Progression Vendor"] = "Comerciante de Progressão JxJ",
        ["PvP Rewards"] = "Recompensas JxJ",
        ["PvP Quartermaster"] = "Intendente JxJ",
        ["PvP Power"] = "Poder JxJ",
        ["PvE Power"] = "Poder JxA",
        ["Max Level PvP"] = "JxJ de Nível Máximo",
        ["End-Game PvP"] = "JxJ de Nível Máximo",
        ["Instanced PvP"] = "JxJ Instanciado",
        ["Outdoor PvP Zones"] = "Zonas de JxJ em Mundo Aberto",
        ["Featured PvP"] = "JxJ em Destaque",
        ["No-Risk PvP Mode"] = "Modo JxJ sem risco",
        ["PvP Challenge"] = "Desafio JxJ",
        ["PvE and PvP Challenge"] = "Desafio JxA e JxJ",
        ["Honor Gear Vendor"] = "Comerciante de Equipamentos de Honra",
        ["Mystic Enchant Scrolls"] = "Pergaminhos de Encantamento Místico",
        ["Mystic Enchanting Scrolls"] = "Pergaminhos de Encantamento Místico",
    }
    for en, pt in pairs(wikiExact) do E[en] = pt end

    local dungeonParts = {
        ["Library"] = "Biblioteca",
        ["Cathedral"] = "Catedral",
        ["Armory"] = "Arsenal",
        ["Graveyard"] = "Cemitério",
        ["Main Gate"] = "Portão Principal",
        ["Service Entrance"] = "Entrada de Serviço",
        ["Upper City"] = "Cidade Superior",
        ["East"] = "Leste",
        ["West"] = "Oeste",
        ["North"] = "Norte",
        ["South"] = "Sul",
    }

    local rarity = {
        Common = { m = "Comum", f = "Comum" },
        Uncommon = { m = "Incomum", f = "Incomum" },
        Rare = { m = "Raro", f = "Rara" },
        Epic = { m = "Épico", f = "Épica" },
        Legendary = { m = "Lendário", f = "Lendária" },
        Artifact = { m = "Artefato", f = "Artefato" },
    }
    local cacheTypes = {
        Armor = { name = "Armadura", gender = "f" },
        Weapon = { name = "Arma", gender = "f" },
        Ability = { name = "Habilidade", gender = "f" },
        Module = { name = "Módulo", gender = "m" },
        Item = { name = "Item", gender = "m" },
    }

    -- Frases que algumas UIs montam em um unico FontString. A troca por trecho
    -- cobre variacoes de quebra de linha sem depender de uma chave 100% identica.
    local phraseFixes = {
        { "Using the Dungeon Finder to do a Random Dungeon will earn you extra rewards.", "Usar o Localizador de Masmorras para fazer uma Masmorra Aleatória rende recompensas extras." },
        { "Using the Dungeon Finder to do a Random Dungeon will earn you extra rewards", "Usar o Localizador de Masmorras para fazer uma Masmorra Aleatória rende recompensas extras" },
        { "Random Dungeons which you complete will earn you:", "Ao concluir masmorras aleatórias, você recebe:" },
        { "Random dungeons which you complete will earn you:", "Ao concluir masmorras aleatórias, você recebe:" },
        { "Random Dungeons you complete will earn you:", "Ao concluir masmorras aleatórias, você recebe:" },
        { "Random dungeons you complete will earn you:", "Ao concluir masmorras aleatórias, você recebe:" },
        { "Potential Rewards", "Recompensas Possíveis" },
        { "Active Manastorm Spells", "Feitiços Ativos da Tormenta de Mana" },
        { "Earned Currencies", "Moedas Obtidas" },
        { "Mythic+ Dungeons", "Masmorras Mítico+" },
        { "Mythic Dungeons", "Masmorras Míticas" },
        { "Dungeon Finder", "Localizador de Masmorras" },
        { "Raid Trials", "Provas de Raide" },
        { "Raid Trial", "Prova de Raide" },
        { "High-Risk PvP", "JxJ de Alto Risco" },
        { "High Risk PvP", "JxJ de Alto Risco" },
        { "Mystic Enchanting", "Encantamento Místico" },
        { "Mystic Enchants", "Encantamentos Místicos" },
        { "Mystic Enchant", "Encantamento Místico" },
        { "World Bosses", "Chefes Mundiais" },
        { "World Boss", "Chefe Mundial" },
        { "Call Boards", "Quadros de Chamados" },
        { "Call Board", "Quadro de Chamados" },
        { "Callboard", "Quadro de Chamados" },
        { "Runes of Ascension", "Runas de Ascensão" },
        { "Rune of Ascension", "Runa de Ascensão" },
        { "REWARDS", "RECOMPENSAS" },
    }

    local function static(text)
        if type(text) ~= "string" or text == "" then return nil end
        if E[text] then return E[text] end
        if A.TranslateStaticText then
            local ok, value = pcall(A.TranslateStaticText, text)
            if ok and type(value) == "string" and value ~= "" and value ~= text then return value end
        end
        return (A.AreaNames and A.AreaNames[text])
            or (A.CustomUI and A.CustomUI[text])
            or (A.ServerUI and A.ServerUI[text])
    end

    function A.TranslateEndgameText(text)
        if type(text) ~= "string" or text == "" then return nil end

        local pt = E[text]
        if pt then return pt end

        -- Mantem cor quando o FontString inteiro vem embrulhado em uma unica cor.
        local color, inner, reset = text:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
        if inner and inner ~= "" and not inner:find("|c", 1, true) then
            local translated = A.TranslateEndgameText(inner)
            if translated and translated ~= inner then return color .. translated .. reset end
        end

        local level = text:match("^Unlocks at [Ll]evel (%d+)$")
        if level then return "Desbloqueia no nível " .. level end

        level = text:match("^Unlocked at [Ll]evel (%d+)$")
        if level then return "Desbloqueado no nível " .. level end

        level = text:match("^Requires [Ll]evel (%d+)$")
        if level then return "Requer nível " .. level end

        level = text:match("^Level (%d+)$")
        if level then return "Nível " .. level end

        local mythic = text:match("^Mythic (%d+%+?)$")
        if mythic then return "Mítico " .. mythic end

        -- Títulos/eventos que o servidor monta em runtime.
        local mythicTier = text:match("^Mythic%+ Dungeons%s+(%d+)$")
        if mythicTier then return "Masmorras Mítico+ " .. mythicTier end

        local pvpTier = text:match("^PvP Progression%s+(%d+)$")
        if pvpTier then return "Progressão JxJ " .. pvpTier end

        local trialLevel = text:match("^Raid Trial%s+(%d+)$")
        if trialLevel then return "Prova de Raide " .. trialLevel end
        trialLevel = text:match("^Trial Level%s+(%d+)$")
        if trialLevel then return "Nível da Prova " .. trialLevel end

        local floor = text:match("^Floor%s+(%d+)$")
        if floor then return "Andar " .. floor end
        local checkpoint = text:match("^Checkpoint%s+(%d+)$")
        if checkpoint then return "Ponto de Controle " .. checkpoint end


        local manastormLevel = text:match("^Manastorm Level%s+(%d+)!?$")
        if manastormLevel then return "Nível " .. manastormLevel .. " da Tormenta de Mana!" end

        local highRiskTier = text:match("^High%-Risk Tier%s+(%d+)$")
        if highRiskTier then return "Alto Risco — Nível " .. highRiskTier end

        local enteredRiskTier = text:match("^You've Entered High%-Risk:%s*Tier%s+(%d+)$")
        if enteredRiskTier then return "Você entrou em Alto Risco: Nível " .. enteredRiskTier end

        local keyLevel = text:match("^Keystone Level%s+(%d+)$")
        if keyLevel then return "Nível " .. keyLevel .. " da Pedra-chave" end

        local mythicSpoils = text:match("^Mythic%s+(%d+)%s+Spoils%s+Cache$")
        if mythicSpoils then return "Baú de Espólios Míticos " .. mythicSpoils end

        local gloryRank = text:match("^Glory Rank%s+(%d+)$")
        if gloryRank then return "Grau de Glória " .. gloryRank end

        local gloryPoints = text:match("^Glory Points:%s*(%d+)$")
        if gloryPoints then return "Pontos de Glória: " .. gloryPoints end

        local worldBoss, worldDiff = text:match("^World Boss:%s*(.-)%s*%((.-)%)$")
        if worldBoss and worldDiff then
            local bossPT = static(worldBoss) or worldBoss
            local diffPT = E[worldDiff] or static(worldDiff) or worldDiff
            return "Chefe Mundial: " .. bossPT .. " (" .. diffPT .. ")"
        end

        worldBoss = text:match("^World Boss:%s*(.+)$")
        if worldBoss then return "Chefe Mundial: " .. (static(worldBoss) or worldBoss) end

        worldBoss = text:match("^Heroic World Boss:%s*(.+)$")
        if worldBoss then return "Chefe Mundial Heroico: " .. (static(worldBoss) or worldBoss) end

        worldBoss = text:match("^Mythic World Boss:%s*(.+)$")
        if worldBoss then return "Chefe Mundial Mítico: " .. (static(worldBoss) or worldBoss) end

        local newBoss = text:match("^New World Boss:%s*(.-)!?$")
        if newBoss and newBoss ~= "" then return "Novo Chefe Mundial: " .. (static(newBoss) or newBoss) .. "!" end

        local bossTitle = text:match("^(.-)%s+%-%s+New World Boss!$")
        if bossTitle and bossTitle ~= "" then
            local first, subtitle = bossTitle:match("^(.-)%s+%-%s+(.+)$")
            if first and subtitle then
                return (static(first) or first) .. " — " .. (E[subtitle] or static(subtitle) or subtitle) .. " — Novo Chefe Mundial!"
            end
            return (static(bossTitle) or bossTitle) .. " — Novo Chefe Mundial!"
        end

        -- Ex.: Pack Tactics (Mythic 7+) / Resistant (Creature Affix)
        local name, tag = text:match("^(.-)%s*%((.-)%)$")
        if name and tag then
            local namePT = static(name) or name
            local tagPT = E[tag]
            if not tagPT then
                local n = tag:match("^Mythic (%d+%+?)$")
                if n then tagPT = "Mítico " .. n end
            end
            if not tagPT then tagPT = static(tag) end
            if (namePT and namePT ~= name) or (tagPT and tagPT ~= tag) then
                return (namePT or name) .. " (" .. (tagPT or tag) .. ")"
            end
        end

        -- Ex.: Scarlet Monastery - Library
        local dungeon, wing = text:match("^(.-)%s+%-%s+(.+)$")
        if dungeon and wing then
            local dungeonPT = static(dungeon) or dungeon
            local wingPT = dungeonParts[wing] or static(wing) or wing
            if dungeonPT ~= dungeon or wingPT ~= wing then
                return dungeonPT .. ": " .. wingPT
            end
        end

        -- Caches de progressao montados pelo servidor.
        local quality, kind = text:match("^(%a+) ([%a]+) Cache$")
        local q = quality and rarity[quality]
        local k = kind and cacheTypes[kind]
        if q and k then
            return "Baú de " .. k.name .. " " .. (q[k.gender] or q.m)
        end

        -- Algumas janelas concatenam titulo, descricao e recompensa no mesmo texto.
        local replaced = text
        for i = 1, #phraseFixes do
            local pair = phraseFixes[i]
            replaced = replaced:gsub(pair[1]:gsub("([%%%-%^%$%(%)%.%[%]%*%+%?])", "%%%1"), pair[2])
        end
        if replaced ~= text then return replaced end

        -- Deixa a base geral resolver nomes de masmorra, afixo, item e outros textos conhecidos.
        pt = static(text)
        if pt and pt ~= text then return pt end
    end
end

-- Padronização do conteúdo endgame vindo do banco grande de ServerUI.
-- Em vez de duplicar centenas de chaves, corrige apenas entradas cujo texto-fonte
-- pertence aos sistemas de nível máximo. Isso também pega tutoriais e tooltips longos.
do
    local U = A.ServerUI
    local E = A.EndgameUIExact
    if U and E then
        -- Quando existe rótulo curto no mapa endgame, ele vira a referência final.
        for en, pt in pairs(E) do
            if U[en] ~= nil then U[en] = pt end
        end

        local sourceMarkers = {
            "Manastorm", "manastorm", "Prestige", "prestige", "Mythic", "mythic", "Keystone", "keystone", "Callboard", "Call Board",
            "World Boss", "Bloodforged", "High-Risk", "High Risk", "Raid Trial",
            "Raider's Commendation", "Raiders Commendation", "Mark of Triumph",
            "Mystic Enchant", "mystic enchant", "Bedlam Bullion", "Bedlam bullion", "bedlam bullion", "Bonzo Bolt", "Bonzo bolt", "bonzo bolt", "Ascended Raid",
            "Dungeon Finder", "World Event", "Glory", "Arena", "Battleground",
            "Fel Commutation", "Worldforged", "Mystic Extract", "Mystic Altar",
            "Mythic Champion", "Blood Bowl", "Boss Shrine", "Crow's Cache", "PvP Progression",
        }

        local function IsEndgameSource(en)
            if type(en) ~= "string" then return false end
            for i = 1, #sourceMarkers do
                if en:find(sourceMarkers[i], 1, true) then return true end
            end
            return false
        end

        local function NormalizePT(pt)
            if type(pt) ~= "string" or pt == "" then return pt end

            -- Nomes próprios primeiro. Millhouse Manastorm é NPC e não deve ser traduzido.
            pt = pt:gsub("Milhouse Manavento", "Millhouse Manastorm")
            pt = pt:gsub("Milhouse Manastorm", "Millhouse Manastorm")

            -- Sistema Manastorm: usa a mesma nomenclatura já adotada nos Globals ptBR.
            pt = pt:gsub("Torbelhino Mágico", "Tormenta de Mana")
            pt = pt:gsub("Torvelinho Mágico", "Tormenta de Mana")
            pt = pt:gsub("dos Manastorms", "das Tormentas de Mana")
            pt = pt:gsub("nos Manastorms", "nas Tormentas de Mana")
            pt = pt:gsub("Manastorms", "Tormentas de Mana")
            pt = pt:gsub("do Manastorm", "da Tormenta de Mana")
            pt = pt:gsub("no Manastorm", "na Tormenta de Mana")
            pt = pt:gsub("ao Manastorm", "à Tormenta de Mana")
            pt = pt:gsub("o Manastorm", "a Tormenta de Mana")
            pt = pt:gsub("O Manastorm", "A Tormenta de Mana")
            pt = pt:gsub("um Manastorm", "uma Tormenta de Mana")
            pt = pt:gsub("Um Manastorm", "Uma Tormenta de Mana")
            pt = pt:gsub("Manastorm", "Tormenta de Mana")
            pt = pt:gsub("Millhouse Tormenta de Mana", "Millhouse Manastorm")

            -- Ajusta gênero/preposições quando o nome vem dentro de hyperlinks da UI.
            pt = pt:gsub("O |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r", "A |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r")
            pt = pt:gsub("o |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r", "a |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r")
            pt = pt:gsub("do |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r", "da |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r")
            pt = pt:gsub("no |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r", "na |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r")
            pt = pt:gsub("O |Hkeyword:150|hTormenta de Mana|h", "A |Hkeyword:150|hTormenta de Mana|h")
            pt = pt:gsub("o |Hkeyword:150|hTormenta de Mana|h", "a |Hkeyword:150|hTormenta de Mana|h")
            pt = pt:gsub("do |Hkeyword:150|hTormenta de Mana|h", "da |Hkeyword:150|hTormenta de Mana|h")
            pt = pt:gsub("no |Hkeyword:150|hTormenta de Mana|h", "na |Hkeyword:150|hTormenta de Mana|h")
            pt = pt:gsub("um |cFF00CCFF|Hkeyword:88|hMasmorra|h|r", "uma |cFF00CCFF|Hkeyword:88|hMasmorra|h|r")
            pt = pt:gsub("um |Hkeyword:88|hMasmorra|h", "uma |Hkeyword:88|hMasmorra|h")
            pt = pt:gsub("Insira o |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r", "Entre na |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r")
            pt = pt:gsub("Insira o |Hkeyword:150|hTormenta de Mana|h", "Entre na |Hkeyword:150|hTormenta de Mana|h")
            pt = pt:gsub("ponto de verificação", "ponto de controle")
            pt = pt:gsub("pontos de verificação", "pontos de controle")
            pt = pt:gsub("Ponto de Verificação", "Ponto de Controle")

            -- Moedas e recompensas próprias da Tormenta de Mana.
            pt = pt:gsub("Bullions de confusão", "Lingotes de Bedlam")
            pt = pt:gsub("Bullions de Confusão", "Lingotes de Bedlam")
            pt = pt:gsub("Barras do Bedlam", "Lingotes de Bedlam")
            pt = pt:gsub("Barras de Bedlam", "Lingotes de Bedlam")
            pt = pt:gsub("Bedlam Bullions", "Lingotes de Bedlam")
            pt = pt:gsub("Bedlam Bullion", "Lingote de Bedlam")
            pt = pt:gsub("Bonzo Bolts", "Parafusos Bonzo")
            pt = pt:gsub("Bonzo Bolt", "Parafuso Bonzo")
            pt = pt:gsub("Bullions Bedlam", "Lingotes de Bedlam")
            pt = pt:gsub("barras de ouro", "Lingotes de Bedlam")
            pt = pt:gsub("metais preciosos", "lingotes")
            pt = pt:gsub("Recompensar níveis concluídos anteriormente", "Repetir níveis já concluídos")
            pt = pt:gsub("parafusos bonzo", "Parafusos Bonzo")
            pt = pt:gsub("Feitiços de Tormenta de Mana", "Feitiços da Tormenta de Mana")
            pt = pt:gsub("Tormenta de Mana Caches", "Baús da Tormenta de Mana")
            pt = pt:gsub("Manastorm Caches", "Baús da Tormenta de Mana")
            pt = pt:gsub("Caches", "Baús")
            pt = pt:gsub("Cache", "Baú")
            pt = pt:gsub("caches", "baús")
            pt = pt:gsub("cache", "baú")
            pt = pt:gsub("Mejoras", "Aprimoramentos")
            pt = pt:gsub("Seroe de sprint", "Soro de Corrida")
            pt = pt:gsub("Hearty Heal", "Cura Revigorante")
            pt = pt:gsub("Hearty Hearts", "Corações Revigorantes")
            pt = pt:gsub("em troca para", "em troca de")
            pt = pt:gsub("que é um |cFF00CCFF|Hkeyword:82|hMoeda|h|r", "que é uma |cFF00CCFF|Hkeyword:82|hmoeda|h|r")
            pt = pt:gsub("que é um |Hkeyword:82|hMoeda|h", "que é uma |Hkeyword:82|hmoeda|h")

            -- Prestígio / Quadro de Chamados.
            pt = pt:gsub("Tokens of Prestige", "Fichas de Prestígio")
            pt = pt:gsub("Token of Prestige", "Ficha de Prestígio")
            pt = pt:gsub("Tokens de Prestígio", "Fichas de Prestígio")
            pt = pt:gsub("Token de Prestígio", "Ficha de Prestígio")
            pt = pt:gsub("Modo Prestige", "Modo Prestígio")
            pt = pt:gsub("modo Prestige", "modo Prestígio")
            pt = pt:gsub("Prestiging", "usar Prestígio")
            pt = pt:gsub("Prestige", "Prestígio")
            pt = pt:gsub("Quadro de Chamadas", "Quadro de Chamados")
            pt = pt:gsub("Quadro de Chamada", "Quadro de Chamados")
            pt = pt:gsub("Callboard", "Quadro de Chamados")
            pt = pt:gsub("Call Board", "Quadro de Chamados")

            -- Mítico+ / pedras-chave.
            pt = pt:gsub("Pedra Angular Mítica", "Pedra-chave Mítica")
            pt = pt:gsub("Pedras Angulares Míticas", "Pedras-chave Míticas")
            pt = pt:gsub("Keystones", "Pedras-chave")
            pt = pt:gsub("Keystone", "Pedra-chave")
            pt = pt:gsub("keystones", "pedras-chave")
            pt = pt:gsub("keystone", "pedra-chave")

            -- Alto Risco / Bloodforged.
            pt = pt:gsub("Bloodforged Gear", "Equipamento Forjado em Sangue")
            pt = pt:gsub("equipamentos Bloodforged", "equipamentos Forjados em Sangue")
            pt = pt:gsub("Equipamentos Bloodforged", "Equipamentos Forjados em Sangue")
            pt = pt:gsub("equipamento Bloodforged", "equipamento Forjado em Sangue")
            pt = pt:gsub("Equipamento Bloodforged", "Equipamento Forjado em Sangue")
            pt = pt:gsub("itens Bloodforged", "itens Forjados em Sangue")
            pt = pt:gsub("Itens Bloodforged", "Itens Forjados em Sangue")
            pt = pt:gsub("Bloodforged", "Forjado em Sangue")
            pt = pt:gsub("High%-Risk", "Alto Risco")
            pt = pt:gsub("High Risk", "Alto Risco")

            -- Localizador / eventos / progressão JxJ.
            pt = pt:gsub("Mítico Plus", "Mítico+")
            pt = pt:gsub("mítico Plus", "Mítico+")
            pt = pt:gsub("Arena Frenesi", "Frenesi de Arena")
            pt = pt:gsub("Fel Magic", "Magia Vil")
            pt = pt:gsub("FFA%-PvP", "JxJ Livre")
            pt = pt:gsub("FFA PvP", "JxJ Livre")
            pt = pt:gsub("PvP", "JxJ")
            pt = pt:gsub("LFG", "Localizador de Grupos")
            pt = pt:gsub(" RH ", " Alto Risco ")
            pt = pt:gsub("masmorra Finder", "Localizador de Masmorras")
            pt = pt:gsub("Masmorra Finder", "Localizador de Masmorras")
            pt = pt:gsub("Dungeon Finder", "Localizador de Masmorras")
            pt = pt:gsub("World Events", "Eventos Mundiais")
            pt = pt:gsub("World Event", "Evento Mundial")
            pt = pt:gsub("Glory Points", "Pontos de Glória")
            pt = pt:gsub("Glory Rank", "Grau de Glória")
            pt = pt:gsub("Glory", "Glória")

            -- Chefes mundiais e encantamento místico.
            pt = pt:gsub("World Bosses", "Chefes Mundiais")
            pt = pt:gsub("World Boss", "Chefe Mundial")
            pt = pt:gsub("World Chat", "bate-papo mundial")
            pt = pt:gsub("Ascension Chat", "bate-papo do Ascension")
            pt = pt:gsub("Mystic Enchanting Scrolls", "Pergaminhos de Encantamento Místico")
            pt = pt:gsub("Mystic Enchant Scrolls", "Pergaminhos de Encantamento Místico")
            pt = pt:gsub("Encantamento Místico Scrolls", "Pergaminhos de Encantamento Místico")
            pt = pt:gsub("Mystic Enchanting", "Encantamento Místico")
            pt = pt:gsub("Mystic Enchants", "Encantamentos Místicos")
            pt = pt:gsub("Mystic Enchant", "Encantamento Místico")
            pt = pt:gsub("loadouts", "conjuntos")

            -- Comendas / moedas de raide.
            pt = pt:gsub("Raiders Commendations", "Comendas do Raideiro")
            pt = pt:gsub("Raider's Commendations", "Comendas do Raideiro")
            pt = pt:gsub("Raider's Commendation", "Comenda do Raideiro")
            pt = pt:gsub("Marks of Triumph", "Marcas do Triunfo")
            pt = pt:gsub("Mark of Triumph", "Marca do Triunfo")
            pt = pt:gsub("Marcas de Triunfo", "Marcas do Triunfo")
            pt = pt:gsub("Marca de Triunfo", "Marca do Triunfo")

            -- Lixo comum que apareceu nas traduções antigas de endgame.
            pt = pt:gsub("conteúdo do conteúdo de nível máximo", "conteúdo de nível máximo")
            pt = pt:gsub("conteúdo de conteúdo de nível máximo", "conteúdo de nível máximo")
            pt = pt:gsub("Removedor", "Remover")
            pt = pt:gsub("Poçãa", "Poção")
            pt = pt:gsub("Feitiça", "Feitiço")
            pt = pt:gsub("feitiça", "feitiço")
            pt = pt:gsub("Ascensãa", "Ascensão")
            pt = pt:gsub("compilação", "composição")
            pt = pt:gsub("Compilação", "Composição")
            pt = pt:gsub("especificações", "especializações")
            pt = pt:gsub("Especificações", "Especializações")
            pt = pt:gsub("especificação", "especialização")
            pt = pt:gsub("Especificação", "Especialização")
            pt = pt:gsub("carregamento", "conjunto")
            pt = pt:gsub("Carregamento", "Conjunto")
            pt = pt:gsub("Role novamente", "Refaça")
            pt = pt:gsub("role novamente", "refaça")
            pt = pt:gsub("re%-role", "refaça")
            pt = pt:gsub("relançar toda a sua composição", "refazer toda a sua composição")
            pt = pt:gsub("re%-nivele", "suba de nível novamente")
            pt = pt:gsub("re%-nivelar", "subir de nível novamente")
            pt = pt:gsub("Pergaminhos da Fortuna bônus", "Pergaminhos da Fortuna extras")
            pt = pt:gsub("Casos de Fortuna", "Caixas de Fortuna")
            pt = pt:gsub("casos de fortuna", "Caixas de Fortuna")
            pt = pt:gsub("Mão do Destino não gasta", "Mãos do Destino não gastas")
            pt = pt:gsub("a Mãos do Destino", "as Mãos do Destino")
            pt = pt:gsub("as Mãos do Destino não gastas e o Pergaminho da Fortuna da especialização prestigiada não são mantidos", "Mãos do Destino não gastas e Pergaminhos da Fortuna da especialização usada no Prestígio não são mantidos")
            pt = pt:gsub("Cada vez que você (.-Prestígio.-) você ganhará", "Cada vez que você usa %1, você ganha")
            pt = pt:gsub("tempo gasto cultivando Caixas de Fortuna", "tempo gasto obtendo Caixas de Fortuna")
            pt = pt:gsub("Isso permite que você experimente um conjunto de Cartas de Habilidade totalmente novo e experimente novas Cartas de Habilidade encontradas", "Isso permite montar um conjunto de Cartas de Habilidade totalmente novo e testar as novas cartas que você encontrar")
            pt = pt:gsub("Refaça apenas suas especializações atuais!", "Refaça apenas sua especialização atual!")
            pt = pt:gsub("Você pode (.-Prestígio.-) no Chromie", "Você pode usar %1 com Chromie")
            pt = pt:gsub("para atualizações de equipamentos", "para melhorar seu equipamento")
            pt = pt:gsub("permitindo que você se atualize rapidamente", "ajudando você a se equipar rapidamente")
            pt = pt:gsub("ajudando você a se equipar rapidamente e pule direto", "ajudando você a se equipar rapidamente e entrar direto")
            pt = pt:gsub("Certifique%-se de pedir para entrar em um grupo com outros jogadores ou convidá%-los para uma (.-Grupo.-) que você formar!", "Entre em um grupo com outros jogadores ou convide-os para o seu %1!")
            pt = pt:gsub("JxJ Potência", "Poder JxJ")
            pt = pt:gsub("PvP Potência", "Poder JxJ")
            -- Mantém "Comerciante", nomenclatura usada no cliente PT-BR.
            pt = pt:gsub("Concluído |cFF00CCFF|Hkeyword:63|hQuadro de Chamados|h|r Missões diárias", "Conclua Missões Diárias do |cFF00CCFF|Hkeyword:63|hQuadro de Chamados|h|r")
            pt = pt:gsub("Concluído |Hkeyword:63|hQuadro de Chamados|h Missões diárias", "Conclua Missões Diárias do |Hkeyword:63|hQuadro de Chamados|h")
            pt = pt:gsub("Concluir |cFF00CCFF|Hkeyword:63|hQuadro de Chamados|h|r Missões", "Concluir missões do |cFF00CCFF|Hkeyword:63|hQuadro de Chamados|h|r")
            pt = pt:gsub("Concluir |Hkeyword:63|hQuadro de Chamados|h Missões", "Concluir missões do |Hkeyword:63|hQuadro de Chamados|h")
            pt = pt:gsub("Aceite todas as disponíveis |cFF00CCFF|Hkeyword:63|hQuadro de Chamados|h|r Missões Diárias! Eles devem ser concluídos juntos%.", "Aceite todas as Missões Diárias disponíveis no |cFF00CCFF|Hkeyword:63|hQuadro de Chamados|h|r! Elas foram feitas para serem concluídas juntas.")
            pt = pt:gsub("Aceite todas as disponíveis |Hkeyword:63|hQuadro de Chamados|h Missões Diárias! Eles devem ser concluídos juntos%.", "Aceite todas as Missões Diárias disponíveis no |Hkeyword:63|hQuadro de Chamados|h! Elas foram feitas para serem concluídas juntas.")
            pt = pt:gsub("Quadro de chamada Baú", "Baú do Quadro de Chamados")
            pt = pt:gsub("Quadro de Chamadas", "Quadro de Chamados")
            pt = pt:gsub("Raids", "Raides")
            pt = pt:gsub("Worldforged", "Forjado pelo Mundo")
            pt = pt:gsub("PvE", "JxA")
            pt = pt:gsub("Honor", "Honra")
            pt = pt:gsub("Bloodforging", "Forjar em Sangue")
            pt = pt:gsub("Bloodforge", "Forjar em Sangue")
            pt = pt:gsub("Sangrento Jar", "Jarro Sangrento")
            pt = pt:gsub("negociar ou venda", "negociar ou vender")
            pt = pt:gsub("um desafio |cFF00CCFF|Hkeyword:88|hMasmorra|h|r", "um desafio de |cFF00CCFF|Hkeyword:88|hMasmorra|h|r")
            pt = pt:gsub("um desafio |Hkeyword:88|hMasmorra|h", "um desafio de |Hkeyword:88|hMasmorra|h")
            pt = pt:gsub("um grupo de |cFF00CCFF|Hkeyword:200|hRaide|h|r de até", "um grupo de |cFF00CCFF|Hkeyword:200|hRaide|h|r com até")
            pt = pt:gsub("um grupo |Hkeyword:200|hRaide|h de até", "um grupo de |Hkeyword:200|hRaide|h com até")
            pt = pt:gsub("conhecidos como 'Feitiço (.-) Ativos'", "conhecidos como 'Feitiços Ativos da %1'")
            pt = pt:gsub("todos os seus feitiços (.-) adquiridos", "todos os feitiços adquiridos da %1")
            pt = pt:gsub("em seu livro de feitiços, sob a Ascensão (.-) Aba Itens", "no Livro de Feitiços, na aba Itens da Ascension dedicada à %1")
            pt = pt:gsub("Cada feitiço pode atualizar até oito classificações diferentes%.", "Cada feitiço pode ser aprimorado em até oito graus.")
            pt = pt:gsub("Classificações mais altas", "Graus mais altos")
            pt = pt:gsub("Atualizar seus feitiços", "Aprimorar seus feitiços")
            pt = pt:gsub("ou atualizar os existentes de (.-Cogsworth.-)%.", "ou aprimorar os que já possui com %1.")
            pt = pt:gsub("variando de equipamento raro (.-Masmorra.-) até épico (.-Raide.-) itens de níveis anteriores", "variando de equipamentos raros de %1 até itens épicos de %2 de níveis anteriores")
            pt = pt:gsub("fluxo constante de atualizações úteis", "fluxo constante de melhorias úteis de equipamento")
            pt = pt:gsub("bônus |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r Baú", "Baú Bônus da |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r")
            pt = pt:gsub("bônus |Hkeyword:150|hTormenta de Mana|h Baú", "Baú Bônus da |Hkeyword:150|hTormenta de Mana|h")
            pt = pt:gsub("seus |cFF00CCFF|Hkeyword:82|hMoeda|h|r ganhos", "suas |cFF00CCFF|Hkeyword:82|hMoedas|h|r obtidas")
            pt = pt:gsub("seus |Hkeyword:82|hMoeda|h ganhos", "suas |Hkeyword:82|hMoedas|h obtidas")
            pt = pt:gsub("Haste de interrupção", "Bastão de Interrupção")
            pt = pt:gsub("Poção Tormenta de Mana sem fim", "Poção Infinita da Tormenta de Mana")
            pt = pt:gsub("Poção Endless Tormenta de Mana", "Poção Infinita da Tormenta de Mana")
            pt = pt:gsub("A fuga mágica de Milhouse", "Fuga Mágica de Millhouse")
            pt = pt:gsub("Fuga Mágica de Milhouse", "Fuga Mágica de Millhouse")
            pt = pt:gsub("Mistura de mobilidade Millhouse", "Mistura de Mobilidade de Millhouse")
            pt = pt:gsub("Sprint Serum", "Soro de Corrida")
            pt = pt:gsub("upgrade Cura Revigorante", "aprimoramento de Cura Revigorante")
            pt = pt:gsub("próxima corrida", "próxima tentativa")
            pt = pt:gsub("Poção (.-Tormenta de Mana.-) Infinita", "Poção Infinita da %1")
            pt = pt:gsub("Poção Infinita da Infinita da", "Poção Infinita da")
            pt = pt:gsub("layouts aleatórios", "cenários aleatórios")
            pt = pt:gsub("Slot 4 Ativo", "Equipe 4")
            pt = pt:gsub("Seu (.-Tormenta de Mana.-) Conjunto de feitiços ativos", "Seu conjunto de Feitiços Ativos da %1")
            pt = pt:gsub("Insira um feitiço (.-Tormenta de Mana.-) ativo", "Equipe um Feitiço Ativo da %1")
            pt = pt:gsub("Insira um Feitiço (.-Tormenta de Mana.-) ativo", "Equipe um Feitiço Ativo da %1")
            pt = pt:gsub("Progresso de rolagem permanente!", "Progresso permanente dos Pergaminhos!")
            pt = pt:gsub("Compre de volta rola depois de", "Recupere seus Pergaminhos depois de usar")
            pt = pt:gsub("Comprar rolos de volta após", "Recupere seus Pergaminhos após usar")
            pt = pt:gsub("Silas Scrolls redefinidos, eles não podem ser recomprados!", "Pergaminhos de Silas são reiniciados e não podem ser recomprados!")
            return pt
        end

        local function PlainReplace(text, from, to)
            local pattern = from:gsub("([%%%-%^%$%(%)%.%[%]%*%+%?])", "%%%1")
            return (text:gsub(pattern, to))
        end

        local function PolishLong(en, pt)
            if type(en) ~= "string" or type(pt) ~= "string" then return pt end

            -- Tutorial de Poder JxJ / Forja de Sangue. A traducao antiga era bem literal
            -- e algumas frases ficavam praticamente ilegíveis na HUD de endgame.
            if en:find("pvppower1", 1, true) then
                local fixes = {
                    {
                        "|cFF00CCFF|Hkeyword:33|hForjado em Sangue|h|r, Honra e |cFF00CCFF|Hkeyword:20|hArena|h|r Equipamento tem Poder JxJ.",
                        "Equipamentos |cFF00CCFF|Hkeyword:33|hForjados em Sangue|h|r, de Honra e de |cFF00CCFF|Hkeyword:20|hArena|h|r possuem Poder JxJ."
                    },
                    {
                        "Adquira um conjunto de equipamentos JxJ de Honra |cFF00CCFF|Hkeyword:250|hMercadores|h|r ou no |cFF00CCFF|Hkeyword:29|hCasa de Leilões|h|r",
                        "Adquira um conjunto de equipamentos JxJ com os |cFF00CCFF|Hkeyword:250|hMercadores|h|r de Honra ou na |cFF00CCFF|Hkeyword:29|hCasa de Leilões|h|r"
                    },
                    {
                        "Colocar |cFF00CCFF|Hkeyword:230|hVinculado|h|r equipamento JxA em JxJ colocará você",
                        "Usar equipamento JxA |cFF00CCFF|Hkeyword:230|hVinculado|h|r em JxJ colocará você"
                    },
                    {
                        "Forjar em Sangue |cFF00CCFF|Hkeyword:230|hVinculado|h|r Engrene o equipamento JxJ!",
                        "Forje em Sangue equipamento |cFF00CCFF|Hkeyword:230|hVinculado|h|r para transformá-lo em equipamento JxJ!"
                    },
                    {
                        "Você pode Forjar em Sangue |cFF00CCFF|Hkeyword:230|hVinculado|h|r equipamento comprando um equipamento |cffe6cc80|Hitem:777999|h[Jarro Sangrento]|h|r de Nozdormu.",
                        "Você pode Forjar em Sangue equipamentos |cFF00CCFF|Hkeyword:230|hVinculados|h|r usando um |cffe6cc80|Hitem:777999|h[Jarro Sangrento]|h|r comprado de Nozdormu."
                    },
                    {
                        "Forjar em Sangue |cFF00CCFF|Hkeyword:230|hVinculado|h|r Equipamentos de honra ou |cFF00CCFF|Hkeyword:20|hArena|h|r reduzirão suas estatísticas",
                        "Forjar em Sangue equipamentos |cFF00CCFF|Hkeyword:230|hVinculados|h|r de Honra ou de |cFF00CCFF|Hkeyword:20|hArena|h|r reduzirá as estatísticas deles"
                    },
                }
                for i = 1, #fixes do pt = PlainReplace(pt, fixes[i][1], fixes[i][2]) end
            end

            if en:find("Call_Board_Quests2", 1, true) then
                pt = PlainReplace(pt,
                    "ajudando você a se equipar rapidamente e pule direto para o conteúdo de nível máximo",
                    "ajudando você a se equipar rapidamente e entrar direto no conteúdo de nível máximo")
            end

            if en:find("Arena", 1, true) then
                pt = PlainReplace(pt,
                    "para subir no |cFF00CCFF|Hkeyword:16|hÍndice de Arena|h|r escada",
                    "para subir no ranking de |cFF00CCFF|Hkeyword:16|hÍndice de Arena|h|r")
                pt = PlainReplace(pt,
                    "para subir no |Hkeyword:16|hÍndice de Arena|h escada",
                    "para subir no ranking de |Hkeyword:16|hÍndice de Arena|h")
            end

            if en:find("219_1", 1, true) then
                pt = PlainReplace(pt,
                    "Insira a |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r da |cFF00CCFF|Hkeyword:86|hLocalizador de Masmorras|h|r!",
                    "Entre na |cFF00CCFF|Hkeyword:150|hTormenta de Mana|h|r pelo |cFF00CCFF|Hkeyword:86|hLocalizador de Masmorras|h|r!")
                pt = PlainReplace(pt,
                    "Insira a |Hkeyword:150|hTormenta de Mana|h da |Hkeyword:86|hLocalizador de Masmorras|h!",
                    "Entre na |Hkeyword:150|hTormenta de Mana|h pelo |Hkeyword:86|hLocalizador de Masmorras|h!")
            end

            if en:find("240_1", 1, true) then
                local fixes = {
                    {"outros métodos não-Silas", "outras fontes além de Silas"},
                    {"outros métodos que não sejam Silas", "outras fontes além de Silas"},
                    {"Pergaminhos usados e não utilizados, recomprados ou não recomprados, são pergaminhos elegíveis para recompra!", "Pergaminhos usados ou não, tenham sido recomprados ou não, continuam elegíveis para recompra!"},
                    {"Você nunca perde esse progresso ao Prestigiar.", "Você nunca perde esse progresso ao usar Prestígio."},
                    {"Isso ocorre porque eles já redefiniram cada", "Isso acontece porque eles são reiniciados a cada"},
                    {"contagens de Pergaminhos de Recompra", "total de Pergaminhos para Recompra"},
                }
                for i = 1, #fixes do pt = PlainReplace(pt, fixes[i][1], fixes[i][2]) end
            end

            return pt
        end

        for en, pt in pairs(U) do
            if IsEndgameSource(en) and type(pt) == "string" then
                U[en] = PolishLong(en, NormalizePT(pt))
            end
        end

        -- Casos curtos cuja tradução antiga estava semanticamente errada.
        if U["Link Best Keystones"] then U["Link Best Keystones"] = "Vincular Melhores Pedras-chave" end
        if U["Insert Mythic Keystone"] then U["Insert Mythic Keystone"] = "Inserir Pedra-chave Mítica" end
        if U["Start Keystone"] then U["Start Keystone"] = "Iniciar Pedra-chave" end
        if U["Couldn't find keystone to activate!"] then U["Couldn't find keystone to activate!"] = "Não foi possível encontrar uma pedra-chave para ativar!" end
        if U["Manastorm Cache"] then U["Manastorm Cache"] = "Baú da Tormenta de Mana" end
        if U["Manastorm Caches"] then U["Manastorm Caches"] = "Baús da Tormenta de Mana" end
        if U["Manastorm Spells"] then U["Manastorm Spells"] = "Feitiços da Tormenta de Mana" end
        if U["Active Manastorm Spells"] then U["Active Manastorm Spells"] = "Feitiços Ativos da Tormenta de Mana" end
        if U["Leave The Manastorm"] then U["Leave The Manastorm"] = "Sair da Tormenta de Mana" end
        if U["Enter the Manastorm"] then U["Enter the Manastorm"] = "Entrar na Tormenta de Mana" end
        if U["Enter The Manastorm"] then U["Enter The Manastorm"] = "Entrar na Tormenta de Mana" end
        if U["Heroes Callboard"] then U["Heroes Callboard"] = "Quadro de Chamado do Herói" end
        if U["Mystic Enchanting Altar"] then U["Mystic Enchanting Altar"] = "Altar de Encantamento Místico" end
    end
end

