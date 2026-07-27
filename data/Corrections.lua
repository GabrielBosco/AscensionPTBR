-- Revisões humanas ptBR aplicadas sobre registros legados cuja tradução
-- espanhola automática ficou corrompida. IDs, chaves e textos-fonte EN são
-- mantidos nas tabelas originais.
local A = AscensionPTBR
if not A then return end

local Q = A.QuestData
if Q then
    local aquaticIntro =
        "Saudações, jovem $c. Chegou a hora de conhecer nossa Forma Aquática, " ..
        "que permite mover-se livremente pela água por tempo indeterminado. " ..
        "Esse aspecto será uma ferramenta útil e uma bênção, mas você precisará merecê-lo antes de dominá-lo.\n\n" ..
        "Você enfrentará duas provas. A primeira testará sua capacidade de agir na água sob pressão. " ..
        "A segunda testará sua determinação para compreender a própria Forma Aquática.\n\n" ..
        "Prepare-se: a prova começa agora."
    if Q[26] then Q[26].c = aquaticIntro end
    if Q[27] then Q[27].c = aquaticIntro end

    local seaLionProgress =
        "Você formou o pingente para que eu possa examiná-lo, $n? Se precisar de ajuda para encontrar as partes, " ..
        "fale com os moradores daqui. Além de encontrar o que procura, você terá um motivo para explorar esta clareira sagrada."
    local seaLionComplete =
        "Parabéns por concluir a Prova do Leão Marinho, $n.\n\n" ..
        "Cada etapa mostrou que agilidade e resistência são necessárias para agir em harmonia debaixo d'água. " ..
        "Uma não existe sem a outra, e ambas dependem da sua disposição para incorporar o aspecto do leão marinho.\n\n" ..
        "Guarde bem essas lições quando conquistar sua Forma Aquática."
    for _, id in ipairs({ 30, 272 }) do
        if Q[id] then
            Q[id].p = seaLionProgress
            Q[id].c = seaLionComplete
        end
    end

    local aquaticReturn =
        "Soube do seu retorno, mas preciso de uma prova das lições aprendidas na Clareira da Lua antes de ensinar a Forma Aquática.\n\n" ..
        "Você trouxe o Pingente do Leão Marinho?"
    local aquaticReward =
        "Impressionante, $n. Você está $gpronto:pronta; para aprender a Forma Aquática, e será um prazer ensiná-la.\n\n" ..
        "Como reconhecimento pela sua conquista nas duas provas, receba este item. Espero que ele seja útil em sua jornada " ..
        "como $gprotetor:protetora; da natureza e $gguardião:guardiã; do equilíbrio."
    for _, id in ipairs({ 31, 5061 }) do
        if Q[id] then
            Q[id].p = aquaticReturn
            Q[id].c = aquaticReward
        end
    end
end

