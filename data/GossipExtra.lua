-- Falas custom/endgame confirmadas no CoA.
-- Além do mapa principal, mantemos um índice pequeno com espaços normalizados.
-- Alguns frames de Gossip entregam \r\n, outros \n e outros juntam quebras de linha.
AscensionPTBR = AscensionPTBR or {}
AscensionPTBR.GossipEN2ES = AscensionPTBR.GossipEN2ES or {}
AscensionPTBR.GossipExtraNormalized = AscensionPTBR.GossipExtraNormalized or {}

local G = AscensionPTBR.GossipEN2ES
local GN = AscensionPTBR.GossipExtraNormalized

local function Normalize(text)
    if type(text) ~= "string" then return nil end
    text = text:gsub("\r", ""):gsub("%s+", " ")
    text = text:gsub("^%s+", ""):gsub("%s+$", "")
    return text ~= "" and text or nil
end

local function Add(en, pt)
    G[en] = pt
    local key = Normalize(en)
    if key then GN[key] = pt end
end

Add([=[The Horde requires your strength blood elf! Core Materials and Demon Materials can be claimed by Heroes willing to venture into High-Risk to obtain them.

While in High-Risk, you can obtain these materials and choose the risk you are willing to take with Tiered Zones.

Tier 1 Zones: Un'goro Crater, Burning Steppes and Azshara. You will only drop items from your bags.

Tier 2 Zones: Western and Eastern Plaguelands. You will drop items from your bag, equipped items or Felcom gold if your items are insured.

Tier 3 Zones: Silithus and Winterspring. You will drop items from your bag and equipped items. Felcom costs 3 times more.]=], [=[A Horda precisa da sua força, elfo sangrento! Materiais do Núcleo e Materiais Demoníacos podem ser obtidos por heróis dispostos a se aventurar em áreas de Alto Risco.

Enquanto estiver em Alto Risco, você poderá obter esses materiais e escolher quanto risco deseja assumir nas Zonas por Grau.

Zonas de Grau 1: Cratera Un'Goro, Estepes Ardentes e Azshara. Você perderá apenas itens das suas bolsas.

Zonas de Grau 2: Terras Pestilentas Ocidentais e Orientais. Você poderá perder itens das bolsas, itens equipados ou ouro Felcom caso seus itens estejam segurados.

Zonas de Grau 3: Silithus e Hibérnia. Você poderá perder itens das bolsas e itens equipados. O Felcom custa três vezes mais.]=])

Add("I want to procure War Supplies!", "Quero obter Suprimentos de Guerra!")
Add("Epic High-Risk Material Transmutation.", "Transmutação Épica de Materiais de Alto Risco.")
Add("Core High-Risk Recipes.", "Receitas do Núcleo para Alto Risco.")
Add("Keeper's Scroll: High-Risk Events.", "Pergaminho do Guardião: Eventos de Alto Risco.")

