-- Remendos confirmados da base antiga. Corrigiu na fonte? Pode apagar daqui.
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


do
    local Q = A.QuestData
    if Q then
        if Q[780] then
            Q[780].p = "A agressividade dos Javaliços continua aumentando. Você já lhes deu uma lição e trouxe alguns focinhos e flancos?"
            Q[780].c = "Excelente. Esses ingredientes renderão um ótimo ensopado, e a perda desses javaliços servirá de lição aos vis Costagulha."
        end

        if Q[871] then
            Q[871].p = "Quanto mais demorarmos para deter esses ataques, mais difícil será abastecer o povo da Encruzilhada."
        end

        if Q[872] then
            Q[872].o = "Mate 8 Geomantes Crinavalha, 8 Defensores Crinavalha e Kreenig Rosnento.\n\nDepois leve a Presa de Kreenig Rosnento para Thork, na Encruzilhada."
            Q[872].p = "Corte a cabeça do líder e o caos se instala, $n. Aprenda bem essa lição; ela poderá ser útil no futuro.\n\nOs javatuscos ficarão sem direção, e conseguiremos retomar os Sertões."
        end

        if Q[893] then
            Q[893].p = "Também tenho minhas dúvidas de que um javatusco saiba se virar numa forja, mas o Chefe Guerreiro ordenou e eu cumpro. Preciso descobrir tudo o que puder sobre a tribo Crinavalha.\n\nJá executei tarefas ainda mais triviais e farei esta de bom grado se isso ajudar o povo orc."
        end

        if Q[1014] then
            Q[1014].p = "Com a morte de Arugal, poderemos fortalecer a posição da Dama Sombria em Lordaeron."
            Q[1014].c = "Por fim, a Floresta de Pinhaprata está livre do domínio daquele miserável Arugal. Você prestou um grande serviço à Dama Sombria, $n. Sua tenacidade será recompensada."
        end

        if Q[354007] then
            Q[354007].d = "Notícias preocupantes chegam da Plataforma da Asa Etérea. O cruel orc vil Korun subjugou um draco da Asa Etérea e agora cruza os céus livremente, aterrorizando todos em seu caminho. Korun lidera um bando de orcs Presa do Dragão, e sua montaria dracônica lhe dá enorme poder sobre a região. Se não for detido, esmagará a resistência restante e consolidará seu domínio. Não podemos permitir que esse tirano continue oprimindo a ninhada da Asa Etérea! Encontre o Senhor dos Céus Korun, mate-o e liberte o draco maltratado para que o verdadeiro espírito da Asa Etérea possa renascer!"
            Q[354007].o = "Mate o Senhor dos Céus Korun."
            Q[354007].c = "Obrigado, herói! Ao derrotar o tirânico Senhor dos Céus Korun, você libertou os Asa Etérea escravizados de sua crueldade. Sem Korun, os Presa do Dragão perderão parte do domínio sobre esses nobres dragões. Hoje você desferiu um golpe em nome da justiça! A ameaça dos Presa do Dragão ainda existe, mas os Asa Etérea e seus aliados agora têm esperança de que as sombras sobre a Plataforma da Asa Etérea finalmente sejam dissipadas."
        end

        if Q[354121] then
            Q[354121].d = "Campeão, os orcs Presa do Dragão exploram sem piedade os dragões da Asa Etérea nas Minas da Asa Etérea. Sangue negro escorre do próprio coração do mundo enquanto rebentadores e assoladores aterrorizam os dragões e os escravos alquebrados. Não podemos permitir tamanha crueldade! Infiltre-se nas minas e desmonte as operações dos Presa do Dragão por dentro. Purifique o sangue negro, elimine os rebentadores e os assoladores e enfraqueça as minas para que a Asa Etérea possa voar livre novamente. Confio em seu sucesso!"
            Q[354121].o = "Vá à Plataforma da Asa Etérea e enfraqueça as forças que mantêm o domínio dos Presa do Dragão sobre o Vale da Lua Negra."
        end

        if Q[770014] then
            Q[770014].d = "Tenho outra missão perigosa para você, herói. Espero que tenha alguns companheiros de confiança ao seu lado.\n\nNossos espiões informam que Charlga Talhaflanco vem negociando com a Praga. Entre no Urzal dos Tuscos e derrube Charlga antes que se forme uma aliança entre a Praga e os javatuscos!\n\nEsta missão deve ser entregue antes do nível 39!"
            Q[770014].o = "Entre no Urzal dos Tuscos e mate Charlga Talhaflanco."
        end

        if Q[770018] then
            Q[770018].d = "Você ficou mais forte, herói. Desta vez, quase parece que não estou enviando você para uma missão suicida... quase.\n\nParece que não fomos rápidos o bastante para impedir as negociações dos javatuscos com a Praga. Um lich poderoso está erguendo um exército de mortos-vivos no Urzal dos Mortos. Mate Amnennar, o Frigífero, de uma vez por todas.\n\nEsta missão deve ser entregue antes do nível 49!"
            Q[770018].o = "Entre no Urzal dos Mortos e mate Amnennar, o Frigífero."
        end

        for _, id in ipairs({ 81287, 177901 }) do
            if Q[id] then
                Q[id].d = "Você ficou mais forte, herói. Desta vez, quase parece que não estou enviando você para uma missão suicida... quase.\n\nParece que não fomos rápidos o bastante para impedir as negociações dos javatuscos com a Praga. Um lich poderoso está erguendo um exército de mortos-vivos no Urzal dos Mortos. Mate Amnennar, o Frigífero, de uma vez por todas."
                Q[id].o = "Entre no Urzal dos Mortos e mate Amnennar, o Frigífero."
            end
        end

        if Q[1660017] then
            Q[1660017].d = "Uma visitante... Raramente recebemos estranhos entre nós, e por um bom motivo: nossas práticas foram proibidas há milênios.\n\nÀs vezes penso que com razão... Lady Aegya está disposta a fazer coisas que fariam até um sátiro estremecer. Sabe do que estou falando? Crianças élficas oferecidas como tributo; órfãos de guerra de quem ninguém sentiria falta.\n\nAjude-me a salvá-las. Vá ao Grande Ninho e procure entre a carniça. Por seu intermédio, canalizarei meu poder e as transformarei em lindas borboletas.\n\nEncantei esta coroa de flores; sua fragrância será... irresistível. Elas seguirão você aonde quer que vá.\n\nTraga-as até aqui. Eu cuidarei do resto."
            Q[1660017].o = "Canalize o poder de Eldya sobre os recém-nascidos no Grande Ninho para transformá-los em borboletas. Depois, conduza as borboletas de volta a Eldya."
            Q[1660017].p = "Você chegou a tempo? Eles ainda estavam vivos?"
            Q[1660017].c = "<A elfa inspira profundamente ao sentir o aroma da coroa de flores.>\n\nElas seguiram você. Ótimo.\n\nO Grande Abutre ensina muitas lições, mas sacrificar vidas tão jovens à crueldade de seu bico... é uma depravação que eu jamais poderia perdoar em mim mesma.\n\nCuste o que custar, vou garantir que essas crianças estejam seguras."
        end

        if Q[81337] then
            Q[81337].o = "Derrote Anub'arak!"
        end

        for _, id in ipairs({ 4420438, 4420439 }) do
            local q = Q[id]
            if q then
                for _, field in ipairs({ "d", "o", "p", "c" }) do
                    if type(q[field]) == "string" then
                        q[field] = q[field]:gsub("velocidadee", "velocidade")
                    end
                end
            end
        end
    end