-- Auditoria final 1.4.0: textos de missões que ainda estavam híbridos
-- espanhol/português na base herdada.
do
    local Q = A.QuestData
    if Q then
        if Q[10426] then
            Q[10426].p = "Você tentou concentrar a energia do domo?"
            Q[10426].c = "Céus! Parece que concentrar a energia do domo continua acelerando o crescimento, chegando ao ponto de provocar agressividade extrema. Se conseguirmos usar esta tecnologia, precisaremos calibrá-la corretamente."
        end

        if Q[14222] then
            Q[14222].d = "Por ordem de Sua Alteza Real, todos os cidadãos aptos ao serviço da Aliança devem se apresentar a Shindrell Fogo Veloz, no Vale Gris.\n\nA agressão da Horda no Vale Gris não pode continuar! Sua ajuda é necessária para repelir os invasores e restaurar a floresta sagrada. Siga ao sul pelo Vale do Crepúsculo, na Costa Negra, para chegar ao Vale Gris.\n\nPela glória e pela honra da Aliança!"
            Q[14222].o = "Apresente-se a Shindrell Fogo Veloz em Astranaar, no Vale Gris."
        end

        if Q[18029] then
            Q[18029].d = "Os Esfoladores Musgosos, que antes viviam em harmonia, sucumbiram a uma influência sombria que os conduz à agressão e à maldade. Batedores rondam o perímetro, infectados espalham a aflição sombria e Caçadores Sombrio unem as trevas aos seus rituais. Herói, sua habilidade é necessária. Enfrente-os e contenha a revolta para impedir mais danos à região e aos seus habitantes."
            Q[18029].o = "Elimine 6 Batedores Esfolamusgo, 6 Esfolamusgo Infectados e 6 Caçadores Sombrio Esfolamusgo."
        end

        if Q[18044] then
            Q[18044].d = "O Refúgio Quel'lithien, ao norte das Terras Pestilentas Orientais, já foi um farol da civilização élfica. Seus habitantes viviam em harmonia e protegiam as fronteiras élficas. Recentemente, porém, uma estranha hostilidade criou raízes entre eles. A agressividade contra forasteiros ameaça a frágil paz estabelecida nas Terras Pestilentas. Viaje até o refúgio e contenha os elfos para que possamos descobrir a origem dessa mudança repentina."
            Q[18044].o = "Viaje ao Refúgio Quel'lithien e mate 8 Mateiros, 8 Patrulheiros e 4 Andarilhos."
        end

        if Q[18102] then
            Q[18102].d = "Herói, o deserto de Silithus não é ameaçado apenas por cultos malignos, mas também por seus próprios habitantes. Rastejantes da Areia, Atacantes da Escavação e Escorpídeos Açoitapedra tornaram-se agressivos e atacam aventureiros e a fauna nativa. Essa agressividade desestabiliza o ecossistema e coloca em risco o equilíbrio de Silithus. Entre no deserto, enfrente essas criaturas e restaure a harmonia das areias."
            Q[18102].o = "Mate 5 Rastejantes da Areia, 5 Atacantes da Escavação e 5 Escorpídeos Açoitapedra nas dunas e nos oásis de Silithus."
        end

        if Q[90000] then
            Q[90000].d = "Saudações, $n.\n\nNossos batedores do Vale Gris relataram uma atividade anormal da Revoada Dragônica Verde na região. Eles parecem inquietos, como se tivessem recebido um mau presságio.\n\nPrecisamos de combatentes na linha de frente, junto ao Galho Sombrio, para conter a agressividade. Se decidir se juntar a nós, arranque algumas escamas dos corpos. Se você se destacar no campo de batalha, podemos chegar a um acordo sobre sua recompensa.\n\nTenha cuidado, $n. Há relatos de homens que se perderam diante dos sonhadores e agora procuram uma recompensa diferente."
            Q[90000].o = "Traga 60 Escamas do Galho Sombrio, no Vale Gris."
        end

        if Q[354035] then
            Q[354035].d = "Os arakkoas de Shienor ficam mais ousados a cada dia. Seus feiticeiros manipulam magia vil, enquanto guardas alados e guerreiros talonitas atacam viajantes no Véu Shienor. Eles precisam ser detidos antes que a agressividade se espalhe pela Mata Terokkar. Vá até Shienor e elimine seus feiticeiros, guardas alados e talonitas fanáticos."
            Q[354035].o = "Mate os feiticeiros, guardas alados e talonitas em Shienor."
            Q[354035].c = "Você dispersou e enfraqueceu as forças de Shienor, pelo menos por enquanto. Os arakkoas aprenderam o preço da agressão. Eles podem se reerguer com o tempo, mas suas ações garantiram uma vitória e deixaram uma mensagem clara: os habitantes da Mata Terokkar não tolerarão ataques sem provocação. Bom trabalho!"
        end

        if Q[354062] then
            Q[354062].d = "Herói, as nagas da Costa Cristanegra ficaram mais ousadas e expandiram suas operações no Pântano Zíngaro. Feiticeiras, capatazes e sentinelas atacam nossos postos e capturam vítimas para rituais abomináveis. Precisamos deter a agressão antes que conquistem mais terreno. Vá até a Costa Cristanegra, elimine os ritualistas e interrompa a magia sombria, obrigando as nagas sobreviventes a recuar para as profundezas."
            Q[354062].o = "Interrompa os rituais das nagas Cristanegra eliminando seus ritualistas."
        end
    end
end

