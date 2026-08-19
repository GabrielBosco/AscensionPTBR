AscensionPTBR = AscensionPTBR or {}

-- Quadro de Chamados e missões de nível máximo.
-- Carrega depois das quests para usar o mesmo texto do log e do rastreador.
local A = AscensionPTBR
local Q = A.QuestData or {}
local T = A.QuestTitle or {}
local E = A.QuestTitleEN or {}

A.DailyQuestUIExact = A.DailyQuestUIExact or {}
A.QuestUIExact = A.QuestUIExact or {}
local UI = A.DailyQuestUIExact
local QUI = A.QuestUIExact

local labels = {
    ["Call Board"] = "Quadro de Chamados",
    ["Callboard"] = "Quadro de Chamados",
    ["Call Boards"] = "Quadros de Chamados",
    ["Callboards"] = "Quadros de Chamados",
    ["Call Board Quests"] = "Missões do Quadro de Chamados",
    ["Callboard Quests"] = "Missões do Quadro de Chamados",
    ["Heroes Callboard"] = "Quadro de Chamados dos Heróis",
    ["Hero's Callboard"] = "Quadro de Chamados dos Heróis",
    ["Daily Quest"] = "Missão Diária",
    ["Daily Quests"] = "Missões Diárias",
    ["Weekly Quest"] = "Missão Semanal",
    ["Weekly Quests"] = "Missões Semanais",
    ["Daily"] = "Diária",
    ["Weekly"] = "Semanal",
    ["Today"] = "Hoje",
    ["This Week"] = "Nesta semana",
    ["Available"] = "Disponível",
    ["Unavailable"] = "Indisponível",
    ["Available Quests"] = "Missões disponíveis",
    ["Completed"] = "Concluída",
    ["Completed Quests"] = "Missões concluídas",
    ["Not Completed"] = "Não concluída",
    ["In Progress"] = "Em andamento",
    ["Accepted"] = "Aceita",
    ["Requirements"] = "Requisitos",
    ["Requirements:"] = "Requisitos:",
    ["Rewards"] = "Recompensas",
    ["Rewards:"] = "Recompensas:",
    ["Reward"] = "Recompensa",
    ["Reward:"] = "Recompensa:",
    ["Objectives"] = "Objetivos",
    ["Objectives:"] = "Objetivos:",
    ["Objective"] = "Objetivo",
    ["Objective:"] = "Objetivo:",
    ["Progress"] = "Progresso",
    ["Progress:"] = "Progresso:",
    ["Description"] = "Descrição",
    ["Description:"] = "Descrição:",
    ["Accept"] = "Aceitar",
    ["Decline"] = "Recusar",
    ["Track"] = "Acompanhar",
    ["Track Quest"] = "Acompanhar missão",
    ["Untrack"] = "Parar de acompanhar",
    ["Untrack Quest"] = "Parar de acompanhar",
    ["Show on Map"] = "Mostrar no mapa",
    ["Show Map"] = "Mostrar no mapa",
    ["View"] = "Ver",
    ["Details"] = "Detalhes",
    ["Refresh"] = "Atualizar",
    ["Reroll"] = "Trocar missão",
    ["Claim"] = "Receber",
    ["Claim Reward"] = "Receber recompensa",
    ["Complete"] = "Concluir",
    ["Complete Quest"] = "Concluir missão",
    ["Reset"] = "Reiniciar",
    ["Daily Reset"] = "Reinício diário",
    ["Daily Quest Reset"] = "Reinício das Missões Diárias",
    ["Resets In"] = "Reinicia em",
    ["Resets in"] = "Reinicia em",
    ["Time Remaining"] = "Tempo restante",
    ["PvE"] = "JxA",
    ["PvP"] = "JxJ",
    ["Dungeons"] = "Masmorras",
    ["Dungeon"] = "Masmorra",
    ["Raids"] = "Raides",
    ["Raid"] = "Raide",
    ["Professions"] = "Profissões",
    ["World"] = "Mundo",
    ["High-Risk"] = "Alto Risco",
    ["High Risk"] = "Alto Risco",
    ["Timewalking"] = "Caminhada Temporal",
    ["Mythic"] = "Mítica",
    ["Mythic+"] = "Mítico+",
    ["Heroic"] = "Heroica",
    ["Normal"] = "Normal",
    ["Arena"] = "Arena",
    ["Arenas"] = "Arenas",
    ["Battleground"] = "Campo de Batalha",
    ["Battlegrounds"] = "Campos de Batalha",
    ["World Boss"] = "Chefe Mundial",
    ["World Bosses"] = "Chefes Mundiais",
    ["Recommended"] = "Recomendado",
    ["Item Level"] = "Nível do item",
    ["Required Item Level"] = "Nível de item necessário",
    ["Level"] = "Nível",
    ["Requires Level"] = "Requer nível",
    ["Required Level"] = "Nível necessário",
    ["Current"] = "Atual",
    ["Next"] = "Próxima",
    ["Previous"] = "Anterior",
    ["Page"] = "Página",
    ["Filter"] = "Filtro",
    ["Filters"] = "Filtros",
    ["All"] = "Todas",
    ["Search"] = "Pesquisar",
    ["No quests available"] = "Nenhuma missão disponível",
    ["No Quests Available"] = "Nenhuma missão disponível",
    ["No daily quests available"] = "Nenhuma missão diária disponível",
    ["No Daily Quests Available"] = "Nenhuma missão diária disponível",
    ["Come back tomorrow"] = "Volte amanhã",
    ["Come Back Tomorrow"] = "Volte amanhã",
    ["Quest Complete"] = "Missão concluída",
    ["Quest Completed"] = "Missão concluída",
    ["Daily and Path of Ascension Quests"] = "Missões Diárias e do Caminho da Ascensão",
    ["Call Board Caches"] = "Baús do Quadro de Chamados",
}