end

do
    if A.QuestTitle and A.QuestTitle[1903540] then
        A.QuestTitle[1903540] = "Caminho da Ascensão: Visite um Estalajadeiro"
    end
    local Q = A.QuestData
    if Q and Q[1903540] then
        Q[1903540].o = "Visite um Estalajadeiro e selecione 'Faça desta estalagem o seu lar'."
    end

    if A.QuestTitle and A.QuestTitle[28480] then
        A.QuestTitle[28480] = "Encomenda para o Estalajadeiro Finmir"
    end
    if Q and Q[28480] then
        Q[28480].d = "Os exilados aqui no Refúgio já suportaram muito. Entre doenças, ferimentos e a longa jornada desde um mundo despedaçado, resta-lhes pouco para cuidar dos feridos.\n\nSe puder fornecer 20 Bandagens Pesadas de Seda, farei com que cheguem aos draeneis que mais precisam. Pode parecer pouco, mas até um simples tecido macio pode trazer esperança."
        Q[28480].o = "O Estalajadeiro Finmir quer que você use Primeiros Socorros para confeccionar 20 Bandagens Pesadas de Seda e entregue a encomenda ao Estalajadeiro Finmir, no Refúgio, no Pântano das Mágoas."
        Q[28480].c = "Obrigado. Essas bandagens aliviarão a dor e lembrarão nosso povo de que não foi esquecido. Nesta terra desconhecida, isso importa mais do que você imagina."
    end

    if Q and Q[28575] then
        Q[28575].d = "Nossos Vigilantes se defendem de jaguares, crocoliscos, elementais e peixes frenéticos. Eles precisam de braçadeiras para proteger os pulsos enquanto enfrentam essas criaturas. Você parece ter habilidade com couro e agulha. Pode ajudá-los?"
        Q[28575].o = "O Estalajadeiro Finmir quer que você use Couraria para confeccionar 6 Braçadeiras Verdes de Couro e leve a encomenda a Manaar, o Vigilante, no Refúgio, no Pântano das Mágoas."
    end
end

-- Endgame e quests custom que ainda estavam com espanhol/portunhol no meio.
do
    local Q = A.QuestData
    if Q then
        for _, id in ipairs({ 7786, 207786, 307786, 1307786 }) do
            local q = Q[id]
            if q then
                q.d = "Ao segurar o receptáculo, você ouve um sussurro fraco.\n\n\"Liberte-me... desta... prisão.\"\n\n\"Dois que nos prendem...\n\naço feito de quatro...\n\nessência... senhor do fogo.\"\n\n\"Dimitriano... Silithus...\""
                q.o = "Para libertar Trovejardus, o Perseguidor dos Ventos, da prisão, entregue o Receptáculo do Renascimento, 10 Barras de Elemêntio e a Essência do Senhor do Fogo ao Grão-lorde Dimitriano, em Silithus."
                q.p = "Faça o mundo se ajoelhar, se for preciso!"
                q.c = "Nem em sonhos ousei prever este dia.\n\nContemple, mortal.\n\nCONTEMPLE AQUELE QUE É MAIS ANTIGO QUE A PRÓPRIA EXISTÊNCIA!\n\nCONTEMPLE AQUELE QUE ENFRENTOU TITÃS E DEUSES DE IGUAL PARA IGUAL!\n\nERGA-SE, MEU SENHOR! ROMPA SUAS CORRENTES!"
            end
        end

        if Q[77734] then
            Q[77734].d = "Meu senhor Thunderaan, Príncipe do Ar, foi abençoado com magias poderosas. Posso transmitir algumas delas àqueles que provarem ser dignos de empunhar seu poder.\n\nProve ser inimigo das forças de Ragnaros. Depois, traga-me o próprio poder do ar. Retorne com Essência do Ar, Sopro do Vento e Ar Elemental."
            Q[77734].o = "Colete o poder do vento."
        end

        if Q[11094] then
            Q[11094].p = "Acalme-se, criança."
        end
        if Q[11812] then
            Q[11812].c = "Honre a chama de Desolação!"
        end

        if Q[255006] then
            Q[255006].d = "Rohil acha você forte. Forte o bastante para matar Urash. Forte o bastante para quebrar a maldição.\n\nHá uma prova para novos caçadores: enfrentar feras e sobreviver. Quimera, lagarto, mantícora. Sobreviva às três e será um grande caçador.\n\nMas isso não basta para Urash. Enfrente as três e também o grande terror dos céus, a fera que chamamos Shanel'Tefir. Sobreviva, traga provas de cada uma e será um dos maiores caçadores. Grande o bastante para provar que Rohil está certo."
            Q[255006].o = "Colete troféus das feras ao redor da mina."
            Q[255006].p = "As feras desta terra são mais fortes que as de fora. Feras grandes e poderosas, abatidas apenas pelos maiores caçadores."
            Q[255006].c = "Muitos troféus. Grandes, fortes!\n\nVocê é um verdadeiro caçador, como Rohil disse."
        end

        if Q[255028] then
            Q[255028].p = "Não sei o que essa naga está fazendo aqui, mas uma naga tão perto de Porto de Bondebico não pode ser coisa boa."
            Q[255028].c = "Ah, você voltou! Deu um jeito naquela escamosa, viscosa, rastejante, sorrateira e submersa...\n\n...deu, não deu?"
        end

        if Q[255060] then
            Q[255060].o = "Mate os Operários Gan'arg e destrua os Protótipos de Canhão Vil no Pântano das Mágoas."
            Q[255060].p = "Esses relatos estão perto demais do Portal Negro para o meu gosto."
            Q[255060].c = "Obrigado. Todos estaremos muito mais seguros sem esses Gan'arg operando por perto.\n\nNunca ouvi falar de Gan'arg trabalhando por conta própria. Alguém deve tê-los trazido até aqui..."
        end

        if Q[255073] then
            Q[255073].o = "Mate os Filhotes de Viúva Negra na Floresta do Crepúsculo."
            Q[255073].p = "E então, já cuidou daquelas aranhas terríveis?"
            Q[255073].c = "Você tem minha gratidão. Dormiremos bem esta noite!\n\n<O olhar dela volta para Brutus enquanto ri baixinho para si mesma.>\n\n...alguns mais do que outros."
        end

        local warlockText = "Não faço rodeios, verme. A escuridão contida nas peças Coração Pestilento pode muito bem destruir nós dois. É por isso que o preço é tão alto. Se eu for morrer, será como um homem rico.\n\nE não me importa nem um pouco como você morre, desde que faça o que peço. Traga-me o que preciso e ambos sairemos ganhando — ou morreremos; mas isso eu já expliquei..."
        for id = 209103, 209110 do
            if Q[id] then
                Q[id].d = warlockText
                Q[id].c = "Excelente, $n. Você trouxe tudo o que pedi. A peça Coração Pestilento está pronta."
            end
        end

        local priestText = "<Padre Montoy faz alguns gestos estranhos no ar diante de você.>\n\nVocê encontrou as vestes dos caídos? Pobres almas cujos últimos suspiros foram dados no campo de batalha — despojadas de tudo, até da própria dignidade.\n\nTraga-me os restos profanados dos mortos junto com reagentes de purificação, e você conhecerá a fé."
        for id = 209111, 209118 do
            if Q[id] then
                Q[id].d = priestText
                Q[id].c = "Excelente, $n. Você trouxe tudo exatamente como pedi. Suas vestes estão prontas. Use-as para enfrentar aqueles que ameaçam nosso mundo."
            end
        end

        -- Essas duas frases aparecem em um monte de missões do Festival do Fogo.
        -- Se a zona existe na nossa tabela, aproveita o nome ptBR em vez de deixar inglês.
        local zones = A.AreaNames or {}
        for _, q in pairs(Q) do
            if type(q) == "table" and type(q.cEN) == "string" then
                local zone = q.cEN:match("^Honor the (.-) flame!$")
                if zone and zones[zone] then
                    q.c = "Honre a chama de " .. zones[zone] .. "!"
                end
            end
        end
    end
