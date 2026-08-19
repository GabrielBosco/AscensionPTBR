AscensionPTBR = AscensionPTBR or {}

-- Acertos pontuais das quests que ainda apareciam tortas no jogo.
local P = {
    [28667]={d="Ei, você! Estou vendo essa picareta que carrega. Estou recrutando você para uma tarefa em nome da Horda.\n\nEstá vendo aquela forja ali? Nós a montamos, mas os ogros ainda não pegaram o jeito porque não têm materiais armazenados. É aí que você entra. Traga-me 20 Minérios de Ferro para mostrarmos a esses ogros como funciona a fundição.",o="Nazeer Bloodpike quer que você use sua perícia em Mineração para coletar 20 Minérios de Ferro e leve a encomenda até ele, na Aldeia Muralha Verde, no Pântano Vadeoso.",c="Ah! Ferro de verdade, não sucata recolhida por aí. Com isto eu consigo trabalhar. Está liberado, <name>. Pode cuidar dos seus assuntos."},
    [28672]={o="Fizit quer que você use sua perícia em Mineração para obter 20 Barras de Tório e leve a encomenda até ele, em Valormok, Azshara.",p="Ainda vai levar algum tempo até conseguirmos oferecer todos os serviços de criação em Valormok, mas isto nos deixa um passo mais perto.",c="Viva! Um pequeno milagre realizado. Agora, se eu tivesse um treco autoajustável e autocalibrável... não se preocupe, não vou pedir que encontre um desses."},
    [28673]={d="O Tenente Rainer vem patrulhando a Guarnição do Arroio do Oeste com uma camisa que mais parece um trapo desde uma emboscada de gnolls na semana passada. Ele se recusa a parar para consertá-la — diz que isso fortalece o caráter.\n\nSe você tiver habilidade, poderia confeccionar duas Camisas Azuis de Linho e levá-las até ele? Talvez não admita, mas sei que apreciaria o gesto. Só não deixe que ele convença você a costurar o guarda-roupa inteiro.",o="Sara Timberlain quer que você use sua perícia em Alfaiataria para confeccionar 2 Camisas Azuis de Linho e leve a encomenda ao Tenente Rainer, na Guarnição do Arroio do Oeste, na Floresta de Elwynn.",p="Malditos gnolls! Estou começando a congelar aqui fora.",c="Ora, veja só! As costuras estão firmes, a cor está certa... você se superou. Sara pensou em tudo — menos no quanto eu odeio ficar devendo favores. Então pegue estes suprimentos e ficamos quites."},
    [28676]={d="Marleth, lá na Aldeia da Cevada, voltou a queimar os dedos no alambique. Diz que as luvas antigas finalmente ficaram duras e quebradiças depois de anos mexendo com caldeirões ferventes.\n\nSe você souber usar uma agulha, faça para ela um novo par de Luvas Pesadas de Linho. Ela não vai pedir ajuda por conta própria, mas acredite: as cervejas dela não terão o mesmo sabor se ela fizer careta toda vez que mexer o caldeirão.",o="Uthrar Threx quer que você use sua perícia em Alfaiataria para confeccionar 1 par de Luvas Pesadas de Linho e leve a encomenda até Marleth Barleybrew, na Aldeia da Cevada, em Dun Morogh.",p="Veio esquentar a barriga com uma Cerveja Cevada?",c="Ooh, estas vão servir muito bem! Grossas, mas ainda flexíveis. Meus dedos agradecem — e o próximo lote de Cerveja Cevada também!"},
    [28678]={d="Vesprystus pode cruzar os céus, mas as botas dele não ficam longe do chão por muito tempo. Entre cuidar dos hipogrifos e levar despachos, o par antigo está se desfazendo nas costuras.\n\nSe puder confeccionar um novo par de Botas Simples de Linho, entregue-o a Vesprystus na Vila de Rut'theran. Ele não vai pedir substituição por conta própria, mas acho que já merece algo melhor do que farpas nas solas.",o="Trianna quer que você use sua perícia em Alfaiataria para confeccionar 1 par de Botas Simples de Linho e leve a encomenda até Vesprystus, na Vila de Rut'theran, em Teldrassil.",p="Precisa de uma carona para algum lugar, <name>?",c="Um excelente par de botas! O céu sempre parece mais bonito quando seus pés não doem ao aterrissar."},
    [28681]={d="Balthule está há semanas de posto na Torre de Althalaxx, exposto aos ventos frios do mar e à escuridão que se espalha lá de dentro. Ele não abandona o posto — nem mesmo para buscar um manto.\n\nÉ aí que alguém com sua habilidade de Alfaiataria entra. Gostaria que você confeccionasse para ele um Manto com Fecho de Pérola que ofereça um pouco de calor e conforto. Entregue-o no norte da Costa Negra, para lembrá-lo de que, mesmo quando o dever chama, ele não foi esquecido.",p="As sombras ficam mais ousadas a cada dia."},
    [28683]={p="Se essas bolsas não foram costuradas com lã e paciência, nem me interessam.",c="Pelas barbas de Moradin! Estas vão carregar o dobro de pedras com metade da dor nas costas. Você me fez um grande favor. Talvez agora eu encontre espaço para aquela pedra azul estranha..."},
    [28684]={d="Chegou notícia do dique: o Montanhês Haggil levou um tombo e rasgou as calças de alto a baixo ao descer por uma viga de sustentação. Desde então vem remendando tudo com barbante e teimosia.\n\nSe não se importar em cuidar desta encomenda também, confeccione uma Calça de Linho Costurada à Mão e leve-a até o Dique Lapidado.",o="Aldren Cordon quer que você use sua perícia em Alfaiataria para confeccionar 1 Calça de Linho Costurada à Mão e leve a encomenda ao Montanhês Haggil, no Dique Lapidado, em Loch Modan.",c="Que alívio! Eu estava a duas rajadas de vento de causar um escândalo. Você mereceu alguns suprimentos extras!"},
    [28686]={d="Então Danielle acha que estou suspirando por aquele vigia velho e sem graça? Nem pensar! Meu pretendente tem estilo. Ambição. Contatos. Ele é... bem, um goblin. Mas não qualquer goblin — Kzixx, o comerciante de bom gosto.\n\nJá que Danielle quer transformar isso numa competição, vou entrar no jogo. Confeccione um Colete de Seda Lazúli para Kzixx. Ele vai ficar tão impressionado que aposto que esquecerá aquela oferecida de Vila Plácida!",o="Sheri Zipstitch quer que você use sua perícia em Alfaiataria para confeccionar 1 Colete de Seda Lazúli e leve a encomenda até Kzixx, na Margem Escurecida, na Floresta do Crepúsculo.",c="Ora, isto é seda da melhor qualidade! Um presente de Sheri Zipstitch... Quem é essa? Suprimentos de alfaiataria em Vila Sombria? Hmm... talvez seja um contato comercial valioso. Obrigado pela dica!"},
    [28688]={d="Já me decidi! Cansei de servir bebidas a gente ingrata quando o que quero é estudar pergaminhos. Ofereceram-me uma vaga de aprendiz na Torre de Azora, e pretendo aceitá-la.\n\nMas, se vou para a Torre, preciso parecer uma maga. Se você puder confeccionar duas Vestes Menores de Mago para mim, significaria muito. Quero que me vejam não apenas como uma aluna, mas como alguém pronta para se tornar maga.",o="Gretchen Vogel quer que você use sua perícia em Alfaiataria para confeccionar 2 Vestes Menores de Mago e leve a encomenda até ela, em Vila Plácida, nas Montanhas Cristarrubra."},
    [28700]={o="Vhan quer que você use sua perícia em Alfaiataria para confeccionar 1 par de Luvas Pesadas de Linho e leve a encomenda até Pawe Mistrunner, no Platô dos Espíritos, em Penhasco do Trovão, Mulgore.",c="Ah... estas luvas protegerão tanto as mãos quanto a história. Bem ajustadas, cuidadosamente costuradas. Vhan foi sábio em mandar você. Os ancestrais agradecem — e eu também."},
    [28708]={d="Minha amiga Brine mora lá embaixo, na Serra do Espinho Negro, e mandou dizer que rasgou as calças nos espinhos enormes que crescem ao redor do acampamento dos javatuscos. Esta é uma boa encomenda para você praticar, se não se importar em me ajudar.",o="Mahani quer que você use sua perícia em Alfaiataria para confeccionar 1 Calça de Linho Costurada à Mão e leve a encomenda até Brine, na Serra do Espinho Negro, ao sul dos Sertões.",c="Agradeço aos elementos! Eu estava a duas rajadas de vento de causar um escândalo. Você conquistou minha gratidão!"},
    [33706]={d="Outra alma atraída pela lâmina... outro peão da minha dor.\n\nSussurro... minha alma...\n\nEu a forjei para desafiar a Legião... mas ela me foi arrancada pela traição e pela morte.\n\nDesde então, meu espírito vaga, alcançando o outro lado do véu e se agarrando à lâmina que um dia fez parte de mim.\n\nA Guerra dos Antigos destruiu mais do que pedra e carne. Destruiu juramentos. Destruiu a fé.\n\nSussurro não é amaldiçoada pelo mal, mas pela saudade... pela minha saudade.\n\nVocê, mortal... ouviu os lamentos, não ouviu? Os gritos através da lâmina?\n\nEram meus. E dos outros também... incontáveis almas atraídas para a sombra de Sussurro.\n\n<Aelric abaixa a cabeça.>\n\nEu imploro. Rompa as correntes.\n\nReúna as relíquias necessárias para realizar a purificação que libertará meu vínculo com esta arma. Preciso dos seguintes itens:\n\nLágrimas de Pó Lunar, que dizem cair dos Altaneiros Angustiados em Hibérnia; o Selo dos Esquecidos, carregado pelos Feiticeiros Eldreth no Gládio Cruel; e um Estilhaço da Ruína Vil, obtido de Comandantes da Guarda Apocalíptica nas Terras Devastadas.\n\nTambém precisarei da Relíquia da Marca da Tristeza — um artefato antigo usado em rituais dos Altaneiros... acredito que seu pequeno amigo lá no pântano possa tê-la encontrado.\n\nSó então Sussurro estará livre... e eu também.",o="Colete os itens de que Aelric precisa para romper seu vínculo com Sussurro.",c="Você fez bem. Agora estou livre do meu vínculo com Sussurro... e, em troca?\n\nEu a entrego a você. Que ela lhe sirva como me serviu, sem o sofrimento que trouxe ao mundo."},
    [49992]={title="Carta Sagrada",o="Procure Elling Trias na Abadia de Vila Norte.",c="A Luz brilha sobre você, <name>. Sinto a bênção dela em sua própria presença.\n\nVocê aceitou o pacto sagrado do Caçador de Bruxas. Agora está ligado a um propósito divino: buscar o mal em todas as suas formas e purificá-lo com fogo justo. Isto não é apenas um chamado; é um mandamento divino.\n\nSua fé será sua arma, e sua convicção, sua armadura. Você aprenderá a canalizar a Luz em ataques devastadores contra o profano, a proteger os inocentes com barreiras abençoadas e a enxergar através dos enganos de demônios e mortos-vivos.\n\nLembre-se sempre: o mal pode se esconder nas sombras, mas não resiste à chama purificadora da justiça. Prepare-se, caçador. A escuridão não vai esperar — e nós também não."},
    [51003]={title="Guia do Patrulheiro",o="Procure o Guia do Patrulheiro e depois Baruhr Mightmane, no Vale Cristálgida.",c="As terras selvagens das montanhas fizeram uma boa escolha, <name>. Você carrega dentro de si o espírito dos lugares elevados, e os caminhos antigos chamam seu sangue. Como Patrulheiro da Montanha, será a ponte entre os salões de pedra e os picos indomados.\n\nBem-vindo à irmandade das montanhas selvagens. Que sua pontaria seja certeira e seu caminho leve à liberdade das alturas."},
    [51005]={title="Diário de Necromancia",o="Procure o Diário de Necromancia e depois Savina Gloom, no Vale Cristálgida.",c="Você tem potencial, <name>. A morte não lhe causa medo nestes salões onde tantos ancestrais repousam, e isso é... revigorante. Como Necromante, aprenderá a trabalhar com a morte da montanha, em vez de lutar contra ela.\n\nSeu aprendizado nas artes antigas começa agora. Lembre-se: a morte não é má, apenas inevitável. Guie-a com sabedoria por estes sagrados salões de pedra."},
    [51012]={title="Mandato do Caçador",o="Procure Yiro, o Vencedor, no Vale Cristálgida.",c="A Luz guiou você até mim, <name>.\n\nEstes picos congelados podem parecer tranquilos, mas o mal se esconde em cada sombra, cada caverna e cada ruína esquecida. Como Caçador de Bruxas, você será a arma da Luz contra a corrupção. Caçará cultistas, destruirá influências demoníacas e purgará a escuridão onde quer que ela se alastre.\n\nSua fúria justa arderá até no ar mais frio das montanhas. Suas armas abençoadas abaterão o profano. Nestas terras severas, você se tornará o algoz de tudo que corrompe e destrói.\n\nBem-vindo à caçada eterna. Que o mal trema com sua chegada!"},
    [51014]={title="Manual da Morte",d="O próprio ar fica mais frio quando este manual está por perto, <name>. A morte é uma companheira constante nestas montanhas impiedosas e, depois de ver você acabar com o sofrimento daqueles lobos, talvez seja por isso que alguns aprendem a guiá-la em vez de temê-la. Trate este conhecimento com o respeito que ele merece.",o="Procure o Manual da Morte e depois Zipak Cogweight, no Vale Cristálgida."},
    [52003]={title="Vínculo Vil",o="Procure o Tirano Gros no Vale das Provas.",c="As chamas vis ardem dentro de você agora — e estão famintas. Você escolheu tornar-se Juramentado Vil, reivindicando o poder da Legião não para desafiá-lo, mas para dominá-lo. O que antes queria escravizar você agora se curva à sua vontade.\n\nComo Juramentado Vil, aprenderá a aprisionar essência demoníaca por domínio e pacto, arrancando aliados infernais da Espiral Etérea e acorrentando-os às suas ordens. Cada demônio que controla é prova de sua ascensão, uma arma forjada na própria corrupção.\n\nEste caminho não busca equilíbrio entre salvação e danação. Ele abandona essas ilusões por completo. Os sussurros vis não são tentações; são verdades, oferecendo força àqueles implacáveis o bastante para aceitá-las. Os fracos sucumbem à corrupção; os dignos a moldam.\n\nLembre-se de por que abraçou este poder: não por redenção, nem por contenção, mas por supremacia. Que o vil consuma hesitação, misericórdia e dúvida. Que suas chamas queimem o mundo até restarem apenas os fortes o bastante para resistir."},
    [52015]={title="Artes Tóxicas",o="Procure Qwi'spe, a Sábia, no Vale das Provas.",c="O equilíbrio mortal flui pelo seu entendimento! Você escolheu dominar a natureza dupla das toxinas: seu poder de ferir e o poder igualmente grande de curar quando aplicadas corretamente.\n\nComo Venomante, aprenderá a preparar venenos capazes de derrubar os inimigos mais poderosos, mas também antídotos e curas que podem salvar vidas que outros já consideram perdidas. Toda toxina tem um remédio, se alguém compreender seus princípios.\n\nEsse conhecimento traz uma responsabilidade enorme: o mesmo composto que mata uma fera corrompida pode salvar uma criança envenenada. Sua sabedoria deve decidir quando liberar a morte e quando preservar a vida.\n\nO equilíbrio natural reconhece sua compreensão. Que seus venenos encontrem os inimigos e suas curas tragam alívio aos aliados."},
    [52016]={title="Sabedoria Ancestral",o="Procure Rol'joku no Vale das Provas.",c="Os loas recebem sua nova voz no mundo mortal! Você escolheu servir como receptáculo da sabedoria ancestral, fazendo a ponte entre o reino dos espíritos e a terra dos vivos.\n\nComo Médico Bruxo, aprenderá a canalizar o poder dos loas por meio de rituais e sacrifícios, a curar com magia espiritual e a lançar mandingas sobre seus inimigos com maldições que transcendem a própria morte. Os ancestrais guiarão suas mãos tanto na bênção quanto no julgamento.\n\nEste chamado sagrado exige respeito pelos costumes antigos sem ignorar as necessidades do presente. Você deve servir como curandeiro, conselheiro e guia espiritual de seu povo, interpretando a vontade dos loas para aqueles que não conseguem ouvir suas vozes.\n\nSua magia não serve apenas a indivíduos, mas à saúde espiritual de toda a comunidade.\n\nA sabedoria ancestral recebe seu novo guardião. Que os loas guiem seus passos, e que sua magia sirva vivos e mortos com igual reverência."},
    [53015]={title="Fórmula de Veneno",c="Os venenos cantam para você, <name>. Cada toxina tem sua própria voz, seu propósito e sua terrível beleza.\n\nA Venomancia é a arte da transformação pela toxicidade. Venenos simples, que apenas matam, são brincadeira de criança: você aprenderá a preparar toxinas capazes de remodelar corpo e mente, evoluir ou regredir um ser, despertar potenciais ocultos ou selar poderes. Toda substância da natureza pode se tornar uma ferramenta em seu arsenal, do veneno da serpente mais letal à humilde picada de uma abelha.\n\nVocê dominará toxinas que agem instantaneamente ou permanecem dormentes por anos, venenos que afetam apenas linhagens ou espécies específicas e agentes que se espalham como doenças por populações inteiras. Mas a destruição é apenas metade da sua arte: você também preparará antídotos capazes de neutralizar qualquer veneno, estimulantes que concedem capacidades sobre-humanas por um tempo e mutagênicos que provocam transformações benéficas permanentes.\n\nSeu próprio corpo se tornará um laboratório vivo. Você desenvolverá imunidade às toxinas conhecidas enquanto aprende a secretar venenos pela pele, pela respiração ou até pelo olhar. Os praticantes mais avançados conseguem envenenar conceitos abstratos — corrompendo memórias, contaminando emoções ou intoxicando a própria magia. Você compreenderá a linha tênue entre remédio e veneno e como a dose determina se uma substância cura ou destrói.\n\nBem-vindo ao caminho do veneno, <name>. Que a química se torne alquimia em suas mãos!"},
    [55000]={d="Ah... este cristal... Já vi algo parecido antes, embora minhas lembranças sejam apenas fragmentos. Certa vez existiu um Altar com o poder de reforjar nosso equipamento em plena batalha. Ele nos deu a vantagem necessária para virar o rumo da guerra. Quando a guerra terminou, tentei reivindicar o Altar para a Aliança. Procurei por toda parte, mas ele havia desaparecido, escondido por aqueles que desejavam proteger seu poder. Gostaria de poder contar mais.\n\nLeve isto, herói. Uma lembrança daquela guerra há muito esquecida.\n\nMantenha-se forte, mantenha-se fiel. Pela Aliança!",o="Fale com o Marechal de Campo Afrasiabi para receber uma Ficha de Reforja."},
    [55001]={d="Ah... este cristal... Já vi algo parecido antes, embora minhas lembranças sejam apenas fragmentos. Certa vez existiu um Altar com o poder de reforjar nosso equipamento em plena batalha. Ele nos deu a vantagem necessária para virar o rumo da guerra. Quando a guerra terminou, tentei reivindicar o Altar para a Horda. Procurei por toda parte, mas ele havia desaparecido, escondido por aqueles que desejavam proteger seu poder. Gostaria de poder contar mais.\n\nLeve isto, herói. Uma lembrança daquela guerra há muito esquecida.\n\nMantenha-se forte, mantenha-se fiel. PELA HORDA!",o="Fale com o Suserano Runthak para receber uma Ficha de Reforja."},
    [77728]={title="Magias Antigas dos Centauros",d="Nosso clã já teve acesso a uma magia antiga que permitia aos nossos guerreiros controlar os ventos de Desolação para abater nossos inimigos. Procuramos esse conhecimento ancestral, mas nunca conseguimos recuperá-lo.\n\nVocê nos ajudou a superar nossos adversários e a tornar Desolação mais segura. Talvez também consiga recuperar o conhecimento perdido e nos devolver o acesso a essas magias.",o="Obtenha a Tábua Antiga dos Gelkis."},
    [77729]={title="Magias Antigas dos Centauros",d="Nosso clã já teve acesso a uma magia antiga que permitia aos nossos guerreiros controlar os ventos de Desolação para abater nossos inimigos. Procuramos esse conhecimento ancestral, mas nunca conseguimos recuperá-lo.\n\nVocê nos ajudou a superar nossos adversários e a tornar Desolação mais segura. Talvez também consiga recuperar o conhecimento perdido e nos devolver o acesso a essas magias.",o="Obtenha a Tábua Antiga dos Gelkis."},
    [77836]={d="Você está se tornando um caçador e tanto. Uma coisa é derrubar a presa quando consegue se aproximar sem ser visto. Outra bem diferente é caçar em campo aberto...\n\nMate 15 Basiliscos Sal-gema ao redor da Cratera de Weazel, nos Baixios Cintilantes.",o="Mate 15 Basiliscos Sal-gema."},
    [77872]={d="Descrição da missão.",o="Mate Azuregos e o Senhor da Perdição Kazzak."},
    [77873]={d="Descrição da missão.",o="Descrição do registro."},
    [77911]={title="Decifrando os Símbolos",d="UMA NOTA? Tudo que ele tinha era... uma nota? Nem conseguimos ler isto; está em dracônico. Leve-a ao Capitão Thalo'thas Brightsun. Ele é um velho conhecido meu. Tenho certeza de que vai nos ajudar com este \"problema\".\n\nDa última vez que ouvi falar dele, estava tentando se afogar em bebida em Vila Catraca.\n\nE nem pense em tentar algum truque comigo. Estarei de olho.",o="Fale com o Capitão Thalo'thas Brightsun."},
    [81285]={d="Você ficou mais forte, herói. Quase sinto que desta vez não estou mandando você para uma missão suicida... quase.\n\nO Arcanista Doan ainda tem multas atrasadas da biblioteca. É totalmente inaceitável. Vá ao Monastério Escarlate e aplique a punição justa e perfeitamente razoável dele: a morte.",o="Entre no Monastério Escarlate e mate o Arcanista Doan."},
    [81289]={d="Estou começando a achar que você tem futuro. Quer provar que estou certo?\n\nEsta não veio dos meus superiores, mas... você não vai acreditar! Um centauro chamou minha mãe de gorda! Já sei a vingança perfeita. Viaje até Maraudon... e mate a mãe dele! É a gorda. Assim ele aprende.",o="Entre em Maraudon e mate a Princesa Theradras."},
    [81308]={title="Raide de Caminhada Temporal: Zul'Aman",d="Os trolls da floresta Amani são conhecidos por seus ataques ousados. Zul'jin é o Senhor da Guerra responsável pelas investidas contra Quel'Thalas, mesmo depois de os trolls terem sido devastados pelos altos elfos. Agora ele volta a reunir seu exército em Zul'Aman. Não se engane... se Zul'jin voltar a atacar, as consequências serão devastadoras. Mate Zul'jin! Sem seu Senhor da Guerra, o exército troll deixará de representar uma ameaça.",o="Derrote Zul'jin!"},
    [81333]={d="Bravo herói, chegou a hora de atacar o coração do poder do Flagelo. Kel'Thuzad, senhor lich e braço direito do Lich Rei, reside em Naxxramas, de onde orquestra horrores incontáveis contra nosso mundo.\n\nPrecisamos pôr fim à existência vil dele e devolver a esperança às terras assoladas pela peste. Reúna seus aliados, invada Naxxramas e elimine Kel'Thuzad de uma vez por todas.",o="Ponha fim a Kel'Thuzad!"},
    [85007]={d="<Você encontra uma nota amassada, enfiada às pressas em um diário.>\n\nTheladrin,\n\nEu... eu sei que você disse para eu não ir, mas não consigo mais ignorar. Os sussurros... a mata... estão gritando, e há algo errado. Consigo sentir no peito, nos ossos...\n\nPreciso ver com meus próprios olhos. Eu... vou tomar cuidado, prometo. Vou correr ao primeiro sinal de perigo. Eu só... não consigo ficar sem fazer nada.\n\nSe você não tiver notícias minhas em breve... por favor... não se culpe. Eu... eu precisava tentar...\n\n<Algo terrível pode ter acontecido aqui. Talvez seja melhor investigar antes que seja tarde demais...>",o="Investigue a área próxima em busca do Zelador Desaparecido.",c="A Alta-sacerdotisa mandou você...?\n\nAh, graças a Eluna... Eu... eu não achei que alguém viria... Eu... eu pensei... pensei que fosse morrer aqui!"},
    [85008]={title="Preso na Escuridão",o="Escolte o Zelador Dalenian até um local seguro nos Remanescentes de Thel'dralor.",p="Hm?"},
    [92000]={c="Pelos deuses... Nunca pensei que voltaria a ver um Dente Imaculado de Verme da Areia. Isto é realmente extraordinário. O poder que ele contém... é quase palpável. Já vi um antes, sim, mas não ouso falar sobre isso aqui. Precisamos agir com cuidado, pois este dente é a chave para um segredo antigo e perigoso."},
    [100073]={p="Como estão as coisas por lá? Conseguiu pôr as mãos em alguma daquelas caixas?"},
    [100080]={title="Uma Troca \"Justa\"",d="Olá, mortal... Se algum dia quiser resgatar uma alma abandonada das profundezas da Espiral Etérea, saiba que não precisa procurar além de mim, o grande Belpix!\n\nSou benevolente, mas não sou instituição de caridade... Traga-me Sangue Vil das forças caídas da Legião e uma Pedra de Ressurreição.\n\nAh, e acrescente umas mil moedas de ouro e estaremos combinados! Preciso disso para, hã... para a troca! Isso, a troca...",o="Volte até Belpix com 250 unidades de Sangue Vil, uma Pedra de Ressurreição e 1.000 moedas de ouro."},
    [100504]={title="Garras de Makrinni ao Vapor",o="Jinx Swiftchop quer que você obtenha os seguintes itens:\n\n10 Garras de Makrinni. Elas podem ser obtidas de qualquer makrinni, inclusive dos arkkoran, em Azshara.\n\n10 Especiarias Goblin. Você pode comprá-las com Jinx ou com qualquer cozinheiro respeitável de uma cidade goblin.\n\nReúna todos os itens e volte até Jinx.",p="Como vai a lição? Está aprendendo todos os pontos do B.O.O.M.?"},
    [149068]={title="Vila Brisabela",d="Relatos preocupantes estão surgindo nos arredores destas matas. Eu pretendia viajar até Vila Brisabela para avaliar a situação, mas preciso permanecer aqui e cuidar dos aprendizes afetados.",o="As notícias vindas da torre são realmente preocupantes. Parece que precisarei ficar aqui por mais algum tempo. Viaje até Vila Brisabela em meu lugar e descubra o que está acontecendo."},
    [149181]={d="Stony Tark permanece como sentinela inabalável no limiar da grandeza, Guardião das Provas e Mestre de Cerimônias. As Provas são modos de jogo personalizáveis que alteram profundamente a dificuldade da sua experiência e oferecem diversas recompensas cosméticas e de aparência."},
    [149182]={d="Stony Tark permanece como sentinela inabalável no limiar da grandeza, Guardião das Provas e Mestre de Cerimônias. As Provas são modos de jogo personalizáveis que alteram profundamente a dificuldade da sua experiência e oferecem diversas recompensas cosméticas e de aparência."},
    [172000]={d="O Inquisidor Caleras, o General Cerulean e o Belígero Goredrak estão entre os tenentes mais leais e formidáveis de Malygos, encarregados de proteger as linhas ley que convergem no Nexus. Eles garantem o domínio da Revoada Azul sobre as energias mágicas do mundo e impulsionam o plano destrutivo de seu mestre.\n\nHerói, a própria essência de Azeroth está em risco. Entre nas profundezas de Coldarra e derrote o Inquisidor Caleras, o General Cerulean e o Belígero Goredrak. Ao eliminar esses guardiões, você enfraquecerá o controle de Malygos sobre as linhas ley e ajudará a preservar o delicado equilíbrio mágico que sustenta nosso mundo.",o="Derrote o Inquisidor Caleras, o General Cerulean e o Belígero Goredrak em Coldarra para enfraquecer o controle de Malygos sobre as linhas ley e proteger o equilíbrio da magia em Azeroth.",c="Herói, seus esforços desferiram um golpe significativo contra o controle de Malygos sobre as linhas ley, preservando o equilíbrio da magia. Em reconhecimento ao seu serviço a Azeroth, você receberá uma recompensa por sua dedicação."},
    [172001]={d="Recentemente, a energia arcana dentro do Nexus começou a transbordar para a região ao redor, fazendo o próprio tecido da realidade se deformar. Isso deu origem a entidades poderosas e instáveis conhecidas como Serpentes Arcanas, criaturas mágicas impregnadas de energia arcana bruta.\n\nHerói, as energias descontroladas dessas serpentes ameaçam a estabilidade das linhas ley e o equilíbrio mágico de Azeroth. Viaje até Coldarra e enfrente essas criaturas voláteis. Ao derrotá-las, você ajudará a restaurar a integridade das linhas ley e evitará uma catástrofe ainda maior.",o="Mate Serpentes Arcanas em Coldarra para impedir que as energias arcanas descontroladas desestabilizem as linhas ley e prejudiquem o equilíbrio mágico de Azeroth.",c="Herói, sua vitória sobre as Serpentes Arcanas ajudou a restaurar o equilíbrio das linhas ley e evitou um desastre em potencial. Por sua dedicação à preservação da magia de Azeroth, você será devidamente recompensado."},
    [172002]={d="Para manter o controle sobre as linhas ley e o Nexus, Malygos posicionou uma legião de Vigilantes do Nexus por toda Coldarra. Essas criaturas foram encarregadas de proteger as linhas ley e eliminar qualquer intruso que ouse desafiar o domínio da Revoada Azul.\n\nHerói, os Vigilantes do Nexus são parte vital do controle de Malygos sobre as energias arcanas de Azeroth. Viaje até Coldarra e derrote-os para enfraquecer o domínio de Malygos sobre as linhas ley e ajudar a preservar o equilíbrio mágico essencial ao nosso mundo.",o="Mate os Vigilantes do Nexus em Coldarra para enfraquecer o controle de Malygos sobre as linhas ley e proteger o equilíbrio mágico de Azeroth.",c="Herói, seu triunfo sobre os Vigilantes do Nexus desferiu um golpe importante no domínio de Malygos sobre as linhas ley. Em reconhecimento ao seu serviço a Azeroth, você receberá uma recompensa por sua dedicação e coragem."},
    [172003]={title="Coldarra: Inclinando a Balança",d="No coração de Coldarra, Malygos, o Tecelão de Feitiços, continua sua tentativa de tomar para si as energias arcanas de Azeroth. Sua legião de Draconídeos Cobalto atua como tropa de linha de frente no esforço para dominar as linhas ley.\n\nAs escamas encantadas desses draconídeos contêm poderosas energias arcanas capazes de se opor à influência de Malygos sobre as linhas ley. Se conseguirmos aproveitar esse poder, talvez possamos preservar o equilíbrio da magia em Azeroth.\n\nHerói, aventure-se pelas terras congeladas de Coldarra e obtenha Escamas de Dragão Cobalto dos Draconídeos Cobalto. Assim, você ajudará a inclinar a balança a nosso favor e a proteger o equilíbrio mágico que sustenta nosso mundo.",o="Colete Escamas de Dragão Cobalto dos Draconídeos Cobalto em Coldarra para combater a influência de Malygos sobre as linhas ley e proteger o equilíbrio da magia em Azeroth.",p="Colete Escamas de Dragão Cobalto dos Escamaflagelo Cobalto, Tecemagos Cobalto e Navalhas Cobalto derrotados em Coldarra. Essas escamas encantadas contêm poderosas energias arcanas que podem combater a influência de Malygos sobre as linhas ley.",c="Herói, as Escamas de Dragão Cobalto que você trouxe nos deram os meios para combater a influência de Malygos sobre as linhas ley. O equilíbrio da magia em Azeroth está um passo mais perto de ser protegido. Por sua dedicação e serviço, você receberá uma recompensa."},
    [172004]={d="As energias arcanas de Coldarra possuem enorme potencial para o bem ou para o mal, dependendo de quem as controla. Para proteger o equilíbrio mágico de Azeroth, precisamos estudar e compreender as forças que Malygos, o Tecelão de Feitiços, tenta manipular.\n\nPara aprendermos mais, reúna quatro itens espalhados pela ilha: um Dragão do Nexus, Mana Cristalizada Potente, uma Casca Antiga Vinculada à Magia e um Relatório Geológico. Esses objetos contêm informações e energias valiosas que podem nos ajudar a elaborar uma estratégia contra os planos de Malygos.\n\nHerói, o futuro do equilíbrio mágico de Azeroth depende disso. Reúna os itens e ajude-nos a desvendar os mistérios das linhas ley e das forças arcanas de Coldarra.",o="Encontre e obtenha o Dragão do Nexus, a Mana Cristalizada Potente, a Casca Antiga Vinculada à Magia e o Relatório Geológico em Coldarra para estudarmos as forças arcanas da região e protegermos o equilíbrio da magia em Azeroth.",p="Herói, os itens que você reuniu nos forneceram conhecimento inestimável sobre as forças arcanas de Coldarra. Com essas informações, podemos tomar medidas para proteger o equilíbrio da magia em Azeroth. Por sua dedicação e serviço, você será recompensado.",c="Herói, os itens que você reuniu nos forneceram conhecimento inestimável sobre as forças arcanas de Coldarra. Com essas informações, podemos tomar medidas para proteger o equilíbrio da magia em Azeroth. Por sua dedicação e serviço, você será recompensado."},
    [172005]={d="Herói, robôs defeituosos perderam o controle e estão espalhando caos e destruição pelos Campos de Gêiseres. Eles foram projetados para operações de mineração, mas a perturbação de energia na região causou falhas em seus sistemas. Precisamos que você elimine as máquinas descontroladas e garanta a segurança das comunidades e de nossas operações de mineração. Atenderá ao chamado?",o="Robôs defeituosos tomaram os Campos de Gêiseres e estão causando destruição. Elimine a ameaça e torne a região segura novamente.",c="Muito bem, herói. Ao eliminar os robôs descontrolados dos Campos de Gêiseres, você devolveu paz e estabilidade à região. As comunidades locais e nossas operações de mineração podem trabalhar novamente sem medo. Obrigado por atender ao chamado."},
    [172006]={d="Herói, interceptamos informações de que os Mecagnomos do Biela estão realizando experimentos nos Campos de Gêiseres da Tundra Boreana. Nossas fontes acreditam que eles descobriram uma nova tecnologia potencialmente perigosa. Precisamos impedir que esse conhecimento seja usado contra nós.",o="Obtenha Esquemas Estranhos dos Mecagnomos do Biela nos Campos de Gêiseres.",p="Excelente trabalho, herói! Você conseguiu obter os Esquemas Estranhos dos Mecagnomos do Biela. Agora poderemos analisá-los e preparar contramedidas para qualquer ameaça que essa tecnologia represente.",c="Você fez um trabalho excepcional, herói. Os Esquemas Estranhos que recuperou serão inestimáveis para proteger nosso povo das maquinações dos Mecagnomos do Biela. Sua coragem e habilidade ajudaram a proteger nosso futuro, e seus esforços serão devidamente recompensados."},
    [172007]={title="Campos de Gêiseres: Fonte de Energia Cristalizada",d="Herói, os Campos de Gêiseres da Tundra Boreana revelaram recentemente um recurso único que despertou o interesse de nossos engenheiros.\n\nOs Cristais de Sal Impregnados de Óleo encontrados na região possuem propriedades extraordinárias e podem ser usados para alimentar e aprimorar nossos dispositivos e armamentos.\n\nEles podem ser obtidos com o Robô-vigia 57-K nos Campos de Gêiseres da Tundra Boreana.",o="Colete 12 Cristais de Sal Impregnados de Óleo do Robô-vigia 57-K nos Campos de Gêiseres.",p="Excelente trabalho, herói! Você reuniu com sucesso 12 Cristais de Sal Impregnados de Óleo. Esses recursos serão valiosos para desenvolver tecnologia avançada e reforçar nossas defesas.",c="Seus esforços fizeram diferença, herói. Com os Cristais de Sal Impregnados de Óleo que você trouxe, nossos engenheiros poderão explorar novas formas de usar esse recurso no desenvolvimento de tecnologias para nossa luta contra as forças das trevas. Sua dedicação e coragem não serão esquecidas, e você será recompensado por sua contribuição."},
    [172503]={title="Coldarra: Inclinando a Balança",p="Texto provisório de missão diária de Wrath.",c="Texto provisório de missão diária de WotLK."},
    [175001]={o="Participe da reunião dos nobres.",p="Lidar com essas pessoas é tedioso e exaustivo...",c="<A derrota está estampada nos olhos lacrimejantes do velho.>\n\nSeria necessário um milagre para convencer este bando de covardes a tomar a iniciativa uma única vez. Você ouviu: enquanto Lady Serenya Coldmere, a última de seu nome, se recusar a pedir ajuda formalmente — e ela nunca pedirá —, a Casa dos Nobres não intervirá.\n\nO sangue do meu povo manchará as mãos deles, mas não as minhas. Não ficarei sentado sem fazer nada enquanto Scadeald definha."},
    [175007]={title="Feridas, Cicatrizes e Sangramento",o="Apresente-se a Sir Draewyn na sala do trono de Graysky.",c="Veio recomendado por Lady Serenya, então?\n\n<Draewyn parece ser o tipo de homem que não precisa elevar a voz para impor respeito. Seus olhos cinzentos analisam você da cabeça aos pés.>\n\nScadeald é generosa em duas coisas: chuva e problemas. A Luz sabe que precisamos de toda ajuda que pudermos reunir. Muito bem! Você parece competente. Dedicado. Já é mais do que posso dizer da maioria daqui!"},
    [175015]={title="A Purga do Fosso Lodoso",d="O covil dos troggs fica do outro lado do rio congelado, além da ponte.\n\n<Uma determinação febril toma conta de Diallos.>\n\nMate quantos puder. Extermine-os. Esmague seus crânios! Perfure-os com sua lâmina! Triture os ossos deles com sua—!\n\n<Um acesso de tosse põe fim ao ímpeto de Diallos. A secreção que ele cospe sobre a neve está manchada de sangue.>\n\nMostre a eles a mesma misericórdia que demonstraram aos meus companheiros.",o="Derrote os troggs do Fosso Lodoso.",p="Que a Luz guie os cruzados onde quer que estejam. Conseguiu encontrá-los?"},
    [175018]={title="Violência na Estrada",d="<Gotas de suor se formam na testa do mercador enquanto ele tenta encontrar as palavras. Seus pulsos carregam marcas de cordas apertadas; claramente foi mantido prisioneiro.>\n\nMinha carroça... minhas mercadorias... meu pobre burro, Tito... Tudo destruído. Que desastre...\n\nGraças à Luz a guarda chegou a tempo e conseguiu espantar aqueles canalhas antes que me deixassem no mesmo estado que Tito.\n\n<O mercador observa a carroça saqueada, com os ombros caídos.>\n\nNão vou conseguir me recuperar disso... investi tudo o que tinha nessas mercadorias. Por favor, ajude-me! Encontre o esconderijo daqueles bandidos e recupere os itens que roubaram.",o="Recupere as mercadorias roubadas no norte da Floresta de Elwynn, dentro da Caverna Pedrafunda."},
    [175021]={title="Erva-anzol para os Feridos",d="Malditos murlocs... ainda vou me vingar!\n\n<Os ferimentos do pescador são recentes. Embora não pareçam fatais, ele precisa de cuidados antes que seu estado piore.>\n\nUm murloc me emboscou e levou a pouca pesca que eu tinha conseguido. Tive sorte de sair vivo, mas mal consigo ficar em pé. Acho que a arma dele estava envenenada...\n\nCresce neste lago uma planta que nós, pescadores, usamos para tratar ferimentos causados por peixes venenosos. Chamamos de Erva-anzol. Pode me ajudar a colher alguns brotos?",o="Colete Ervas-anzol no Lago Landen e entregue-as ao pescador ferido.",p="Aagh... por favor, não demore. Já conseguiu as plantas?"},
    [175030]={d="A receita da Torta de Dunshire leva vários ingredientes. Tenho quase tudo de que precisamos aqui, mas ainda faltam algumas coisas, guloso.\n\nVá lá fora e traga os melhores ovos das galinhas de Dunshire.\n\nE... hmm... eu poderia mandar você subir a montanha, mas será mais fácil passar na estalagem e comprar alguns litros daquele Leite Requintado dos Ventos que trazem do cume.",p="É importante que os ingredientes que você trouxer estejam frescos.",c="Temos tudo!\n\nQuer que eu comece a preparar agora ou a fome ainda não apertou, guloso?\n\nBah, que pergunta... assim que o cheiro chegar, sua boca vai começar a salivar!"},
    [175032]={title="O Medalhão Perdido",d="Você! Sim, você. Não viu um medalhão por aqui, viu?\n\n<Os ombros de Darond caem quando ele vê você negar com a cabeça.>\n\nSou o carregador desta vila e um 'amigo' dos elfos. O medalhão que perdi é minha garantia para atravessar a barreira encantada da caverna. Sem ele, não consigo fazer meu trabalho; de tempos em tempos, os elfos precisam dos meus serviços.\n\nE este é um desses momentos. Já procurei o amuleto por toda parte.\n\nPoderia me dar uma mão?",o="Encontre o amuleto mágico de Darond, o carregador de Dunshire."},
    [175033]={d="Você chegou. Ótimo. Está tudo pronto para a entrega. Pegue o medalhão; você vai precisar dele para atravessar a barreira mágica da caverna.\n\nColoque a carga nas costas e siga até o Santuário Namarien. Quando chegar, procure Haldin Greensong. Ele é o mercador do Santuário e o elfo que fez esta encomenda.\n\nFique com o pagamento. Você mereceu depois de toda a ajuda que me deu. E, se não me engano, quando vir o Vale Dourado com os próprios olhos, qualquer outra recompensa vai parecer pequena em comparação.",o="Pegue as mercadorias de Darond e atravesse a caverna até o Vale Dourado. Depois, siga ao Santuário Namarien e encontre Haldin Greensong.",c="Um rosto novo. Hm. Pelo pacote em suas costas, suponho que trouxe minha encomenda. Darond mandou você, então.\n\nMuito bem, amigo. Respire fundo e tranquilize a mente. Você não encontrará neste Santuário mal algum que não tenha trazido consigo."},
    [175034]={title="Fúria Ursina",d="Os ursos estão se tornando um problema, e a culpa é dos Ealdir. Todo aquele discurso sobre a floresta e os espíritos... Hipócritas! Eles ocupam as cavernas dos ursos e interrompem seus ciclos de hibernação...\n\nAgora as feras vagam furiosas pela mata, rondando as vilas e atacando nossas fazendas. Isso precisa acabar!\n\nA única solução a curto prazo é caçá-las. Adultos, filhotes... não podemos abrir exceções.\n\nMate quantos encontrar e traga-me as peles, para que suas mortes não sejam completamente em vão.",o="Mate os Ursos de Scadeald e leve as peles até Jornan Thalor.",c="O povo de Cresthairn agradece.\n\nA morte desses ursos trará paz à região, e suas peles fornecerão calor quando os ventos de Dun Morogh soprarem."},
    [175039]={title="O Irmão Íntegro",d="E agora? Mandaram você para me torturar? Já disse que não vou dar a vocês o prazer de me ouvir gritar.\n\n<Você reconhece no prisioneiro a descrição dada pela mulher de Cresthairn sobre um de seus dois filhos: loiro, cabelo curto, rosto barbeado. Este deve ser Cairn.>\n\n<Você explica que a mãe dele mandou você.>\n\nLouvada seja a Luz! Achei que apodreceria nesta jaula. Você precisa me tirar daqui, custe o que custar. Encontre a chave da jaula. Um dos Ealdir está com ela. Mate-o. Mate todos eles. Nenhum desses selvagens é inocente!",o="Encontre a chave da jaula de Cairn derrotando os Ealdir próximos."},
    [175042]={title="Ruídos Abaixo",o="Derrote os mortos-vivos que rondam as criptas da igreja de Cresthairn.",c="Você cuidou dos mortos-vivos?\n\nGraças à Luz! E graças ao Lorde Comandante por ter enviado você! E a você, é claro, por ter feito o trabalho.\n\nAinda não entendo como isso pôde acontecer. Que tipo de feitiço aquelas bruxas conjuraram para profanar a santidade dos túmulos e erguer seus ocupantes como mortos-vivos?"},
    [175046]={title="Pescaria do Dia: Truta",o="Pesque Trutas de Scadeald para o Comerciante Mercel.",c="Belo estoque você reuniu! Até mais do que eu esperava!\n\nPromessa é promessa, então aqui está. E, ei... se algum dia quiser trabalhar para um humilde comerciante, apareça por aqui."},
    [175049]={d="Não fique aí parado!\n\nVeio ajudar ou assistir seus companheiros sangrarem até a morte sobre a neve?\n\nEncontre um rolo de bandagem grossa entre os suprimentos de primeiros socorros e cuide dos feridos. Eles estão dando a própria vida para proteger a província e o reino. O seu reino também!\n\nAnde, rápido!",o="Procure bandagens grossas entre os suprimentos de primeiros socorros e cuide dos feridos."},
    [175050]={title="Insígnias do Sacrifício",d="A emboscada dos trolls e a batalha que veio depois tingiram a neve de vermelho. Centenas morreram: amigos, companheiros, compatriotas.\n\nAinda não conseguimos recuperar os corpos. Pelo inferno, desde então não fazemos outra coisa além de oferecer cadáveres à neve.\n\nFaça-me um favor: não vou pedir que carregue corpos, mas recupere ao menos as insígnias deles. Algo a que possamos prestar homenagem quando este pesadelo acabar, quando o último troll Jubafria tiver caído.",o="Recupere as insígnias dos soldados caídos nos arredores da Emboscada Jubafria."},
    [175064]={title="Aperitivo de Grifo",c="Quanta carne conseguiu trazer?\n\n<Bromli dá uma olhada rápida.>\n\nÓtimo, ótimo. Isto serve como aperitivo. Sim, 'aperitivo'. Não me olhe assim: eu avisei que eles comem mais do que você imagina!"},
    [175065]={title="Ninhos e Penas",d="Importa-se de me ajudar mais uma vez? Às vezes os grifos trazem itens... 'peculiares' para os ninhos, e é melhor limpar tudo antes que alguém se machuque.\n\nAgora que você tem a carne, jogue um bom pedaço para eles encherem a barriga e ficarem tranquilos. Só depois se aproxime dos ninhos.\n\nAh! E, se encontrar penas caídas, não jogue no lixo; elas têm mais utilidades do que você imagina. Traga todas as que encontrar!",o="Limpe os ninhos de grifo no Pico Daumor e colete as penas caídas."},
    [175067]={title="Seus Dias Sombrios",d="Ela está sempre em minhas orações. Ralda, pobre mulher... Está ouvindo o lamento? Deve ser um daqueles dias. Os dias sombrios dela. Metade das águas do Shadewell deve ser feita das lágrimas daquela mulher.\n\nNão há remédio para isso; perder uma filha... não é natural. Para piorar, pouco depois do que aconteceu com a menina, o marido dela foi destacado para a Vigília dos Ventos, onde monta guarda dia e noite. E ela ficou tão sozinha...\n\nPoderia me fazer uma gentileza? Leve algo para ela comer. A pobre quase nunca tem apetite e às vezes esquece de comer completamente.\n\nEla mora na casa solitária logo abaixo de nós, às margens do lago.",p="Dorothy...?",c="Dorothy...? Ah...\n\n<Ao ver o pacote de comida, você percebe a esperança desaparecer dos olhos dela.>\n\nFernad mandou você. Eu... obrigada, eu acho. Mas não tenho apetite. Não consigo ficar parada enquanto minha filha está desaparecida.\n\nPreciso encontrá-la!"},
    [175069]={title="Agarraram-na pelo Tornozelo",c="Como assim você não encontrou nada? Mas os murlocs... Dorothy...\n\n<O olhar de Ralda escurece.>\n\nEstá escondendo alguma coisa de mim? Você não ousaria! Mesmo que Dorothy não estivesse... Se ela... <Ela engole em seco, mas o nó na garganta permanece.> Prefiro saber do que viver com a incerteza.\n\nEntão diga. Porque você deve ter encontrado alguma coisa.\n\nEla ainda está viva? Por favor!\n\n<Ralda desaba em lágrimas.>"},
    [175071]={title="Os Kobolds Estão com Ela",c="Como assim você não encontrou nada? Tem certeza? Nenhum sinal de Dorothy? Impossível... Impossível... Impossível!\n\nO pai dela a puniu e a levou para a mina com os kobolds. Ela precisa estar lá!\n\nVocê não procurou direito... precisa voltar e procurar melhor. Ela tem que estar lá... em algum lugar."},
    [175079]={title="Costas Largas e Generosas",d="O exército inimigo — se é que aquilo pode ser chamado de exército — não espera um ataque pela retaguarda. Os melhores guerreiros estão na linha de frente, presos em combate com os soldados da fortaleza.\n\nSabe o que isso significa? Chegou a hora de atacar.\n\nVocê parece impaciente e, se veio até aqui, é porque está louco por uma briga. Quer liderar a investida?\n\nDerrube alguns desses soldados Rocha Negra. Meus homens e eu cuidaremos do resto. Quando terminar, apresente-se ao Comandante Moore.",o="Derrote os guerreiros orcs Rocha Negra que cercam a Fortaleza de Andraste pela retaguarda."},
    [175080]={d="Por mais rudimentar que seja a tecnologia dos orcs, uma catapulta continua sendo uma catapulta. E uma pedra grande e rápida o bastante pode causar tanto estrago quanto um canhão.\n\nPrecisamos nos livrar delas.\n\nAqui. Explosivos. Coloque-os na base quando chegar perto e mande algumas daquelas coisas pelos ares. Quando terminar, apresente-se ao Comandante Moore.",o="Destrua as máquinas de cerco dos orcs Rocha Negra."},
    [175083]={title="Não Peça Conselho aos Elfos",d="Não gosto de ver você parado aí de braços cruzados enquanto preparo as rações. Que tal uma última tarefa?\n\nOs Elfos da Nascente estão perto daqui; muito educados, muito cordiais, mas não se engane: a gentileza deles é um escudo, e a cautela, uma desculpa para ficarem longe dos nossos problemas.\n\nTalvez você tenha mais sorte do que eu.\n\nFaça uma visita a eles, sim? Peça água encantada da preciosa nascente para os nossos feridos. Eles guardam o lugar com zelo feroz, mas já passou da hora de ajudarem como todo mundo.",o="Encontre os Altos Elfos na nascente e consiga um suprimento de água encantada."},
    [175086]={o="Encontre os agentes da AVIN nos arredores do Forte Kerebor.",p="Sh..."},
    [175091]={title="Quando os Chifres Soaram",o="Encontre Darvin nas ruínas fora das muralhas da fortaleza.",c="Você... você não é um orc, é?\n\n<Darvin solta um suspiro estrondoso, como se estivesse prendendo a respiração havia horas.>\n\nPelas barbas dos meus ancestrais! Nunca fiquei tão apavorado! Quando as pedras começaram a voar e aqueles chifres de guerra soaram... achei que certamente me encontrariam."},
    [175103]={title="Semente Abençoada de um Novo Começo",d="Não esqueci o motivo que trouxe você aqui, a maldição que caiu sobre os mineiros daquela vila humana.\n\nO vale está se recuperando, e meu poder cresce. Você nos ajudou mais do que imagina. É justo que eu retribua o favor.\n\nAceite este presente.\n\n<O elfo coloca em sua mão uma semente parecida com uma pepita de ouro.>\n\nUma lembrança de minha terra natal, Quel'Thalas; a semente de uma flor que crescia perto da agora perdida Nascente do Sol e que ainda conserva seu brilho. Leve-a aos mineiros e diga que a enterrem perto da mina.\n\nQuando florescer, a maldição desaparecerá."},
    [175116]={title="A Bruxa dos Meus Pesadelos",d="A sudeste de nossa posição, escondida entre os penhascos no coração da floresta, fica a vila Ealdir de Cair Cragg, lar da bruxa Bagga Darma.\n\nVenho enfrentando a magia dela há algum tempo. Ela envia vermes, maldições e sombras para nos atormentar. Eu nos protejo como posso, invocando o poder da floresta e a proteção da Deusa.\n\nSua ajuda pode inclinar a balança a nosso favor.\n\nProcure Cair Cragg e encontre Bagga Darma. Provavelmente ela estará consumida por sua feitiçaria vil. Use isso a seu favor: pegue-a de surpresa e ponha fim à existência miserável dela.",o="Encontre e derrote a bruxa Bagga Darma na vila de Cair Cragg."},
    [175124]={c="Isto é...\n\n<Deirdre examina o anel de Lady Serenya com algo próximo de ganância. O anel é uma obra-prima como nenhuma que você já viu; só a safira incrustada nele vale mais do que todas as joias dos Ealdir juntas.>\n\nEntão você a matou. Não vai demorar para a notícia se espalhar.\n\nÓtimo. Ótimo! Agora que Serenya saiu do tabuleiro, só resta Morgwena."},
    [175129]={title="Murlocs Quillscale",c="Vejo que voltou coberto de sangue.\n\n<O anão franze o nariz quando sente o cheiro.>\n\nMurlocs? Embora... o cheiro seja diferente. Ah, bem. Suponho que você lhes deu uma bela surra. Ótimo. Que voltem choramingando para o oceano. Quanto mais longe das nossas praias, melhor. Já temos problemas suficientes por aqui."},
    [175131]={d="<Kildar faz um gesto brusco e impaciente para que você se aproxime. Seu olhar é sombrio e preocupado.>\n\nVocê disse que seu nome era <name>, certo? Sim. Ótimo. Vai servir.\n\nTenho uma missão para você. Eu mandaria meus montanheses, mas eles estão ocupados com os Jubafria, os wendigos, os javalis, os leopardos, os ursos, os lobos e...\n\n<Kildar respira fundo.>\n\nEscute com atenção: um comboio diplomático partiu recentemente de Altaforja rumo à cidade-estado de Dun Kazad. Algo deu errado. Eles sofreram uma emboscada na Estrada Sinuosa e, embora o embaixador tenha sobrevivido e conseguido seguir viagem, pediram reforços.\n\nVocê é esse reforço.",o="Investigue o local da emboscada na Estrada Sinuosa, descubra o que aconteceu e localize o Embaixador Thargas Anvilmar."},
    [175133]={title="Orgulho Lanoso",d="<O anão força a vista para se concentrar na mensagem criptografada. Depois de um bom tempo, solta um resmungo.>\n\n\"Decifrar isto vai dar mais trabalho do que eu pensava. Trabalho demais! Mas... estou disposto a fazer um acordo.\n\nEu disse que devia dinheiro ao estalajadeiro; não é bem verdade. Fizemos um trato: em troca de quitar minha dívida, eu ajudaria com algumas tarefas. Principalmente alimentar e limpar os iaques da fazenda.\n\nNão é que eu vá ficar sentado sem fazer nada! Enquanto você cuida dos iaques, eu tento decifrar esta maldita mensagem.",o="Alimente os iaques das fazendas de Nivelarn e limpe a palha suja dos estábulos.",p="Como foi com os iaques?",c="Você foi rápido! Rápido demais! Se eu soubesse, teria pedido mais alguns favores.\n\nEnfim, estou quase terminando. Dê-me só um instante; quero conferir esta tradução mais uma vez..."},
    [175145]={d="<name>, vou ficar aqui para vigiar as instalações da Metantenna, mas preciso que você conte pessoalmente a Baugwolf sobre esta sabotagem.\n\nDiga a ele que envie guardas para proteger a área e uma equipe de mecanoengenheiros para restaurar a segurança operacional da estação.\n\nEnquanto isso, vou estudar os dados armazenados no Robô-alarme. Talvez consiga descobrir por que aquele Ferro Negro queria desativar o Metrô Correfundo entre Ventobravo e Altaforja.\n\nAnde! Não temos tempo a perder!",o="Viaje até Dun Kazad e informe Baugwolf sobre os acontecimentos na Estação Metantenna."},
    [175146]={title="Forte Boreos",d="A estrada que você usou para chegar a esta cidade se desvia pouco antes dos portões de Dun Kazad e sobe ainda mais a montanha.\n\nEm nossa língua, essa trilha antiga é chamada de 'Scyldrand', o Caminho do Inverno.\n\nPreciso que alguém percorra o caminho até o Forte Boreos. Já se passaram vários dias desde a última notícia que recebemos de lá.\n\nNossos guerreiros estavam enfrentando os trolls Jubafria. É possível que estejam em sério perigo.\n\n<Baugwolf lança um olhar urgente para você.>\n\nVá.",o="Percorra o Caminho do Inverno até o Forte Boreos e apresente-se ao Capitão da Guarda Erdruin."},
    [175152]={d="Esta trilha, o Caminho do Inverno, atravessa os picos de Ealdfrost de leste a oeste.\n\nEm tempos de perigo, os anões deste reino recorrem ao Monte Moroduin, do outro lado deste vale, em busca de orientação. Não é por acaso: em eras passadas, os Titãs construíram um observatório em seu cume nevado.\n\nSeu único e último habitante há milênios é um gigante do gelo chamado Thrymus, o mais sábio de sua espécie.\n\nTemo que ele esteja em grave perigo por causa dos trolls Jubafria. E, entre nós, se existe alguém capaz de percorrer esse caminho até o fim e voltar inteiro, é você.",o="Percorra o Caminho do Inverno até o cume de Moroduin e proteja Thrymus dos trolls."},
    [175181]={title="A Congregação Cresce"},
    [175182]={title="A Congregação Cresce"},
    [175196]={title="Ambições Traiçoeiras"},
    [175198]={title="Vozes no Portão Norte"},
    [175201]={title="O Que a Mina Escondia"},
    [175206]={title="Uma Variedade de Queijos"},
    [175238]={title="Dízimo de Almas"},
    [175282]={title="Enterre-os na Neve"},
    [175350]={title="Rebanho Gentil"},
    [254005]={d="A velha Mirsinth vai falar agora. Para ela, o irmão Jun'Kon está morto há muito, muito tempo... mais morto ainda desde que expulsou a velha Mirsinth. Ela não deveria lamentá-lo, mas há sabedorias que nem a idade nem os loa conseguem ensinar...\n\nSeu ser de metal foi criado como uma ferramenta, sim? Martelo, espada, faca, mais peças... parecem magia para o povo da velha Mirsinth, mas ainda são ferramentas, sim? Uma ferramenta deveria fazer aquilo para que foi usada, cumprir seu propósito. Mas o ser de metal não é uma ferramenta.\n\nO ser de metal está vivo. Metal, sim, mas vivo. A criadora não lhe contou isso, não? Talvez nem saiba?\n\nEla é tola.\n\nEspíritos não são ferramentas. Diga isso a ela. Você não encontrará nada sem a verdade dela. Faça-a contar, e quando contar, diga que a velha Mirsinth precisa de mais informações para encontrar o ser de metal.",o="Encontre Efry Cogspark na Estalagem Stoutlager, em Thelsamar."},
    [254007]={o="Derrote Nylrisa perto do Sítio de Escavação de Bandaferro e recupere seus componentes.",p="Por favor, por favor, diga que Mirsinth conseguiu encontrar Nylrisa. Conseguiu? Então vá antes que a percamos outra vez!",c="Conseguiu? Encontrou Nylrisa? Vamos, vamos, vamos... desculpe, não estou nervosa. Só... funcionou? A troll conseguiu encontrá-la?\n\nVocê trouxe os componentes... obrigada. Seria caro substituir tudo isso. Vejamos... treco termoarcano, geringonça eletrostática, dispositivo mecanofuncional do núcleo... hmm, acho que o processador quebrou na luta. O ectoplasma também deve ter vazado; sobrou só um pouco de resíduo. Ah, bem... talvez isto tenha sido uma ideia ruim.\n\nCerto, foi definitivamente uma ideia ruim. Olha, não vou fazer isso de novo, está bem? De qualquer forma, você salvou minha vida — provavelmente no sentido literal. Muito obrigada! Se algum dia precisar que uma inventora invente alguma coisa, é só me procurar.\n\nHmm... eu jurava ter usado microengrenagens de bronze neste processador, não de cobre... ah, estou pensando demais. Vidra, quero uma daquelas bebidas agora! Na verdade, traga três!"},
    [254011]={title="Coisas Brilhantes!",o="Colete destroços metálicos.",p="Você procura coisas brilhantes? Sim, sim, sim! Volte com coisas brilhantes e talvez eu não coma você!"},
    [254013]={title="A Rosa de Avianna",o="Leve as informações que descobriu até Sakari, em Orgrimmar.",p="Ainda está aqui? Vá logo! Hoje eu não como você, mas outro dia talvez não tenha tanta sorte!"},
    [254014]={d="Bem, não sei até que ponto a história sobre a origem é verdadeira, mas ela precisa ter surgido de algum lugar. Se a flor realmente possui propriedades poderosas para remover maldições, isso faria sentido.\n\nTalvez, usando métodos alquímicos, eu consiga estender o efeito e produzir várias curas — embora ainda não sejam muitas. A flor tem apenas uma semente, mas talvez eu encontre uma forma de cultivar outras a partir dela...\n\nAh, estou me adiantando. Primeiro precisamos ter certeza de que este método funciona. Você já chegou até aqui comigo; se conseguir o cristal de que a harpia falou e me encontrar nos Sertões quando terminar, acredito que posso usar o sangue demoníaco para fazer a mistura se ligar ao nosso próprio sangue demoníaco e neutralizá-lo.",o="Encontre o Cristal de Ouru'gai nos Sertões."},
    [254032]={title="As Catacumbas de Karazhan: Rompendo as Proteções",d="Certo. Agora que ajustei a pedra-chave para que você consiga usá-la, deve ser possível simplesmente abrir a porta e entrar.\n\nMas não recomendo fazer isso sozinho. Reúna alguns aliados e entre nas catacumbas.\n\nMeu poder está praticamente esgotado, então não serei de muita ajuda daqui em diante. Ainda assim, vou projetar uma imagem minha lá dentro. Há mais algumas coisas que precisamos resolver enquanto você estiver por lá.",o="Encontre a projeção de Tabetha dentro das Catacumbas de Karazhan."},
    [254034]={title="As Catacumbas de Karazhan: Um Coração Ensanguentado",o="Derrote Cynfael nas Catacumbas de Karazhan.",c="Então a longa vida de Cynfael finalmente chegou ao fim, não é?\n\nSabia que ele nunca podia se afastar demais do próprio coração? Se a ligação fosse rompida, morreria imediatamente. Que desperdício... preso numa tumba por causa de uma busca imprudente por \"imortalidade\".\n\nNão é de admirar que os San'layn de hoje não tentem repetir a mesma coisa."},
    [254035]={title="As Catacumbas de Karazhan: O Antigo Cavaleiro da Morte",d="Antes do Lich Rei e daqueles soldados mortos-vivos que vocês jovens gostam de chamar de \"Cavaleiros da Morte\", esse nome significava outra coisa, sabia?\n\nDurante a Segunda Guerra, Gul'dan colocou as almas dos bruxos mortos do Conselho das Sombras nos cadáveres de cavaleiros da Irmandade do Cavalo. Como assim você não reconhece esses nomes? Não ensinam nem um livro de história aos aventureiros antes de mandá-los para missões perigosas? Este mundo está perdido, e essa é a verdade!\n\nEnfim, não estou aqui para dar aula sobre a Segunda Guerra. Você pode descobrir isso sozinho. Um desses cavaleiros acabou enfrentando Aegwynn. Ela havia sido privada da maior parte de sua magia, mas acredite: um mago realmente habilidoso continua sendo um adversário terrível mesmo sem seus feitiços.\n\nEla conseguiu atraí-lo para perto das catacumbas e ativou as proteções para aprisionar sua alma lá dentro. Provavelmente ele ainda procura um hospedeiro adequado até hoje. Acabe com essa alma de uma vez por todas, antes que consiga outro corpo.",o="Derrote Kurgoth Doomreaver nas Catacumbas de Karazhan."},
    [254036]={title="As Catacumbas de Karazhan: O Julgamento dos Pecadores",d="Aegwynn pouco queria saber dos problemas da cidade abaixo, mas as pessoas tendem a tratar como líder qualquer maga poderosa que more numa torre enorme, queira ela ou não. Isso fica especialmente perigoso quando essa maga está paranoica e sob a influência de Sargeras — como era o caso, se você não sabia.\n\nEla passou a punir qualquer crime com os destinos mais cruéis. Os condenados eram pendurados de cabeça para baixo em uma piscina nas catacumbas; seus corpos se afogavam, mas suas almas permaneciam seladas para sempre. Talvez não fossem exemplos de virtude, mas nenhum deles merecia um fim desses.\n\nJá que estará lá embaixo, finalmente liberte essas almas. Tenho certeza de que dará um jeito. Só tome cuidado: depois de tantos anos, duvido que estejam de bom humor.",o="Enfrente o Julgamento dos Pecadores nas Catacumbas de Karazhan."},
    [254037]={d="Aquela armadura amaldiçoada finalmente foi destruída... nunca imaginei que veria este dia.\n\nTenho certeza de que meu nome já não significa nada para o mundo lá de cima. Afinal, quem se lembraria de um herói fracassado? Não há motivo para se lembrar de mim.\n\nMesmo assim, peço que ouça minha história. Ao menos assim compreenderá que a sombra presa àquela armadura não foi quem eu sempre fui.",o="Ouça a história de Takan Velor.",p="Você não me deve nada. Vou entender se decidir voltar."},
    [254046]={title="Subterfúgio na Parada",d="Argh! Alguém roubou minha Chave de Arco Voltaico, e tenho quase certeza de que foi um daqueles goblins sebosos lá do Circuito da Ilusão.\n\nAposto que aquele tagarela do Pozzik sabe de alguma coisa. As orelhas enormes dele estão sempre metidas nos assuntos dos outros. Vá até lá e descubra se ouviu alguma coisa.\n\nSó não deixe que ele faça você ficar andando em círculos.",o="Tibbi Fizzcrank quer que você descubra quem levou suas ferramentas. Pozzik, no Circuito da Ilusão, provavelmente sabe de alguma coisa."},
    [254055]={title="Um Petisco para um Cão das Trevas",d="Você ainda parece um pouco nervoso. Não se preocupe, ele não morde... a menos que eu mande.\n\nCerto, faça o seguinte para conquistar um pouco da confiança dele. Ele gosta muito daqueles morcegos-cinzentos. Na verdade, demorou para eu treiná-lo a não sair correndo atrás deles toda vez que um passava pelo acampamento.\n\nTenho visto um bem grande a leste e estava pensando em caçá-lo para ele. Já que você está aqui, por que não vai encontrá-lo e traz um pedaço para o meu cão?",o="Encontre um petisco e ofereça-o ao Cão das Trevas de Edwin."},
    [254057]={d="Pronto. Está feito. Com isto, a Cruzada Escarlate nem perceberá que perdeu até ser tarde demais.\n\nAgora falta apenas levar a mistura até eles sem levantar suspeitas. Era para isso que servia a cabeça do tenente.\n\nPreparei um elixir que fará você parecer exatamente com ele. Deve conseguir entrar no Monastério Escarlate sem muita dificuldade. Só não chegue perto demais de ninguém se puder evitar, e continue andando. O disfarce não é perfeito, mas, desde que você não faça nenhuma idiotice, ficará bem.\n\nE nem pense em começar uma briga. Os guardas do monastério não são como os daquele acampamento. Eles podem espalhar suas entranhas pela grama com um único golpe. Se descobrirem que você não é o tenente, não vão hesitar em provar isso.",o="Use o Elixir de Transformação de Ralden para se infiltrar no pátio do Monastério Escarlate e contaminar os suprimentos da Cruzada."},
    [254065]={title="Noite do Eclipse"},
    [254091]={title="Que Possamos nos Reencontrar"},
    [255017]={title="Cegando os Presa do Dragão"},
    [255019]={title="Batalha na Ponte"},
    [255029]={title="A Corrupção dos Altaneiros"},
    [255091]={title="Stromgarde Caiu"},
    [255094]={title="O Legado de Strom"},
    [255116]={title="Recuperando o Moinho de Alther"},
    [1005367]={title="Falta de Suprimentos: Pedra de Amolar Grosseira"},
    [1008023]={title="Contrato de Demônio: Ouça-os Cair"},
    [1008025]={title="Contrato de Demônio: Queda dos Invernosos"},
    [1100039]={title="Guerreiro: Pergaminhos Místicos"},
    [1100059]={title="Guerreiro: Pergaminhos Místicos"},

    -- Encomendas de profissão do Ascension. Este bloco tinha muito espanhol,
    -- portunhol e nomes de item diferentes entre título, diário e rastreador.
    [1005645]={title="Fazendo a Carne Render: Carne Temperada de Lobo",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 20 Carne Temperada de Lobo para conseguirmos atender à demanda.",o="Colete 20 Carne Temperada de Lobo.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},
    [1005646]={title="Fazendo a Carne Render: Bife de Coiote",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 10 Bifes de Coiote para conseguirmos atender à demanda.",o="Colete 10 Bifes de Coiote.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},
    [1005647]={title="Fazendo a Carne Render: Bolinho de Caranguejo",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 10 Bolinhos de Caranguejo para conseguirmos atender à demanda.",o="Colete 10 Bolinhos de Caranguejo.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},
    [1005648]={title="Fazendo a Carne Render: Costelinhas Suínas Ressecadas",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 10 Costelinhas Suínas Ressecadas para conseguirmos atender à demanda.",o="Colete 10 Costelinhas Suínas Ressecadas.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},
    [1005649]={title="Fazendo a Carne Render: Mariscos Fervidos",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 10 Mariscos Fervidos para conseguirmos atender à demanda.",o="Colete 10 Mariscos Fervidos.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},
    [1005650]={title="Fazendo a Carne Render: Mariscos Recheados à Moda Goblínica",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 10 Mariscos Recheados à Moda Goblínica para conseguirmos atender à demanda.",o="Colete 10 Mariscos Recheados à Moda Goblínica.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},
    [1005651]={title="Fazendo a Carne Render: Linguiça de Aranha",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 15 Linguiças de Aranha para conseguirmos atender à demanda.",o="Colete 15 Linguiças de Aranha.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},

    [1005652]={title="Finalizando os Curativos: Bandagem de Linho Grossa",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 20 Bandagens de Linho Grossas para ajudar a repor nosso estoque.",o="Colete 20 Bandagens de Linho Grossas.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005653]={title="Finalizando os Curativos: Bandagem de Lã",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 40 Bandagens de Lã para ajudar a repor nosso estoque.",o="Colete 40 Bandagens de Lã.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005654]={title="Finalizando os Curativos: Bandagem Grossa de Lã",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 20 Bandagens Grossas de Lã para ajudar a repor nosso estoque.",o="Colete 20 Bandagens Grossas de Lã.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005655]={title="Finalizando os Curativos: Bandagem de Seda",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 30 Bandagens de Seda para ajudar a repor nosso estoque.",o="Colete 30 Bandagens de Seda.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005656]={title="Finalizando os Curativos: Bandagem Grossa de Seda",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 15 Bandagens Grossas de Seda para ajudar a repor nosso estoque.",o="Colete 15 Bandagens Grossas de Seda.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005657]={title="Finalizando os Curativos: Antipeçonha",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 10 Antipeçonhas para ajudar a repor nosso estoque.",o="Colete 10 Antipeçonhas.",c="Perfeito. Com esse material, nosso estoque volta a ficar em ordem."},
    [1005658]={title="Finalizando os Curativos: Bandagem de Magitrama",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 20 Bandagens de Magitrama para ajudar a repor nosso estoque.",o="Colete 20 Bandagens de Magitrama.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005659]={title="Finalizando os Curativos: Bandagem Grossa de Magitrama",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 10 Bandagens Grossas de Magitrama para ajudar a repor nosso estoque.",o="Colete 10 Bandagens Grossas de Magitrama.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005660]={title="Finalizando os Curativos: Bandagem de Runatrama",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 40 Bandagens de Runatrama para ajudar a repor nosso estoque.",o="Colete 40 Bandagens de Runatrama.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005661]={title="Finalizando os Curativos: Bandagem Grossa de Runatrama",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 20 Bandagens Grossas de Runatrama para ajudar a repor nosso estoque.",o="Colete 20 Bandagens Grossas de Runatrama.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},

    [1005662]={title="Por um Fio: Boca-negra Oleoso",o="Colete 7 Boca-negras Oleosos."},
    [1005663]={title="Por um Fio: Vermelhão Cru",o="Colete 10 Vermelhões Crus."},
    [1005664]={title="Por um Fio: Sabichão Cru",o="Colete 10 Sabichões Crus."},
    [1005665]={title="Por um Fio: Pargo-de-fogo",o="Colete 7 Pargos-de-fogo."},
    [1005666]={title="Por um Fio: Pargo-da-noite Cru",o="Colete 7 Pargos-da-noite Crus."},
    [1005667]={title="Por um Fio: Parrudo Lustroso Cru",o="Colete 10 Parrudos Lustrosos Crus."},
    [1005668]={title="Por um Fio: Bacalhau Escama-de-pedra Cru",o="Colete 10 Bacalhaus Escama-de-pedra Crus."},
    [1005669]={title="Por um Fio: Enguia Petrescama",o="Colete 6 Enguias Petrescama."},
    [1005670]={title="Por um Fio: Sabichão Maior Cru",o="Colete 10 Sabichões Maiores Crus."},
}

-- Revisao extra: nomes tortos, textos custom e restos de espanhol.
local function QuestFix(id, patch)
    local row = P[id]
    if not row then row = {}; P[id] = row end
    for k, v in pairs(patch) do row[k] = v end
end

QuestFix(265, {title="A busca sombria continua"})
QuestFix(269, {title="Em busca da sabedoria"})
QuestFix(284, {title="A busca continua"})
QuestFix(305, {title="Em busca da equipe de escavação"})
QuestFix(306, {title="Em busca da equipe de escavação"})
QuestFix(315, {title="A cerveja perfeita"})
QuestFix(467, {title="A busca de Marchapedra"})
QuestFix(727, {title="Em busca do Compêndio de Yagyin em Altaforja"})
QuestFix(728, {title="Em busca do Compêndio de Yagyin na Cidade Baixa"})
QuestFix(768, {title="Coletando couro"})
QuestFix(812, {title="Em busca da cura"})
QuestFix(813, {title="Em busca do antídoto"})
QuestFix(1437, {title="A busca de Vahlarriel"})
QuestFix(1438, {title="A busca de Vahlarriel"})
QuestFix(1439, {title="Em busca de Tyranis"})
QuestFix(1442, {title="Em busca da Gema Kor"})
QuestFix(1448, {title="Em busca do templo"})
QuestFix(1465, {title="A busca de Vahlarriel"})
QuestFix(1921, {title="Coletando materiais"})
QuestFix(1961, {title="Coletando materiais"})
QuestFix(2205, {title="Em busca da AVIN"})
QuestFix(2759, {title="Em busca de Galvan"})
QuestFix(2939, {title="Em busca de conhecimento"})
QuestFix(3841, {title="Um órfão em busca de um lar"})
QuestFix(4736, {title="Em busca de Menara Nihila"})
QuestFix(4737, {title="Em busca de Menara Nihila"})
QuestFix(4738, {title="Em busca de Menara Nihila"})
QuestFix(4739, {title="Em busca de Menara Nihila"})
QuestFix(5722, {title="Em busca da algibeira perdida"})
QuestFix(8924, {title="Caçando ectoplasma"})
QuestFix(8982, {title="Rastreando a fonte"})
QuestFix(8983, {title="Rastreando a fonte"})
QuestFix(9026, {title="Rastreando a fonte"})
QuestFix(9027, {title="Rastreando a fonte"})
QuestFix(9476, {title="Em busca de Barbapena"})
QuestFix(9565, {title="Vasculhe a Aldeia de Pinhoquieto"})
QuestFix(10290, {title="Em busca de faralita"})
QuestFix(10316, {title="Em busca de evidências"})
QuestFix(10435, {title="Recuperando a mercadoria"})
QuestFix(10849, {title="Em busca de Kirrik"})
QuestFix(10958, {title="Em busca dos Grislíngua"})
QuestFix(11082, {title="Em busca da verdade"})
QuestFix(12102, {title="Em busca da lilás-rubi"})
QuestFix(12234, {title="Precisamos saber"})
QuestFix(12595, {title="Em busca de uma caça maior"})
QuestFix(12902, {title="Em busca de respostas"})
QuestFix(12949, {title="Em busca da chave"})
QuestFix(13273, {title="Em busca do núcleo"})
QuestFix(354126, {title="Rechaçando as forças invasoras dos Grislíngua"})
QuestFix(499998, {title="Em busca de coelhos"})
QuestFix(1650012, {title="Em busca do mago"})
QuestFix(1660014, {title="Em busca da carne boa"})

QuestFix(1652, {c="Então, nos encontramos novamente, $n, e vejo que está de ótimo humor.\n\nA casa dos Stilwell ficará segura por mais um dia e, pelo que me contou, não faltou perigo. Muito bem.\n\nDafne e Jardel ajudaram muito a Igreja, e o mínimo que podíamos fazer era proteger a propriedade deles — e suas próprias vidas.\n\nPor sua bravura, você será recompensado."})
QuestFix(1778, {c="Então voltou tão rápido, hein? E o que conseguiu fazer nesse tempo?\n\nConseguiu ajudar uma causa nobre? Talvez tenha aprendido o valor da caridade ou um pouco mais sobre suas obrigações com os habitantes de Azeroth. Conte-me quem ajudou e como...\n\nImpressionante, $n. Essas são, sem dúvida, ações de alguém que segue o caminho da Luz.\n\nEsse tipo de sacrifício sempre é recompensado com o tempo."})
QuestFix(1820, {c="Sim, é verdade. Preciso da sua perícia em combate. Meus recursos são poucos, mas minha tarefa serve tanto aos meus interesses quanto à causa dos Renegados. Faça isso e sua recompensa será dobrada."})
QuestFix(1920, {p="Você capturou as criaturas, $n? Elas precisam ser estudadas para descobrirmos o motivo de sua chegada."})
QuestFix(1960, {p="Você investigou o distúrbio, $n? Conseguiu capturar as criaturas?",c="Muito bem, $n. As criaturas dentro desses cofres de contenção serão estudadas por nossas melhores mentes, e descobriremos o motivo da presença delas na Cidade Baixa.\n\nSe o aparecimento delas foi causado por uma fenda no fluxo natural da magia, precisamos descobrir se essa fenda surgiu ao acaso. Caso tenha sido provocada por alguma força mágica, teremos de nos preparar para distúrbios ainda mais graves."})
QuestFix(2203, {d="Você tem sido de grande ajuda, $c. Eu lhe daria como recompensa a própria receita da bebida que ofereci antes... mas primeiro tenho uma tarefa bastante perigosa. Ouça meu pedido.\n\nEste cofre contém três Recipientes de Taumaturgia Vazios. Eles estão imbuídos de uma aura de harmonização capaz de drenar o sangue de um Dragão Guardião Calcinado. Usar um recipiente na criatura a deixará extremamente furiosa, então tome cuidado. Assim que encher os três, traga-os para mim.\n\nFaça isso e a receita será sua.",p="Conseguiu usar os recipientes para obter o sangue dos Dragões Guardiões Calcinados de que preciso? Sim, sei que é perigoso... mas a receita da minha bebida restauradora espera por você. Risco e recompensa, $gamigo meu:amiga minha;... risco e recompensa...",c="De um alquimista para outro, eu o saúdo. Pegue esta receita e aprenda-a. Que ela lhe traga o mesmo sucesso e as mesmas recompensas que me trouxe ao longo dos anos."})
QuestFix(11209, {c="Nada mal, mas, se eu fosse você, tomaria um banho o quanto antes.\n\nAgora, sobre seu monstro marinho...\n\nEnquanto isso, sirva-se de uma bebida ou duas."})
QuestFix(11210, {d="Sim, não há dúvida de que Tethyr é real e vive nas águas de Theramore.\n\nEle tem uma queda por luzes fortes. Foi por causa dele que apagaram o farol, sabia?\n\nSe acenderem o farol de novo, ele voltará. Mas ninguém em sã consciência faria uma coisa dessas.\n\nEntão esse deve ser o seu plano! Foi bom dividir uma bebida com você, mas não culpe o velho Nat se Tethyr REALMENTE transformar você em isca de peixe. Se pretende levar isso adiante, fale antes com o Major Mills nas docas de Theramore."})
QuestFix(11214, {d="O Cartel Bondebico estabeleceu recentemente um novo posto avançado na parte sul do Pântano Vadeoso. Se não me engano, chama-se Coroa de Barro e fica na estrada principal, ao sul da Fazenda de Tabetha e das Ruínas Pedramalho.\n\nÉ uma excelente oportunidade para estabelecermos novas relações comerciais, e Grã-senhora Jaina quer que eu envie um representante para fazer contato. Você estaria disposto a ir?",c="Então Theramore está interessada em fazer negócios? Essa é uma oferta que eu não recusaria. Os suprimentos estão bem escassos por aqui, então precisamos de todos os contatos comerciais que pudermos conseguir!"})
QuestFix(11270, {p="Não me importa quantos gigantes, dragões ou kobolds você já matou. Termine este trabalho e volte quando estiver pronto."})
QuestFix(175170, {d="Este cemitério é um dos lugares mais sagrados para os anões de Dun Kazad.\n\nMas olhe ao redor. Quando não é a neve se acumulando, são as ervas daninhas tomando conta de tudo. Os mortos merecem respeito; no mínimo, seus nomes deveriam permanecer legíveis.\n\nJá arrumei algumas sepulturas por conta própria. Que tal me ajudar a limpar o restante?",o="Ajude a colocar o Cemitério Véu de Neve em ordem.",p="Já terminou?"})
QuestFix(175179, {d="Decidi consagrar a alma do meu marido à Luz.\n\nEle conheceu guerra demais em vida; morte e violência em abundância. Se a Luz puder oferecer a Holdor um pouco de paz e me trazer algum conforto...\n\nVocê ficará para ouvir o sermão do Bispo Beorn?\n\nFale com ele quando estiver pronto para iniciar a cerimônia.",o="Informe ao Bispo Beorn que a cerimônia pode começar.",c="Está feito.\n\nQue a Luz o acolha em sua glória e conceda consolo aos seus familiares.\n\nA morte sempre pesa mais sobre os vivos."})
QuestFix(175180, {d="Holdor falava muito sobre legado. Seu desejo era deixar para trás uma cidade mais segura e mais forte.\n\nMais soberana.\n\nEle nunca se interessou muito por espiritualidade, mas acredito que teria apreciado o pragmatismo do Credo do Panteão.\n\nConhecer, recordar, honrar. É isso que devemos fazer agora por meu falecido marido.\n\nFale com o Patriarca quando estiver pronto para iniciar a cerimônia.",o="Informe ao Patriarca Khazemil que a cerimônia pode começar.",c="Palavras austeras, mas sinceras.\n\nAgora começa o verdadeiro trabalho: lembrar é carregar um peso. A memória traz conforto, mas também pode levar ao esgotamento.\n\nO Credo do Panteão estará aqui para guiá-los quando o peso das lembranças ameaçar esmagá-los."})
QuestFix(175181, {d="Você tem minha gratidão. Sem sua ajuda, acredito que os Stonefist teriam acabado escolhendo o Credo do Panteão.\n\nUma religião nobre, sem dúvida, mas que oferece pouco consolo. E diante da morte, o que mais se precisa é de compaixão.\n\nTenho um último favor a pedir. Quando passar por Dun Kazad, apresente-se ao Bispo Degarn, meu superior. Diga a ele que a família Stonefist se converteu à Luz Sagrada.",o="Viaje até Dun Kazad e informe ao Bispo Degarn sobre a conversão da família Stonefist à Luz Sagrada.",c="Apesar de nossas diferenças, somos todos um na Luz: fazendeiros, mineiros ou campeões como Holdor. Até reis e thanes.\n\nQue a Luz guie seus passos, meu filho."})
QuestFix(175196, {o="Viaje até Dun Kazad e informe pessoalmente o Thane Azaghal Stonesong.",c="<A testa do Thane se franze enquanto você relata a conspiração da Guilda e os planos de Thorazin Anvilmar.>\n\nAquele rato do Thorazin. Nunca gostei dele. Mandaria executá-lo se já não tivesse fugido com o primo!\n\nImagino que tenham deixado a cidade pouco depois de falar com você. Devem estar a caminho de Altaforja.\n\nMaldito anão. Ele posicionou as peças exatamente onde queria. O primo, o Senador, dirá a Magni exatamente o que Thorazin quer que ele ouça, e ninguém duvidará da palavra dele.\n\nOs Barbabronze declararão guerra contra nós."})
QuestFix(175198, {d="Vi você falando com Lorde Darengar. A ralé não mandou você, espero? <Sermon Spada lança um olhar arrogante e avaliador.>\n\nMas escute só. Claro que não. Você parece mais um mercenário.\n\nAcontece que há uma multidão furiosa no portão norte de Ventobravo, exigindo respostas sobre a situação em Scadeald. Nada do que tentamos conseguiu acalmá-los, mas talvez as palavras de alguém da mesma “posição” tenham mais efeito que um documento oficial.\n\nFale com eles. Intimide-os, se for necessário. Quando terminar, procure meu sobrinho, Thair Spada, que monta guarda no portão.",o="Informe aos cidadãos preocupados do Distrito dos Anões de Ventobravo que a Casa dos Nobres ouviu seus apelos.",p="Não recomendo entrar em Scadeald neste momento.",c="Meu tio...? Não havia necessidade de mandar ninguém. Estou cumprindo meu dever como esperado.\n\nA situação no portão está sob controle... embora a palavra “controle” esteja começando a parecer generosa.\n\nDe qualquer forma, agradeço por ter se dado ao trabalho de ajudar.\n\nEspero que meu tio e a Casa dos Nobres decidam agir logo."})
QuestFix(175201, {d="Nenhum daqueles brutamontes cobertos de lata que mandam de Graysky vai resolver o problema dos gnolls, a menos que “resolver” queira dizer “matar todos”. Não que eu vá reclamar se for esse o caso.\n\nDe um jeito ou de outro, não posso fazer mais nada por você. Essa é a maneira educada de convidá-lo a sair da minha cabana.\n\n<Beldred aponta para a porta com um de seus dedos muito longos.>\n\nEntão, adeus! Vá fazer seja lá o que você faz melhor: matar coisas, colher flores... ou falar com pessoas. Isso! Conte ao Capitão Amros o que descobriu. Que homem preocupado, esse Amros, não é? Tenho certeza de que nem saiu da taverna.",o="Informe ao Capitão Amros Dhagor o que aconteceu na Mina Galho de Ferro.",c="Maldição ou não, vão querer ouvir seu relatório em Graysky. Melhor do que nada, suponho.\n\nVou ficar por aqui, caso a situação piore."})
QuestFix(175206, {d="Desculpe incomodar, mas estou bastante sobrecarregado. Minha mãe não pode deixar a loja sozinha, e meu pai já tem preocupações demais, entre a fama que o queijo Windswept vem ganhando e a situação em Ventobravo...\n\nPoderia me ajudar com uma coisa simples? Estou atrasado com uma entrega.\n\nSó preciso que esta seleção de queijos seja entregue a Zaradiel, a elfa no Parque de Ventobravo. Não vai levar muito tempo e você me faria um enorme favor.",o="Entregue a seleção de queijos a Zaradiel no Parque de Ventobravo.",p="Está com a seleção de queijos?"})
QuestFix(175220, {d="O antigo senhor de Wangard, Ohlos, era um líder sábio e querido por seu povo. Talvez, apesar do medo, alguns yetis ainda estejam dispostos a se levantar contra o novo tirano e lutar pelo que é certo.\n\nPrincipalmente se virem você derrubando os capangas dele.\n\nMate o máximo que puder.",o="Derrote os capangas de Gharma em Wangard e inspire os yetis leais a Ohlos, seu antigo senhor.",p="<O yeti não passa de um monte ensanguentado, largado sem cerimônia no chão.>",c="<Você percebe que Ruhl está dando seus últimos suspiros, longos e dolorosos.>\n\nTudo... por nada..."})
QuestFix(175238, {d="Como vestígios da Grande Árvore, a flor e o fruto estão além do alcance de Tzotec. São relíquias da Vida, e ele é o Loa da Morte. Água e óleo.\n\nPara que ele devore a energia que guardam, primeiro precisamos temperá-los com magia da morte.\n\n<Tizare entrega a você um amuleto negro, frio como uma moeda colocada sobre os olhos de um cadáver.>\n\nUse-o nos corpos dos yetis Chifrefrio e dos pelursos Cascagélida que matar. As almas deles ficarão presas de forma irreversível ao apetite do Loa da Morte.",o="Use o amuleto de Tizare nos cadáveres dos yetis Chifrefrio e dos pelursos Cascagélida para capturar suas almas.",p="Almas frescas pesam menos.",c="<Tizare ergue o amuleto até o ouvido, como se escutasse algo lá dentro.>\n\nSim. Isto será suficiente.\n\nEles não estão felizes, é claro. Mas a agonia será breve e, depois disso, conhecerão a paz. A verdadeira paz."})
QuestFix(175249, {d="Há alguma coisa rio acima. Não falei disso antes porque não queria mandar você para a morte.\n\nMas, depois do que vi, talvez consiga enfrentá-la e destruí-la.\n\n<Telkin tira as mãos do gelo por um instante e encara você intensamente.>\n\nÉ um espírito nascido do rio estagnado, uma manifestação elemental de sua corrupção. O gelo contaminado que você purificou era apenas uma de suas muitas formas.\n\nSe conseguir destruí-lo, fale com Shivara.",o="Derrote Kegare, o Espírito Estagnado, na represa rio acima.",p="Água parada gera veneno.",c="<Os olhos de Shivara brilham ao compreender o que aconteceu.>\n\nKegare está morto? Eu não imaginava que isso fosse possível.\n\nQue a bênção da Muda esteja com você. Estamos em dívida, <class>."})
QuestFix(175282, {d="Precisamos fechar a passagem. Selar as cavernas.\n\n<Olgrim ergue os olhos para o teto irregular de pedra.>\n\nA montanha é velha. Cansada. Ela aceitará desabar, se pedirmos com educação.\n\nHá pilares de gelo sustentando o desfiladeiro. Quebre alguns e o peso da montanha fará o resto.\n\nAs Cavernas Nascimento Gélido serão o túmulo daqueles trolls miseráveis.",o="Derrube várias seções das Cavernas Nascimento Gélido para bloquear a passagem usada pelos Filhos da Luz Doente.",c="<Um rugido distante ecoa pela caverna. Neve, pedra e poeira caem do teto como cinzas brancas.>\n\nBem.\n\n<Olgrim apoia uma mão na parede congelada.>\n\nO caminho está fechado. Com isso, você salvou a vida de alguns leopardos."})
QuestFix(177899, {d="Você ficou mais forte, herói. Quase parece que desta vez não estou mandando você para uma missão suicida... quase.\n\nO Arcanista Doan ainda tem multas atrasadas da biblioteca. Totalmente inaceitável. Vá até o Monastério Escarlate e aplique a punição justa e perfeitamente razoável que ele merece.\n\nA morte."})
QuestFix(177903, {d="Estou começando a achar que você tem potencial. Quer provar que estou certo?\n\nEsta nem veio dos meus superiores, mas... você não vai acreditar! Um centauro chamou minha mãe de gorda! Sei exatamente como me vingar. Vá até Maraudon... e mate a mãe dele! É a grandona.\n\nIsso vai ensiná-lo a ter educação."})
QuestFix(200001, {d="Você encontra um bilhete preso ao falcão: \n\n<Se está lendo isto, encontrou meu amigo. Junto ao bilhete há um pequeno frasco vermelho. Dê a ele caso esteja ferido; ele saberá o que fazer em seguida.>",o="Use o Frasco Vermelho no falcão."})
QuestFix(200004, {d="Você encontra um bilhete preso ao falcão: \n\n<Se está lendo isto, encontrou meu amigo. Junto ao bilhete há um pequeno frasco vermelho. Dê a ele caso esteja ferido; ele saberá o que fazer em seguida.>",o="Use o Frasco Vermelho no falcão.",p="Aye, guri. Talos já voltou. Obrigado."})
QuestFix(200007, {d="Você encontra um bilhete preso ao falcão: \n\n<Se está lendo isto, encontrou meu amigo. Junto ao bilhete há um pequeno frasco vermelho. Dê a ele caso esteja ferido; ele saberá o que fazer em seguida.>",o="Use o Frasco Vermelho no falcão.",p="Maravilha! Brim voltou!"})
QuestFix(200010, {d="Você encontra um bilhete preso ao falcão: \n\n<Se está lendo isto, encontrou meu amigo. Junto ao bilhete há um pequeno frasco vermelho. Dê a ele caso esteja ferido; ele saberá o que fazer em seguida.>",o="Use o Frasco Vermelho no falcão."})
QuestFix(200013, {d="Você encontra um bilhete preso ao falcão: \n\n<Se está lendo isto, encontrou meu amigo. Junto ao bilhete há um pequeno frasco vermelho. Dê a ele caso esteja ferido; ele saberá o que fazer em seguida.>",o="Use o Frasco Vermelho no falcão.",p="Você fez uma grande coisa hoje ao encontrar Felo. Obrigado."})
QuestFix(200016, {d="Você encontra um bilhete preso ao falcão: \n\n<Se está lendo isto, encontrou meu amigo. Junto ao bilhete há um pequeno frasco vermelho. Dê a ele caso esteja ferido; ele saberá o que fazer em seguida.>",o="Use o Frasco Vermelho no falcão."})
QuestFix(202566, {d="Escute aqui, aventureiro. Todo mercenário e peão de fazenda acha que sabe balançar uma espada, mas defender uma posição? Isso exige fibra de verdade. Vila Plácida resiste aos ataques dos orcs há meses porque nossos guardas sabem manter a linha quando importa. Quer aprender o que sabemos? Então prove que tem coragem. Não abandone esse posto, não importa o que vier contra você. No instante em que quebrar a formação, terá fracassado. Nosso povo depende de guardas e batedores que não recuam quando o inimigo avança.",o="Ajude o Batedor Peter a defender seu posto.",p="Ainda está segurando a posição? Ótimo. Mas não relaxe; a próxima onda vem mais forte.",c="Então você manteve a posição. Não recuou. É disso que eu gosto. Talvez você não seja apenas mais um mercenário.\n\nO povo da cidade poderá dormir um pouco mais tranquilo esta noite graças a você. Conquistou seu lugar entre aqueles que mantêm a linha.\n\nPegue isto como um sinal do respeito de Vila Plácida. Só não deixe subir à cabeça. A próxima luta está sempre logo depois da colina."})
QuestFix(254011, {d="Você reconhece o desenho como uma criatura que já ouviu dizer que ameaça Durotar: uma harpia. Talvez alguns pedaços de metal brilhante a deixem calma o bastante para conversar.",p="Procura brilhos? Sim, sim, sim! Volta com brilhos e talvez eu não coma você!"})
QuestFix(254013, {o="Leve as informações que descobriu até Sakari, em Orgrimmar.",p="Ainda está aqui? Vou comer você logo, sim, sim, sim! Vá embora! Um dia sem comer você, não mais que isso!",c="Você falou com uma harpia?!\n\nEu acredito em você, claro. Tenho certeza de que é honrado demais para me enganar. Elas só nunca foram muito receptivas... e, para falar a verdade, também não tentamos conversar muito.\n\nBem, se descobriu as propriedades da flor, posso começar."})
QuestFix(254037, {d="Aquela armadura amaldiçoada finalmente foi destruída... Nunca achei que veria este dia.\n\nTenho certeza de que meu nome já não significa nada para o mundo lá em cima. Quem se lembraria de um herói fracassado? Não há motivo para guardar minha memória, mas ainda assim peço que ouça minha história, para entender que a sombra presa àquela armadura não representa quem eu sempre fui.",p="Você não me deve nada, então entenderei se decidir voltar.",c="Espero de verdade que consiga vencer onde eu fracassei. Queria poder empunhar minha espada ao seu lado mais uma vez, mas minha alma está fraca demais. Só posso observar e rezar para que a Luz conceda sua salvação."})
QuestFix(254089, {p="Ele não diz nada, mas tenho certeza de que é ele. Antes de você chegar, eu pensei que talvez ele...\n\nEu sei. É raro um worgen conservar sequer um vestígio de quem já foi. Era apenas uma esperança egoísta, nada mais.",c="Trouxe o Néctar? Ótimo. Acho que chegou a hora de começarmos."})
QuestFix(1660054, {d="<Parece que você é uma das raras almas curiosas dispostas a ouvir o sermão de uma banshee.>\n\n<Talvez ela tenha algo interessante para compartilhar.>",c="A curiosidade não está entre as Três Virtudes que seguimos no Culto da Sombra Esquecida.\n\nMas é a antessala delas."})
QuestFix(1660058, {d="Sussurros. Eles acham que ninguém percebeu, mas eu durmo com o ouvido no chão! Ha!\n\nCavam, cavam e cavam. Vão atacar quando você menos esperar... a menos que faça alguma coisa primeiro.\n\nKobolds, kobolds e mais kobolds. Debaixo dos nossos pés! Cuidado onde pisa!\n\nEncontre as tocas deles e ponha fogo. Esmague tudo. Com um martelo grande e pesado!\n\n<Ela ri sozinha e depois encara o horizonte.>",o="Encontre e destrua as tocas de kobolds ao redor de Vila d’Ouro.",p="Não deixe nenhum desses vermes vivo, ou Vila d’Ouro vai afundar nos túneis deles.",c="<Clara, a Louca, segura uma maçã na mão direita e a admira como se fosse seu bem mais precioso.>\n\nVila d’Ouro é como esta maçã.\n\n<Devagar, ela gira a fruta e mostra uma mordida; por dentro, apesar da aparência, está podre e cheia de vermes.>"})
QuestFix(1660061, {c="<O velho orc ouve seu relato sobre o Vale das Provações com os olhos semicerrados.>\n\nNunca gostei daquela Hirsutta. E nunca confiei no vodu dela. Uma pena o tempo ter provado que eu estava certo.\n\nÉ uma bênção que tenha conseguido derrotá-la. Mas temo que o eco da ambição dela não desapareça tão cedo. As consequências do ritual já repercutem até aqui, em Monte Navalha."})
QuestFix(1660071, {d="Espere.\n\nTem mais uma coisa. <A voz de Thariel sai tensa; as palavras tropeçam em seus lábios.>\n\nAquele culto. Os lunáticos que atraíram minha irmã. Precisamos fazer alguma coisa.\n\nVou ficar em Aldrassil e denunciar o culto a Tenaron Punho-da-Tempestade. Você vá até Dolanaar e conte tudo a Tallonkai Raizveloz.\n\nEntre os dois, saberão como acabar com isso."})
QuestFix(1903546, {d="Você encontra Mestres de Voo nas principais cidades e centros de missões. A maioria das regiões possui um Mestre de Voo que permite viajar rapidamente de e para aquela área.\n\nPara localizar um Mestre de Voo próximo, use a lupa ao lado do minimapa e ative a opção de Mestre de Voo.\n\nPara desbloquear uma nova rota, fale com o Mestre de Voo. Sempre que chegar a uma região nova, procure o Mestre de Voo no centro de missões da sua facção.",o="Fale com o Mestre de Voo e voe até a Encruzilhada.",p="Fale com Doras, o Mestre de Voo no alto da torre ao lado do Banco de Orgrimmar, e depois voe até a Encruzilhada.",c="Os Mestres de Voo são uma parte importante da sua jornada e permitem viajar rapidamente por Azeroth.\n\nVocê começa com algumas rotas básicas desbloqueadas. Conforme sobe de nível e explora regiões mais perigosas, fale com os Mestres de Voo encontrados nos centros de missões para liberar viagens de ida e volta àquelas localidades.\n\nRotas ainda não descobertas aparecem com um ponto de exclamação verde. Fale com o Mestre de Voo para desbloqueá-las. Algumas rotas dependem de conexões intermediárias, e descobrir novos pontos costuma liberar caminhos mais rápidos.\n\nSempre procure e desbloqueie novas rotas de voo ao explorar uma região pela primeira vez."})
QuestFix(1903547, {d="Você encontra Mestres de Voo nas principais cidades e centros de missões. A maioria das regiões possui um Mestre de Voo que permite viajar rapidamente de e para aquela área.\n\nPara localizar um Mestre de Voo próximo, use a lupa ao lado do minimapa e ative a opção de Mestre de Voo.\n\nPara desbloquear uma nova rota, fale com o Mestre de Voo. Sempre que chegar a uma região nova, procure o Mestre de Voo no centro de missões da sua facção.",o="Fale com o Mestre de Voo e voe até Cerro Oeste.",p="Vá até o canto leste do Distrito Comercial, suba a rampa e fale com Dungar Tragolongo. Depois voe até Cerro Oeste.",c="Os Mestres de Voo são uma parte importante da sua jornada e permitem viajar rapidamente por Azeroth.\n\nVocê começa com algumas rotas básicas desbloqueadas. Conforme sobe de nível e explora regiões mais perigosas, fale com os Mestres de Voo encontrados nos centros de missões para liberar viagens de ida e volta àquelas localidades.\n\nRotas ainda não descobertas aparecem com um ponto de exclamação verde. Fale com o Mestre de Voo para desbloqueá-las. Algumas rotas dependem de conexões intermediárias, e descobrir novos pontos costuma liberar caminhos mais rápidos.\n\nSempre procure e desbloqueie novas rotas de voo ao explorar uma região pela primeira vez."})

-- Mais um pente-fino nas linhas que ainda estavam em portunhol pesado.
QuestFix(2501, {p="Conseguiu usar os recipientes para obter o sangue dos Dragões Guardiões Calcinados de que preciso? Sim, sei que é perigoso... mas a receita da minha bebida restauradora espera por você. Risco e recompensa, $gamigo meu:amiga minha;... risco e recompensa...",c="De um alquimista para outro, eu o saúdo. Pegue esta receita e aprenda-a. Que ela lhe traga o mesmo sucesso e as mesmas recompensas que me trouxe ao longo dos anos."})
QuestFix(175182, {o="Viaje até Dun Kazad e informe ao Patriarca Arbilun sobre a conversão da família Stonefist ao Credo do Panteão.",c="Da terra viemos e à terra retornamos. Tudo o que tomamos emprestado dela, um dia devolvemos.\n\nDo anão mais humilde ao lorde mais poderoso, isso é o que todos temos em comum. Não importa quão rico ou nobre alguém seja; no fim, não passamos de pedra moldada em carne."})
QuestFix(254004, {d="Quer saber das coisas que o Velho Mirsinth viu? Um ser de metal faz guerra contra meu povo e talvez contra o seu também? Sim, sim, o Velho Mirsinth viu muitas coisas. Talvez tenha visto seu ser de metal. Você quer detê-lo por causa da ameaça que representa ao seu povo, mesmo que ele ataque o meu?\n\nTalvez você tenha mais visão que o povo do Velho Mirsinth. Você deixou antigas rivalidades de lado; então o Velho Mirsinth fará o mesmo. O povo do Velho Mirsinth já não é mais seu povo. Expulsa, sim, “exilada”, como você diz. Por quê? E por que seu ser de metal não faz o que mandam? Talvez pelas mesmas razões do Velho Mirsinth... ou pelo contrário.\n\nSe quer respostas, fará algo que o Velho Mirsinth não pode. O Velho Mirsinth se esconde aqui porque os yetis mantêm nosso povo afastado. Yetis são mais fáceis de evitar que nosso próprio povo, entende? O Velho Mirsinth pode se esconder, fugir, vagar... mas o Irmão Jun’Kon tomou seu totem quando a expulsou. Disse que ela não era mais família dele. O Irmão Jun’Kon é covarde e se esconde bem fundo numa caverna. Traga o totem de volta e falaremos sobre o ser de metal, a história e muitas outras coisas. Sim?",o="Recupere o totem de Mirsinth, a Exilada, com Jun’Kon na Fortaleza Jubafria.",p="O Irmão Jun’Kon expulsou o Velho Mirsinth. Disse que ela era traidora por questionar velhas rivalidades e vinganças.\n\nMesmo assim, o Velho Mirsinth gostaria que o irmão não precisasse morrer... Faça isso rápido, por favor.",c="O Velho Mirsinth e o Irmão Jun’Kon foram amigos um dia, há muito, muito tempo... Já não são crianças. O Velho Mirsinth ficou mais sábio; o Irmão Jun’Kon, menos. Mesmo assim, é difícil esquecer aqueles dias...\n\nDê ao Velho Mirsinth um momento. Paciência tem valor, sabe?... Não é mesmo, Irmão Jun’Kon?"})
QuestFix(254007, {d="O Velho Mirsinth terminou. Encontrou o espírito do ser de metal. Ele está perto de uma escavação que seu povo chama de Ironband, lá em cima. O Velho Mirsinth só sabe onde, não por quê, mas era disso que você precisava, sim? Parece que o trabalho do Velho Mirsinth acabou.\n\nAgora talvez o Velho Mirsinth vague pelo mundo. Este lugar já não parece muito um lar. Rivalidades antigas demais, ciclos demais... mas os loa mostraram muitas coisas ao Velho Mirsinth. Então ela vagará por um mundo que já não chama de casa.\n\nFaz muito tempo que o Velho Mirsinth chamou alguém de amigo. Talvez seja cedo demais para usar essa palavra com alguém com quem falou tão pouco. Mesmo assim, o Velho Mirsinth espera encontrar você novamente em suas andanças, amigo.",o="Derrote Nylrisa perto do Local de Escavação de Ironband e recupere seus componentes.",p="Por favor, por favor, por favor, diga que ela conseguiu encontrar Nylrisa.\n\nConseguiu? Então vá logo, antes que a perca de novo!",c="Você conseguiu? Encontrou ela? Anda, anda, andaandaanda... desculpe. Não estou nervoso. Só... funcionou? A troll encontrou ela?\n\nVocê trouxe os componentes de volta... obrigado. Seria caro substituir isso tudo. Vejamos... treco termoarcano, peça eletrostática, dispositivo mecanofuncional do núcleo... Hmm. Acho que o processador quebrou na luta, e o ectoplasma deve ter vazado também. Só sobrou um pouco de resíduo. Bem... talvez isso tenha sido uma péssima ideia.\n\nTá bom, foi definitivamente uma péssima ideia. Não vou fazer de novo, certo? De qualquer forma, você salvou minha pele, talvez literalmente. Obrigado mesmo! Se um dia precisar de um inventor para inventar alguma coisa, é só me chamar.\n\nHmm... eu jurava que tinha usado microengrenagens de bronze neste processador, não cobre... Ah, estou pensando demais. Vidra, vou querer uma daquelas bebidas agora! Melhor: três!"})
QuestFix(254087, {d="Agora me lembro. Ouvi dizer que uma tal de Julie Addle está hospedada na estalagem de Vila Sombria. Hoje em dia precisamos ficar de olho em todo mundo; nunca se sabe quando uma pessoa comum pode esconder algo a mais.\n\nNós três somos necessários aqui e já somos poucos. Mesmo assim, duvido que avancemos muito por este caminho. Se passar por Vila Sombria, talvez possa procurá-la e descobrir se ela consegue ajudar.",o="Encontre Julie Addle na Taverna Corvo Escarlate.",c="<A mulher parece prestes a chorar, mas se recompõe um pouco quando você se aproxima.>\n\nOlá. Posso ajudar em alguma coisa?\n\nUm worgen disse o meu nome...?\n\nArvis... foi nisso que você se transformou? Desculpe. Preciso de um momento..."})
QuestFix(255030, {d="Faz anos que estou longe de casa, mas meu irmão ainda aparece toda semana para tomar uma caneca. Isso prova que ele sabe que eu sou o melhor cervejeiro, rá!\n\n...Só que ele ainda não apareceu esta semana. Estranho para ele. Não estou preocupado nem nada, mas, se acabar passando por Burndural em suas viagens, diga que ele está atrasado, tá?",o="Encontre o Estalajadeiro Arnith em Burndural.",c="Halbrek mandou você, foi? Não suponho que tenha mandado cerveja junto... Eu bem que precisava de uma agora.\n\nClaro que não. Aquele pão-duro ainda me cobra toda vez que apareço por lá.\n\nBem, se sabe se virar numa luta, talvez possa ficar por aqui um pouco. Vou visitar meu irmão quando este ataque acabar."})
QuestFix(255122, {d="Este lugar está cheio de segredos. Claro, é perigoso demais para eu sair explorando sozinho, e os Renegados não parecem ter muito interesse na história troll.\n\nSe estiver disposto a ajudar, há ruínas rio acima que todos evitam, até as feras. Talvez exista alguma coisa protegendo o lugar, mas tenho certeza de que está cheio de artefatos e relíquias que eu adoraria colocar as mãos.\n\nPegue tudo que conseguir encontrar e traga para mim.",p="Encontrou alguma coisa, mon?",c="Então eram espíritos...\n\nSe eu fosse um troll melhor, diria que deveríamos encontrar uma forma de dar descanso às almas deles. Mas... isso talvez significasse abrir mão das minhas novas relíquias.\n\nNão acho que eles se importem se eu ficar com elas mais um pouquinho, né, mon?"})
QuestFix(255150, {d="Antes de pendurar minha lança para sempre, há uma última ameaça nestas colinas que precisa ser abatida.\n\nMas preste atenção: não enfrente esta caçada sozinho. Esta fera está além do alcance de qualquer caçador solitário.\n\nChamam-no de Highclaw, o maior e mais esquivo leão-da-montanha que já rastreei. Leões raramente são um problema, pelo menos para mim... mas este é diferente. Ele caça pessoas de propósito. Acampamentos, caravanas, não importa. Para ele, todos nós somos presas.\n\nSeja rápido e ataque sem hesitar. Não sei o que faria se ele matasse você.",o="Mate Highclaw na Contraforte de Eira dos Montes.",p="Então... está feito?",c="Não vou mentir: eu não tinha certeza de que você voltaria. E uma parte de mim se perguntava o que faria se voltasse... se eu estava realmente pronto para pendurar minha lança.\n\nAbandonar a emoção da caçada... e o dever de manter este povo em segurança.\n\nMas agora vejo com clareza. Esse fardo já não pertence a mim. Você o carregou mais longe do que eu jamais conseguiria.\n\nObrigado, <name>."})
QuestFix(760001, {d="Seu próximo adversário é Ironhide Gorefist, um brutal guerreiro de sangue ogro do clã Rocha Negra.\n\nEle abriu caminho na pancada por metade dos Reinos do Leste. Suas correntes características ecoam em cada luta como um sino fúnebre, ficando mais altas a cada golpe. Quando começam a chacoalhar, a multidão sabe que alguém está prestes a cair.\n\nO público já provou o primeiro gosto de sangue. Agora quer um banquete. Dê a eles Ironhide.",c="Então... o brutamontes finalmente caiu. Eu não achava que você duraria mais de um minuto contra ele, mas aqui está: ensanguentado e ainda respirando.\n\nAquilo não foi apenas uma luta. Você conquistou o respeito dos veteranos, dos apostadores e dos assassinos que já viram de tudo. Está um passo mais perto de conquistar seu lugar na lenda da arena.\n\nNão relaxe. O próximo desafio vai bater ainda mais forte."})
QuestFix(980251, {d="A Fortaleza Presa do Dragão serve como base avançada dos orcs Presa do Dragão no Vale da Lua Negra.\n\nEles escravizam dracos para fazer sua vontade e usam a fortaleza como centro de suas operações sob as ordens vis de Zuluhed.\n\nSiga até os Campos da Asa Etérea e verá a enorme fortaleza erguida contra as montanhas.\n\nMate todos os orcs Presa do Dragão que encontrar por lá e garanta que teremos uma ameaça a menos com que lidar."})
-- Pente-fino extra dos blocos custom, com foco no que aparece no rastreador e no registro.
QuestFix(255000, {title="Quando a Luz da Vela se Apaga"})
QuestFix(255001, {title="O Despertar dos Terranos"})
QuestFix(255002, {title="Legado da Ravina Deslizapedra"})
QuestFix(255004, {title="Morte à Rainha Traidora"})
QuestFix(255005, {title="Mudança de Comando"})
QuestFix(255007, {title="Caçando o Caçador"})
QuestFix(255008, {title="Uma Ressonância Antiga"})
QuestFix(255009, {title="A Força da Pedra"})
QuestFix(255010, {title="Fim do Dever"})
QuestFix(255012, {title="Rechaçando a Ofensiva"})
QuestFix(255013, {title="Belas Armas Enânicas"})
QuestFix(255014, {title="Um Fim à Vista"})
QuestFix(255015, {title="O Viajante de Vermelho"})
QuestFix(255017, {title="Cegando os Presa do Dragão"})
QuestFix(255018, {title="Mestres Cruéis"})
QuestFix(255019, {title="Batalha na Ponte"})
QuestFix(255020, {title="As Mãos Certas"})
QuestFix(255025, {title="Entesourando Conhecimento"})
QuestFix(255026, {title="Em Atraso"})
QuestFix(255028, {title="Uma Estranheza Serpentina"})
QuestFix(255029, {title="A Corrupção dos Altaneiros"})
QuestFix(255030, {title="Irmãos na Cerveja"})
QuestFix(255031, {title="Carneiros em Espera"})
QuestFix(255034, {title="Proprietários Legítimos"})
QuestFix(255035, {title="Questão Contratual"})
QuestFix(255038, {title="Poder do Núcleo"})
QuestFix(255043, {title="Chama Eterna"})
QuestFix(255045, {title="Uma Colheita Escassa"})
QuestFix(255047, {title="Jaula Iridescente"})
QuestFix(255050, {title="Espíritos de Thel'Dralor"})
QuestFix(255055, {title="Recuperação da Bateria"})
QuestFix(255057, {title="Treinamento da Milícia"})
QuestFix(255061, {title="Eles Tinham a Tecnologia"})
QuestFix(255062, {title="Fuga de Ja'kani"})
QuestFix(255063, {title="Missão do Pântano 4 — Não Usada"})
QuestFix(255065, {title="Fuga de Ja'kani"})
QuestFix(255066, {title="Eles Tinham a Tecnologia"})
QuestFix(255067, {title="Até que a Não Morte nos Separe"})
QuestFix(255069, {title="Da Morte Vem o Amor"})
QuestFix(255070, {title="Lavrando contra a Corrupção"})
QuestFix(255072, {title="O Tolo e o Torpe"})
QuestFix(255075, {title="Ventos Crescentes"})
QuestFix(255076, {title="Adversários Hostis"})
QuestFix(255077, {title="A Mácula da Costa Negra"})
QuestFix(255078, {title="Toque de Ouvido"})
QuestFix(255079, {title="Encontrando o Ritmo"})
QuestFix(255080, {title="Dançando no Ritmo"})
QuestFix(255082, {title="Eliminando a Concorrência"})
QuestFix(255083, {title="Aniquilando a Concorrência"})
QuestFix(255084, {title="O Dever Solene dos Guardiões"})
QuestFix(255085, {title="Estudo Individual"})
QuestFix(255086, {title="Você Ouve as Sombras?"})
QuestFix(255088, {title="Encontrando o Invisível"})
QuestFix(255091, {title="Stromgarde Caiu"})
QuestFix(255093, {title="O Último da Cavalaria"})
QuestFix(255094, {title="O Legado de Strom"})
QuestFix(255095, {title="Confronto de Vontades"})
QuestFix(255096, {title="Um Passeio Tranquilo"})
QuestFix(255098, {title="Siga para Darnassus"})
QuestFix(255104, {title="Aviso de Atraso"})
QuestFix(255105, {title="Robô Perdido"})
QuestFix(255106, {title="Comportamento Autodestrutivo"})
QuestFix(255107, {title="O Paladino Perdido"})
QuestFix(255111, {title="Aliados Alternativos"})
QuestFix(255113, {title="Comida para Gnolls"})
QuestFix(255114, {title="Bênçãos da Luz"})
QuestFix(255116, {title="Recuperando a Serraria de Alther"})
QuestFix(255117, {title="Tábuas Perfeitamente Boas"})
QuestFix(255118, {title="Água Própria para os Vivos"})
QuestFix(255119, {title="Água Própria para os Mortos"})
QuestFix(255120, {title="Água Própria para os Insanos"})
QuestFix(255122, {title="História Há Muito Esquecida"})
QuestFix(255127, {title="Buscando Almas"})
QuestFix(255130, {title="As Salas de Interrogatório"})
QuestFix(255131, {title="Uma Busca Inútil"})
QuestFix(255132, {title="Loucura Vinda do Alto"})
QuestFix(255133, {title="O Expurgo de Fosso Macabro"})
QuestFix(255135, {title="Rotmaw"})
QuestFix(255140, {title="Lâminas Banhadas em Luz"})
QuestFix(255141, {title="Pedra para Costa Sul"})
QuestFix(255143, {title="Contendo a Cratera"})
QuestFix(255147, {title="Vale um Tostão"})
QuestFix(255148, {title="O Descanso dos Denholm"})
QuestFix(255150, {title="O Rei das Colinas"})
QuestFix(255151, {title="Ladrões Canalhas"})
QuestFix(255152, {title="Preservando a História"})
QuestFix(255153, {title="Entrega em Menethil"})
QuestFix(255158, {title="Uma Doação de Madeira do Bosque"})
QuestFix(255159, {title="Mais Madeira do Bosque"})
QuestFix(980000, {title="Pela Horda: Esmagando os Caçadores (Alto Risco)"})
QuestFix(980104, {title="Guerra em Nagrand: Descida Aterrorizante (Alto Risco)"})
QuestFix(980105, {title="Guerra em Nagrand: Mau Conselho (Alto Risco)"})
QuestFix(980106, {title="Guerra em Nagrand: Guerra na Crista (Alto Risco)"})
QuestFix(980107, {title="Guerra em Nagrand: Ódio e Medo (Alto Risco)"})
QuestFix(980112, {title="Guerra nas Montanhas da Lâmina Afiada: Uma Tarefa Gruulenta (Alto Risco)"})
QuestFix(980113, {title="Guerra nas Montanhas da Lâmina Afiada: Armadilha Mortal (Alto Risco)"})
QuestFix(980114, {title="Guerra nas Montanhas da Lâmina Afiada: Uma Caçada Ogri'norme (Alto Risco)"})
QuestFix(980115, {title="Guerra nas Montanhas da Lâmina Afiada: A Presa do Corvo (Alto Risco)"})
QuestFix(980120, {title="Guerra em Eternévoa: Entre no Ecodomo! (Alto Risco)"})
QuestFix(980121, {title="Guerra em Eternévoa: Quebre os Rompedores (Alto Risco)"})
QuestFix(980122, {title="Guerra em Eternévoa: O que é Seu é Meu (Alto Risco)"})
QuestFix(980123, {title="Guerra em Eternévoa: Forjado pela Guerra (Alto Risco)"})
QuestFix(980128, {title="Guerra no Vale da Lua Negra: Drenando a Cisterna (Alto Risco)"})
QuestFix(980129, {title="Guerra no Vale da Lua Negra: Eu Me Tornei a Morte, Destruidor de Forjas (Alto Risco)"})
QuestFix(980130, {title="Guerra no Vale da Lua Negra: Caçando Demônios Illidari (Alto Risco)"})
QuestFix(980131, {title="Guerra no Vale da Lua Negra: Trabalho Ascendido (Alto Risco)"})
QuestFix(980232, {title="Guerra em Nagrand: Solução Cristalina (Alto Risco)"})
QuestFix(980233, {title="Guerra em Nagrand: Campos de Sombra (Alto Risco)"})
QuestFix(980234, {title="Guerra em Nagrand: Enterre os Punho de Pedra (Alto Risco)"})
QuestFix(980235, {title="Guerra em Nagrand: Acabe com a Lama (Alto Risco)"})
QuestFix(980236, {title="Guerra em Nagrand: Limpeza de Primavera (Alto Risco)"})
QuestFix(980237, {title="Guerra nas Montanhas da Lâmina Afiada: Ruuan e o Culto das Serpes (Alto Risco)"})
QuestFix(980238, {title="Guerra nas Montanhas da Lâmina Afiada: Cânion Malho Sangrento (Alto Risco)"})
QuestFix(980239, {title="Guerra nas Montanhas da Lâmina Afiada: Silenciando a Crista Harmônica (Alto Risco)"})
QuestFix(980240, {title="Guerra nas Montanhas da Lâmina Afiada: Ataque Arakkoa (Alto Risco)"})
QuestFix(980241, {title="Guerra nas Montanhas da Lâmina Afiada: Patrulheiro da Mata do Corvo (Alto Risco)"})
QuestFix(980242, {title="Guerra em Eternévoa: Engenharia 100% de Qualidade (Alto Risco)"})
QuestFix(980243, {title="Guerra em Eternévoa: As Ruínas Têm Olhos (Alto Risco)"})
QuestFix(980244, {title="Guerra em Eternévoa: Obsolescência Planejada (Alto Risco)"})
QuestFix(980245, {title="Guerra em Eternévoa: Enterre os Solfúria (Alto Risco)"})
QuestFix(980246, {title="Guerra em Eternévoa: Saqueador de Ruínas (Alto Risco)"})
QuestFix(980247, {title="Guerra no Vale da Lua Negra: Baa'ri é um Desafio (Alto Risco)"})
QuestFix(980248, {title="Guerra no Vale da Lua Negra: Alarme de Sereia (Alto Risco)"})
QuestFix(980249, {title="Guerra no Vale da Lua Negra: Caçada Magmática (Alto Risco)"})
QuestFix(980250, {title="Guerra no Vale da Lua Negra: Tem um Pontal? (Alto Risco)"})
QuestFix(980251, {title="Guerra no Vale da Lua Negra: Ataque aos Presa do Dragão (Alto Risco)"})
QuestFix(980252, {title="Guerra no Pântano Zíngaro: Tribos Perdidas (Alto Risco)"})
QuestFix(980253, {title="Guerra no Pântano Zíngaro: A Cristanegra (Alto Risco)"})
QuestFix(980254, {title="Guerra no Pântano Zíngaro: O Charco Fantasma (Alto Risco)"})
QuestFix(980255, {title="Guerra no Pântano Zíngaro: Nagas Sangrescama (Alto Risco)"})
QuestFix(980256, {title="Guerra no Pântano Zíngaro: O Vale dos Rebentos (Alto Risco)"})
QuestFix(980257, {title="Guerra no Pântano Zíngaro: Terras de Ango'rosh (Alto Risco)"})
QuestFix(980258, {title="Guerra no Pântano Zíngaro: Fortaleza Ango'rosh (Alto Risco)"})
QuestFix(980259, {title="Guerra na Mata Terokkar: Picos da Barreira (Alto Risco)"})
QuestFix(980260, {title="Guerra na Mata Terokkar: Tuurem (Alto Risco)"})
QuestFix(980261, {title="Guerra na Mata Terokkar: Pontal Asardente (Alto Risco)"})
QuestFix(980262, {title="Guerra na Mata Terokkar: Skettis (Alto Risco)"})
QuestFix(980263, {title="Guerra na Mata Terokkar: Véu Shalas (Alto Risco)"})
QuestFix(980264, {title="Guerra na Mata Terokkar: Tumba das Luzes (Alto Risco)"})
QuestFix(980265, {title="Guerra na Mata Terokkar: Ruínas dos Olhos Sangrentos (Alto Risco)"})
QuestFix(980266, {title="Guerra na Mata Terokkar: Ruínas Mascaosso (Alto Risco)"})
QuestFix(980267, {title="Guerra na Mata Terokkar: Tumba Sombria (Alto Risco)"})
QuestFix(980268, {title="Guerra no Pântano Zíngaro: Aldeia do Charco Sombrio (Alto Risco)"})
QuestFix(980269, {title="Guerra no Pântano Zíngaro: Aldeia Lamadaga (Alto Risco)"})
QuestFix(1650012, {title="Em Busca do Mago"})
QuestFix(1650029, {title="Pedido em Andamento"})
QuestFix(1650030, {title="Preparando a Guerra"})
QuestFix(255000, {o="Derrote a “Fera que Habita na Escuridão”.",p="Uma criatura corrompida pelas sombras habita essa caverna. É melhor deter essa fera antes que ela faça novas vítimas."})
QuestFix(255001, {o="Abra o Grande Barril de Ressonita com um Cristal de Ressonita Zumbante, mate Adaziar e volte ao estranho eremita com a notícia.",p="Sei que é uma esperança vã. Você provavelmente morrerá, e essa criatura poderá ser libertada sobre Azeroth em toda a sua força.\n\nÉ egoísmo meu pedir que ponha fim a isso. Não precisa dar ouvidos a este velho."})
QuestFix(255002, {p="Um Terrano não seria selado aqui sem motivo. Sinto que há mais nesta história do que aprendemos, e talvez você encontre as respostas dentro daquele vale."})
QuestFix(255004, {o="Mate a Rainha Erethina.",p="Claro que estou curioso sobre ela. Se essa flor a transformou em uma elfa noturna, será que as harpias já foram elfas noturnas um dia?\n\nMas ela é perigosa demais para permanecer viva só por causa da minha curiosidade. Quando isso estiver resolvido, poderei voltar às pesquisas para purgar nossa corrupção vil."})
QuestFix(255005, {d="<As feridas deste corpo não correspondem às de nenhuma criatura local que você enfrentou até agora, mas lembram os cortes de um retalhador goblin. O que quer que tenha causado isso não pode estar muito longe.>",o="Encontre e derrote o que matou os trabalhadores da Empreendimentos S.A."})
QuestFix(255006, {d="Rohil acha que você é forte. Forte o bastante para matar Urash. Forte o bastante para quebrar a maldição.\n\nTemos uma prova para novos caçadores: enfrentar as feras e sobreviver. Quimera, lagarto e mantícora. Sobreviva às três e será um grande caçador.\n\nMas isso não basta para Rohil. Enfrente também Shanel’tefir, o maior terror dos céus. Traga troféus de todas elas e prove que Rohil estava certo sobre você.",o="Colete troféus das grandes feras ao redor da mina.",p="As feras destas terras são mais fortes que as de fora. Grandes e poderosas, só caem diante dos melhores caçadores."})
QuestFix(255007, {o="Mate Kasajh.",p="Não chame atenção para nós, forasteiro. Ainda estamos sendo caçados."})
QuestFix(255008, {c="Éramos todos tolos. Talvez você também seja.\n\nMas estas velhas anotações resistiram bem. Faça com elas o que quiser; eu só não quero mais me envolver nisso."})
QuestFix(255009, {d="Rohil diz que você é forte.\n\nNão há nada mais forte que pedra. E a pedra mais forte de todas é a grande pedra roxa.\n\nSe é tão forte quanto Rohil diz, prove que é mais forte que ela.",o="Destrua os Elementais de Ressonita.",p="A grande pedra roxa nunca fica parada por muito tempo. Talvez ela esteja inquieta.",c="Você quebra grandes pedras roxas?\n\nÉ forte. Mais forte que eu, mais forte que a maioria.\n\nRohil estava certo."})
QuestFix(255013, {o="Colete Armamentos Enânicos nos arredores de Burndural."})
QuestFix(255014, {o="Mate o Comandante Amzust nos arredores de Burndural."})
QuestFix(255015, {o="Fale com Aelir em Burndural.",p="<O anão parece confuso, como se você tivesse feito algo que, de alguma forma, não deveria ser possível.>"})
QuestFix(255016, {o="Mate Lordes da Guerra, Xamãs Sombrios e Videntes da Morte Presa do Dragão em Zulumar."})
QuestFix(255017, {o="Mate os Vigias Presa do Dragão nas torres ao redor de Zulumar."})
QuestFix(255018, {o="Resgate as “crianças” mantidas pelos Presa do Dragão."})
QuestFix(255019, {o="Derrote Konym Rompedragões em Zulumar."})
QuestFix(255021, {o="Derrote Lorde Valesir na Fortaleza de Desterro e recupere a correspondência."})
QuestFix(255022, {o="Mate Fuzileiros e Curadores de Theramore no Forte Coração do Ar."})
QuestFix(255023, {o="Mate o Capitão Farran no Forte Coração do Ar.",p="<A tauren parece fraca demais para dizer qualquer outra coisa. É melhor deixá-la descansar.>"})
QuestFix(255024, {o="Escolte Viktorin Newbery para fora do Forte Coração do Ar.",p="Não há tempo para conversar. Precisamos sair daqui!"})
QuestFix(255026, {o="Recupere o cajado do Arquimago Henricus no alto da torre."})
QuestFix(255028, {p="Não sei o que essas nagas estão fazendo aqui, mas nagas tão perto do Porto de Bondebico nunca são bom sinal."})
QuestFix(255029, {p="Já encontrou? Tenho visto dragões de bronze ao sul, mas nunca consegui chegar perto. Talvez devesse procurar por lá."})
QuestFix(255030, {o="Encontre o Estalajadeiro Arnith em Burndural."})
QuestFix(255031, {o="Encontre o Caçador Ukourn em Burndural."})
QuestFix(255040, {o="Confronte o informante dos Vela Sangrenta na Angra do Butim."})
QuestFix(255041, {o="Fique ao lado da Angra do Butim e denuncie o informante ao Barão Rezingada."})
QuestFix(255042, {o="Fique ao lado dos Bucaneiros da Vela Sangrenta e aceite o suborno do informante."})
QuestFix(255043, {o="Derrote a Abominação da Chama Eterna.",p="Não deve ser nada com que se preocupar... Só prefiro não continuar pensando nisso."})
QuestFix(255044, {o="Mate Campeões, Esfoladores e Cervejeiros Cascasseca nas Terras Altas Arathi.",p="Deve haver um caminho ao norte que leva até a colina."})
QuestFix(255046, {p="Já conseguiu a pelagem e as presas, mon?"})
QuestFix(255047, {p="Se esse cristal é uma prisão, deve conter bastante poder, mon."})
QuestFix(255048, {o="Recupere o carregamento de charutos de Zebel com o fornecedor e volte até Zebel Shplit em Gadgetzan.",p="Já conseguiu meu carregamento de charutos?"})
QuestFix(255049, {o="Mate 8 Ladinos, 5 Magos das Sombras e 5 Vigias do Sindicato perto da Fortaleza de Desterro.",p="Odeio ficar aqui parado..."})
QuestFix(255050, {o="Mate 6 Altaneiros Atormentados, 6 Altaneiros Lamentadores e 6 Altaneiros Esquecidos."})
QuestFix(255051, {o="Mate 7 Espíritos Torturados e 5 Servos de Xorthal."})
QuestFix(255052, {o="Use o Pano de Polimento para limpar as estátuas nos Vestígios de Thel’Dralor."})
QuestFix(255053, {o="Colete Selos de Thel’Dralor dos espíritos Altaneiros em Thel’Dralor."})
QuestFix(255054, {o="Derrote Setheria Starsong."})
QuestFix(255055, {o="Derrote a Serpente das Nuvens Tempestívaga e recupere a bateria do zepelim.",p="<Você terá que destruir a serpente das nuvens antes de conseguir examinar a bateria direito.>"})
QuestFix(255056, {o="Encontre uma fonte de energia e restaure a bateria."})
QuestFix(255057, {o="Pratique suas habilidades contra os Recrutas da Milícia."})
QuestFix(255058, {o="Colete Carne de Cervo Chifre-sombrio para Eikta.",p="Não sei por que Mishu sempre preferiu a carne dos Cervos Chifre-sombrio. Eu nunca consegui notar diferença no sabor."})
QuestFix(255059, {o="Alimente Mishu, o urso adormecido.",p="Já o alimentou? Talvez seja pedir demais, mas espero que isso tenha algum efeito."})
QuestFix(255060, {o="Mate Trabalhadores Gan’arg e destrua Protótipos de Canhão Vil no Pântano das Mágoas.",p="Esses relatos estão perto demais do Portal Negro para o meu gosto."})
QuestFix(255061, {o="Derrote Vir’Ishar no Pântano das Mágoas."})
QuestFix(255062, {o="Escolte Ja’kani para fora do acampamento demoníaco."})
QuestFix(255063, {p="Admiro a engenhosidade dos Gan’arg, mas isso não significa que eu queira vê-la usada contra nós."})
QuestFix(255064, {o="Mate Trabalhadores Gan’arg e destrua Protótipos de Canhão Vil no Pântano das Mágoas."})
QuestFix(255065, {o="Escolte Ja’kani para fora do acampamento demoníaco."})
QuestFix(255066, {o="Derrote Vir’Ishar no Pântano das Mágoas."})
QuestFix(255067, {o="Colete as alianças de casamento sob o Cemitério do Morro do Corvo.",p="Esses anéis... eu já os vi antes..."})
QuestFix(255068, {o="Colete gemas no Monte dos Ogros Vul’Gol."})
QuestFix(255069, {o="Leve a encomenda até Eleanor Zemille.",p="Você voltou com meu precioso anel? Mal consigo conter a expectativa!"})
QuestFix(255071, {o="Encontre o estranho que permanece nos arredores da vila.",p="Já foi verificar quem é esse estranho?"})
QuestFix(255072, {o="Investigue os locais ao redor da Floresta do Crepúsculo para Quill, o Tolo.",p="Encontrou alguma coisa? Espero que não tenha sido assustador demais..."})
QuestFix(255073, {o="Mate Filhotes de Viúva Negra na Floresta do Crepúsculo.",p="Então, já cuidou daquelas aranhas terríveis?"})
QuestFix(255074, {o="Colete carne de Jovens Devastadores Negros, Mastins Devastadores Negros e Devastadores Negros.",p="Trouxe alguma coisa para mim?"})
QuestFix(255075, {o="Colete Totens do Vento de Totêmicos e Xamãs dos Bosques Negros para Losir.",p="Não desejo mal a eles, mas assim pelo menos alguns sobreviverão e a tribo poderá se reerguer com o tempo."})
QuestFix(255076, {o="Derrote Ursas e Guerreiros dos Bosques Negros para Serevei.",p="O poder arcano é, na verdade, o poder da ordem. Tudo o que desejo é preservar a ordem destas terras."})
QuestFix(255077, {o="Purifique os cultistas mortos do Martelo do Crepúsculo usando o Estilhaço Puro de Arvekor.",p="Não podemos ignorar um inimigo só porque um dia foi nosso amigo. Por mais que doa, precisamos agir se quisermos sobreviver."})
QuestFix(255078, {o="Raj’iri quer dançar com a irmã, mas Naj’iri não está no clima. Talvez um pouco de música ajude. Consiga uma Flauta de Vento Centauro com Domadores e Tempestuosos Kolkar.",p="E aí, mon! Teve sorte?"})
QuestFix(255080, {p="Já voltou! Conseguiu o tambor?"})
QuestFix(255082, {o="Voltzix Sprocketpop quer que você elimine as forças da Empreendimentos S.A. no campo de lodo ao norte.",p="Já acabaram com eles?"})
QuestFix(255083, {o="Voltzix Sprocketpop quer que você elimine as forças da Empreendimentos S.A. na Mina Boulder Lode, ao norte.",p="Já acabaram com eles?"})
QuestFix(255084, {o="Recupere o Cálice de Vozes Opalinas, o Manto de Proteção Elemental e o Anel da Rainha Louca para os Guardiões.",p="Já encontrou as relíquias?"})
QuestFix(255085, {o="Colete Grimórios do Sindicato dentro da Fortaleza de Stromgarde.",p="Encontrou algum grimório na fortaleza até agora?"})
QuestFix(255086, {o="Verifique como está Stephana Fryth, a soldado de Stromgarde que vem agindo de forma estranha.",p="Conheço Stephana desde antes da queda da fortaleza. Não consigo deixar de me preocupar; alguma coisa nisso não me agrada..."})
QuestFix(255087, {o="Mate Espancadores e Xamãs Punho de Pedra."})
QuestFix(255088, {o="Use as Lentes da Visão Verdadeira para procurar sombras fora do lugar na Fortaleza de Stromgarde.",p="Ouvi dizer que Alaric pediu que você investigasse o incidente com Fryth. Eu preferia que se concentrasse nas ameaças mais óbvias, mas ela era uma boa soldado e Alaric sempre cumpriu seu dever. Prossiga, se desejar."})
QuestFix(255089, {o="Mate o Tecelão de Espectros do Sindicato na Fortaleza de Stromgarde.",p="Você consegue me perceber até agora? Que interessante..."})
QuestFix(255090, {o="Mate Thalanas, o Louco, na estrada para a Propriedade Northfold.",p="Ouviu falar de outro membro do Sindicato? Então pode muito bem cuidar disso também."})
QuestFix(255091, {o="Informe o povo restante de Stromgarde sobre a decisão de Alaric.",p="É uma decisão difícil, mas não posso sacrificar mais vidas em uma batalha perdida."})
QuestFix(255093, {o="Fale com o Tenente Valorcall."})
QuestFix(255094, {o="Intercepte Zengu na Ponte Thandol e recupere Trol’kalar."})
QuestFix(255095, {o="Resista à Rainha Sybell."})
QuestFix(255096, {o="Caminhe com o Tenente Valorcall."})
QuestFix(255098, {p="Olá. Está procurando por mim?"})
QuestFix(255099, {p="Vai a algum lugar? Pense duas vezes antes de sair sem um dos meus hipogrifos."})
QuestFix(255101, {o="Use o Orbe de Subterfúgio na Montanha Rocha Negra e leve a Missiva de Vaelastrasz até Ralestrasza, perto do Desgaste Rubi, nos Pantanais."})
QuestFix(255102, {o="Encontre o Artífice Baraal no Porto de Menethil e descubra por que ele ainda não chegou a Dun Algaz."})
QuestFix(255103, {o="Encontre as peças perdidas do robô do Artífice Baraal."})
QuestFix(255104, {o="Informe aos gnomos de Dun Algaz que Baraal se reunirá com eles em breve."})
QuestFix(255105, {o="Encontre o robô desaparecido em Thelgen Rock."})
QuestFix(255106, {o="Leve o robô ao Engenheiro de Dun Algaz antes que ele se autodestrua.",p="Oh? Tem alguma coisa para mim?"})
QuestFix(255107, {o="Encontre Edmund Crestfall na Fortaleza de Desterro."})
QuestFix(255109, {o="Fale com o Fazendeiro Sal na Propriedade Alestone."})
QuestFix(255110, {o="Fale com o Fazendeiro Sal na Propriedade Alestone."})
QuestFix(255111, {o="Encontre o Rastreador de Meridianos Hestlor na Torre do Mago Vermelho em nome de Lady Idelia Solomon."})
QuestFix(255113, {o="Colete suprimentos de comida nos acampamentos de gnolls da Cordilheira Cristarrubra para Luca Tyndall."})
QuestFix(255114, {o="Recupere o Cálice de Tyrenel para o Padre Norice.",p="O Cálice de Tyrenel permaneceu nesta capela por gerações. Não podemos permitir que seja perdido."})
QuestFix(255116, {o="Mate Tarântulas Maiores ao redor da Serraria de Alther para ajudar o povo de Lakeshire a recuperar a região."})
QuestFix(255117, {o="Colete Tábuas de Madeira na Serraria de Alther para o Encarregado Oslow.",p="É melhor trazer uma boa quantidade. Não sei de quantas ainda vou precisar antes que os ataques terminem."})
QuestFix(255118, {o="Busque água na base da cachoeira para Monika Sengutz.",p="Não me diga que já terminou...?"})
QuestFix(255119, {o="Busque água do mar na foz do rio para Monika Sengutz.",p="Quase perguntei se viu alguém que eu conhecia em Costa Sul... mas talvez seja melhor não saber."})
QuestFix(255120, {o="Busque um balde de água pestilenta na cachoeira do Lago Darrowmere, na fronteira das Terras Pestilentas Ocidentais.",p="Já foi buscar a água? Meus ossos doem só de pensar nessa viagem..."})
QuestFix(255121, {o="Entregue a refeição de Derak às irmãs Evermorne na estalagem da Serraria Tarren.",p="Mmmm... Que cheiro delicioso é esse?"})
QuestFix(255122, {p="Encontrou alguma coisa, mon?"})
QuestFix(255127, {o="Use o Extrator de Essência de Bergamont Lestern em humanos mortos em Strahnbrad."})
QuestFix(255130, {o="Procure a chave nas salas de interrogatório.",p="Encontrou a chave nas salas de interrogatório?"})
QuestFix(255131, {o="Procure a chave nas salas orientais.",p="Diga que encontrou a chave nas salas orientais."})
QuestFix(255132, {p="Esses traidores já foram punidos?"})
QuestFix(255134, {o="Mate o Cronista Harvey e recupere a Chave da Cela de Fosso Macabro.",p="Tem a chave? Diga que foi o Cronista que estava com ela."})
QuestFix(255135, {o="Mate Rotmaw e informe o Boticário Holm no Sepulcro.",p="Rotmaw está morto?"})
QuestFix(255136, {p="Você trouxe notícias de Fosso Macabro? Deixe-me ver esse diário."})
QuestFix(255140, {o="Fortaleça 10 Sentinelas ou Defensores da Eira dos Montes na Mina Lazúli usando Óleo Sagrado de Armas."})
QuestFix(255141, {o="Recupere 15 pedaços de Minério de Azurita dos Mineradores da Eira dos Montes na Mina Lazúli.",p="Essas pedras não vão se minerar sozinhas, você sabe..."})
QuestFix(255142, {o="Entregue o Bilhete Elegantemente Selado do Conselheiro Belview ao Arquimago Ansirem Tecerrunas, perto da Cratera de Dalaran, nas Montanhas Alterac."})
QuestFix(255144, {o="Vasculhe os montes de escombros em busca de materiais reaproveitáveis e entregue-os aos trabalhadores de Dalaran na Cratera de Dalaran.",p="Você está imundo. Imagino que a coleta esteja indo bem?"})
QuestFix(255145, {o="Destrua a Anomalia Arcana na borda leste da Cratera de Dalaran."})
QuestFix(255146, {o="Volte ao Conselheiro Belview em Costa Sul e conte sobre seu trabalho na Cratera de Dalaran.",p="O Arquimago disse o quê?"})
QuestFix(255147, {o="Derrote 6 Saqueadores e 6 Escravos Ravenclaw nas Terras de Olsen."})
QuestFix(255148, {o="Ajude o Padre Dayton a dar descanso aos espíritos da família Denholm no Campo Morto."})
QuestFix(255149, {o="Mate Silkshadow na Eira dos Montes.",p="O covil dela fica a leste, perto da muralha, onde pode atacar viajantes... É esperta, não é?"})
QuestFix(255150, {o="Mate Highclaw na Eira dos Montes.",p="Então... está feito?"})
QuestFix(255151, {o="Recupere 8 Relíquias Roubadas do Sindicato na Fortaleza de Desterro.",p="Conseguiu localizar algum de nossos carregamentos?"})
QuestFix(255152, {o="Leve o pacote de relíquias danificadas ao representante da Liga dos Exploradores em Costa Sul."})
QuestFix(255153, {o="Entregue em segurança a caixa de relíquias extremamente frágeis ao Arqueólogo Flagongut no Porto de Menethil.",p="Eu não estava esperando uma entrega..."})
QuestFix(255154, {o="Leve o pagamento do arqueólogo de volta ao Historiador Wendell em Costa Sul.",p="Você voltou! Mas... onde estão as relíquias?"})
QuestFix(255157, {p="Estamos quase prontos para sair da casa da minha filha, mas parece que sempre preciso de mais tecido. Se encontrar runatrama sobrando, ela será muito bem aproveitada aqui."})
QuestFix(255159, {p="A barricada continua firme e, com a batalha finalmente virando a nosso favor, comecei a ouvir conversas sobre o futuro. Talvez seja otimismo demais, mas depois de tudo que passamos, um pouco de esperança não faz mal.\n\nQuando expulsarmos o Sindicato, ainda haverá muito trabalho para restaurar a fortaleza, e precisaremos de bastante material de construção. Se encontrar Madeira do Bosque sobrando, ela será muito bem-vinda."})
QuestFix(980000, {o="Colete um Núcleo de Esmagador Corrompido e uma Lança de Ogro Ensanguentada."})
QuestFix(980004, {o="Recupere as poções roubadas nos acampamentos dos Défias em Cerro Oeste."})
QuestFix(980104, {o="Assassine a Subjugadora Vaz’shir e mate Guardas do Terror dentro de Oshu’gun."})
QuestFix(980105, {o="Assassine Zorbo, o Conselheiro, e os ogros Malho Guerreiro nas Ruínas Gargaveira."})
QuestFix(980106, {o="Mate os cultistas Sombra da Morte na Crista do Crepúsculo."})
QuestFix(980107, {o="Mate os Supervisores dos Campos-forja e seus seguidores no Campo-forja: Ódio e no Campo-forja: Medo."})
QuestFix(980112, {o="Assassine os ogros Giralança nos arredores do Covil de Gruul."})
QuestFix(980113, {o="Execute Baelmon, o Mestre dos Cães, e seus lacaios no Portão da Morte."})
QuestFix(980114, {o="Destrua os Portadores da Chama Abissal, Javalis Cascadura e Cães da Ira no alto do Pináculo do Vórtice."})
QuestFix(980115, {o="Elimine Corvos Desprezados e Arautos Grishna e derrote a Matriarca Grishna."})
QuestFix(980120, {o="Cace a fauna dentro do Ecodomo do Meio."})
QuestFix(980121, {o="Mate Cragskaar e os Rompedores Farahlon em Pedranévoa."})
QuestFix(980122, {o="Limpe a Mina Trellium sob a Manaforja Ara e o Poço de Acesso Zeon sob a Manaforja Ultris."})
QuestFix(980123, {o="Devaste as forças da Manaforja Duro e da Manaforja Coruu."})
QuestFix(980128, {o="Extermine as nagas na Cisterna Serpentália."})
QuestFix(980129, {o="Ataque a Forja da Morte. Mate os Guardiões da Forja da Morte e colete o cajado do Evocador Skartax e Estilhaços de Alma Retorcida de seus evocadores."})
QuestFix(980130, {o="Derrote os Mestres Caçadores de Demônios nas Ruínas de Karabor."})
QuestFix(980131, {o="Massacre os peões Presa do Dragão e os Ascendentes Presa do Dragão que os supervisionam no Arrecife Asa Etérea."})
QuestFix(980232, {o="Elimine os etéreos Vir’aani nos arredores de Oshu’gun."})
QuestFix(980233, {o="Mate as criaturas do Caos nos arredores de Oshu’gun."})
QuestFix(980234, {o="Mate os ogros Punho de Pedra na Fenda do Vento Norte e na Fenda do Vento Sul."})
QuestFix(980235, {o="Extermine as Criaturas de Lama sob Halaa."})
QuestFix(980236, {o="Extermine os Sangue Turvo no Posto Solavera."})
QuestFix(980237, {o="Mate os arakkoas Ruuan’ok e os cultistas do Culto das Serpes Asa Negra no Bosque Ruuan."})
QuestFix(980238, {o="Mate os ogros Malho Sangrento no Cânion Malho Sangrento."})
QuestFix(980239, {o="Extermine os Dracos Etéreos Menores e os Esfoladores de Cristal na Crista Harmônica."})
QuestFix(980240, {o="Mate os arakkoas que vivem no Véu Vekh."})
QuestFix(980241, {o="Elimine os ogros Boulder’mok e os cultistas do Culto das Serpes Asa Negra na Mata do Corvo."})
QuestFix(980242, {o="Mate Engenheiros Gan’arg e Ferreiros da Perdição Mo’arg."})
QuestFix(980243, {o="Vingue-se do Cão de Culuthas e do Olho de Culuthas nas Ruínas de Farahlon."})
QuestFix(980244, {o="Mate os etéreos Zaxxis que vivem nos Destroços."})
QuestFix(980245, {o="Mate os elfos sangrentos Solfúria da Manaforja B’naar."})
QuestFix(980246, {o="Mate os draeneis Desencarnados nas Ruínas de Enkaat e os demônios Arklon nas Ruínas de Arklon."})
QuestFix(980247, {o="Mate os Partidos Grislíngua e os Supervisores Illidari nas Ruínas de Baa’ri."})
QuestFix(980248, {o="Mate as Sereias Serpentália que vivem no Pontal Serpentália."})
QuestFix(980249, {o="Massacre os Dimetrodontes Fogo Vil e os Javalis Vis nos Campos de Magma."})
QuestFix(980250, {o="Acabe com os demônios Illidari que vivem no Pontal Illidari."})
QuestFix(980251, {o="Mate os orcs Presa do Dragão que vivem na Fortaleza Presa do Dragão."})
QuestFix(980252, {o="Elimine os habitantes da Vila Charco das Feras no Pântano Zíngaro."})
QuestFix(980253, {o="Elimine os habitantes da Praia Cristanegra no Pântano Zíngaro."})
QuestFix(980254, {o="Elimine os habitantes do Charco Fantasma no Pântano Zíngaro."})
QuestFix(980255, {o="Elimine os habitantes das Terras Sangrescama no Pântano Zíngaro."})
QuestFix(980256, {o="Elimine os habitantes do Vale dos Rebentos no Pântano Zíngaro."})
QuestFix(980257, {o="Elimine os habitantes das Terras de Ango’rosh no Pântano Zíngaro."})
QuestFix(980258, {o="Elimine os habitantes da Fortaleza Ango’rosh no Pântano Zíngaro."})
QuestFix(980259, {o="Elimine os habitantes dos Picos da Barreira na Mata Terokkar."})
QuestFix(980260, {o="Elimine os habitantes de Tuurem na Mata Terokkar."})
QuestFix(980261, {o="Elimine os habitantes do Pontal Asardente na Mata Terokkar."})
QuestFix(980262, {o="Elimine os habitantes de Skettis na Mata Terokkar."})
QuestFix(980263, {o="Elimine os habitantes do Véu Shalas na Mata Terokkar."})
QuestFix(980264, {o="Elimine os habitantes da Tumba das Luzes na Mata Terokkar."})
QuestFix(980265, {o="Elimine os habitantes das Ruínas dos Olhos Sangrentos na Mata Terokkar."})
QuestFix(980266, {o="Elimine os habitantes das Ruínas Mascaosso na Mata Terokkar."})
QuestFix(980267, {o="Elimine os habitantes da Tumba Sombria na Mata Terokkar."})
QuestFix(980268, {o="Elimine os habitantes da Aldeia do Charco Sombrio no Pântano Zíngaro."})
QuestFix(980269, {o="Elimine os habitantes da Aldeia Lamadaga no Pântano Zíngaro."})
QuestFix(1650021, {o="Acorde os trabalhadores oferecendo o que cada um pedir. Depois, leve um café a Durgan.",p="Quero sentir o rugido das máquinas funcionando a plena potência."})
QuestFix(1650026, {o="Elimine os membros da Horda, queime os navios e enfrente o líder da operação no acampamento da Horda na praia.",p="Partir sem expulsar a Horda de nossas praias seria imprudente."})
QuestFix(1650027, {o="Neutralize os reservatórios de praga e mate o Necromante Venthral.",p="Uma criação como a Praga dos traidores nunca trará nada de bom. É nosso dever erradicar tudo o que esses monstros fizeram."})
QuestFix(1650100, {o="Use o elevador na Fenda das Sombras em Orgrimmar e mostre a carta ao Renegado chamado Caindres, na fonte das Profundezas de Orgrimmar.",p="<A mão do Renegado vai direto ao punhal quando você se aproxima.>"})
QuestFix(1650105, {o="Espanque o espião da Aliança até que ele confesse tudo o que sabe.",p="Está com um nó no estômago? Ou existe outro motivo para ainda não ter começado o serviço?"})
QuestFix(1650108, {o="Vá até o Refúgio de Vil, o Vesgo, no fim do Distrito do Caldeirão, nas Profundezas de Orgrimmar, e coloque o sedativo nas bebidas dos soldados da Horda.",p="A gente se conhece?"})
QuestFix(1650110, {o="Encontre pistas dos Renegados desaparecidos e use Barguist para rastreá-los."})
QuestFix(1650111, {o="Derrote 12 Iluminados dos Patriarcas e liberte 4 Pacientes Renegados na Gruta dos Patriarcas."})
QuestFix(1650113, {o="Fale com Lucranta no Covil de Lucranta, nas Profundezas de Orgrimmar, e assegure o controle dos pacificados."})
QuestFix(1650117, {o="Mostre o selo de Kagtha no quartel dos Dardos e peça uma audiência com a Duquesa."})
QuestFix(1650119, {o="Elimine 10 morcegos usando os arpões na Coroa de Madeira, nas Profundezas de Orgrimmar.",p="Ainda consigo ouvir os guinchos daqueles ratos voadores.\n\nVai se livrar dos morcegos ou devo deixar Ardayn apodrecer na cela?"})
QuestFix(1650120, {o="Use a chave para abrir a jaula de Ardayn na Coroa de Madeira, nas Profundezas de Orgrimmar, e desamarre-o."})
QuestFix(1650124, {o="Volte até Kagtha e informe o paradeiro de Glotka e sua disposição para fechar o acordo."})
QuestFix(1650127, {p="Lembre-se: coloque os documentos no baú do comandante inimigo. Precisamos que Garrosh e os Kor’kron culpem a Aliança pelos incêndios da Colina Navalha."})
QuestFix(1650129, {o="Avise Kagtha quando estiver pronto para partir rumo ao Arquipélago Azzar."})
QuestFix(1650131, {p="<A Duquesa boceja, irradiando um tédio verdadeiramente imperial.>\n\nAh, não, claro... não se preocupe. Leve todo o tempo de que precisar..."})
QuestFix(1650236, {o="Distribua 10 garrafas de Água Refrescante da Selma aos apertadores de porcas da montanha-russa."})
QuestFix(1650274, {o="Distribua 10 garrafas de Água Refrescante da Selma aos apertadores de porcas da montanha-russa."})


QuestFix(255018, {d="Os Presa do Dragão ainda mantêm muitos cativos, pobres crianças obrigadas a servir a todos os caprichos deles. Conheço bem demais a dor que devem sentir, a impotência de sequer conseguir escapar.\n\nTudo o mais que peço é por Burndural, mas, enquanto estiver lá, preciso fazer um pedido pessoal também. Por favor, liberte as crianças das garras dos Presa do Dragão. Talvez sejam forçadas a resistir, mas, quando seus opressores caírem, tenho certeza de que conseguirão escapar sozinhas."})
QuestFix(255033, {d="Ora, se não é meu salvador! O que posso fazer por você? No mínimo, devo uma bebida por ter me tirado daquela enrascada.\n\nIsso me lembra: aqueles orcs levaram minha caneca favorita. Tentei procurá-la depois do ataque, mas não encontrei em lugar nenhum, e aquele sujeito de vermelho disse que eu preciso “descansar e me recuperar”.\n\nComo vou descansar se nem beber parece certo sem minha caneca? Não seria justo pedir mais uma coisa, mas, se for atrás dos Presa do Dragão de qualquer forma, poderia ficar de olho nela?",o="Recupere a caneca de Urgil dos Presa do Dragão.",p="Por favor, encontre minha caneca! Não suporto imaginar aqueles orcs quebrando-a.",c="Minha linda e preciosa caneca! Como senti sua falta!\n\nAh, e de você também, <name>. Agora lhe devo duas bebidas, e não sou o tipo de anão que gosta de deixar dívidas pendentes. Já deixei tudo acertado. É o melhor que temos por enquanto, então aproveite."})
QuestFix(255053, {d="Um grupo de historiadores pediu que alguém recolha selos rúnicos dos espíritos em Thel'Dralor para ajudar nos estudos sobre a história dos Altaneiros."})
QuestFix(255054, {d="Registros históricos sugerem que o espírito de uma poderosa maga Altaneira ainda permanece nas ruínas de Thel'Dralor. Pouco se sabe sobre Setheria Starsong, e concluíram que a melhor maneira de descobrir mais seria enviar um grupo de aventureiros para enfrentar o espírito dela e reunir informações."})
QuestFix(255098, {c="Um exemplar duplicado do livro de Thelaesa? Certo, deixe-me ver.\n\nA biblioteca dela está muito bem abastecida hoje em dia, então não chega a me surpreender. De qualquer forma, este acabou vindo no carregamento por engano, então é melhor assim."})
QuestFix(255100, {c="Ela mandou outro livro em troca?\n\nSempre foi muito atenciosa. Tenho uma boa coleção de tomos sobre nossa própria história, mas o material sobre outros povos ainda é limitado. Agora que nos juntamos à Aliança, faria bem a todos aprender mais sobre nossos novos aliados. Ficarei feliz em acrescentar este às estantes."})
QuestFix(255111, {c="Aquela imprudente da Idelia voltou rastejando para pedir nossa ajuda, foi?\n\nAh, claro. E nem se deu ao trabalho de explicar por que mandou você falar conosco em vez de vir pessoalmente. Que conveniente."})
QuestFix(255131, {d="Todos os worgens de Fosso Macabro deveriam permanecer presos e contidos. Foram trazidos para cá para que a Sociedade Real dos Boticários pudesse estudar a maldição... entendê-la e, talvez, até controlá-la. Mas, depois do que você me contou, está claro que alguém aqui busca muito mais do que simples pesquisa.\n\nNada disso importa se eu continuar acorrentada nesta cela.\n\nAs salas orientais às vezes são usadas para guardar pertences confiscados. Talvez seja lá que encontre o que procura.",c="Maldição... ainda sem chave.\n\nNecromantes, você disse!?\n\nPela Dama Sombria... eu sabia que havia algo errado!\n\nSe necromantes realmente estão soltos por este lugar, profanando cadáveres com rituais não autorizados, então meu encarceramento deixou de ser a maior preocupação.\n\nNenhum servo leal dos Renegados, louco ou não, se rebaixaria a tamanha depravação. Forçar outra pessoa à maldição da não morte... é um crime indescritível."})
QuestFix(980247, {d="Há uma recompensa pelos Partidos Grislíngua e pelos Supervisores Illidari nas Ruínas de Baa'ri. Illidan ordenou que os Grislíngua escavassem a área em busca de antigos artefatos draeneis que, segundo rumores, guardam segredos do Templo de Karabor, hoje conhecido como Templo Negro. Vá até as Ruínas de Baa'ri e reivindique a recompensa, mas cuidado, <name>: você não é o único aventureiro que aceitou este contrato. Esteja preparado para enfrentar concorrência durante a caçada!"})
QuestFix(1650010, {c="Você veio em busca de respostas, mas minha presença provavelmente levantará ainda mais perguntas.\n\nNão tema. Servimos ao SI:7 e à Aliança. Em breve, entenderá tudo o que precisa saber.\n\nBoas-vindas à Sombra, <name>."})
QuestFix(1650110, {d="A emboscada me custou um punhado de bons guerreiros. Alguns encontraram sua morte verdadeira. Outros se perderam no caos, e ainda não os encontramos.\n\n<Os olhos vermelhos de Lenara brilham como gemas cruéis. O salto da bota dela pressiona a mão do orc, fazendo os ossos estalarem sob o peso.>\n\nQuero que encontre meus homens. Barguist, nosso cão, ajudará a rastreá-los. Não se preocupe: a condição de morto-vivo não prejudicou o faro dele. Basta dar uma pista para seguir.\n\nCertifique-se de que meus guerreiros voltem inteiros — figurativamente falando, é claro.",c="Uma elfa mandou você para ajudar?"})
QuestFix(1650124, {d="Agradeço por ter me libertado. Ainda assim... isto não me parece certo. Esses soldados só estavam seguindo ordens. Espero... que você não tenha matado todos.\n\n<Glotka dá de ombros, claramente abatido. Não é a reação que se esperaria de alguém que acabou de ser libertado de uma cela.>\n\nKagtha vai querer saber que ainda estou disposto a assinar os papéis. Depois disso, não tenho muitas outras opções. Vá na frente. Preciso de um momento para me recompor...",c="Como sempre, você fez um bom trabalho, <name>. Tem meu reconhecimento.\n\nMas não podemos relaxar. Entre os espiões da Aliança e isto agora, nossa missão está em risco.\n\nPrecisamos agir rápido e concluir os preparativos antes que tenham a chance de arruinar nosso plano."})


-- Revisão do tracker e das quests clássicas que ainda escapavam em inglês/portunhol.
local QX = AscensionPTBR.QuestUIExact
if QX then
    QX["Return to Seereth Stonebreak at Greatwood Vale in Stonetalon Mountains."] = "Retorne a Seereth Quebra-pedra no Vale Matagrande, na Cordilheira das Torres de Pedra."
    QX["Retorne a Seereth Stonebreak at Greatwood Vale in Stonetalon Mountains."] = "Retorne a Seereth Quebra-pedra no Vale Matagrande, na Cordilheira das Torres de Pedra."
    QX["Return to Seereth Stonebreak at Greatwood Vale in Stonetalon Mountains"] = "Retorne a Seereth Quebra-pedra no Vale Matagrande, na Cordilheira das Torres de Pedra"
    QX["Retorne a Seereth Stonebreak at Greatwood Vale in Stonetalon Mountains"] = "Retorne a Seereth Quebra-pedra no Vale Matagrande, na Cordilheira das Torres de Pedra"
end

QuestFix(743, {
    p="As harpias Ventofúria são inimigas mortais. Sua força em combate só é superada pela sede de sangue.",
    c="Bom trabalho, $n. Você está bem $gpreparado:preparada; para seguir viagem. Que o vento esteja sempre às suas costas."
})
QuestFix(744, {
    p="Este cocar será o presente perfeito para meu irmão.",
    c="Obrigado por sua ajuda, $n.\n\nMeu trabalho no cocar está quase concluído. Agora só preciso entregá-lo ao meu irmão e presenciar a cerimônia."
})
QuestFix(745, {
    p="Se os Jubalba tivessem respeitado a terra e seus habitantes, este conflito jamais teria acontecido."
})
QuestFix(746, {
    o="Recolha 5 Picaretas do Prospector.\n\nEm uma forja, esmague as picaretas para criar Ferramentas Quebradas.\n\nLeve 5 Ferramentas Quebradas para Baine Casco Sangrento, na Aldeia Casco Sangrento.",
    p="Olá, $n. Trouxe as Ferramentas Quebradas? A escavação dos anões enfurecerá os kodos de Mulgore. Essa profanação precisa acabar!",
    c="Obrigado, $n. Isso acalmará as feras de Mulgore e, com a bênção dos espíritos, ensinará aos anões que profanar a terra não é o caminho para a sabedoria."
})
QuestFix(747, {
    p="Trazer carne e penas para a tribo é o primeiro passo para provar seu valor diante do Chefe.",
    c="Os taurens de Narache agradecem, $n. Você demonstra grande potencial."
})
QuestFix(914, {
    o="Leve as Gemas de Cobrahn, Sucurina, Pítias e Serpentis para Nara Juba Agreste, no Penhasco do Trovão."
})
QuestFix(925, {
    c="UAU! Você conseguiu a impressão do casco de Caerne Casco Sangrento para mim! Muito obrigado! E... uau! Ele ainda escreveu uma mensagem só para mim! Eu sabia que ele era incrível! Talvez algum dia eu possa agradecer pessoalmente... quando me tornar um herói da Horda!\n\nVocê é $go melhor:a melhor;, $n. Obrigado por ser tão $glegal:legal; comigo."
})
QuestFix(929, {
    c="Depois da Batalha do Monte Hyjal, ficamos sem rumo. Nordrassil ainda fumegava por causa do fogo que havia liberado, e nossa imortalidade — a própria essência do nosso povo — estava perdida.\n\nFoi nesse período difícil que o Traidor foi libertado de sua prisão e Shan'do Tempesfúria desapareceu. Foram tempos sombrios para todos nós."
})
QuestFix(1062, {
    title="Invasores Goblins",
    p="O Vale Matagrande fica a noroeste, $n. Vá. Espalhe o medo entre aqueles que saqueiam estas terras!"
})
QuestFix(1068, {
    p="Os espíritos das árvores lamentam a perda de seus irmãos, $n. Você precisa destruir os retalhadores XT:4 e XT:9, ou temo que as Torres de Pedra jamais se recuperem."
})
QuestFix(5722, {
    title="Em busca da algibeira perdida",
    o="Investigue as Cavernas Ígneas à procura do corpo de Mauren Temível Totem e examine-o em busca de quaisquer itens de interesse.",
    c="O corpo está coberto de marcas de golpes, mas as roupas e o equipamento permanecem praticamente intactos. Parece que os troggs não dão muita importância a riquezas materiais.\n\nVocê começa a revistar o corpo em busca de algo que possa interessar a Magatha."
})
QuestFix(6362, {
    p="Há poeira dos Sertões em seus ombros. Você falou com meu amigo Jahan?",
    c="Ah, um novo pacote de peles! Vou começar a trabalhá-las imediatamente.\n\nObrigado, $girmão:irmã;. Você me fez um grande favor. Pegue estas moedas pelo seu tempo e pelos custos da viagem."
})


QuestFix(779, {
    p="O Selo da Terra está aqui, com três nichos destinados às Pedras Rúnicas de Ametista, Opala e Diamante.",
    c="Ao encaixar as Pedras Rúnicas nos nichos correspondentes, um estrondo violento sacode a terra e o Selo se rompe."
})
QuestFix(780, {
    p="Os javaliços estão ficando cada vez mais agressivos. Já deixou o recado bem claro e trouxe os focinhos e flancos?",
    c="Excelente. Com estes ingredientes farei um belo ensopado, e a perda desses javaliços servirá de lição aos Costagulha."
})
QuestFix(781, {
    p="Você parece preocupado, $n. Que notícias traz?",
    c="Isto é realmente alarmante! Mas, com esta informação, podemos chamar nossos irmãos da Aldeia Casco Sangrento para ajudar a impedir o ataque. Você salvou a vida de muitos taurens, $n."
})
QuestFix(821, {
    p="Como está indo a busca?"
})
QuestFix(822, {
    p="Está sendo muito difícil encontrar esses ingredientes, $n?"
})
QuestFix(826, {
    o="Derrote Zalazane.\n\nMate 8 Trolls Vodu e 8 Trolls Enfeitiçados.\n\nLeve a Cabeça de Zalazane para Mestre Gadrin."
})

-- Campos antigos que ainda misturavam espanhol e português.
QuestFix(138, {
    p="Este parece ser o barril certo."
})
QuestFix(700, {
    c="O granito parece uma homenagem pequena diante da grandeza daquele anão, mas ninguém vive para sempre.\n\nQue este monumento atravesse as eras e lembre às futuras gerações que bravos soldados como Sully Caxias deram a vida por elas."
})
QuestFix(770, {
    c="Mal posso acreditar no que vejo! Você derrotou o grande Uivo Fantasma? Passo a olhar para você com muito respeito, jovem $c. Você demonstra uma habilidade extraordinária para a caça!\n\nMeus dias de caçador terminaram, mas eu ficaria honrado se usasse uma de minhas armas em suas jornadas.\n\nQue ela sempre atinja o alvo e traga reconhecimento a você. E que o espírito de Uivo Fantasma finalmente tenha encontrado a paz."
})
QuestFix(915, {
    p="Eu queria que fizessem outros sabores além de morango, mas ainda bem que morango é o meu favorito!"
})
QuestFix(951, {
    p="$n, sua exploração das Ruínas de Mathistra rendeu bons frutos?",
    c="Obrigado. Estas relíquias pertencem ao tempo em que Mathistra ainda resplandecia. A antiga fortaleza é apenas uma sombra do que foi, mas fragmentos da magia daquele povo permanecem. Espero que consigamos desvendar seus segredos antes dos nossos inimigos...\n\nMantenha-se alerta, $n."
})
QuestFix(981, {
    c="Eu sabia que você estaria à altura da tarefa, $n.\n\nPressinto grandes feitos em seu futuro e acredito que você corrigirá muitos dos males que assolam nossas terras. Leve minhas bênçãos, $n, e aceite também este presente."
})
QuestFix(1401, {
    p="Está feito? Você pôs fim ao sofrimento dele?"
})
QuestFix(2204, {
    p="Você nem parou para se arrumar depois de sair de Uldaman, não é? Veio direto para cá, sem se importar com o cheiro persistente da masmorra. Espero que esta visita seja apenas desagradável ao nariz, e não inútil também.\n\nTrouxe a fonte de energia para o colar?",
    c="Ora, veja só! Fico feliz que você e a fonte de energia tenham chegado inteiros. Agora que as gemas estão unidas, vou levar apenas um instante para fundir a magia da fonte ao colar. Quando terminar, ele será seu!\n\nEstá $gansioso:ansiosa;, não é? Dá até para sentir o frio na barriga! Agora... onde deixei aquele foco de feitiço?"
})
QuestFix(28661, {
    c="Ah, um trabalho prazeroso! Agora que tenho os materiais adequados, a encomenda de Jahan será fácil. Obrigado, $c."
})
QuestFix(53004, {
    c="Seu juramento foi testemunhado, $n. A partir deste momento, você será escudo e abrigo para os necessitados.\n\nO Guardião permanece onde os outros não conseguem, suporta o que os outros não suportariam e protege aqueles que não podem se defender. Seu juramento não é apenas um conjunto de palavras: ele se torna parte da sua própria essência e transforma você em um baluarte vivo contra todas as formas de dano.\n\nVocê aprenderá a tecer escudos de pura força de vontade, barreiras capazes de proteger exércitos inteiros do sopro de dragões ou de bombardeios. Sua presença inspirará coragem nos aliados e lançará dúvidas sobre os inimigos.\n\nMas entenda: o caminho do Guardião exige sacrifício. Repetidas vezes, você se colocará entre o perigo e os inocentes. Suportará a dor para que outros não precisem suportá-la. Permanecerá só diante de possibilidades impossíveis enquanto os demais recuam. Isso não é um fardo, mas um privilégio: ser o escudo que nunca se parte e a muralha que nunca cai.\n\nBoas-vindas à vigilância eterna, $n. Que o mal se despedace contra suas defesas!"
})
QuestFix(175268, {
    d="<O antigo golem permanece imóvel entre as ruínas, como mais uma estátua no pátio sacerdotal.>\n\n<Uma sucessão de imagens fragmentadas invade seus pensamentos: um templo intacto, sacerdotes Jubafria entoando cânticos, uma oferenda...>\n\n<Então a sensação muda. Exaustão. Submissão. Séculos de passos sem rumo. Guardiões privados de propósito, protegendo salões vazios e altares destruídos.>\n\n<O golem ergue lentamente uma das mãos na direção dos outros constructos que patrulham as ruínas.>\n\n<Ele quer que você lhes conceda descanso.>",
    o="Destrua os constructos drakkari no Palácio Sacerdotal para libertar os restos espirituais aprisionados dentro deles.",
    p="<O golem espera em silêncio. Uma vibração tênue percorre a pedra de seu corpo.>",
    c="<Ao retornar, o antigo golem recebe você com algo parecido com uma reverência.>\n\n<Onde os constructos tombaram, fios azul-claros de energia espiritual flutuam e desaparecem entre a neve e a rocha. Não há vozes, mas você sente algo semelhante a alívio.>\n\n<O golem estende uma mão rachada em sua direção. Por um breve instante, sua mente é preenchida por uma última impressão: uma gratidão antiga, pesada como uma montanha.>"
})
QuestFix(255012, {
    d="Estou começando a me sentir como se estivesse lidando com coelhos na fazenda: derrubamos um e logo aparecem outros três. Pela Luz, eu queria que fossem coelhos!\n\nSe pretende ajudar, mate alguns orcs até que o avanço deles desacelere. Não espero que acabe com a ofensiva por conta própria, mas ao menos nos dê um pouco de fôlego. Estou pronto para esmagar mais alguns crânios, mas os outros não estão acostumados a lutar tanto tempo sem descanso.",
    c="Você matou quantos?!\n\nRetiro o que disse sobre os coelhos. Nem eles são tão persistentes. Foi uma boa tentativa, obrigado.\n\nVamos, pessoal. Parece que ainda ficaremos aqui por um bom tempo."
})
QuestFix(255079, {
    d="Ah... então nem a flauta foi suficiente para animá-la. Que pena, amigo. A melodia era doce, mas o coração dela continua pesado.\n\nMas não vamos desistir! Precisamos apenas de algo mais forte, mais barulhento... um tambor! É disso que precisamos!\n\nRhuna, a curtidora, poderia costurar um para nós se tivesse os materiais certos. Você faria isso por minha pobre irmã mais velha?",
    c="Precisa de um tambor, é?\n\nVeio ao lugar certo. Ninguém nos Sertões trabalha o couro melhor do que eu!"
})
QuestFix(255151, {
    d="Um grupo de saqueadores nos atacou perto da Fortaleza de Desterro — ou do que restou dela.\n\nNossa companhia transportava várias relíquias pela estrada principal e esperava repelir qualquer ladrão que cruzasse nosso caminho. Infelizmente, falhamos e ainda estamos nos recuperando da viagem.\n\nVocê poderia recuperar nossos pertences roubados antes que esses saqueadores destruam peças tão valiosas da história?",
    c="Ahá! Você as encontrou...\n\n<O Historiador examina as relíquias, e a expressão dele desaba.>\n\nAh... não..."
})
QuestFix(499997, {
    d="Escute bem, $r. Coelhos são criaturas magníficas. São gentis e confiantes, além de terem os pelos mais macios dos Reinos do Leste. Dá para fazer praticamente qualquer peça confortável com pele de coelho: botas, luvas, roupas de baixo. Foi por isso que veio, não é? Procurando um belo par de ceroulas de pele de coelho?\n\n[Opção de diálogo: Não, George. Coelhos são amigos, não acessórios.]\n\nOra, que resposta adorável. Então me diga, $r: se ama tanto os coelhos, estaria disposto a fazer qualquer coisa por eles? Até mesmo provar sua lealdade trazendo uma cenoura bem grande?",
    o="Prove a George Candarte que você é amigo dos coelhos levando até ele uma Cenoura Grande.",
    p="Ora, essa é a maior cenoura que já vi na vida."
})
QuestFix(499999, {
    d="Ah, bom dia, $r. Os espíritos desejam a você uma feliz Jardinova. Pena que a ocasião não seja tão feliz para eles...\n\nUma estranha tristeza emana dos nobres espíritos, herói. Ao longe, em Mulgore, algo clama em desespero. Você estaria disposto a viajar até lá e descobrir a origem dessa tristeza? A Jardinova deveria ser uma ocasião alegre para todos.",
    o="Viaje até Mulgore e descubra a origem da tristeza.",
    p="Jardinova — texto provisório nº 14."
})
QuestFix(500005, {
    d="Mandaram você? Se for mais um daqueles gerentes de contrato imprestáveis, dê meia-volta e volte por onde veio. Estou atolado em encomendas ruins e papelada ainda pior.\n\nAcabamos de receber um pedido extra de Altaforja. Grande e urgente. Em vez de mandarem mais trabalhadores, trocaram toda a equipe de lenhadores. Não há tempo para treinamento nem planejamento; só querem o serviço pronto.\n\nEstou atrasado, e odeio ficar atrasado. Se sabe usar um machado e não se importa com o frio, sua ajuda seria bem-vinda. Precisamos de doze Troncos de Pinheiro Gélido das árvores próximas.\n\nNão é caridade. Garanto que valerá a pena.",
    o="Derrube árvores próximas ao Acampamento Talhafrio, em Dun Morogh, e traga 12 Troncos de Pinheiro Gélido.",
    c="Isto serve. Não está perfeito, mas é melhor do que nada. Você acabou de me livrar de um sermão e de uma noite congelante fora do alojamento.\n\nPegue isto. Você merece mais do que apenas um agradecimento."
})
QuestFix(4004, {
    c="<Thrall fica visivelmente abalado com as informações que você trouxe.>\n\nUma nova ameaça surge no horizonte. À medida que os anos de Magni chegam ao fim, abre-se o caminho para que uma criança ainda não nascida dos Ferro Negro governe Altaforja.\n\nVocê cumpriu a tarefa que lhe confiei e será $grecompensado:recompensada; por isso.\n\nAgora vá, $n. Preciso conversar com Sylvana e Caerne."
})
QuestFix(9370, {
    p="Você voltou, $n. Pôs fim à loucura dos draeneis?"
})
QuestFix(9518, {
    p="Enquanto o Feitor Gorthak viver, continuarei combatendo-o. Que notícias você traz, $n?"
})
QuestFix(13043, {
    p="Você recuperou o tomo do doutor, mas não acabou com ele usando o gigante de carne?\n\nVolte lá e mate-o antes que seja tarde demais!"
})
QuestFix(13164, {
    p="Finalmente estamos livres daquele aspirante a Arthas?"
})
QuestFix(13190, {
    c="Ah!\n\nQue o odor zombeteiro do fracasso consuma as almas vazias deles!\n\nObrigado, $c. Hoje você desferiu um golpe contra os mortos-vivos."
})
QuestFix(13283, {
    c="Eu sabia que você era a pessoa certa para este trabalho!\n\nTenho que admitir: neste momento, você é meu $c favorito de todos os tempos.\n\nQue tal repetir a façanha amanhã? Posso recompensar bem seu esforço."
})
QuestFix(13307, {
    p="Você matou os portadores dos estandartes e impediu a tentativa deles de usar os caídos contra nós?"
})
QuestFix(24562, {
    c="Espero que entenda que não posso simplesmente permitir sua entrada na Nascente do Sol, $n. Este é o lugar mais sagrado dos sin'dorei, e só recentemente recuperamos o controle dele.\n\nVocê pretende alimentar as esperanças do nosso povo com histórias sobre Quel'Delar? Sem uma prova da veracidade de suas afirmações, não tenho motivo para acreditar em sua palavra."
})
QuestFix(49986, {
    d="Que visão magnífica, $n! Esta escritura brilha com a luz cálida da aurora, e sua leitura me enche de esperança e vigor renovados. O texto dourado fala da cura por meio da energia solar e da canalização do poder vital do sol. Uma magia tão radiante traz apenas bênçãos e renovação ao mundo.",
    o="Leia a Escritura Solar e procure a Capelã Nysoni no Vale de Vila Norte.",
    p="Sua presença aquece este lugar sagrado, $n. Trouxe a Escritura Solar? A bênção do sol flui por aqueles escolhidos para curar.",
    c="Você recebeu a bênção, $n! A luz radiante do sol flui por seu ser, marcando você como alguém escolhido para a cura e a renovação. Como Clérigo Solar, você levará esperança aos desesperados e luz aos lugares mais sombrios.\n\nSeu caminho de cura começa agora. Que sua luz jamais se apague e que você sempre leve a aurora aos que se perderam nas trevas."
})
QuestFix(255075, {
    d="Dos quatro, eu era quem melhor conhecia a tribo Bosque Negro. Muitos deles já dominaram o poder do vento e, embora suas mentes tenham sido corrompidas, vários ainda conservam essa habilidade.\n\nNão tenho forças para salvá-los, mas talvez eles próprios ainda tenham. Embora me desagrade pedir que os machuque, traga os totens que abençoei em nome deles. Muitos ainda os carregam.\n\nTalvez o vento ainda consiga levar embora a corrupção.",
    o="Colete Totens do Vento dos Totêmicos e Xamãs Bosque Negro para Losir.",
    p="Não quero que sofram, mas assim ao menos alguns poderão viver, e a tribo terá a chance de se reerguer com o tempo.",
    c="Eu nunca quis tomar de volta os totens que abençoei, mas, no estado atual, eles não conseguem usar essas bênçãos.\n\nPode levar algum tempo, mas farei tudo o que puder para salvá-los. Obrigado."
})
QuestFix(255114, {
    title="Bênçãos da Luz"
})

-- Revisão em blocos: missões clássicas, contratos e murais de comando.
QuestFix(639, {o="Obtenha o Selo de Strom para Zengu, em Ruína do Martelo.",p="Já encontrou o primeiro selo? É provável que um dos agentes da Camarilha em Stromgarde esteja com ele.",c="Excelente, camarada. É um bom começo. Precisaremos de todos os selos para retirar Trol'kalar da tumba de Matatroll."})
QuestFix(640, {o="Recupere os 5 Fragmentos do Selo dos defensores de Stromgarde e leve-os a Tor'gan, em Ruína do Martelo.",c="Ah, você precisa que eu reconstrua este selo? Não será difícil... Todas as peças estão aqui, e restaurar a estrutura mágica será simples.\n\nTalvez seja melhor fechar os olhos."})
QuestFix(641, {o="Leve o Selo de Thoradin restaurado para Zengu, em Ruína do Martelo.",p="$n! Trouxe o segundo selo?",c="Já estamos na metade do caminho para retirar Trol'kalar da tumba de Matatroll. Ainda não sabemos exatamente onde está o terceiro selo, pois seus portadores circulam bastante por Arathi, mas confio que você o encontrará."})
QuestFix(643, {o="Recupere o Selo de Arathor e leve-o a Zengu, em Ruína do Martelo.",p="Valente não será fácil de localizar, $n. Montado, ele percorre grandes distâncias rapidamente. Ainda assim, precisamos do selo.",c="A perda do líder da cavalaria será um duro golpe para os defensores de Stromgarde. Melhor ainda: agora falta apenas um selo para tomarmos Trol'kalar."})
QuestFix(644, {o="Mate o Príncipe Galen Matatroll e leve o Selo de Matatroll para Zengu, em Ruína do Martelo.",p="Você voltou, $n. A linhagem de Ignaeus Matatroll foi encerrada?",c="Este é um grande dia, $c. O sangue de Matatroll não assombrará mais meu povo, e os selos necessários para obter Trol'kalar estão em nossas mãos. Em breve atacaremos os odiados trolls de Zul'Gurub."})
QuestFix(645, {o="Recupere Trol'kalar na tumba de Matatroll, em Stromgarde.",p="As gravações na pedra da tumba de Matatroll correspondem às linhas brilhantes do Selo de Ignaeus..."})
QuestFix(2380, {c="É importante que a Mão Despedaçada permaneça alerta diante das mudanças que Thrall pretende trazer à Horda. Nossos números não bastarão para superar o governo dele: precisamos dominar a furtividade e a dissimulação."})
QuestFix(3781, {p="Que a paz e a serenidade acompanhem você. Veio a serviço do próprio arquidruida, não é?"})
QuestFix(3782, {p="Que a paz e a serenidade acompanhem você. Veio a serviço do próprio arquidruida, não é?"})

local cenarionSkinner = "Um Sinalizador Cenariano permite que um esfolador experiente identifique retalhos de pele contaminada nas criaturas caçadas na Selva Maleva. Transformo esses retalhos aparentemente inúteis em uma pasta espessa, usada como catalisador para o Bálsamo Vegetal Cenariano. Ao esfolar suas presas na Selva Maleva, mantenha um sinalizador com você.\n\nQuando obtiver Retalhos Contaminados, traga-os para mim e entregarei alguns bálsamos já preparados."
local cenarionComplete = "É exatamente disso que preciso. Pegue estes Bálsamos Vegetais e use-os para recuperar a Selva Maleva da corrupção. Precisamos perseverar, $n!"
for _, id in ipairs({4106, 4111, 5885, 5890}) do QuestFix(id, {p=cenarionSkinner,c=cenarionComplete}) end

local dawnMantle = "Seu serviço à Aurora Argêntea merece reconhecimento, $n. Você é verdadeiramente reverenciado entre nós. Fui autorizado a permitir que adquira um dos itens mais valiosos da Aurora: nossos mantos de resistência mágica.\n\nAplicar um desses mantos às suas ombreiras aumentará sua resistência à magia de uma entre cinco maneiras. Como prova de sua dedicação contínua à causa, peço dez Símbolos de Bravura em troca do acesso aos mantos."
local dawnProgress = "Ah, nobre $c! Trouxe os Símbolos de Bravura solicitados? Quando entregá-los, nossos diversos mantos ficarão disponíveis para compra."
local dawnComplete = "Excelente! Sua contribuição à Aurora foi devidamente registrada, $n. Agora posso disponibilizar nossos mantos para compra. Enquanto mantiver sua reputação conosco, poderá adquiri-los com qualquer intendente autorizado da Aurora Argêntea.\n\nPela Aurora, $gmeu irmão:minha irmã;!"
QuestFix(5504, {d=dawnMantle,p=dawnProgress,c=dawnComplete})
QuestFix(5507, {d=dawnMantle,p=dawnProgress,c=dawnComplete})

local allianceCommand = {
 [14206]={d="Por ordem de Sua Alteza Real, todos os cidadãos aptos da Aliança devem se apresentar a Manivela Chumbomela, na Angra do Butim.\n\nSiga ao sul pelo Cabo do Espinhaço até a movimentada cidade portuária goblínica. Manivela fica próximo às docas e precisa de ajuda em tarefas importantes para o equilíbrio de poder na região.\n\nPela glória e honra da Aliança!",o="Apresente-se a Manivela Chumbomela na Angra do Butim, no Cabo do Espinhaço."},
 [14207]={d="Por ordem de Sua Alteza Real, todos os cidadãos aptos da Aliança devem se apresentar ao Intendente Lungertz, na Fortaleza de Etergarde.\n\nA guarnição precisa urgentemente de ajuda na Barreira do Inferno. Siga ao sul pelo Pântano das Mágoas e tome a estrada para leste até a fortaleza.\n\nPela glória e honra da Aliança!",o="Apresente-se ao Intendente Lungertz na Fortaleza de Etergarde."},
 [14208]={d="Por ordem de Sua Alteza Real, todos os cidadãos aptos da Aliança devem se apresentar à Comandante Althea Ebanez, em Vila Sombria.\n\nPara chegar a Vila Sombria, no Bosque do Crepúsculo, siga pela estrada ao sul entre a Floresta de Elwynn e as Montanhas Cristarrubra.\n\nPela glória e honra da Aliança!",o="Apresente-se à Comandante Althea Ebanez em Vila Sombria, no Bosque do Crepúsculo."},
 [14210]={d="Por ordem de Sua Alteza Real, todos os cidadãos aptos da Aliança devem se apresentar a Oralius, na Vigília de Morgan, nas Estepes Ardentes.\n\nSua ajuda é urgente para deter a ameaça dos orcs Rocha Negra. Atravesse a Montanha Rocha Negra ao sul da Garganta Abrasadora para chegar às Estepes Ardentes.\n\nPela glória e honra da Aliança!",o="Apresente-se a Oralius na Vigília de Morgan, nas Estepes Ardentes."},
}
for id, patch in pairs(allianceCommand) do QuestFix(id, patch) end

local hordeReports = {
 [14230]="Greta Casco Musgoso no Santuário Esmeralda, na Selva Maleva",
 [14231]="Mitsuwa no Posto Avançado Zoram'gar, no Vale Gris",
 [14232]="Sergra Espinho Negro na Encruzilhada, nos Sertões",
 [14233]="Mebok Borratrelha em Vila Catraca, nos Sertões",
 [14234]="Maggran Moldaterra no Retiro Rocha do Sol, nas Cordilheiras das Torres de Pedra",
 [14235]="Takata Lamináurea no Posto do Andarilho Fantasma, em Desolação",
 [14236]="Krog na Aldeia Muralha Verde, no Pântano Vadeoso",
 [14237]="Mandingueiro Uzer'i no Acampamento Mojache, em Feralas",
 [14238]="Hagar Casco de Raio no Morro Livre dos Ventos, nas Mil Agulhas",
 [14239]="Engenheiro-chefe Parafuseta em Geringontzan, em Tanaris",
 [14240]="Williden Marechal no Refúgio do Marechal, na Cratera Un'Goro",
 [14241]="Clamaventos Chifre Altivo no Forte Cenariano, em Silithus",
 [14242]="Dalar Tecelauro no Sepulcro, na Floresta de Pinhaprata",
 [14243]="Sicário Samsa na Serraria Tarren, na Contraforte de Eira dos Montes",
 [14244]="Tor'gan em Ruína do Martelo, nas Terras Altas Arathi",
 [14245]="Otho Moji'ko na Aldeia Revatusco, nas Terras Agrestes",
 [14246]="Alto-executor Derrington no Baluarte, nas Terras Pestilentas Ocidentais",
 [14247]="Arquimaga Angela Dosantos na Capela Esperança da Luz, nas Terras Pestilentas Orientais",
 [14248]="Hansel Mãos-pesadas no Posto de Tório, na Garganta Abrasadora",
 [14249]="Gorn em Karrath, nos Ermos",
 [14250]="Dar em Pedregal, no Pântano das Mágoas",
}
for id, destination in pairs(hordeReports) do
    QuestFix(id, {
        d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a " .. destination .. ".\n\nAs forças da Horda na região precisam de reforços. O destino chama!",
        o="Apresente-se a " .. destination .. ".",
        c="Pela força e pela fúria da Horda!",
    })
end

-- Campos que existiam, mas ainda estavam em espanhol ou portunhol.
QuestFix(2848, {
    p="Trouxe os seis Kits de Armadura Grossa e a Vinha Selvagem?\n\nNão pense que confeccionar kits de armadura é um trabalho monótono. A prática constante desenvolve a precisão necessária para produzir peças de Couro Silvestre. Há um bom motivo para este exercício.",
    c="Estes kits de armadura são de excelente qualidade, $n. Se há algo que exijo no meu trabalho e no de quem trabalha comigo, é qualidade.\n\nVocê fez por merecer este molde. Espero que ele lhe traga tantas recompensas quanto trouxe a mim."
})
QuestFix(2855, {
    p="Trouxe os seis Kits de Armadura Grossa e a Vinha Selvagem?\n\nConsidere a confecção dos kits uma lição de técnica e consistência. A prática prepara suas mãos para o trabalho delicado exigido pelas armaduras de Couro Silvestre. Toda lição tem um propósito, $n.",
    c="Estes kits de armadura são de excelente qualidade, $n. Exijo esse mesmo cuidado tanto no meu trabalho quanto no daqueles que ensino.\n\nVocê fez por merecer este molde. Espero que ele lhe traga tantas recompensas quanto trouxe a mim."
})
QuestFix(8892, {p="Ensinou uma lição àqueles Ignóbeis?"})
QuestFix(9137, {
    p="Para cada conjunto de Frondes Selvagens que entregar, você poderá escolher entre uma Insígnia da Aurora ou uma Insígnia da Cruzada.\n\nAs insígnias podem ser entregues ao intendente em troca de diversas recompensas.",
    c="Obrigado, $n. Seu trabalho é essencial para o sucesso da nossa campanha contra o Flagelo."
})
QuestFix(9759, {c="Você salvou as ilhas Névoa Rubra e Névoa Lazúli e garantiu o futuro dos draeneis em Azeroth, $n. Não existem palavras nem recompensas capazes de expressar toda a nossa gratidão.\n\nMuitos ainda ficaram para trás em Draenor e não puderam testemunhar este momento histórico. Encontre um caminho de volta a Terralém, Herói de Argus. Traga nosso povo para casa — para Azeroth, a terra que você ajudou a salvar."})
QuestFix(10042, {
    p="Então, o que descobriu, $gmeu rapaz:minha moça;?",
    c="Notícias terríveis! Parece que acertei ao enviar você para ajudar Semanas. A última coisa de que precisamos é o Concílio das Sombras se estabelecendo bem diante de nossas portas.\n\n$n, em reconhecimento aos seus esforços na Aldeia Grangol'var, concedo a você o direito de escolher uma destas recompensas."
})
QuestFix(11318, {
    d="Então você quer experimentar as corridas de carneiros? Espero que esteja preparad$go:a; para a velocidade! Antes de liberar você pela CervaFest, preciso ter certeza de que sabe controlar um desses animais.\n\nVou emprestar um carneiro e as rédeas de corrida. Mantenha-o em trote, meio-galope e galope durante oito segundos em cada velocidade. Se precisar de instruções, fale com meu aprendiz, Pol Ambarmanso.",
    o="Cavalgue o carneiro e mantenha cada um dos três níveis de velocidade durante 8 segundos. Você tem 4 minutos.",
    p="Conseguiu dominar as três velocidades?",
    c="Muito bem! Leva algum tempo para dominar um carneiro de corrida, mas depois disso qualquer montaria comum parece lenta.\n\nOnde está sua recompensa? Ora, você acabou de montar um dos carneiros mais rápidos da região! Ainda quer mais? Então ajude o pessoal da CervaFest. Há bastante trabalho — e boas recompensas — para quem tem disposição."
})
QuestFix(12262, {p="Vejo sangue em suas mãos... Então está feito?",c="Eles imploraram por suas vidas miseráveis? Fracos."})
QuestFix(13539, {
    p="Meu desprezo pelos bruxos só é superado pelo ódio que sinto pelos mortos-vivos. Ainda assim, ambos podem ser úteis de vez em quando.",
    c="Para derrotar o inimigo, nossos homens precisam ser tomados pela fúria; para que a vitória tenha valor, devem receber sua recompensa. Espero que isto seja suficiente por seu serviço à Horda."
})
QuestFix(17006, {p="Os Défias já foram eliminados?",c="Ah, graças à Luz — e graças a você, herói. Hoje você prestou um grande serviço ao rei. Agora só preciso encontrar homens disponíveis para entregar estes suprimentos."})
QuestFix(77725, {title="Obtenha o Conhecimento Proibido",d="A busca pelo Conhecimento Proibido oferece grandes recompensas. Persiga seus inimigos com a mesma ambição ardente com que persegue o conhecimento!",o="Obtenha o Conhecimento Proibido com Theldurin."})

local dungeonDiving = {
    [81316]="Normal",
    [81317]="Heroica",
    [81318]="Mítica",
}
for id, difficulty in pairs(dungeonDiving) do
    QuestFix(id, {
        title=difficulty == "Normal" and "Exploração de Masmorra" or ("Exploração de Masmorra " .. difficulty),
        d="O Quadro de Chamados oferece recompensas valiosas a aventureiros capazes de concluir uma masmorra " .. difficulty .. ". Use o Localizador de Masmorras, entre em um grupo e prove seu valor. Depois, leve a comprovação da vitória ao Quadro de Chamados para receber sua recompensa.",
    })
end

QuestFix(172008, {
    title="Campos de Gêiseres: Erradicando os Nerub'ar",
    o="Mate Cospe-venenos, Guerreiros e Escavadores Nerub'ar nos Campos de Gêiseres.",
    c="Você demonstrou grande habilidade em batalha, herói. Os Cospe-venenos, Guerreiros e Escavadores Nerub'ar não foram páreo para sua força. Com essas criaturas eliminadas, os Campos de Gêiseres voltaram a ser seguros. Sua coragem não passará despercebida, e sua recompensa está garantida."
})
QuestFix(172009, {
    title="Campos de Gêiseres: Interrompendo a Ninhada",
    o="Destrua os Sacos de Ovos Nerub'ar nos Campos de Gêiseres.",
    c="Sua ação decisiva impediu uma infestação que poderia ter tomado os Campos de Gêiseres e colocado nosso povo em grave perigo. Mais uma vez, sua rapidez e determinação foram essenciais. Sua bravura será devidamente reconhecida."
})
QuestFix(172010, {
    p="Trabalho incrível, herói! Você reuniu a Carne do Flagelo dos mamutes assolados e as Amostras de Sangue do Flagelo dos magnatauros pestilentos. Essas amostras ampliarão nosso conhecimento sobre os métodos de corrupção do Flagelo.",
    c="Graças à sua coragem, nossos pesquisadores poderão aprofundar o estudo dos efeitos do Flagelo sobre a fauna local. Sua contribuição é vital para restaurar o equilíbrio da Tundra Boreana. Você provou seu valor mais uma vez e receberá a recompensa merecida."
})
QuestFix(172012, {
    title="Talramas: Crônicas dos Mortos-vivos",
    d="Herói, recebemos informações sobre quatro poderosos tomos necromânticos escondidos em Talramas e na Cidade-Templo de En'kilah. Esses livros descrevem os métodos usados pelo Flagelo para ressuscitar os mortos e controlar seus exércitos.\n\nInfiltre-se nessas fortalezas, recupere os quatro tomos e traga-os para nós. O conhecimento contido neles pode revelar como enfraquecer as forças do Flagelo.",
    o="Colete os quatro tomos necromânticos em Talramas e na Cidade-Templo de En'kilah.",
    c="Com esses tomos proibidos em nosso poder, poderemos estudar as artes sombrias do Flagelo e desenvolver maneiras de combatê-las. Sua coragem e inteligência foram essenciais, herói. Estamos um passo mais perto da vitória, e seu nome será lembrado entre aqueles que enfrentaram o Flagelo."
})
QuestFix(580200, {
    title="Caminho da Ascensão — Curinga: Bilhetes de Negraluna",
    d="Você recebe Bilhetes de Negraluna ao abrir Pacotes de Cartas Selados.\n\nTroque os bilhetes com Silas Negraluna por Cartas de Habilidade Comuns, Incomuns, Raras e Épicas. Guarde-os para adquirir cartas importantes para sua composição.\n\nTambém é possível comprar recompensas cosméticas. As Bolsas de Bilhetes de Negraluna permitem transferir bilhetes entre personagens da mesma conta.",
    o="Visite Silas Negraluna em uma capital, abra o menu de recompensas e compre uma Bolsa de Bilhetes de Negraluna por 25 bilhetes.",
    c="Agora você sabe como obter e gastar Bilhetes de Negraluna. Use-os para ampliar sua coleção de Cartas de Habilidade, adquirir recompensas cosméticas ou transferi-los entre personagens da conta."
})
QuestFix(967492, {
    d="Você adquiriu poder suficiente para cumprir minha vontade, Forjado pelo Vil. Chegou a hora de massacrar nossos inimigos. Grandes recompensas aguardam quem levar nosso Plano Mestre à conclusão.\n\nOs orcs Mag'har sobreviveram em Terralém por tempo demais. Precisamos agir antes que recebam reforços da Horda. Viaje até o Posto Mag'har e ceife suas almas!",
    o="Massacre os orcs Mag'har.",
    p="O Plano Mestre ainda não foi concluído. Volte quando tiver cumprido suas ordens."
})


-- Segunda passada: resíduos em inglês/portunhol e conteúdo custom do CoA.
QuestFix(7623, {c="Minha paciência atravessa milênios, <class>. Mas não pense que isso lhe dá mais do que um instante do meu tempo..."})
QuestFix(7646, {
    c="São exemplares excelentes, <name> — as últimas peças finalmente estão no lugar. Enfim, chegou a sua hora!\n\nNas profundezas do Grande Ossuário de Scolomântia estão os restos mortais de incontáveis seres. Entre eles há um corcel que um dia foi nobre. A alma esvaziada dessa criatura agora serve de montaria ao Cavaleiro da Morte Trevassol. É ele quem você enfrentará, e é sobre esse corcel que você dará seu veredito. Só você, <name>, pode redimir a alma dele e libertá-lo do tormento dessa servidão."
})
QuestFix(9195, {c="Agora você está falando a minha língua, <class>. Coisas que fazem BOOM!"})
QuestFix(9198, {c="Tubos de tório? Nossa, obrigado.\n\n<O Caravaneiro Esmagapedra joga a pilha de tubos de tório sobre um grande monte de sucata variada.>"})
QuestFix(9200, {c="A utilidade disto dispensa explicações."})
QuestFix(9359, {c="Veio ajudar? Excelente!\n\nA batalha contra os trolls Amani cobrou um preço alto, e combatentes capazes como você são sempre bem-vindos."})
QuestFix(9643, {c="Estas vinhas parecem resistentes o bastante para o trabalho. Obrigado pela ajuda, <name>. Sua contribuição para a defesa da Vigília de Sangue não será esquecida."})
QuestFix(9914, {
    c="Nunca duvidei de você nem por um segundo, amigo. A maioria destas presas está em ótimo estado, apesar de um pouco suja e arranhada. Ainda assim, acredito que valham o preço que combinamos.\n\nEspero que possamos continuar fazendo negócios no futuro."
})
QuestFix(10091, {
    c="To'gun esteve aqui há pouco para apresentar o relatório. Ele deveria ter ficado com você para ajudar!\n\nMandei-o de volta para auxiliar Grik'tha. Acho que os dois formam um belo casal.\n\nEntão estes são os dispositivos de alma que o Concílio das Sombras usava para fortalecer suas evocações? Parecem perigosos. Talvez os Áugures saibam o que fazer com eles.\n\nPor favor, aceite uma destas recompensas por ter prejudicado a operação do Concílio das Sombras no labirinto."
})

QuestFix(255144, {
    o="Vasculhe os montes de escombros em busca de materiais reaproveitáveis e entregue-os aos Trabalhadores de Dalaran na Cratera de Dalaran.",
    c="Aprecio seus esforços. Espero que isto ajude a acelerar o trabalho.\n\nDo jeito que as coisas estão, pouco me resta além de esperar e observar como tudo se desenrola.\n\nAinda assim... suponho que paciência seja uma virtude que estou sendo obrigado a praticar hoje."
})
QuestFix(255145, {
    o="Destrua a Anomalia Arcana na margem leste da Cratera de Dalaran."
})
QuestFix(255146, {
    d="Agora que a situação aqui está relativamente sob controle, como você pôde ver com os próprios olhos... importaria-se de voltar ao meu aprendiz um tanto zeloso demais e garantir a ele que tenho tudo sob controle?\n\nFrancamente, ser importunado dessa maneira pelo próprio aprendiz...\n\n<O Arcimago suspira profundamente.>",
    o="Volte ao Conselheiro Belview, em Costa Sul, e conte a ele sobre seu trabalho na Cratera de Dalaran.",
    c="Ah... que atrevimento!\n\nPor pouco não me teletransporto até lá para dizer umas boas verdades àquele sujeito pessoalmente!\n\nDito isso... mesmo que ele tenha usado você para se livrar do próprio trabalho, fico aliviado em saber que o Arcimago manteve a barreira e que o progresso continua.\n\nTalvez, pelo menos por enquanto, eu possa voltar toda a minha atenção para Costa Sul.\n\nObrigado, aventureiro."
})
QuestFix(255147, {
    o="Derrote 6 Saqueadores Ravenclaw e 6 Escravos Ravenclaw na Fazenda de Olsen."
})
QuestFix(255148, {
    o="Ajude o Padre Dayton a libertar os espíritos da família Denholm no Campo dos Mortos."
})
QuestFix(255149, {
    o="Mate Silkshadow no Contraforte de Eira dos Montes.",
    p="O covil dela fica a leste, perto da muralha, onde pode atacar viajantes desprevenidos... é uma criatura astuta, não é?"
})
QuestFix(255150, {
    d="Antes de pendurar minha lança de vez, ainda há uma última ameaça nestas colinas que precisa ser abatida.\n\nMas preste atenção... não enfrente esta caçada sozinho. Esta fera está além das capacidades de um único caçador.\n\nChamam-no Highclaw, o maior e mais esquivo leão-da-montanha que já rastreei. Leões raramente são um problema, pelo menos para mim... mas este é diferente. Ele caça pessoas de propósito. Acampamentos, caravanas, tanto faz. Para ele, todos nós somos presas.\n\nSeja rápido e ataque sem hesitar. Não sei o que faria se ele matasse você.",
    o="Mate Highclaw no Contraforte de Eira dos Montes.",
    p="Então... está feito?"
})
QuestFix(255151, {
    d="Fomos atacados por um bando de ladrões perto do Forte do Desterro — ou do que restou dele, pelo menos.\n\nNosso grupo transportava diversas relíquias pela estrada principal e esperava conseguir repelir qualquer ladrão que cruzasse nosso caminho. Infelizmente, fracassamos, e ainda estamos nos recuperando da viagem.\n\nVocê estaria disposto a recuperar nossos bens roubados antes que esses pilhadores destruam peças tão valiosas da história?",
    o="Recupere 8 Relíquias Roubadas do Sindicato no Forte do Desterro.",
    p="Conseguiu localizar parte da nossa carga?",
    c="Ahá! Você encontrou...!\n\n<O Historiador examina as relíquias e sua expressão desaba.>\n\nOh... oh, não..."
})
QuestFix(255152, {
    d="Embora pareçam estar em bom estado para uma pessoa comum, qualquer especialista percebe o quanto estas peças foram danificadas.\n\nNas condições atuais, não tenho certeza de que sobreviveriam a uma viagem sem se desfazer por completo.\n\nEnquanto você esteve fora, perguntei pela cidade e descobri que há um membro da Liga dos Exploradores por aqui — uma organização de arqueólogos renomados. Se houver algo que possamos fazer para preparar estes artefatos para a jornada, talvez ele tenha algum conselho para nós.",
    o="Leve o pacote de relíquias danificadas ao representante da Liga dos Exploradores em Costa Sul.",
    c="Pelas minhas barbas! Que tipo de trogg pôs as mãos nestas preciosidades?!\n\n<O anão resmunga, encarando você de forma acusadora.>\n\nMãos pesadas são uma coisa, mas trate estas peças com um pouco mais de cuidado se sabe o que é bom para você!"
})
QuestFix(255153, {
    o="Entregue com segurança a caixa de relíquias extremamente frágeis ao Arqueólogo Flagongut, no Porto de Menethil.",
    p="Eu não estava esperando uma entrega..."
})
QuestFix(255154, {
    d="Não quero ofender, mas alguém como você realmente não deveria manusear artefatos tão frágeis.\n\nDito isso, ficarei mais do que feliz em tirá-los das suas mãos.\n\nAgora, não quero que você vá embora de mãos vazias... leve esta moeda à pessoa de quem estou comprando estas preciosidades e, depois disso, estará livre para seguir seu caminho.",
    o="Leve o pagamento do Arqueólogo de volta ao Historiador Wendell, em Costa Sul.",
    p="Você voltou! Mas... onde estão as relíquias?"
})
QuestFix(255155, {
    c="Obrigada. Isso é muito generoso da sua parte. Pode ter certeza de que vou aproveitar tudo muito bem."
})
QuestFix(255156, {
    c="Isso será de grande ajuda. Vou colocar tudo em uso o mais rápido possível."
})
QuestFix(255157, {
    p="Estamos quase prontos para sair da casa da minha filha, mas sempre parece faltar mais tecido. Se encontrar algum de que não precise, ele será muito bem aproveitado aqui."
})
QuestFix(255158, {
    c="Isso será de enorme ajuda. Com este material, a barricada deve aguentar por mais algum tempo.\n\nSe a Luz nos favorecer, talvez tempo suficiente para que logo nem precisemos mais dela. Obrigado."
})

local Q = AscensionPTBR.QuestData
local T = AscensionPTBR.QuestTitle

for id, patch in pairs(P) do
    if T and patch.title then
        T[id] = patch.title
    end

    local quest = Q and Q[id]
    if quest then
        if patch.d ~= nil then quest.d = patch.d end
        if patch.o ~= nil then quest.o = patch.o end
        if patch.p ~= nil then quest.p = patch.p end
        if patch.c ~= nil then quest.c = patch.c end
    end
end

-- O arquivo principal já tem cobertura PT-BR para todos os campos existentes.
-- Mantemos o contador por compatibilidade com o diagnóstico antigo.
AscensionPTBR.QuestMissingFieldFallbacks = 0