for en, pt in pairs(labels) do
    UI[en] = pt
    QUI[en] = pt
end

-- Algumas linhas vêm direto do servidor, então acertamos o texto aqui também.
if A.ServerUI then
    local S = A.ServerUI
    for en, pt in pairs(labels) do S[en] = pt end

    S["At max level, the [KEYWORD:Call Board] is the place to find [KEYWORD:Daily Quests] and [KEYWORD:Weekly Quests]\n\n[KEYWORD:Daily Quests] are marked with a blue |cff267bfc!|r icon. Daily Quests refresh every day, giving you new tasks to complete every day!\n\n[KEYWORD:Weekly Quests] look like regular quests, but are only available once per week. Weekly Quests typically have far greater rewards."] =
        "No nível máximo, o [KEYWORD:Quadro de Chamados] é o lugar onde você encontra [KEYWORD:Missões Diárias] e [KEYWORD:Missões Semanais].\n\nAs [KEYWORD:Missões Diárias] são marcadas com um ícone azul |cff267bfc!|r e são renovadas todos os dias, oferecendo novas tarefas diariamente.\n\nAs [KEYWORD:Missões Semanais] se parecem com missões comuns, mas ficam disponíveis apenas uma vez por semana e normalmente oferecem recompensas muito maiores."

    S["Allows Path to Ascension quests to be offered to you through a popup in the quest tracker.\n\nPath to Ascension quests can still be found at a Call Board if this is disabled"] =
        "Permite que as missões do Caminho da Ascensão sejam oferecidas por uma janela no rastreador de missões.\n\nMesmo com esta opção desativada, as missões do Caminho da Ascensão continuam disponíveis no Quadro de Chamados."

    S["I would like to purchase Temporal contracts to complete my Callboard Quests!"] =
        "Quero comprar Contratos Temporais para concluir minhas missões do Quadro de Chamados!"

    S["Bazaar Tokens are a premium |cFF00CCFF|Hkeyword:82|hCurrency|h|r used to purchase a wide range of items from |cFF00CCFF|Hkeyword:238|hTiraxis|h|r, a Vendor located in the |cFF00CCFF|Hkeyword:29|hAuction House|h|r of every |cFF00CCFF|Hkeyword:64|hCapital City|h|r. These tokens can be purchased from the |cFF00CCFF|Hkeyword:29|hAuction House|h|r or bought from the |cFF00CCFF|Hkeyword:31|hAscension Store|h|r for |cFF00CCFF|Hkeyword:40|hDonation Points|h|r (DP).\r\n\r\nOnce obtained, you can exchange them for:\r\n\r\n- Cosmetic Equipment, |cFF00CCFF|Hkeyword:157|hMounts|h|r, |cFF00CCFF|Hkeyword:74|hCompanions|h|r, spell effects, and wings\r\n- Convenient |cFF00CCFF|Hkeyword:90|hDonation Items|h|r such as the |cFF00CCFF|Hkeyword:54|hBook of Ascension|h|r or a Craftsman’s Codex\r\n- |cFF00CCFF|Hkeyword:125|hHeirlooms|h|r that increase levelling speed\r\n- |cFF00CCFF|Hkeyword:225|hStones of Retreat|h|r for quick travel around the world\r\n\r\nIn addition to shopping at |cFF00CCFF|Hkeyword:238|hTiraxis|h|r, Bazaar Tokens can be used to auto-complete the |cFF00CCFF|Hkeyword:63|hCall Board|h|r Daily Quest, making them a valuable catch-up tool for players with limited time or those aiming to progress quickly through end-game content."] =
        "Fichas do Bazar são uma |cFF00CCFF|Hkeyword:82|hmoeda|h|r premium usada para comprar diversos itens de |cFF00CCFF|Hkeyword:238|hTiraxis|h|r, um comerciante encontrado na |cFF00CCFF|Hkeyword:29|hCasa de Leilões|h|r de cada |cFF00CCFF|Hkeyword:64|hcapital|h|r. Elas podem ser adquiridas na |cFF00CCFF|Hkeyword:29|hCasa de Leilões|h|r ou compradas na |cFF00CCFF|Hkeyword:31|hLoja do Ascension|h|r por |cFF00CCFF|Hkeyword:40|hPontos de Doação|h|r (DP).\r\n\r\nDepois de obtidas, podem ser trocadas por:\r\n\r\n- Equipamentos cosméticos, |cFF00CCFF|Hkeyword:157|hmontarias|h|r, |cFF00CCFF|Hkeyword:74|hcompanheiros|h|r, efeitos de feitiço e asas\r\n- |cFF00CCFF|Hkeyword:90|hitens de doação|h|r úteis, como o |cFF00CCFF|Hkeyword:54|hLivro da Ascensão|h|r ou um Códice do Artesão\r\n- |cFF00CCFF|Hkeyword:125|hHeranças|h|r que aceleram a evolução do personagem\r\n- |cFF00CCFF|Hkeyword:225|hPedras de Retirada|h|r para viajar rapidamente pelo mundo\r\n\r\nAlém das compras com |cFF00CCFF|Hkeyword:238|hTiraxis|h|r, as Fichas do Bazar podem concluir automaticamente a Missão Diária do |cFF00CCFF|Hkeyword:63|hQuadro de Chamados|h|r, servindo como uma opção de recuperação para jogadores com pouco tempo ou que desejam avançar mais rapidamente no conteúdo de nível máximo."

    -- Corrige nomes antigos do Quadro que ainda podem chegar do servidor.
    for en, pt in pairs(S) do
        if type(pt) == "string" and (pt:find("Quadro", 1, true) or pt:find("callboard", 1, true) or pt:find("Callboard", 1, true)) then
            pt = pt:gsub("Quadro de Chamadas", "Quadro de Chamados")
                :gsub("Quadro de chamadas", "Quadro de Chamados")
                :gsub("Quadros de chamadas", "Quadros de Chamados")
                :gsub("Quadros de chamada", "Quadros de Chamados")
                :gsub("Quadro de chamada", "Quadro de Chamados")
                :gsub("missões de callboard", "missões do Quadro de Chamados")
                :gsub("missões do Callboard", "missões do Quadro de Chamados")
                :gsub("missões do callboard", "missões do Quadro de Chamados")
                :gsub("Callboard", "Quadro de Chamados")
                :gsub("callboard", "Quadro de Chamados")
                :gsub("Diariamente Quest", "Missão Diária")
            S[en] = pt
        end
    end