end

-- Algumas descrições de habilidades custom ainda tinham termos literais bem feios.
do
    local D = A.DescPairs
    if D then
        if D[10] then D[10][2] = "Dispara automaticamente contra o alvo até ser cancelado. Aumenta em {{1}}% sua velocidade de ataque à distância e escala com o Poder de Ataque à distância." end
        if D[25196] then D[25196][2] = "Clique com o botão direito para evocar ou dispensar seu Príncipe Thunderaan." end
        if D[35473] then D[35473][2] = "Exibe a Marca Lendária de Thunderaan. Mostre-a com orgulho!" end
        if D[59427] then D[59427][2] = "Combina as metades esquerda e direita da Prisão de Thunderaan." end
        if D[59453] then D[59453][2] = "Combina as metades heroicas esquerda e direita da Prisão de Thunderaan." end
    end
end


-- Acabamento de endgame, Festival do Fogo e habilidades temporais/felinas.
do
    local Q = A.QuestData
    if Q then
        if Q[11696] then
            Q[11696].c = "O frio de Ahune se espalha por estas cavernas, $n; uma semente da morte gélida que nos aguarda caso ele alcance todo o seu poder. Agradeço à Mãe Terra por ter enviado você."
        end

        if Q[13370] then
            Q[13370].d = "Seu campeão, Bolvar, morreu defendendo nosso mundo. A Horda lamenta a perda de um herói tão grandioso, mas não foi responsável pelos ataques covardes de Putress no Portão da Ira. Também perdemos grandes heróis por causa dessa traição.\n\nDiga ao seu rei que faremos tudo ao nosso alcance para levar os responsáveis por esse ato covarde à justiça. Faremos o possível para evitar um conflito com a Aliança, mas não hesitaremos em nos defender se formos provocados."
            Q[13370].o = "Use o portal no Forte Grommash para retornar à Bastilha de Ventobravo e entregue a mensagem de Thrall ao Rei Varian Wrynn."
            Q[13370].c = "Eles perderam a Cidade Baixa? Então a hora de atacar é agora. Nós mesmos lidaremos com Putress e retomaremos as Ruínas de Lordaeron para a Aliança!"
        end

        if Q[13377] then
            Q[13377].d = "Nas profundezas da Cidade Baixa se esconde o assassino responsável pela morte de Bolvar e de nossos bravos soldados no Portão da Ira.\n\nVarian trouxe consigo todo o poderio da Aliança para ajudar a derrubá-lo. Junte-se a ele e à Grã-senhora Jaina Proudmoore na caçada e conquiste seu lugar entre os maiores campeões da Aliança!\n\nFale com o Rei Varian Wrynn quando estiver pronto."
            Q[13377].o = "Ajude o Rei Varian Wrynn e a Grã-senhora Jaina Proudmoore a levar o Grão-boticário Putress à justiça. Se tiver sucesso, apresente-se ao Rei Varian Wrynn."
            Q[13377].c = "Por tempo demais, deixamos a Horda agir sem controle. Permitimos que seus territórios prosperassem e, em troca da nossa generosidade, eles tramaram nossa ruína.\n\nPaz? Inútil... Não nos levou a lugar algum. Perdemos alguns dos nossos maiores heróis por causa da \"paz\". Vamos ver o que a batalha nos traz...\n\nVolte para Nortúndria, $n. Conquiste-a para o seu rei -- PELA ALIANÇA!"
        end

        if Q[14232] then
            Q[14232].o = "Apresente-se a Sergra Espinho Negro na Encruzilhada, nos Sertões."
        end

        -- O banco antigo tem dezenas de conclusões do Festival do Fogo ainda em inglês.
        -- Corrige em lote usando a mesma tabela de nomes de zonas do addon.
        local zones = A.AreaNames or {}
        local aliases = { ["Elywnn Forest"] = "Elwynn Forest" }
        for _, q in pairs(Q) do
            if type(q) == "table" and type(q.cEN) == "string" then
                local zone = q.cEN:match("^Honor the (.-) flame[%.!]$")
                if zone then
                    zone = aliases[zone] or zone
                    if zones[zone] then q.c = "Honre a chama de " .. zones[zone] .. "!" end
                else
                    local faction, dzone = q.cEN:match("^Desecrate the (Alliance)'s (.-) bonfire!$")
                    if not faction then faction, dzone = q.cEN:match("^Desecrate the (Horde)'s (.-) bonfire!$") end
                    if faction and dzone then
                        dzone = aliases[dzone] or dzone
                        if zones[dzone] then
                            local factionPT = faction == "Alliance" and "Aliança" or "Horda"
                            q.c = "Profane a fogueira da " .. factionPT .. " em " .. zones[dzone] .. "!"
                        end
                    else
                        local generic = q.cEN:match("^Desecrate the (.-) bonfire!$")
                        if generic then
                            generic = aliases[generic] or generic
                            if zones[generic] then q.c = "Profane a fogueira de " .. zones[generic] .. "!" end
                        end
                    end
                end
            end
        end
    end
end

