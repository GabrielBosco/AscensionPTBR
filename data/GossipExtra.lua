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

-- Revisao NPCs/AscensionDB 2026-08-24
-- Kelm Hargunth possui varias entradas/variantes no AscensionDB e o texto
-- exibido pelo cliente CoA pode trazer a classe ja renderizada em vez de $c.
Add("Do you have more advanced gear to sell me?",
    "Você tem equipamentos mais avançados para me vender?")
Add("What goods have I earned the right to purchase for use in Warsong Gulch?",
    "Quais mercadorias conquistei o direito de comprar para usar na Ravina Brado Guerreiro?")
Add("Zug zug, my friend!  I am Kelm Hargunth, the main supplier for the Warsong Outriders.  As you improve your standing with the Outriders, I will make available to you a fine selection of goods that you can use inside Warsong Gulch.  Should you find yourself in need of item repair, I also provide those services.",
    "Zug zug, meu amigo! Sou Kelm Hargunth, o principal fornecedor dos Pioneiros do Brado Guerreiro. Conforme sua reputação com os Pioneiros melhorar, disponibilizarei uma excelente seleção de mercadorias para você usar na Ravina Brado Guerreiro. Se precisar reparar seus itens, também ofereço esse serviço.")

local GOSSIP_CLASS_PT = {
    ["Barbarian"] = "Bárbaro",
    ["Bloodmage"] = "Mago Sangrento",
    ["Blood Mage"] = "Mago Sangrento",
    ["Chronomancer"] = "Cronomante",
    ["Cultist"] = "Cultista",
    ["Felsworn"] = "Juramentado Vil",
    ["Guardian"] = "Guardião",
    ["Knight of Xoroth"] = "Cavaleiro de Xoroth",
    ["Necromancer"] = "Necromante",
    ["Primalist"] = "Primalista",
    ["Pyromancer"] = "Piromante",
    ["Ranger"] = "Patrulheiro",
    ["Reaper"] = "Ceifador",
    ["Runemaster"] = "Mestre das Runas",
    ["Starcaller"] = "Invocador Estelar",
    ["Stormbringer"] = "Portador da Tempestade",
    ["Sun Cleric"] = "Clérigo Solar",
    ["SunCleric"] = "Clérigo Solar",
    ["Templar"] = "Templário",
    ["Tinker"] = "Inventor",
    ["Venomancer"] = "Venomante",
    ["Witch Doctor"] = "Médico Bruxo",
    ["WitchHunter"] = "Caçador de Bruxas",
    ["Witch Hunter"] = "Caçador de Bruxas",
}

local previousGossipPatternFallback = AscensionPTBR.GossipPatternFallback
function AscensionPTBR.GossipPatternFallback(text)
    local normalized = Normalize(text)
    if normalized
        and normalized:find("I am Kelm Hargunth, the main supplier for the Warsong Outfitters of Ashenvale.", 1, true)
        and normalized:find("As you improve your standing with us", 1, true)
        and normalized:find("Should you find yourself in need of item repair", 1, true) then
        local classEN = normalized:match("^Zug zug, (.-)%.%.%.") or "herói"
        local classPT = GOSSIP_CLASS_PT[classEN]
        if not classPT and AscensionPTBR.TranslateStaticText then
            local ok, translated = pcall(AscensionPTBR.TranslateStaticText, classEN)
            if ok and type(translated) == "string" and translated ~= "" and translated ~= classEN then
                classPT = translated
            end
        end
        classPT = classPT or classEN
        return "Zug zug, " .. classPT .. "...\n\n"
            .. "Eu sou Kelm Hargunth, o principal fornecedor do corpo de suprimentos do Brado Guerreiro no Vale Gris.\n\n"
            .. "Conforme sua reputação conosco melhorar, disponibilizarei uma excelente seleção de mercadorias que podem ser úteis para você.\n\n"
            .. "Se precisar reparar seus itens, também ofereço esse serviço."
    end

    if previousGossipPatternFallback then
        return previousGossipPatternFallback(text)
    end
    return nil
end

-- AscensionDB NPC dialogue sweep 1.5.3 - 2026-08-24
-- Falas custom de NPCs que não existiam no Gossip.lua original.
-- A mesma tabela é usada pelos eventos CHAT_MSG_MONSTER_* no Integration.lua.

-- Fashionable Necromancer (ID 110941)
Add("The loom is MINE!", "O tear é MEU!")
Add("I don't care how ethereal those fingers are, work faster!", "Não me importa o quanto esses dedos sejam etéreos. Trabalhem mais rápido!")
Add("Stitch like your afterlife depends on it - because it does!", "Costurem como se a pós-vida de vocês dependesse disso — porque depende!")
Add("Put some spirit into it, you lazy wraith!", "Coloque um pouco de espírito nisso, espectro preguiçoso!")
Add("The loom… slips from my grasp.", "O tear... escapa das minhas mãos.")