end

local function patchTitle(id, pt)
    if T[id] then T[id] = pt end
end

local function patchQuest(id, data)
    local q = Q[id]
    if not q then return end
    for k, v in pairs(data) do q[k] = v end
end

-- Títulos que ainda chegavam ao quadro com espanhol/portunhol.
local titleFixes = {
    [81252] = "Cerco da Cidade: Batalha por Darnassus",
    [81253] = "Cerco da Cidade: Batalha por Orgrimmar",
    [81254] = "Cerco da Cidade: Batalha pela Cidade Baixa",
    [81255] = "Cerco da Cidade: Batalha pelo Penhasco do Trovão",
    [81256] = "Conclusão de Manastorm",
    [81257] = "Campo de Provas: Ranqueada 2v2",
    [81258] = "Campo de Provas: Ranqueada 3v3",
    [81259] = "Campo de Provas: Jogo de Guerra",
    [81260] = "Chamado às Armas: Campo de Batalha",
    [81261] = "Campo de Provas: Escaramuça 1v1",
    [81262] = "Campo de Provas: Escaramuça 2v2",
    [81313] = "Raide de Caminhada Temporal: Batalha pelo Monte Hyjal",
    [81316] = "Exploração de Masmorra",
    [81317] = "Exploração de Masmorra Heroica",
    [81318] = "Exploração de Masmorra Mítica",
    [81321] = "Cerco da Cidade: Batalha por Darnassus",
    [81322] = "Cerco da Cidade: Batalha por Orgrimmar",
    [81323] = "Cerco da Cidade: Batalha pela Cidade Baixa",
    [81324] = "Cerco da Cidade: Batalha pelo Penhasco do Trovão",
    [81325] = "Campo de Provas: Ranqueada 1v1",
    [81326] = "Campo de Provas: Ranqueada 2v2",
    [81327] = "Campo de Provas: Ranqueada 3v3",
    [81328] = "Campo de Provas: Jogo de Guerra",
    [81330] = "Campo de Provas: Escaramuça 1v1",
    [81331] = "Campo de Provas: Escaramuça 2v2",
    [81341] = "Exploração de Masmorra Mítico+",
    [81342] = "Exploração de Masmorra Mítico+",
    [81343] = "Exploração de Masmorra Mítico+",
    [81344] = "Exploração de Masmorra: Scolomântia Superior",
    [81345] = "Exploração de Masmorra: Scolomântia Superior (Heroica)",
    [81356] = "Exploração de Masmorra: Scolomântia Superior (Mítica)",
}
for id, pt in pairs(titleFixes) do patchTitle(id, pt) end