-- Terceira parte da revisão 1.3.1: habilidades e arquétipos.
-- Sobrescreve somente traduções comprovadamente corrompidas, preservando
-- as chaves em inglês usadas pelo cliente do Project Ascension.
do
    local S = A.SpellNameEN2ES
    if S then
        S["Abyssal Strike"] = "Golpe Abissal"
        S["Accursed Armor"] = "Armadura Amaldiçoada"
        S["Ambidextrous"] = "Ambidestro"
        S["Ambidextrous SLS"] = "Ambidestro SLS"
        S["Ambidextrous Strike"] = "Golpe Ambidestro"
        S["Anomalous Armor"] = "Armadura Anômala"
        S["Anomaly Spike"] = "Espinho Anômalo"
        S["Aroy Kidney Shot"] = "Aroy: Golpe nos Rins"
        S["Aroy Molten Armor"] = "Aroy: Armadura Derretida"
        S["Battered Armor"] = "Armadura Danificada"
        S["Beastmaster's Whistle: Tomb Burster <Dread Crawler Queen>"] =
            "Apito do Mestre das Feras: Rompe-Tumbas <Rainha Rastejante Terrível>"
        S["Brigand Strike"] = "Golpe do Salteador"
        S["Cauterizing Fire - Hit Chance"] = "Fogo Cauterizante — Chance de Acerto"
        S["Chilled Armor"] = "Armadura Resfriada"
        S["Frost Tomb"] = "Tumba Gélida"
        S["Frost Tomb Summon"] = "Evocar Tumba Gélida"
        S["Frozen Tomb"] = "Tumba Congelada"
        S["Hasty Kidney Shot"] = "Golpe nos Rins (Acelerado)"
        S["Ice Tomb"] = "Tumba de Gelo"
        S["Icy Tomb"] = "Tumba Gélida"
        S["Improved Kidney Shot"] = "Golpe nos Rins Aprimorado"
        S["Kidney Shot"] = "Golpe nos Rins"
        S["Lose buff after X seconds"] = "Perde o bônus após X segundos"
    end

    local T = A.TipPairs
    if T then
        if T[621] then
            T[621][2] = "Aumenta o dano de |cffffffffAngústia de Atherann|r em {{1}}% e o bônus de dano crítico dos seus feitiços em {{2}}%."
        end
        if T[623] then
            T[623][2] = "Explosão da Lua de Sangue, Consumir e Tormento de Taldaram agora têm {{1}}% de chance de aplicar |cffffffffGarra Sinistra|r ao causarem dano."
        end
        if T[624] then
            T[624][2] = "Aumenta em {{1}}% a chance de acerto crítico de |cffffffffMordida de Presa Sangrenta|r e |cFFFFFFFFRasgo Vital|r, e em {{2}}% o dano crítico dessas habilidades."
        end
        if T[626] then
            T[626][2] = "|cffffffffMordida de Presa Sangrenta|r aplica |cffffffffMordida de Worgen|r ao alvo."
        end
        if T[627] then
            T[627][2] = "|cffffffffUivo do Caçador Noturno|r aplica |cffffffffMordida de Worgen|r a todos os inimigos atingidos."
        end
        if T[631] then
            T[631][2] = "Reduz em {{1}}% o custo de |cffffffffAbalo Glacial|r e |cffffffffBarragem de Gelo|r, e em {{2}} s a recarga de |cffffffffVentos de Nortúndria|r."
        end
        if T[635] then
            T[635][2] = "Quando |cffffffffPraga|r termina, imobiliza os inimigos afetados durante {{1}}. |cffffffffRaio de Putrefação|r causa {{2}}% a mais de dano contra alvos imobilizados dessa forma."
        end
        if T[636] then
            T[636][2] = "Quando |cffffffffPraga|r termina, imobiliza os inimigos afetados durante {{1}}."
        end
        if T[643] then
            T[643][2] = "Quando seus Podrinhos explodem, fortalecem todos os mortos-vivos ao redor durante {{1}} s, aumentando o dano em {{2}}% e a velocidade de movimento em {{3}}%."
        end
        if T[647] then
            T[647][2] = "|cffffffffExpurgar|r consome Parasita dos inimigos para causar {{1}}% a mais de dano e colher um Punhado de Vermes."
        end
        if T[763] then
            T[763][2] = "O efeito |cffffffffMachucado|r de |cffffffffAdaptação: Bandido|r aumenta em {{1}}% o dano que o alvo recebe de |cffffffffGolpe do Salteador|r e |cffffffffGolpe do Duelista|r."
        end
        if T[949] then
            T[949][2] = "Habilidades que exigem Manto Rúnico podem ser usadas durante {{1}} depois que o Manto Rúnico se desfaz."
        end
        if T[1074] then
            T[1074][2] = "Aumenta seu dano em {{1}}% durante {{2}} sempre que você invoca um Raptor ou Saurídeo. Acumula até {{3}} vezes."
        end
        if T[1421] then
            T[1421][2] = "Sempre que você recebe |cffb0f67a|cffb0f67acura|r|r, há 10% de chance de habilitar Vingança de Eluna durante 10 segundos.\n\nEsse efeito só pode ser ativado quando uma cura realmente restaura vida perdida."
        end
        if T[1432] then
            T[1432][2] = "Aumenta em {{1}} segundos a duração de |cffffffffFissão Atômica|r (ou 2 segundos em combate) e em {{2}}% a velocidade concedida pelo feitiço."
        end
    end