-- Habilidades custom de Chronomancer/Feral que ainda estavam literais ou com espanhol.
do
    local D = A.DescPairs
    if D then
        local chrono = "\nConjurar Lampejo concede a você |cFFFFFFFFDistorção Temporal|r.\n\nVocê aprenderá a criar uma |cFFFFFFFFDobra Temporal|r, permitindo retornar à posição original do Lampejo caso a conjure dentro de 3 segundos.\n\nSeus feitiços de dano com tempo de lançamento prolongam a duração de |cFFFFFFFFDistorção Temporal|r em 1 segundo e reduzem a recarga de Lampejo em 2 segundos."
        if D[17764] then D[17764][2] = chrono end
        if D[66786] then D[66786][2] = chrono end
        if D[57296] then D[57296][2] = "Ensina: Fenda Temporal." end
        if D[83405] then D[83405][2] = "Ensina: Fenda Temporal." end
        if D[92242] then D[92242][2] = "Canaliza uma fenda temporal em um dragão inimigo por {{1}}. Enquanto estiver preso na fenda, todo o dano causado ao alvo aumenta em {{2}}%. Além disso, a cada 15.000 de dano causado a um alvo afetado por Fenda Temporal, 1 Carga de Choque é gerada." end
        if D[53307] then D[53307][2] = "Causar dano ao longo do tempo com Mutilar, Ancinho, Rasgar ou Bote tem {{1}} de chance de potencializar uma das suas habilidades, fazendo com que ela cause {{2}}% a mais de dano e custe {{3}}% mais Energia a cada ativação subsequente.\n\nFrenesi Felino possui 18 segundos de recarga interna." end
    end
end