-- Descobre as famílias usadas pelo conteúdo de nível máximo. Além da geração
-- clássica 806xx/813xx, o Ascension reaproveita o Quadro de Chamados com IDs
-- novos em algumas temporadas. O critério pelo texto inglês mantém essas cópias
-- ligadas sem depender de uma lista fixa que envelhece a cada patch do servidor.
local boardIDs = {}
local function MarkBoardID(id)
    if type(id) == "number" then boardIDs[id] = true end
end

for id = 80600, 81381 do MarkBoardID(id) end
for id, en in pairs(E) do
    if type(id) == "number" and id >= 70000 and type(en) == "string" then
        local low = en:lower()
        if low:find("timewalking", 1, true)
            or low:find("dungeon diving", 1, true)
            or low:find("hero's call:", 1, true)
            or low:find("city siege:", 1, true)
            or low:find("proving grounds:", 1, true)
            or low:find("ill gotten goods:", 1, true)
            or low:find("weekly quest:", 1, true)
            or low:find("daily quest", 1, true)
            or low:find("call board", 1, true)
            or low:find("callboard", 1, true) then
            MarkBoardID(id)
        end
    end
end
for id, q in pairs(Q) do
    if type(id) == "number" and type(q) == "table" then
        for _, field in ipairs({ "dEN", "oEN", "pEN", "cEN" }) do
            local en = q[field]
            if type(en) == "string" and (en:find("Call Board", 1, true) or en:find("Callboard", 1, true)) then
                MarkBoardID(id)
                break
            end
        end
    end
end