Add([=[My time has come and gone, I've had my share of battles, and I've conquered some of the fiercest creatures on all of Azeroth. If you can best a raid boss in battle, you'll gain 2 Raider's Commendation, bring them to me when you have finished the raid, and have enough Commendations- I'll trade you some of my wares.]=], [=[Meu tempo de lutar já passou. Travei muitas batalhas e derrotei algumas das criaturas mais ferozes de toda Azeroth. Se você derrotar um chefe de raide, receberá 2 Comendas do Incursor. Quando terminar o raide, traga-as até mim; juntando comendas suficientes, poderei trocá-las por algumas das minhas mercadorias.]=])

Add("LOCKED [Clear Zul'Gurub]", "BLOQUEADO [Conclua Zul'Gurub]")
Add("LOCKED [Clear Molten Core]", "BLOQUEADO [Conclua Núcleo Derretido]")
Add("LOCKED [Clear Onyxia's Lair]", "BLOQUEADO [Conclua Covil da Onyxia]")
Add("Nevermind...", "Deixa pra lá...")

Add([=[Legends are not born - they are forged.
Browse my collection, and perhaps you'll find armor worthy of your deeds]=], [=[Lendas não nascem — são forjadas.
Dê uma olhada na minha coleção e talvez encontre uma armadura à altura dos seus feitos.]=])

Add("Tier 1 Sets", "Conjuntos de Grau 1")
Add("Tier 2 Sets", "Conjuntos de Grau 2")
Add("Tier 2.5 Sets", "Conjuntos de Grau 2,5")

-- Opcoes curtas e sistemas custom do Ascension que aparecem em varios NPCs.
-- Sao mantidas aqui para o Gossip nao depender do scanner generico da interface.
Add("I want to browse your wares.", "Quero ver suas mercadorias.")
Add("I want to see your wares.", "Quero ver suas mercadorias.")
Add("Show me your wares.", "Mostre-me suas mercadorias.")
Add("Show me what you have for sale.", "Mostre-me o que você tem à venda.")
Add("I want to make this inn my home.", "Quero fazer desta estalagem o meu lar.")
Add("I need to repair my equipment.", "Preciso reparar meu equipamento.")
Add("I need to repair my gear.", "Preciso reparar meu equipamento.")
Add("What is High-Risk?", "O que é o modo Alto Risco?")
Add("What can you tell me about High-Risk?", "O que você pode me dizer sobre o modo Alto Risco?")
Add("Tell me about High-Risk.", "Fale-me sobre o modo Alto Risco.")
Add("What are Trials?", "O que são as Provas?")
Add("Tell me about Trials.", "Fale-me sobre as Provas.")
Add("What is Prestige?", "O que é Prestígio?")
Add("Tell me about Prestige.", "Fale-me sobre Prestígio.")
Add("What is Mythic+?", "O que é Mítica+?")
Add("Tell me about Mythic+.", "Fale-me sobre Mítica+.")
Add("What are Worldforged items?", "O que são itens Forjados pelo Mundo?")
Add("Tell me about Worldforged items.", "Fale-me sobre os itens Forjados pelo Mundo.")
Add("Never mind.", "Deixa pra lá.")
Add("Nevermind.", "Deixa pra lá.")
Add("Goodbye.", "Até logo.")
Add("Goodbye", "Até logo")


-- Revisao adicional de falas que ainda estavam com portunhol ou frases
-- quebradas na base grande. Mantemos os overrides fora do Gossip.lua de 5 MB
-- para ser facil revisar e sem custo de varredura em tempo de jogo.
Add("How goes the relic retrieval, $n? I hope those mogu statues aren't giving you too much trouble.",
    "Como está a busca pelas relíquias, $n? Espero que aquelas estátuas mogu não estejam causando problemas demais.")
Add("Sadly, my - ah - artistic talents are somewhat lacking. What would YOU do to decorate my wall here?",
    "Infelizmente, meus... ahn... talentos artísticos deixam um pouco a desejar. O que VOCÊ faria para decorar esta parede?")
Add("This mission is far too vital to leave your repairs in the hands of someone other than myself.",
    "Esta missão é importante demais para deixar os reparos do seu equipamento nas mãos de outra pessoa.")
Add("Why is everyone looking at me as if I crashed the ship?",
    "Por que todo mundo está olhando para mim como se eu tivesse derrubado o navio?")
Add("The tablet has the confirmation we need, just as I thought. Now, we have to use this information to draw out and defeat this Anzu before he can do any more damage to the Emerald Dream!",
    "A tabuleta contém a confirmação de que precisávamos, exatamente como eu imaginava. Agora temos que usar essas informações para atrair e derrotar Anzu antes que ele cause mais danos ao Sonho Esmeralda!")
Add("Now we will see why this ore is so important to the Scourge.",
    "Agora veremos por que esse minério é tão importante para o Flagelo.")
Add("Use your body to shield Wrathion from the incoming attacks!",
    "Use seu corpo para proteger Wrathion dos ataques que se aproximam!")
Add("Back to square one, I guess. What's it going to take to get this thing off the ground?",
    "De volta à estaca zero, pelo visto. O que será preciso para fazer esta coisa sair do chão?")
Add("I was supposed to get firewood for the campsite...",
    "Eu deveria ter buscado lenha para o acampamento...")
Add("We're currently focus testing The Black Temple. You must have at least HONORED reputation with the Violet Eye to participate.  That's the reputation you gain while doing Karazhan.",
    "No momento estamos concentrando os testes no Templo Negro. Para participar, você precisa ter pelo menos reputação HONRADO com o Olho Violeta, obtida ao progredir em Karazhan.")
Add("I only make my mounts available to those who are considered exalted to Orgrimmar and the Orcish race.  Go prove yourself to us, and I'll make my mighty wolves available for your inspection.",
    "Só disponibilizo minhas montarias a quem é considerado Exaltado por Orgrimmar e pelo povo orc. Prove seu valor para nós e deixarei meus poderosos lobos à sua disposição.")
Add("I've got too much to do and not enough time to do it in, $r! Please, get out of my way.  If you're infected with the maggot slime or ghoul rot, I might be able to help you.",
    "Tenho coisa demais para fazer e tempo de menos, $r! Por favor, saia do meu caminho. Se você estiver infectado pela gosma de larva ou pela podridão de carniçal, talvez eu consiga ajudar.")
Add("I'm ready, Brann. Let's make the keystone.",
    "Estou pronto, Brann. Vamos criar a Pedra-Chave.")
Add("Right. Let's see if we can finish this keystone.",
    "Certo. Vamos ver se conseguimos concluir esta Pedra-Chave.")
Add("The keystone is completed! We've done it, $n!",
    "A Pedra-Chave está pronta! Conseguimos, $n!")
Add("What is a Horde Commendation Signet?",
    "O que é um Sinete de Comenda da Horda?")
Add("What is an Alliance Commendation Signet?",
    "O que é um Sinete de Comenda da Aliança?")
Add("I am on the path to ascension and no petty, aspiring hero is going to stop me.",
    "Estou no caminho da ascensão, e nenhum aspirante a herói insignificante vai me impedir.")
Add("You will not stop my ascension, tiny $r. Time to die!",
    "Você não impedirá minha ascensão, $r insignificante. É hora de morrer!")
Add("These supply crates came from Orgrimmar. What is Garrosh planning to do with so many war supplies?",
    "Estas caixas de suprimentos vieram de Orgrimmar. O que Garrosh pretende fazer com tantos suprimentos de guerra?")

-- Revisao endgame 2026-08-19: variantes reais vistas no cliente CoA.
-- As entradas abaixo existem para absorver pequenas diferencas de pontuacao,
-- quebra de linha e capitalizacao sem colocar scanner pesado no Gossip.

Add([=[The Horde requires your strength, blood elf! Core Materials and Demon Materials can be claimed by Heroes willing to venture into High-Risk to obtain them.

While in High-Risk, you can obtain these materials and choose the risk you are willing to take with Tiered Zones.

Tier 1 Zones: Un'goro Crater, Burning Steppes and Azshara. You will only drop items from your bags.

Tier 2 Zones: Western and Eastern Plaguelands. You will drop items from your bag, equipped items or Felcom gold if your items are insured.

Tier 3 Zones: Silithus and Winterspring. You will drop items from your bag and equipped items. Felcom costs 3 times more.]=], [=[A Horda precisa da sua força, elfo sangrento! Materiais do Núcleo e Materiais Demoníacos podem ser obtidos por heróis dispostos a se aventurar em áreas de Alto Risco.

Enquanto estiver em Alto Risco, você poderá obter esses materiais e escolher o grau de risco que deseja enfrentar nas Zonas por Grau.

Zonas de Grau 1: Cratera Un'Goro, Estepes Ardentes e Azshara. Você perderá apenas itens das suas bolsas.

Zonas de Grau 2: Terras Pestilentas Ocidentais e Orientais. Você poderá perder itens das bolsas, itens equipados ou ouro Felcom caso seus itens estejam segurados.

Zonas de Grau 3: Silithus e Hibérnia. Você poderá perder itens das bolsas e itens equipados. O Felcom custa três vezes mais.]=])

Add([=[The Horde requires your strength blood elf! Core Materials and Demon Materials can be claimed by Heroes willing to venture into High-Risk to obtain them.
While in High-Risk, you can obtain these materials and choose the risk you are willing to take with Tiered Zones.
Tier 1 Zones: Un'goro Crater, Burning Steppes and Azshara. You will only drop items from your bags.
Tier 2 Zones: Western and Eastern Plaguelands. You will drop items from your bag, equipped items or Felcom gold if your items are insured.
Tier 3 Zones: Silithus and Winterspring. You will drop items from your bag and equipped items. Felcom costs 3 times more.]=], [=[A Horda precisa da sua força, elfo sangrento! Materiais do Núcleo e Materiais Demoníacos podem ser obtidos por heróis dispostos a se aventurar em áreas de Alto Risco.

Enquanto estiver em Alto Risco, você poderá obter esses materiais e escolher o grau de risco que deseja enfrentar nas Zonas por Grau.

Zonas de Grau 1: Cratera Un'Goro, Estepes Ardentes e Azshara. Você perderá apenas itens das suas bolsas.

Zonas de Grau 2: Terras Pestilentas Ocidentais e Orientais. Você poderá perder itens das bolsas, itens equipados ou ouro Felcom caso seus itens estejam segurados.

Zonas de Grau 3: Silithus e Hibérnia. Você poderá perder itens das bolsas e itens equipados. O Felcom custa três vezes mais.]=])

-- Arauto de Guerra da Horda / High-Risk
Add("I want to procure War Supplies!", "Quero obter Suprimentos de Guerra!")
Add("Epic High-Risk Material Transmutation.", "Transmutação Épica de Materiais de Alto Risco.")
Add("Core High-Risk Recipes.", "Receitas do Núcleo para Alto Risco.")
Add("Keeper's Scroll: High-Risk Events.", "Pergaminho do Guardião: Eventos de Alto Risco.")
Add("Tier 1 Zones", "Zonas de Grau 1")
Add("Tier 2 Zones", "Zonas de Grau 2")
Add("Tier 3 Zones", "Zonas de Grau 3")
Add("War Supplies", "Suprimentos de Guerra")
Add("High-Risk Events", "Eventos de Alto Risco")
Add("High-Risk Recipes", "Receitas de Alto Risco")

-- Lorde Supremo Runthak / conjuntos classicos
Add([=[Legends are not born - they are forged. Browse my collection, and perhaps you'll find armor worthy of your deeds]=],
    [=[Lendas não nascem — são forjadas. Dê uma olhada na minha coleção e talvez encontre uma armadura à altura dos seus feitos.]=])
Add([=[Legends are not born - they are forged.
Browse my collection, and perhaps you'll find armor worthy of your deeds.]=],
    [=[Lendas não nascem — são forjadas.
Dê uma olhada na minha coleção e talvez encontre uma armadura à altura dos seus feitos.]=])
Add("Tier 1 Sets", "Conjuntos de Grau 1")
Add("Tier 2 Sets", "Conjuntos de Grau 2")
Add("Tier 2.5 Sets", "Conjuntos de Grau 2,5")
Add("Classic Tier Sets", "Conjuntos Clássicos por Grau")

-- Romus, o Redentor / troca de comendas
Add([=[My time has come and gone, I've had my share of battles, and I've conquered some of the fiercest creatures on all of Azeroth. If you can best a raid boss in battle, you'll gain 2 Raider's Commendation, bring them to me when you have finished the raid, and have enough Commendations- I'll trade you some of my wares.]=],
    [=[Meu tempo de lutar já passou. Travei muitas batalhas e derrotei algumas das criaturas mais ferozes de Azeroth. Se você derrotar um chefe de raide, receberá 2 Comendas do Incursor. Quando terminar o raide, traga-as até mim; ao reunir comendas suficientes, poderei trocá-las por algumas das minhas mercadorias.]=])
Add("LOCKED [Clear Zul'Gurub]", "BLOQUEADO [Conclua Zul'Gurub]")
Add("LOCKED [Clear Molten Core]", "BLOQUEADO [Conclua Núcleo Derretido]")
Add("LOCKED [Clear Onyxia's Lair]", "BLOQUEADO [Conclua Covil da Onyxia]")
Add("Commendation Exchange", "Troca de Comendas")
Add("Raider's Commendation", "Comenda do Incursor")
Add("Raider's Commendations", "Comendas do Incursor")

-- Avisos/diálogos endgame custom que apareceram nas capturas.
Add("The Glorious Azzar Faire has opened its gates! Step through the portal outside Orgrimmar and be among the first to experience the wonders hidden across Dawnrise Island!",
    "A Gloriosa Feira de Azzar abriu seus portões! Atravesse o portal nos arredores de Orgrimmar e esteja entre os primeiros a descobrir as maravilhas escondidas pela Ilha Dawnrise!")