-- AscensionPTBR 1.5.1 - auditoria geral
-- Correções tardias para conteúdo custom que ainda carregava espanhol/portunhol.
do
    local Q = A.QuestData
    local T = A.QuestTitle
    if Q then
        local function setQuest(id, title, d, o, p, c)
            if T and title then T[id] = title end
            local q = Q[id]
            if not q then return end
            if d ~= nil then q.d = d end
            if o ~= nil then q.o = o end
            if p ~= nil then q.p = p end
            if c ~= nil then q.c = c end
        end

        setQuest(175136, "Emissário Especial de Altaforja",
            "Tenho uma missão para você e, junto dela, um novo título. Considere isto uma promoção.\n\nQuero que fale com o Thane desta cidade, Azaghal Stonesong, na qualidade de Emissário Especial de Altaforja. Coloque-se a serviço dele e ajude o governo de Dun Kazad como um gesto de boa vontade do Rei Magni Barbabronze.\n\nEnquanto isso, meu primo e eu investigaremos a conspiração até encontrarmos quem ordenou o ataque. Com um pouco de sorte, até lá você terá conquistado a amizade do Thane...\n\nE a confiança dele.",
            "Apresente-se ao Thane Azaghal Stonesong, na Praça da Audiência de Dun Kazad.", nil,
            "Imagino que tenha vindo com a delegação.\n\n<O Thane de Dun Kazad observa você sob as sobrancelhas espessas. Seu olhar exala uma autoridade fria, distante dos problemas mundanos.>\n\nPoupe-me dessas acusações veladas. A emboscada sofrida pelo Senador Thargas foi uma coincidência trágica. Nenhum anão de honra desta cidade, de todos os lugares possíveis, conspiraria para matar outro anão.")

        setQuest(175139, "Vidraça Externa do Metrô Correfundo",
            "Alertas e mais alertas! A vidraça submersa do Metrô Correfundo está em estado crítico!\n\nA linha que liga Altaforja a Ventobravo passa exatamente sob nossos pés. O pessoal da cidade acha que ela atravessa por baixo do mar... rá! Nada disso! Ela passa sob um lago congelado — sim, este mesmo lago! É o lar dos Caranguejos Gélidos, e são eles os responsáveis por todos os riscos e arranhões no vidro.\n\nNão posso abandonar o Posto Metantenna com todos esses alarmes disparando; o lugar inteiro pode ir pelos ares! Você assume daqui. Vista o traje de mergulho, pegue a fita adesiva reforçada e remende a parte externa da vidraça.\n\nE, já que estará lá... faça-me um favor e reduza um pouco a população de Caranguejos Gélidos.",
            "Vista o traje de mergulho, repare a parte externa da vidraça do Metrô Correfundo e mate os Caranguejos Gélidos.",
            "Alertas, alertas e mais alertas! O que está acontecendo lá fora?",
            "Os alarmes finalmente se calaram! Rá!\n\nDeixe-me calcular...\n\n<Ele murmura, marcando cada palavra com um clique no console mecânico.>\n\nA fita tem uma durabilidade de 7 sobre 3... a população foi reduzida em 15... a temperatura oscila entre 6 e 7 graus... e o fluxo do Metrô aumentou em '2E'...\n\n<Ele aperta uma tecla com força e o resultado aparece imediatamente. Então grita, empolgado:>\n\nCento e trinta e sete por cento!")

        setQuest(175227, "Apaziguando a Morte", nil,
            "Apresente-se a Jabul, Sumo Sacerdote de Tzotec, em Thundrakar.", nil,
            "<O Sumo Sacerdote do Loa da Morte observa você com uma expressão altiva.>\n\nA princesa me envia um estranho.\n\nCurioso. Mas não totalmente inesperado; já me acostumei às excentricidades dela.\n\nSe Mexitla acredita que você pode ajudar a restaurar nosso vínculo com Tzotec, que assim seja.")

        setQuest(175256, "O Ídolo de Ossos de Kezajin", nil,
            "Apresente-se a Hezari e ofereça a ela o tributo preparado por Kezajin.", nil,
            "Minha mãe... ela nos despreza... Sente repulsa da nossa fraqueza... repulsa da própria filha. Seus seguidores... seus fiéis...\n\nEla viu o que a devoção fez aos Filhos da Luz Enferma e decidiu que não quer adoração troll alguma.\n\nÉ da natureza dela mudar de ideia. Ela é o vento; eu sou a brisa. Eu tentaria convencê-la, mas estou morrendo, mortal. E ninguém pode curar esta doença...\n\nNinguém pode curar a radiação...\n\nExceto... talvez... as Três Bruxas.")

        setQuest(175257, "Pelos Olhos da Ruína", nil,
            "Obtenha uma Joia do Olho Intacta das cabeças entalhadas do Palácio Hierático e ofereça-a no altar.",
            "<Quase não passa de um fiapo de sombra junto ao altar; poderia ser qualquer coisa.>",
            "<O ar se dobra sobre o altar. O espírito encara você sem demonstrar emoção.>\n\nUma Joia do Olho intacta. Um olhar mutilado. O tributo de quem deseja enxergar o Outro Lado.\n\n<Patlazar inclina a cabeça.>\n\nFale, forasteiro. Que dívida trouxe sua sombra até este palácio?")

        setQuest(1205283, "Contrato da Legião: Acabando com os Patavil",
            "Os Patavil vêm atacando mercadores nas estradas de ida e volta de Hibérnia. Está na hora de colocá-los em seu devido lugar.\n\nVolte quando tiver abatido trinta pelursos da região.",
            "Mate 30 habitantes da Aldeia Patavil, na Selva Maleva.",
            "Sua tarefa ainda não está concluída. Volte ao quadro quando tiver cumprido o contrato.")

        setQuest(1660019, "O Caminho Está Fechado",
            "Perto daqui, encontramos uma caverna onde o véu entre os mundos é tênue. É um lugar de poder, assombrado por espíritos que assumem a forma de feras.\n\nA Bruxa enviou sua aprendiz para reunir o necessário para o ritual: a essência espiritual de uma serpente, de um morcego e de uma aranha. Mas ela nunca voltou. Talvez já esteja morta.\n\n<Swa'li coloca em sua mão um pequeno ídolo troll entalhado em osso e adornado com uma gema vermelho-sangue.>\n\nUm poderoso feitiço protege a entrada da caverna. Você precisará disto para atravessar a barreira e chegar ao outro lado. Se Anjali estiver morta... podemos contar com você para terminar o que ela começou?",
            "Use o amuleto dado por Swa'li para romper a barreira mágica que protege a entrada do Covil Sinistro.",
            "<A troll jaz destroçada, com a vida por um fio que mal suporta tamanho peso.>",
            "Mandaram você... pra ter certeza de que eu morri. Ha...\n\n<A troll jaz caída no chão, e cada respiração sai como um gemido áspero.>\n\nO amuleto... num funcionou. Não por completo... A magia desta caverna me despedaçou, por dentro e por fora. Era uma armadilha. A Bruxa deve ter percebido minhas ambições...\n\nMas eles num contavam que eu ia me agarrar à vida feito sanguessuga. Eu não vou morrer aqui!\n\nChegue mais perto... <a voz dela cai para um sussurro>. Eu conto tudo pra você.")

        local artisan = {
            [1005688] = {"Verdadeiro Artesão: Manto Cambiante", "1 Manto Cambiante"},
            [1005689] = {"Verdadeiro Artesão: Um Punhado de Barras", "20 Barras de Ferrovil e 20 Barras de Adamantita"},
            [1005690] = {"Verdadeiro Artesão: Uma Pilha de Carne", "40 Pedaços de Basilisco e 40 Carnes de Talbuque"},
            [1005691] = {"Verdadeiro Artesão: Muitos Materiais", "40 Pó Arcano, 40 Essências Planares Inferiores e 5 Cristais do Vazio"},
            [1005692] = {"Verdadeiro Artesão: Uma Carga de Couro", "40 Couros Nodosos e 40 Escamas de Dragão Etéreo"},
            [1005693] = {"Verdadeiro Artesão: Um Estoque de Estilhaços", "15 Estilhaços Prismáticos Grandes e 15 Estilhaços Prismáticos Pequenos"},
            [1005694] = {"Verdadeiro Artesão: Um Conjunto de Componentes", "10 Barras de Kório e 4 Barras de Adamantita Endurecida"},
            [1005695] = {"Verdadeiro Artesão: Uma Coleção de Tecidos", "5 Lunatramas Primevas"}
        }
        for id, info in pairs(artisan) do
            setQuest(id, info[1],
                "Um verdadeiro artesão é capaz de criar maravilhas dignas de lenda.\n\nPrecisamos da sua ajuda. Só alguém com a sua habilidade pode nos tirar desta situação.\n\nColete " .. info[2] .. " e entregue os materiais em qualquer Quadro de Chamados para receber sua recompensa.",
                "Colete " .. info[2] .. ".",
                "Sua tarefa ainda não está concluída. Volte ao quadro quando tiver cumprido o contrato.")
        end

        local outlandThreads = {
            [1007390] = {"Peça de Etertrama Imbuída", 4},
            [1007391] = {"Peça de Almatrama", 2},
            [1007392] = {"Tecido de Etertrama", 30}
        }
        for id, info in pairs(outlandThreads) do
            local item, amount = info[1], info[2]
            setQuest(id, "Fios de Terralém: " .. item,
                "As forças da Legião continuam atacando nossas linhas de suprimentos dos dois lados do Portal Negro. Temo que nossa campanha pare se não conseguirmos recursos localmente.\n\nManter o exército abastecido é a primeira batalha que precisamos vencer para derrotar a Legião. É essencial fornecer materiais aos curandeiros e conjuradores de apoio para manter nossos guerreiros em combate.\n\nColete " .. amount .. "x " .. item .. " e entregue em qualquer Quadro de Chamados.",
                "Colete " .. amount .. "x " .. item .. ".",
                "Sua tarefa ainda não está concluída. Volte ao quadro quando tiver cumprido o contrato.")
        end

        local food = {
            [1007394] = "Enguia Elétrica",
            [1007395] = "Carne de Marisco Jaggal",
            [1007396] = "Truta de Guelras Farpadas",
            [1007397] = "Cauda-de-feltro-malhada",
            [1007398] = "Peixe-esporo Zangariano",
            [1007399] = "Peixe-lama de Figluster",
            [1007400] = "Peixe-azul Guelra-de-gelo",
            [1007401] = "Dardejante Dourado",
            [1007402] = "Lagostim Furioso",
            [1007405] = "Carne de Abutre",
            [1007406] = "Carne de Assolador",
            [1007407] = "Pedaço de Basilisco",
            [1007408] = "Carne de Fenoceronte",
            [1007409] = "Carne Distorcida",
            [1007410] = "Carne de Talbuque",
            [1007411] = "Costelinhas de Raptor",
            [1007412] = "Carne de Serpente"
        }
        for id, item in pairs(food) do
            setQuest(id, "Período de Adaptação: " .. item,
                "Parece que nossos caçadores ainda não se adaptaram completamente a Terralém...\n\nPrecisamos da sua ajuda, herói. Pode ser um trabalho simples, mas os caçadores ainda estão se acostumando ao novo ambiente e nossos cozinheiros estão ficando sem ingredientes.\n\nColete 12x " .. item .. ". Você será muito bem recompensado pela ajuda.",
                "Colete 12x " .. item .. ".",
                "Sua tarefa ainda não está concluída. Volte ao quadro quando tiver cumprido o contrato.")
        end

        local enchanting = {
            [1007415] = {"Pó Arcano", 12},
            [1007416] = {"Essência Planar Maior", 5},
            [1007417] = {"Essência Planar Inferior", 10},
            [1007418] = {"Estilhaço Prismático Pequeno", 8},
            [1007419] = {"Estilhaço Prismático Grande", 4},
            [1007420] = {"Cristal do Vazio", 2},
            [1007422] = {"Óleo de Mana Superior", 4}
        }
        for id, info in pairs(enchanting) do
            local item, amount = info[1], info[2]
            setQuest(id, "Uma Situação Estranha: " .. item,
                "Nosso Grande Encantador está... ocupado. Precisamos da sua ajuda para manter o estoque de materiais em ordem.\n\nColete " .. amount .. "x " .. item .. ". Você será muito bem recompensado pela ajuda.",
                "Colete " .. amount .. "x " .. item .. ".",
                "Sua tarefa ainda não está concluída. Volte ao quadro quando tiver cumprido o contrato.")
        end

        local leather = {
            [1007425] = {"Couro Nodoso", 10},
            [1007426] = {"Couro Nodoso Pesado", 3},
            [1007428] = {"Couro Imbuído de Cristal", 4},
            [1007429] = {"Pelego Vil", 2},
            [1007430] = {"Couro Grosso de Fenoceronte", 3},
            [1007431] = {"Escama de Vento", 2},
            [1007432] = {"Escama de Dragão Etéreo", 2}
        }
        for id, info in pairs(leather) do
            local item, amount = info[1], info[2]
            setQuest(id, "Uma Grande Tarefa de Ética Questionável: " .. item,
                "Direitos dos animais pra cá, direitos dos animais pra lá...\n\nPrecisamos da sua ajuda, herói. Nossos caçadores estão encontrando certa resistência de terceiros e o trabalho está atrasando.\n\nColete " .. amount .. "x " .. item .. ". Você será muito bem recompensado pela ajuda.",
                "Colete " .. amount .. "x " .. item .. ".",
                "Sua tarefa ainda não está concluída. Volte ao quadro quando tiver cumprido o contrato.")
        end
    end