local titleMaterialNames = {
    ["Healthy Sanguine Vine"] = "Vinha Sanguínea Saudável",
    ["Tainted Sanguine Metal"] = "Metal Sanguíneo Corrompido",
    ["Bonded Sanguine Leather"] = "Couro Sanguíneo Reforçado",
    ["Malicious Sanguine Shard"] = "Estilhaço Sanguíneo Malicioso",
    ["Weaved Sanguine Thread"] = "Fio Sanguíneo Tecido",
    ["Cured Sanguine Infused Meat"] = "Carne Curada com Infusão Sanguínea",
    ["Healthy Core Root"] = "Raiz do Núcleo Saudável",
    ["Healthy Demon Bloom"] = "Flor Demoníaca Saudável",
    ["Tainted Core Metal"] = "Metal do Núcleo Corrompido",
    ["Tainted Demon Metal"] = "Metal Demoníaco Corrompido",
    ["Bonded Core Leather"] = "Couro do Núcleo Reforçado",
    ["Bonded Demon Leather"] = "Couro Demoníaco Reforçado",
    ["Malicious Core Dust"] = "Pó do Núcleo Malicioso",
    ["Malicious Demon Dust"] = "Pó Demoníaco Malicioso",
    ["Weaved Core Thread"] = "Fio do Núcleo Tecido",
    ["Weaved Demon Thread"] = "Fio Demoníaco Tecido",
    ["Cured Core Infused Meat"] = "Carne Curada com Infusão do Núcleo",
    ["Cured Demon Infused Meat"] = "Carne Curada com Infusão Demoníaca",
}

for id in pairs(boardIDs) do
    local en = E[id]
    if type(en) == "string" then
        local value = en:match("^Ill Gotten Goods: (.+)$")
        if value and titleMaterialNames[value] then
            T[id] = "Bens Mal-Adquiridos: " .. titleMaterialNames[value]
        elseif en == "Hero's Call: Battle for Mount Hyjal" then
            T[id] = "Chamado do Herói: Batalha pelo Monte Hyjal"
        else
            local rated = en:match("^Proving Grounds: (%d+v%d+) Rated$")
            local skirmish = en:match("^Proving Grounds: (%d+v%d+) Skirmish$")
            if rated then T[id] = "Campo de Provas: Ranqueada " .. rated end
            if skirmish then T[id] = "Campo de Provas: Escaramuça " .. skirmish end
            if en == "Proving Grounds: Wargame" then T[id] = "Campo de Provas: Jogo de Guerra" end
            local weekly = en:match("^Weekly Quest: (.+)$")
            if weekly then
                local current = T[id]
                local suffix = type(current) == "string" and current:match(":%s*(.+)$")
                if suffix and suffix ~= "" then T[id] = "Missão Semanal: " .. suffix end
            end
        end
    end
end

local arenaDesc = "Ei, você! Parece ter o que é preciso. Entre na Arena e lute até a morte."
local arenaPending = "Achei que você fosse digno da minha recompensa... talvez ainda não. Volte quando terminar."
local arenaDone = "Ha! Eu sabia que você conseguiria. Pegue isto — é seu."

patchQuest(81256, { p = arenaPending, c = arenaDone })
patchQuest(81257, { d = arenaDesc, o = "Participe de 10 partidas de Arena 2v2.", p = arenaPending, c = arenaDone })
patchQuest(81258, { d = arenaDesc, o = "Participe de 10 partidas de Arena 3v3.", p = arenaPending, c = arenaDone })
patchQuest(81259, { d = "Ei, você! Parece ter o que é preciso. Entre em um Jogo de Guerra e lute até a morte." })
patchQuest(81325, { d = arenaDesc, o = "Participe de 10 partidas de Arena 1v1.", p = arenaPending, c = arenaDone })
patchQuest(81326, { d = arenaDesc, o = "Participe de 10 partidas de Arena 2v2.", p = arenaPending, c = arenaDone })
patchQuest(81327, { d = arenaDesc, o = "Participe de 10 partidas de Arena 3v3.", p = arenaPending, c = arenaDone })
patchQuest(81328, { d = "Ei, você! Parece ter o que é preciso. Entre em um Jogo de Guerra e lute até a morte." })