-- Verac the Wraithbound <Reaper of Souls> (ID 899403)
Add("What are you doing? You're blowing my cover. That damned gnome is mine!", "O que está fazendo? Você está estragando meu disfarce. Aquele gnomo maldito é meu!")
Add("You will not claim it! It is mine — by right of the dead!", "Você não vai tomá-la! Ela é minha — por direito dos mortos!")
Add("I have seen the Shadowlands. I fear nothing.", "Eu vi as Terras Sombrias. Não temo nada.")
Add("Can you not hear them? The dagger calls... it calls for me!", "Você não consegue ouvi-los? A adaga chama... ela chama por mim!")
Add("It... was never meant... for either of us...", "Ela... nunca foi destinada... a nenhum de nós...")

-- Necromancer Adept / Cultist trainer
Add("Ghouls are so disgusting, do we really have to do this?", "Carniçais são tão nojentos... precisamos mesmo fazer isso?")
Add("The end is near! The true gods are here! Join me!", "O fim está próximo! Os verdadeiros deuses estão aqui! Juntem-se a mim!")

-- Xarthos <Subject Zero> (ID 12538). Seleção de falas de encontro para cobrir
-- as mensagens mais visíveis sem transformar o arquivo em um dump bruto da DB.
Add("A pity... But the show must go on!", "Que pena... Mas o espetáculo tem que continuar!")
Add("I've collected sufficient data under these conditions. Now, let us observe how the subjects respond to a sudden temperature shift.",
    "Já coletei dados suficientes nestas condições. Agora veremos como os sujeitos respondem a uma mudança repentina de temperatura.")
Add("Most intriguing! I must see how Subject 1 performs outside containment. Try not to expire too quickly!",
    "Muito intrigante! Preciso ver como o Sujeito 1 se comporta fora da contenção. Tente não morrer tão rápido!")
Add("Curious... Subject 4 displayed tremendous survival instinct, followed by an abrupt and disappointing cessation of function.",
    "Curioso... O Sujeito 4 demonstrou um tremendo instinto de sobrevivência, seguido por uma interrupção abrupta e decepcionante das funções.")
Add("Remarkable! Subject 12 expired only after total nervous collapse. I must replicate these conditions immediately!",
    "Notável! O Sujeito 12 só morreu após um colapso nervoso completo. Preciso reproduzir essas condições imediatamente!")
Add("Curious... I hadn't anticipated this outcome... These results will require... deep analysis... You are all... dismissed...",
    "Curioso... Eu não havia previsto este resultado... Isso exigirá... uma análise profunda... Vocês estão todos... dispensados...")

-- Polimento global de opções comuns de instrutores/vendedores.
-- GossipExtra carrega depois do dump principal, então estes valores corrigem
-- traduções antigas/espanholas sem alterar milhares de linhas do arquivo-base.
Add("Train me.", "Treine-me.")
Add("I would like to train.", "Gostaria de treinar.")
Add("I wish to train.", "Desejo treinar.")
Add("I require training.", "Preciso de treinamento.")
Add("I would like training.", "Gostaria de receber treinamento.")
Add("What can you teach me?", "O que você pode me ensinar?")
Add("Let me browse your goods.", "Deixe-me ver suas mercadorias.")
Add("I want to browse your goods.", "Quero ver suas mercadorias.")
Add("I would like to browse your goods.", "Gostaria de ver suas mercadorias.")
Add("Show me your goods.", "Mostre-me suas mercadorias.")
Add("Train me in Alchemy.", "Treine-me em Alquimia.")
Add("Train me in Blacksmithing.", "Treine-me em Ferraria.")
Add("Train me in Cooking.", "Treine-me em Culinária.")
Add("Train me in Enchanting.", "Treine-me em Encantamento.")
Add("Train me in Engineering.", "Treine-me em Engenharia.")
Add("Train me in First Aid.", "Treine-me em Primeiros Socorros.")
Add("Train me in Fishing.", "Treine-me em Pesca.")
Add("Train me in Herbalism.", "Treine-me em Herborismo.")
Add("Train me in Inscription.", "Treine-me em Escrivania.")
Add("Train me in Jewelcrafting.", "Treine-me em Joalheria.")
Add("Train me in Leatherworking.", "Treine-me em Couraria.")
Add("Train me in Mining.", "Treine-me em Mineração.")
Add("Train me in Skinning.", "Treine-me em Esfolamento.")
Add("Train me in Tailoring.", "Treine-me em Alfaiataria.")