end



-- 1.5.1: cobertura extra de nomes Mystic/Skill Card/CoA (AscensionDB sweep)
do
    local S = A.SpellNameEN2ES
    if S then
        S["'Frost Storm'"] = "'Tempestade de Gelo'"
        S["Absolute Quality"] = "Qualidade Absoluta"
        S["Ancestral Ninja"] = "Ninja Ancestral"
        S["Banshee's Lament - WIP"] = "Lamento da Banshee — Em desenvolvimento"
        S["Battle Glaive"] = "Glaive de Batalha"
        S["Beastmastery Mastery"] = "Maestria em Domínio das Feras"
        S["Blink and you'll miss it!"] = "Piscou, Perdeu!"
        S["Blood"] = "Sangue"
        S["Blood Tracker: Carving Strikes"] = "Rastreador de Sangue: Golpes Retalhadores"
        S["Bound for Glory"] = "Rumo à Glória"
        S["Burning Jewels"] = "Joias Ardentes"
        S["Bursting Soul"] = "Alma Explosiva"
        S["Coldshot"] = "Tiro Gélido"
        S["Corrupted Druid"] = "Druida Corrompido"
        S["Dancing Demon Blades"] = "Lâminas Demoníacas Dançantes"
        S["Danse Macabre"] = "Dança Macabra"
        S["Disciple of the Sea Witch"] = "Discípulo da Bruxa do Mar"
        S["Dreadful Presence"] = "Presença Aterradora"
        S["Dual Wielding"] = "Ambidestria"
        S["Dusk, Dawn and Twilight"] = "Anoitecer, Alvorada e Crepúsculo"
        S["Ebon Dawn"] = "Alvorada de Ébano"
        S["Eldritch Wisdom"] = "Sabedoria Oculta"
        S["Elemental Exposure"] = "Exposição Elemental"
        S["Eskimo"] = "Esquimó"
        S["Fizzle"] = "Falha"
        S["Flourishing Nourish"] = "Nutrir Florescente"
        S["Focused Prayer"] = "Prece Focada"
        S["Forceful Nature"] = "Natureza Impetuosa"
        S["Furious Presence"] = "Presença Furiosa"
        S["Hasty Divine Protection"] = "Proteção Divina Acelerada"
        S["Hex: Skeletal Hatchling"] = "Malefício: Filhote Esquelético"
        S["High Roller"] = "Grande Apostador"
        S["Holy Templar: Light of Dawn"] = "Templário Sagrado: Luz da Aurora"
        S["Hydra's Sting"] = "Picada da Hidra"
        S["Icecrown Double-Tap"] = "Tiro Duplo da Coroa de Gelo"
        S["Leap of the Old Gods"] = "Salto dos Deuses Antigos"
        S["Lengthy Abolish Curse"] = "Abolir Maldição (Duração Aumentada)"
        S["Loa's Assault"] = "Investida do Loa"
        S["Madness of the Old Gods"] = "Loucura dos Deuses Antigos"
        S["Mana Reave"] = "Dilacerar Mana"
        S["Mighty Presence"] = "Presença Poderosa"
        S["Mystic Companion"] = "Companheiro Místico"
        S["Nimble Mind"] = "Mente Ágil"
        S["Overheated Strikes"] = "Golpes Superaquecidos"
        S["Overloaded Mind"] = "Mente Sobrecarregada"
        S["Phalanx Thrust"] = "Investida da Falange"
        S["Poison Mastery"] = "Maestria em Venenos"
        S["Ritualistic Presence"] = "Presença Ritualística"
        S["Saber Fangs"] = "Presas de Sabre"
        S["Salem Inquisitor"] = "Inquisidor de Salem"
        S["Scholar's Presence"] = "Presença do Erudito"
        S["Scryer Paladin"] = "Paladino Áugure"
        S["Seal Twister"] = "Manipulador de Selos"
        S["Second Chances"] = "Segundas Chances"
        S["Second Sunrise"] = "Segundo Nascer do Sol"
        S["Servant of the Old Gods"] = "Servo dos Deuses Antigos"
        S["Shadowed Mind Assault"] = "Investida da Mente Sombria"
        S["Sniper"] = "Franco-atirador"
        S["Spot Weakness"] = "Detectar Fraqueza"
        S["Storm Trooper"] = "Soldado da Tempestade"
        S["Swift Presence"] = "Presença Veloz"
        S["the Elune's Doctrine"] = "Doutrina de Eluna"
        S["Thundarian's Fury"] = "Fúria de Thundarian"
        S["TIMBERRR"] = "MADEIRAAA!"
        S["Trick Shots"] = "Tiros Ardilosos"
        S["Truestrike Presence"] = "Presença do Golpe Certeiro"
        S["Twisted Mind"] = "Mente Distorcida"
        S["Twisted Pact"] = "Pacto Distorcido"
        S["Untold Secrets"] = "Segredos Não Contados"
        S["Vigilance"] = "Vigilância"
        S["Viper Trap"] = "Armadilha de Víbora"
        S["Void Herald: Madness of the Old Gods"] = "Arauto do Vazio: Loucura dos Deuses Antigos"
        S["Void Herald: Madness of the Old Godss"] = "Arauto do Vazio: Loucura dos Deuses Antigos"
        S["Void Herald: Whispers of the Old Gods"] = "Arauto do Vazio: Sussurros dos Deuses Antigos"
        S["Warden's Glaive"] = "Glaive da Guardiã"
        S["Withering Fire - WIP"] = "Fogo Devastador — Em desenvolvimento"
        S["Zealots Might"] = "Poder do Zelote"
    end