local twPending = "Os inimigos da masmorra ainda resistem. Volte quando tiver concluído sua missão através das linhas temporais."
local twDone = "Os ecos do passado voltam a silenciar. Sua bravura através das linhas temporais é lendária, herói. Receba sua recompensa."

patchQuest(81267, {
    d = "Nossos batedores informam que Onyxia, filha de Asa da Morte, está escondida em seu covil nas profundezas do Pântano Vadeoso. Ela fugiu para lá depois que sua identidade como Lady Katrana Prestor foi descoberta, assim como seu envolvimento no desaparecimento de Varian Wrynn, rei de Ventobravo.\n\nPrecisamos atacar agora, enquanto ela está vulnerável!\n\nReúna aventureiros capazes, vá ao Covil da Onyxia e elimine-a.",
    o = "Mate Onyxia!", p = twPending, c = twDone
})
patchQuest(81277, { o = "Entre na Caverna Ululante e mate Mutanus, o Devorador.", p = twPending, c = twDone })
patchQuest(81280, {
    d = "Rumores por toda Azeroth dizem que os habitantes de Naxxramas estão crescendo em número e poder. Estou procurando um grupo de heróis fortes o bastante para entrar na necrópole e acabar com seus líderes. E então, $n, aceita o desafio?",
    o = "Derrote os chefes de Naxxramas.", p = twPending, c = twDone
})
patchQuest(81281, {
    d = "Não gosto de enviar você para uma missão tão perigosa sem mais treinamento, mas a ameaça surgiu agora. Reúna um grupo de aventureiros experientes antes de enfrentá-la.\n\nElimine os bandidos que tomaram as Minas Mortas. Mate Edwin VanCleef para garantir que a ameaça seja eliminada de vez.",
    o = "Entre nas Minas Mortas e mate Edwin VanCleef.", p = twPending, c = twDone
})
patchQuest(81282, { o = "Entre em Gnomeregan e derrote Mekanizador Termaplugue.", p = twPending, c = twDone })
patchQuest(81283, {
    d = "Tenho outra tarefa perigosa para você, herói. Espero que tenha companheiros de confiança ao seu lado.\n\nNossos espiões informam que Charlga Talhaflanco vem negociando com o Flagelo. Entre no Urzal dos Tuscos e derrube Charlga antes que uma aliança entre o Flagelo e os javaliços possa se formar.",
    o = "Entre no Urzal dos Tuscos e mate Charlga Talhaflanco.", p = twPending, c = twDone
})
patchQuest(81286, { o = "Entre no Monastério Escarlate e mate Herodes e o Comandante Escarlate Mograine.", p = twPending, c = twDone })
patchQuest(81287, {
    d = "Você ficou mais forte, herói. Quase parece que desta vez não estou mandando você para uma missão suicida... quase.\n\nParece que não fomos rápidos o bastante para impedir as negociações entre os javaliços e o Flagelo. Um poderoso lich está erguendo um exército de mortos-vivos no Urzal dos Mortos. Mate Amnennar, o Senhor do Frio, de uma vez por todas.",
    o = "Entre no Urzal dos Mortos e mate Amnennar, o Senhor do Frio.", p = twPending, c = twDone
})
patchQuest(81288, { o = "Entre em Zul'Farrak e mate o Chefe Ukorz Escalpareia.", p = twPending, c = twDone })
patchQuest(81290, { o = "Entre em Uldaman e mate Archaedas.", p = twPending, c = twDone })
patchQuest(81307, { o = "Derrote o Príncipe Malchezaar em Karazhan!", p = twPending, c = twDone })
patchQuest(81309, { o = "Mate Gruul, o Matador de Dragões.", p = twPending, c = twDone })
patchQuest(81310, { o = "Derrote Magtheridon.", p = twPending, c = twDone })
patchQuest(81312, {
    d = "Mesmo depois da traição de Kael'thas, peregrinos elfos sangrentos ainda buscam refúgio na Bastilha da Tormenta. Não podemos permitir que Kael'thas fortaleça a Legião Ardente nem mantenha o controle sobre O Olho. A tecnologia naaru permitiria que suas forças atacassem Azeroth sem depender do Portal Negro. Precisamos tomar a fortaleza e acabar com Kael'thas.",
    o = "Derrote Kael'thas Andassol.", p = twPending, c = twDone
})
patchQuest(81314, {
    d = "Illidan acumulou muitos inimigos poderosos e permaneceu no Templo Negro por medo de provocar o Lich Rei ou chamar a atenção dos senhores remanescentes da Legião Ardente. Ainda assim, continua consolidando seu domínio sobre Terralém. Jamais teremos paz enquanto ele mantiver o controle do Templo Negro. Reúna seus aliados e ponha fim ao reinado do Traidor.",
    o = "Mate Illidan Tempesfúria!", p = twPending, c = twDone
})