end



-- Otimizacao/revisao 1.3: correcoes pontuais e seguras sobre dados legados.
do
    local S = A.SpellNameEN2ES
    if S then
        S["Amber Shardhide"] = "Pele de Estilhaço Âmbar"
        S["Amber Spiteful Frog"] = "Sapo Âmbar Rancoroso"
        S["Amethyst Glintshell"] = "Carapaça Brilhante de Ametista"
        S["Captain's Resolve"] = "Determinação do Capitão"
        S["Captain’s Resolve"] = "Determinação do Capitão"
        S["Corroded Carapace: Physical"] = "Carapaça Corroída: Dano Físico"
        S["Elder Hide"] = "Couro Ancião"
    end

    local I = A.ItemDesc
    if I then
        I[30721] = "*ATENÇÃO* Fantasmas não gostam de ser vistos."
        I[37027] = "AVISO: NÃO ABRIR, QUEBRAR, COMER, VESTIR, BEBER NEM CHEIRAR."
        I[50301] = "ATENÇÃO: Não há garantia de que realmente contenha uma mascote."
        I[54218] = "ATENÇÃO: Não há garantia de que realmente contenha uma montaria."
    end
end

-- Revisão de prioridade alta 1.3.0c: correções humanas de resíduos
-- espanhóis e traduções híbridas encontradas na auditoria.
do
    local S = A.SpellNameEN2ES
    if S then
        S["Fetch Shrunken Dragon's Claw"] = "Buscar a Garra de Dragão Encolhida"
        S["I'm not afraid cause yeah I'm gliding"] = "Não tenho medo, pois estou planando"
        S["Ironman - Skills Before Kills"] = "Homem de Ferro — Habilidades Antes das Baixas"
        S["Shudder Before The Scythe"] = "Estremecer Diante da Foice"
        S["Sigil of The Nightmare Before Winter Veil"] = "Selo do Pesadelo Antes do Véu de Inverno"
    end

    local I = A.ItemDesc
    if I then
        I[30417] = "Fede, é nojento e grande demais para você, mas é o que você procura."
        I[30759] = "Pode lançar outra flecha antes que a primeira alcance o alvo."
        I[33040] = "Renn o consertou, mas ninguém sabe quanto tempo vai durar."
        I[34600] = "É melhor devolvê-la a Glrglrglr o quanto antes!"
        I[34710] = "Lance um e procure abrigo!"
        I[39318] = "É melhor devolvê-la a Har'koa o quanto antes!"
        I[40536] = "Aviso: pode explodir prematuramente se for submetido a um pulso eletromagnético."
        I[44511] = "Embora você já tenha lido este molde, os elementos o danificaram tanto que seu conteúdo foi perdido."
        I[98074] = "Ensina a evocar este companheiro.\n\n|cFFFFD100Bip, bop. Cogsley ao seu dispor. Precisa de ajuda na Tormenta de Mana? Posso reparar seus itens e comprar suas mercadorias.|r\n\n|cFFFFD100Cogsley funciona somente na Tormenta de Mana.|r\n\nEste é um companheiro não combatente."
        I[355168] = "Antes do ataque da Horda, as forças de Stromgarde usavam bestas como esta para eliminar membros da Camarilha que se aventurassem ao alcance da ponte."
        I[777992] = "Estes itens não são mais usados e podem ser excluídos. Você pode escolher novamente seus feitiços iniciais pelo Avanço do Personagem (atalho N) antes de alcançar o nível 10."
        I[824385] = "Não pertenço a nenhuma filosofia; pertenço ao mundo real. A realidade não se ajusta a ideologias. Elas são abstrações convenientes que adotamos por medo de fazer perguntas sem a promessa de respostas."
        I[1389901] = I[824385]
    end

    local C = A.AchCritEN2ES
    if C then
        C["Complete 130 quests in Boren Tundra"] = "Conclua 130 missões na Tundra Boreana."
        C["Complete 100 Storm Peaks Quests"] = "Conclua 100 missões nos Picos Tempestuosos."
        C["Complete 2000 quests"] = "Conclua 2.000 missões."
    end
end