end
-- 1.5.1: padronização profunda Mystic/CoA/WotLK pt-BR (gerado offline)
do
    local S = A.SpellNameEN2ES
    if S then
        S["Afterkindling"] = "Rescaldo"
        S["Aftermath"] = "Consequências"
        S["Aggression"] = "Agressão"
        S["Amplify Curse"] = "Amplificar Maldição"
        S["Ancestral Healing"] = "Cura Ancestral"
        S["Annihilation"] = "Aniquilação"
        S["Anticipation"] = "Antecipação"
        S["Arcane Fortitude"] = "Fortitude Arcana"
        S["Arcane Shielding"] = "Proteção Arcana"
        S["Arcane Subtlety"] = "Sutileza Arcana"
        S["Arctic Reach"] = "Alcance Ártico"
        S["Aspect Mastery"] = "Maestria em Aspectos"
        S["Bane"] = "Ruína"
        S["Blade Barrier"] = "Barreira de Lâminas"
        S["Bladed Armor"] = "Armadura Laminada"
        S["Blessed Hands"] = "Mãos Abençoadas"
        S["Blessed Vengeance"] = "Vingança Abençoada"
        S["Blood Craze"] = "Mania de Sangue"
        S["Blood Pact"] = "Pacto de Sangue"
        S["Blood Spatter"] = "Respingos de Sangue"
        S["Brambles"] = "Sarças"
        S["Call of Flame"] = "Chamado das Chamas"
        S["Careful Aim"] = "Mira Cuidadosa"
        S["Chaos Bolt"] = "Seta do Caos"
        S["Chill of the Grave"] = "Calafrio da Tumba"
        S["Close Quarters Combat"] = "Combate a Curta Distância"
        S["Commanding Presence"] = "Presença de Comando"
        S["Convection"] = "Convecção"
        S["Death Rune Mastery"] = "Maestria em Runas da Morte"
        S["Deflection"] = "Deflexão"
        S["Demonic Aegis"] = "Égide Demoníaca"
        S["Demonic Embrace"] = "Abraço Demoníaco"
        S["Destructive Reach"] = "Alcance Destrutivo"
        S["Divine Intellect"] = "Intelecto Divino"
        S["Dual Wield Specialization"] = "Especialização em Duas Armas"
        S["Earth's Grasp"] = "Agarrão da Terra"
        S["Efficiency"] = "Eficiência"
        S["Elemental Warding"] = "Proteção Elemental"
        S["Elusiveness"] = "Elusividade"
        S["Empowered Corruption"] = "Corrupção Potencializada"
        S["Endless Winter"] = "Inverno sem Fim"
        S["Endurance"] = "Resistência"
        S["Enhancing Totems"] = "Totens Fortalecedores"
        S["Enrage"] = "Enfurecer"
        S["Entrapment"] = "Enredamento"
        S["Fel Synergy"] = "Sinergia Vil"
        S["Feral Charge"] = "Investida Feral"
        S["Feral Swiftness"] = "Rapidez Feral"
        S["Firebolt"] = "Seta de Fogo"
        S["Flame Throwing"] = "Lançar Chamas"
        S["Flurry"] = "Rajada"
        S["Focused Aim"] = "Mira Focada"
        S["Focused Fire"] = "Fogo Focado"
        S["Frost Channeling"] = "Canalização de Gelo"
        S["Frost Warding"] = "Proteção contra Gelo"
        S["Frostbite"] = "Mordedura de Gelo"
        S["Go for the Throat"] = "Na Jugular"
        S["Grim Reach"] = "Alcance Sinistro"
        S["Guardian Totems"] = "Totens Guardiões"
        S["Haunt"] = "Assombração"
        S["Hawk Eye"] = "Olho de Falcão"
        S["Healing Grace"] = "Graça de Cura"
        S["Healing Light"] = "Luz Curativa"
        S["Health Funnel"] = "Canalizar Vida"
        S["Holy Fire"] = "Fogo Sagrado"
        S["Holy Nova"] = "Nova Sagrada"
        S["Holy Reach"] = "Alcance Sagrado"
        S["Holy Specialization"] = "Especialização Sagrada"
        S["Ice Floes"] = "Fluxos de Gelo"
        S["Icy Reach"] = "Alcance Glacial"
        S["Improved Ambush"] = "Emboscada Aprimorada"
        S["Improved Arcane Shot"] = "Tiro Arcano Aprimorado"
        S["Improved Aspect of the Hawk"] = "Aspecto do Falcão Aprimorado"
        S["Improved Aspect of the Monkey"] = "Aspecto do Macaco Aprimorado"
        S["Improved Blessing of Might"] = "Bênção do Poder Aprimorada"
        S["Improved Blessing of Wisdom"] = "Bênção da Sabedoria Aprimorada"
        S["Improved Blizzard"] = "Nevasca Aprimorada"
        S["Improved Bloodrage"] = "Raiva Sanguinária Aprimorada"
        S["Improved Charge"] = "Investida Aprimorada"
        S["Improved Cleave"] = "Cutilada Aprimorada"
        S["Improved Concentration Aura"] = "Aura de Concentração Aprimorada"
        S["Improved Concussive Shot"] = "Tiro de Concussão Aprimorado"
        S["Improved Corruption"] = "Corrupção Aprimorada"
        S["Improved Counterspell"] = "Contrafeitiço Aprimorado"
        S["Improved Curse of Agony"] = "Maldição da Agonia Aprimorada"
        S["Improved Curse of Weakness"] = "Maldição da Fraqueza Aprimorada"
        S["Improved Demoralizing Shout"] = "Grito Desmoralizador Aprimorado"
        S["Improved Devotion Aura"] = "Aura de Devoção Aprimorada"
        S["Improved Disarm"] = "Desarmar Aprimorado"
        S["Improved Drain Soul"] = "Drenar Alma Aprimorado"
        S["Improved Eviscerate"] = "Eviscerar Aprimorado"
        S["Improved Execute"] = "Executar Aprimorado"
        S["Improved Expose Armor"] = "Expor Armadura Aprimorado"
        S["Improved Fear"] = "Medo Aprimorado"
        S["Improved Fire Blast"] = "Impacto de Fogo Aprimorado"
        S["Improved Fire Nova"] = "Nova de Fogo Aprimorada"
        S["Improved Fireball"] = "Bola de Fogo Aprimorada"
        S["Improved Frostbolt"] = "Seta de Gelo Aprimorada"
        S["Improved Ghost Wolf"] = "Lobo Fantasma Aprimorado"
        S["Improved Gouge"] = "Goivar Aprimorado"
        S["Improved Hammer of Justice"] = "Martelo da Justiça Aprimorado"
        S["Improved Healing"] = "Cura Aprimorada"
        S["Improved Healing Wave"] = "Onda de Cura Aprimorada"
        S["Improved Health Funnel"] = "Canalizar Vida Aprimorado"
        S["Improved Healthstone"] = "Pedra de Vida Aprimorada"
        S["Improved Heroic Strike"] = "Golpe Heroico Aprimorado"
        S["Improved Hunter's Mark"] = "Marca do Caçador Aprimorada"
        S["Improved Imp"] = "Diabrete Aprimorado"
        S["Improved Inner Fire"] = "Fogo Interior Aprimorado"
        S["Improved Judgements"] = "Julgamentos Aprimorados"
        S["Improved Kick"] = "Chute Aprimorado"
        S["Improved Lay on Hands"] = "Imposição das Mãos Aprimorada"
        S["Improved Life Tap"] = "Transfusão de Vida Aprimorada"
        S["Improved Mana Burn"] = "Queimar Mana Aprimorado"
        S["Improved Mark of the Wild"] = "Marca do Indomado Aprimorada"
        S["Improved Mend Pet"] = "Curar Mascote Aprimorado"
        S["Improved Mind Blast"] = "Impacto Mental Aprimorado"
        S["Improved Moonfire"] = "Fogo Lunar Aprimorado"
        S["Improved Overpower"] = "Subjugar Aprimorado"
        S["Improved Poisons"] = "Venenos Aprimorados"
        S["Improved Power Word: Fortitude"] = "Palavra de Poder: Fortitude Aprimorada"
        S["Improved Power Word: Shield"] = "Palavra de Poder: Escudo Aprimorada"
        S["Improved Psychic Scream"] = "Grito Psíquico Aprimorado"
        S["Improved Reincarnation"] = "Reencarnação Aprimorada"
        S["Improved Rejuvenation"] = "Rejuvenescimento Aprimorado"
        S["Improved Rend"] = "Desgarrar Aprimorado"
        S["Improved Renew"] = "Renovar Aprimorado"
        S["Improved Revenge"] = "Revanche Aprimorada"
        S["Improved Revive Pet"] = "Reviver Mascote Aprimorado"
        S["Improved Righteous Fury"] = "Fúria Íntegra Aprimorada"
        S["Improved Rune Tap"] = "Transfusão Rúnica Aprimorada"
        S["Improved Scorch"] = "Calcinar Aprimorado"
        S["Improved Searing Pain"] = "Dor Calcinante Aprimorada"
        S["Improved Shadow Bolt"] = "Seta Sombria Aprimorada"
        S["Improved Shadow Word: Pain"] = "Palavra Sombria: Dor Aprimorada"
        S["Improved Shields"] = "Escudos Aprimorados"
        S["Improved Sinister Strike"] = "Golpe Sinistro Aprimorado"
        S["Improved Slice and Dice"] = "Fatiar e Picar Aprimorado"
        S["Improved Spell Reflection"] = "Reflexão de Feitiço Aprimorada"
        S["Improved Spirit Tap"] = "Transfusão de Espírito Aprimorada"
        S["Improved Sprint"] = "Disparada Aprimorada"
        S["Improved Stings"] = "Ferroadas Aprimoradas"
        S["Improved Succubus"] = "Súcubo Aprimorado"
        S["Improved Thunder Clap"] = "Trovoada Aprimorada"
        S["Improved Tracking"] = "Rastreamento Aprimorado"
        S["Improved Water Shield"] = "Escudo de Água Aprimorado"
        S["Incineration"] = "Incineração"
        S["Incite"] = "Incitar"
        S["Iron Will"] = "Vontade de Ferro"
        S["Lethal Shots"] = "Disparos Letais"
        S["Lightning Reflexes"] = "Reflexos Relâmpago"
        S["Lock and Load"] = "Travar e Carregar"
        S["Magic Absorption"] = "Absorção Mágica"
        S["Magic Attunement"] = "Sintonia Mágica"
        S["Master Shapeshifter"] = "Mestre Metamorfo"
        S["Mind Flay"] = "Açoite Mental"
        S["Molten Shields"] = "Escudos Derretidos"
        S["Molten Skin"] = "Pele Derretida"
        S["Moonglow"] = "Brilho Lunar"
        S["Morbidity"] = "Morbidez"
        S["Multi-Shot"] = "Tiro Múltiplo"
        S["Natural Shapeshifter"] = "Metamorfo Natural"
        S["Nature's Majesty"] = "Majestade da Natureza"
        S["Night of the Dead"] = "Noite dos Mortos"
        S["Nightfall"] = "Ocaso"
        S["Omen of Clarity"] = "Presságio de Clareza"
        S["On a Pale Horse"] = "Num Cavalo Pálido"
        S["Pathfinding"] = "Desbravamento"
        S["Permafrost"] = "Permafrost"
        S["Piercing Howl"] = "Uivo Perfurante"
        S["Piercing Ice"] = "Gelo Perfurante"
        S["Primal Fury"] = "Fúria Primeva"
        S["Primal Precision"] = "Precisão Primeva"
        S["Puncture"] = "Perfuração"
        S["Puncturing Wounds"] = "Feridas Perfurantes"
        S["Pursuit of Justice"] = "Busca pela Justiça"
        S["Rapid Fire"] = "Tiro Rápido"
        S["Rapid Killing"] = "Matança Rápida"
        S["Ravenous Dead"] = "Mortos Vorazes"
        S["Relentless Strikes"] = "Golpes Implacáveis"
        S["Remorseless Attacks"] = "Ataques Impiedosos"
        S["Restorative Totems"] = "Totens Restauradores"
        S["Runic Power Mastery"] = "Maestria em Poder Rúnico"
        S["Sanctity of Battle"] = "Santidade da Batalha"
        S["Savage Fury"] = "Fúria Selvagem"
        S["Savage Strikes"] = "Golpes Selvagens"
        S["Scent of Blood"] = "Aroma de Sangue"
        S["Seals of the Pure"] = "Selos dos Puros"
        S["Searing Light"] = "Luz Calcinante"
        S["Serrated Blades"] = "Lâminas Serrilhadas"
        S["Setup"] = "Preparação"
        S["Shadow Affinity"] = "Afinidade Sombria"
        S["Shadow Bolt"] = "Seta Sombria"
        S["Shadow Focus"] = "Foco Sombrio"
        S["Shadow Reach"] = "Alcance Sombrio"
        S["Shadow Weaving"] = "Trama Sombria"
        S["Shamanistic Focus"] = "Foco Xamânico"
        S["Shatter"] = "Estilhaçar"
        S["Shield Mastery"] = "Maestria com Escudo"
        S["Shield Specialization"] = "Especialização em Escudo"
        S["Shredding Attacks"] = "Ataques Trituradores"
        S["Sleight of Hand"] = "Prestidigitação"
        S["Smite"] = "Punição"
        S["Soul Siphon"] = "Sifão de Alma"
        S["Spell Deflection"] = "Deflexão de Feitiços"
        S["Spell Warding"] = "Proteção contra Feitiços"
        S["Spirit Tap"] = "Transfusão de Espírito"
        S["Starlight Wrath"] = "Ira da Luz Estelar"
        S["Stoicism"] = "Estoicismo"
        S["Student of the Mind"] = "Estudante da Mente"
        S["Subtlety"] = "Sutileza"
        S["Surefooted"] = "Passo Firme"
        S["Survival Instincts"] = "Instintos de Sobrevivência"
        S["Survivalist"] = "Sobrevivencialista"
        S["Taste for Blood"] = "Gosto por Sangue"
        S["Thick Hide"] = "Pelego Grosso"
        S["Thundering Strikes"] = "Golpes Trovejantes"
        S["Tidal Focus"] = "Foco das Marés"
        S["Tidal Mastery"] = "Maestria das Marés"
        S["Torment the Weak"] = "Atormentar os Fracos"
        S["Totemic Focus"] = "Foco Totêmico"
        S["Toughness"] = "Tenacidade"
        S["Tranquil Spirit"] = "Espírito Tranquilo"
        S["Trap Mastery"] = "Maestria em Armadilhas"
        S["Twin Disciplines"] = "Disciplinas Gêmeas"
        S["Unbridled Wrath"] = "Ira Desenfreada"
        S["Unholy Command"] = "Comando Profano"
        S["Unholy Power"] = "Poder Profano"
        S["Unleashed Fury"] = "Fúria Liberta"
        S["Unstable Affliction"] = "Agonia Instável"
        S["Unyielding Faith"] = "Fé Inabalável"
        S["Vicious Strikes"] = "Golpes Cruéis"
        S["Vile Poisons"] = "Venenos Vis"
    end
end