local heroPending = "O inimigo ainda resiste. Prepare-se e volte quando tiver cumprido seu dever, herói."
local heroDone = "Vitória! As forças das trevas sofreram um golpe devastador. Seu heroísmo será lembrado por toda Azeroth."
patchQuest(81332, {
    d = "Aventureiro, a Abóbada de Arcavon tornou-se um foco de imenso poder elemental. Arcavon, o Vigia de Pedra, protege seus tesouros e impede que aproveitemos o potencial guardado ali.\n\nPrecisamos eliminar essa ameaça para ter acesso aos tesouros e segredos da abóbada. Reúna seus aliados e derrote esse poderoso guardião.",
    o = "Derrote Arcavon, o Vigia de Pedra!", p = heroPending, c = heroDone
})
patchQuest(81334, {
    d = "Bravo campeão, uma ameaça terrível surgiu sob o Templo do Repouso das Serpes. Sartharion, o Guardião Ônix, estabeleceu-se no Santuário Obsidiano. Esse poderoso dragão negro, junto de seus tenentes dracônicos, ameaça nosso mundo com suas maquinações sombrias.\n\nReúna seus aliados, desça ao santuário e ponha fim ao reinado de terror de Sartharion.",
    o = "Derrote Sartharion!", p = heroPending, c = heroDone
})
patchQuest(81335, { o = "Derrote Malygos!", p = heroPending, c = heroDone })
patchQuest(81336, { o = "Derrote Yogg-Saron!", p = heroPending, c = heroDone })
patchQuest(81337, { o = "Derrote Anub'arak!", p = heroPending, c = heroDone })

-- Quando a mesma frase inglesa aparece em várias rotações do quadro, reaproveita
-- a melhor versão ptBR já revisada. Assim não precisamos manter quatro
-- cópias diferentes da mesma diária e impede regressões entre ciclos antigos/novos.
local badWords = {
    "clasific", "inmers", " derriba", " ingresa", " exilia", "pelean", "creí ",
    "sabiao", "mancilh", "inmerecid", "inmoral", "infecdadea", "vidaable",
    "presacurva", "fortalezca", "lugarteniente", "confiable", "se encontrei",
    "vai ao ", "cima provas", "sua sucesso", "exitosa invérnia", "óleo estas",
    "o quadro de anuncios", "o tábua ofereça", "por que não entre não", "reúna a seus",
}

local function badness(text)
    if type(text) ~= "string" or text == "" then return 100000 end
    local low = text:lower()
    local score = 0
    for i = 1, #badWords do
        if low:find(badWords[i], 1, true) then score = score + 20 end
    end
    if low:find(" callboard", 1, true) then score = score + 4 end
    if low:find(" timewalking", 1, true) then score = score + 3 end
    if low:find(" dungeon", 1, true) then score = score + 2 end
    return score
end

local fieldPairs = {
    { "dEN", "d" }, { "oEN", "o" }, { "pEN", "p" }, { "cEN", "c" },
}

local bestByEnglish = {}
for id in pairs(boardIDs) do
    local q = Q[id]
    if q then
        for i = 1, #fieldPairs do
            local enField, ptField = fieldPairs[i][1], fieldPairs[i][2]
            local en, pt = q[enField], q[ptField]
            if type(en) == "string" and en ~= "" and type(pt) == "string" and pt ~= "" then
                local current = bestByEnglish[en]
                local score = badness(pt)
                if not current or score < current.score then
                    bestByEnglish[en] = { text = pt, score = score }
                end
            end
        end
    end
end

for id in pairs(boardIDs) do
    local q = Q[id]
    if q then
        for i = 1, #fieldPairs do
            local enField, ptField = fieldPairs[i][1], fieldPairs[i][2]
            local en = q[enField]
            local best = type(en) == "string" and bestByEnglish[en]
            if best and best.text then q[ptField] = best.text end
        end
    end
end

-- O quadro customizado às vezes recebe só texto cru, sem questID. Espelhamos a
-- tradução final por texto inglês para que a mesma frase funcione em qualquer aba.
-- Títulos duplicados em IDs sazonais recebem a melhor versão ptBR do mesmo
-- título inglês antes de montar o mapa exato do quadro.
local bestTitleByEnglish = {}
for id in pairs(boardIDs) do
    local en, pt = E[id], T[id]
    if type(en) == "string" and en ~= "" and type(pt) == "string" and pt ~= "" then
        local current = bestTitleByEnglish[en]
        local score = badness(pt)
        if not current or score < current.score then bestTitleByEnglish[en] = { text = pt, score = score } end
    end
end
for id in pairs(boardIDs) do
    local en = E[id]
    local best = type(en) == "string" and bestTitleByEnglish[en]
    if best and best.text then T[id] = best.text end
end

for id in pairs(boardIDs) do
    local enTitle, ptTitle = E[id], T[id]
    if type(enTitle) == "string" and enTitle ~= "" and type(ptTitle) == "string" and ptTitle ~= "" then
        UI[enTitle] = ptTitle
        QUI[enTitle] = ptTitle
    end

    local q = Q[id]
    if q then
        for i = 1, #fieldPairs do
            local en, pt = q[fieldPairs[i][1]], q[fieldPairs[i][2]]
            if type(en) == "string" and en ~= "" and type(pt) == "string" and pt ~= "" then
                UI[en] = pt
                QUI[en] = pt
            end
        end
    end
end

A.DailyQuestUIPatterns = {
    { "^Daily Quests %((%d+)%)$", function(n) return "Missões Diárias (" .. n .. ")" end },
    { "^Weekly Quests %((%d+)%)$", function(n) return "Missões Semanais (" .. n .. ")" end },
    { "^Completed:?%s*(%d+)%s*/%s*(%d+)$", function(a, b) return "Concluídas: " .. a .. "/" .. b end },
    { "^Progress:?%s*(%d+)%s*/%s*(%d+)$", function(a, b) return "Progresso: " .. a .. "/" .. b end },
    { "^[Rr]esets? in:?%s*(.+)$", function(v) return "Reinicia em: " .. v end },
    { "^Time Remaining:?%s*(.+)$", function(v) return "Tempo restante: " .. v end },
    { "^Requires Level%s+(%d+)$", function(v) return "Requer nível " .. v end },
    { "^Required Level:?%s*(%d+)$", function(v) return "Nível necessário: " .. v end },
    { "^Item Level:?%s*(%d+)$", function(v) return "Nível do item: " .. v end },
    { "^Page%s+(%d+)%s+of%s+(%d+)$", function(a, b) return "Página " .. a .. " de " .. b end },
    { "^(%d+)%s+Daily Quests?$", function(v) return v .. " missões diárias" end },
    { "^(%d+)%s+Weekly Quests?$", function(v) return v .. " missões semanais" end },
}

A.DailyQuestIDs = boardIDs
function A.IsDailyQuestID(id)
    id = tonumber(id)
    return id and boardIDs[id] == true or false
end

function A.TranslateDailyQuestText(text)
    if type(text) ~= "string" or text == "" then return nil end
    local exact = UI[text] or QUI[text]
    if exact and exact ~= text then return exact end

    local patterns = A.DailyQuestUIPatterns
    for i = 1, #patterns do
        local pattern, fn = patterns[i][1], patterns[i][2]
        local a, b = text:match(pattern)
        if a then
            local ok, result = pcall(fn, a, b)
            if ok and result and result ~= text then return result end
        end
    end

    return nil
end
