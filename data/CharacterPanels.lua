AscensionPTBR = AscensionPTBR or {}

local A = AscensionPTBR

-- Textos das abas do C. Estatísticas ficam em outro arquivo para este aqui não virar um balaio.
A.CharacterPanelExact = {
    -- Abas e navegação
    ["Character"] = "Personagem",
    ["Character Info"] = "Informações do Personagem",
    ["AllStats->"] = "Mais →",
    ["AllStats ->"] = "Mais →",
    ["Level"] = "Nível",
    ["Blood Elf"] = "Elfo Sangrento",
    ["Night Elf"] = "Elfo Noturno",
    ["Draenei"] = "Draenei",
    ["Dwarf"] = "Anão",
    ["Gnome"] = "Gnomo",
    ["Human"] = "Humano",
    ["Orc"] = "Orc",
    ["Tauren"] = "Tauren",
    ["Troll"] = "Troll",
    ["Undead"] = "Renegado",
    ["Necromancer"] = "Necromante",
    ["Runemaster"] = "Mestre das Runas",
    ["Barbarian"] = "Bárbaro",
    ["Witch Doctor"] = "Médico Bruxo",
    ["Felsworn"] = "Devoto Vil",
    ["Witch Hunter"] = "Caçador de Bruxas",
    ["Stormbringer"] = "Arauto da Tempestade",
    ["Knight of Xoroth"] = "Cavaleiro de Xoroth",
    ["Guardian"] = "Guardião",
    ["Templar"] = "Templário",
    ["Bloodmage"] = "Mago Sangrento",
    ["Ranger"] = "Patrulheiro",
    ["Chronomancer"] = "Cronomante",
    ["Pyromancer"] = "Piromante",
    ["Cultist"] = "Cultista",
    ["Starcaller"] = "Arauto Estelar",
    ["Sun Cleric"] = "Clérigo Solar",
    ["Tinker"] = "Engenhoqueiro",
    ["Venomancer"] = "Venomante",
    ["Reaper"] = "Ceifador",
    ["Primalist"] = "Primalista",
    ["Pets"] = "Mascotes",
    ["Pet"] = "Mascote",
    ["Companions"] = "Companheiros",
    ["Companion"] = "Companheiro",
    ["Reputation"] = "Reputação",
    ["Skills"] = "Perícias",
    ["Skill"] = "Perícia",
    ["Professions"] = "Profissões",
    ["Profession"] = "Profissão",
    ["Currency"] = "Moedas",
    ["Currencies"] = "Moedas",
    ["Collections"] = "Coleções",
    ["Collection"] = "Coleção",
    ["Mount"] = "Montaria",
    ["Mounts"] = "Montarias",
    ["Books"] = "Livros",
    ["Book"] = "Livro",
    ["Spellbook"] = "Grimório",
    ["Spell Book"] = "Grimório",
    ["Spellbook & Abilities"] = "Grimório e Habilidades",
    ["Search"] = "Pesquisar",
    ["Search..."] = "Pesquisar...",
    ["Filter"] = "Filtrar",
    ["Filters"] = "Filtros",
    ["All"] = "Todos",
    ["All Types"] = "Todos os tipos",
    ["All Categories"] = "Todas as categorias",
    ["Available"] = "Disponível",
    ["Unavailable"] = "Indisponível",
    ["Known"] = "Aprendido",
    ["Not Known"] = "Não aprendido",
    ["Unknown"] = "Desconhecido",
    ["Learned"] = "Aprendido",
    ["Not Learned"] = "Não aprendido",
    ["Already Known"] = "Já aprendido",
    ["Already learned"] = "Já aprendido",
    ["Can be Learned"] = "Pode aprender",
    ["Can be Unlearned"] = "Pode desaprender",
    ["Cannot be unlearned"] = "Não pode desaprender",
    ["Collected"] = "Coletado",
    ["Not Collected"] = "Não coletado",
    ["Collected Only"] = "Apenas coletados",
    ["Owned"] = "Obtido",
    ["Not Owned"] = "Não obtido",
    ["Favorite"] = "Favorito",
    ["Favorites"] = "Favoritos",
    ["Set Favorite"] = "Adicionar aos favoritos",
    ["Remove Favorite"] = "Remover dos favoritos",
    ["Sort"] = "Ordenar",
    ["Name"] = "Nome",
    ["Type"] = "Tipo",
    ["Category"] = "Categoria",
    ["Description"] = "Descrição",
    ["Details"] = "Detalhes",
    ["Close"] = "Fechar",

    -- Profissões e perícias
    ["Primary Professions"] = "Profissões Primárias",
    ["Primary Profession"] = "Profissão Primária",
    ["Secondary Skills"] = "Perícias Secundárias",
    ["Secondary Skill"] = "Perícia Secundária",
    ["Profession Skills"] = "Perícias de Profissão",
    ["Profession Skill"] = "Perícia de Profissão",
    ["Profession Trainer"] = "Instrutor de Profissão",
    ["Profession Trainers"] = "Instrutores de Profissão",
    ["Profession Specialization"] = "Especialização de Profissão",
    ["Profession Specializations"] = "Especializações de Profissão",
    ["Gathering Profession"] = "Profissão de Coleta",
    ["Crafting Profession"] = "Profissão de Produção",
    ["First Profession"] = "Primeira profissão",
    ["Second Profession"] = "Segunda profissão",
    ["Recipes"] = "Receitas",
    ["Recipe"] = "Receita",
    ["Known Recipes"] = "Receitas conhecidas",
    ["Available Recipes"] = "Receitas disponíveis",
    ["Learn Recipe"] = "Aprender receita",
    ["Create"] = "Criar",
    ["Create All"] = "Criar todos",
    ["Have Materials"] = "Com materiais disponíveis",
    ["Reagents"] = "Reagentes",
    ["Reagents:"] = "Reagentes:",
    ["Required Materials"] = "Materiais necessários",
    ["Required Skill"] = "Perícia necessária",
    ["Current Skill"] = "Perícia atual",
    ["Maximum Skill"] = "Perícia máxima",
    ["Skill Level"] = "Nível da perícia",
    ["Train"] = "Treinar",
    ["Learn"] = "Aprender",
    ["Unlearn"] = "Desaprender",
    ["Apprentice"] = "Aprendiz",
    ["Journeyman"] = "Profissional",
    ["Expert"] = "Perito",
    ["Artisan"] = "Artífice",
    ["Master"] = "Mestre",
    ["Grand Master"] = "Grão-Mestre",
    ["Alchemy"] = "Alquimia",
    ["Blacksmithing"] = "Ferraria",
    ["Enchanting"] = "Encantamento",
    ["Engineering"] = "Engenharia",
    ["Herbalism"] = "Herborismo",
    ["Inscription"] = "Escrivania",
    ["Jewelcrafting"] = "Joalheria",
    ["Leatherworking"] = "Couraria",
    ["Mining"] = "Mineração",
    ["Skinning"] = "Esfolamento",
    ["Tailoring"] = "Alfaiataria",
    ["Cooking"] = "Culinária",
    ["First Aid"] = "Primeiros Socorros",
    ["Fishing"] = "Pesca",
    ["Riding"] = "Montaria",
    ["Weapon Skills"] = "Perícias com Armas",
    ["Class Skills"] = "Perícias de Classe",

    -- Reputação
    ["Faction"] = "Facção",
    ["Standing"] = "Nível de reputação",
    ["Reputation Details"] = "Detalhes da Reputação",
    ["At War"] = "Em guerra",
    ["At Peace"] = "Em paz",
    ["Show as Experience Bar"] = "Exibir como barra de experiência",
    ["Inactive"] = "Inativo",
    ["Move to Inactive"] = "Marcar como inativa",
    ["Move to Active"] = "Marcar como ativa",
    ["Hated"] = "Odiado",
    ["Hostile"] = "Hostil",
    ["Unfriendly"] = "Ignorado",
    ["Neutral"] = "Tolerado",
    ["Friendly"] = "Respeitado",
    ["Honored"] = "Honrado",
    ["Revered"] = "Reverenciado",
    ["Exalted"] = "Exaltado",

    -- Facções clássicas mais comuns. Nomes próprios sem tradução oficial confiável
    -- ficam de fora para o jogo preservar o original em vez de inventar nome.
    ["Argent Dawn"] = "Aurora Argêntea",
    ["Argent Crusade"] = "Cruzada Argêntea",
    ["Bloodsail Buccaneers"] = "Bucaneiros da Vela Sangrenta",
    ["Brood of Nozdormu"] = "Prole de Nozdormu",
    ["Cenarion Circle"] = "Círculo Cenariano",
    ["Cenarion Expedition"] = "Expedição Cenariana",
    ["Hydraxian Waterlords"] = "Senhores das Águas Hidraxianos",
    ["Timbermaw Hold"] = "Domínio dos Presamatos",
    ["Darkmoon Faire"] = "Feira de Negraluna",
    ["Darkspear Trolls"] = "Trolls Lançanegra",
    ["Gnomeregan Exiles"] = "Exilados de Gnomeregan",
    ["Ironforge"] = "Altaforja",
    ["Stormwind"] = "Ventobravo",
    ["Silvermoon City"] = "Luaprata",
    ["Thunder Bluff"] = "Penhasco do Trovão",
    ["Undercity"] = "Cidade Baixa",
    ["Frostwolf Clan"] = "Clã Lobo do Gelo",
    ["The Defilers"] = "Os Profanadores",
    ["Warsong Outriders"] = "Pioneiros do Brado Guerreiro",
    ["Steamwheedle Cartel"] = "Cartel Bondebico",
    ["Booty Bay"] = "Angra do Butim",
    ["Everlook"] = "Visteterna",
    ["Gadgetzan"] = "Geringontzan",
    ["Ratchet"] = "Vila Catraca",
    ["Kirin Tor"] = "Kirin Tor",
    ["Knights of the Ebon Blade"] = "Cavaleiros da Lâmina de Ébano",
    ["The Kalu'ak"] = "Kalu'ak",
    ["Frenzyheart Tribe"] = "Tribo Feralma",
    ["The Oracles"] = "Oráculos",
    ["The Sons of Hodir"] = "Filhos de Hodir",
    ["The Wyrmrest Accord"] = "Acordo do Repouso das Serpes",
    ["Alliance Vanguard"] = "Vanguarda da Aliança",
    ["Explorers' League"] = "Liga dos Exploradores",
    ["Valiance Expedition"] = "Expedição Valentia",
    ["Horde Expedition"] = "Expedição da Horda",
    ["Hand of Vengeance"] = "Mão da Vingança",
    ["The Sunreavers"] = "Os Fendessol",
    ["The Taunka"] = "Taunka",
    ["Warsong Offensive"] = "Ofensiva do Brado Guerreiro",
    ["Honor Hold"] = "Fortaleza da Honra",
    ["Lower City"] = "Bairro Inferior",
    ["The Scale of the Sands"] = "A Escama das Areias",
    ["The Violet Eye"] = "O Olho Violeta",
    ["Ogri'la"] = "Ogri'la",
    ["Sporeggar"] = "Sporeggar",
    ["Thrallmar"] = "Thrallmar",
    ["Tranquillien"] = "Tranquillien",
    ["Ashen Verdict"] = "Veredito Cinzento",

    -- Montarias e mascotes
    ["Ground Mounts"] = "Montarias terrestres",
    ["Flying Mounts"] = "Montarias voadoras",
    ["Aquatic Mounts"] = "Montarias aquáticas",
    ["Favorite Mounts"] = "Montarias favoritas",
    ["Random Favorite Mount"] = "Montaria favorita aleatória",
    ["Summon"] = "Invocar",
    ["Dismiss"] = "Dispensar",
    ["Summon Pet"] = "Invocar mascote",
    ["Dismiss Pet"] = "Dispensar mascote",
    ["Display Pets"] = "Mostrar mascotes",
    ["Cosmetic Pets"] = "Mascotes cosméticos",
    ["Critters and Vanity Pets"] = "Bichos e mascotes cosméticos",
    ["Current Pet:"] = "Mascote atual:",
    ["Riding Skill"] = "Perícia de Montaria",
    ["Mount Speed"] = "Velocidade da montaria",
    ["You do not own any mounts!"] = "Você ainda não tem nenhuma montaria.",
    ["You do not own any pets!"] = "Você ainda não tem nenhum mascote.",
    ["Go to Mounts tab"] = "Abrir aba Montarias",
    ["Go to Pets tab"] = "Abrir aba Mascotes",

    -- Livros e itens de conveniência ligados ao personagem
    ["Book of Ascension"] = "Livro da Ascensão",
    ["Beginner's Book of Ascension"] = "Livro da Ascensão para Iniciantes",
    ["Book of Artisans"] = "Livro dos Artesãos",
    ["Book of Conquest"] = "Livro da Conquista",
    ["Beginner's Book of Artisans"] = "Livro dos Artesãos para Iniciantes",
    ["Cockroach"] = "Barata",
    ["Night Web Spider Hatchling"] = "Filhote de Aranha da Teia Noturna",
    ["Nightmarish Book of Ascension"] = "Livro de Pesadelos da Ascensão",
    ["Necrolord's Meat Wagon"] = "Carroça de Carne do Necrolorde",
    ["Red Hawkstrider"] = "Falcostruz Vermelho",
    ["Right Click to summon and dismiss your personal guide of Ascension."] = "Clique com o botão direito para invocar ou dispensar seu guia pessoal do Ascension.",
    ["Summons and dismisses your Necrolord's Meat Wagon. This mount's speed changes depending on your Riding skill and location."] = "Invoca ou dispensa sua Carroça de Carne do Necrolorde. A velocidade desta montaria varia conforme sua perícia de Montaria e o local.",
    ["Craftsman's Codex"] = "Códice do Artesão",
    ["Tome of Specialization"] = "Tomo de Especialização",
    ["Riding Tome"] = "Tomo de Montaria",
    ["Riding Tomes"] = "Tomos de Montaria",
    ["You have learned everything from that book"] = "Você já aprendeu tudo desse livro",

    -- Coleções / vaidade
    ["Vanity"] = "Aparências",
    ["Vanity Collection"] = "Coleção de Aparências",
    ["Vanity Item Collection"] = "Coleção de Itens Cosméticos",
    ["Vanity Items"] = "Itens Cosméticos",
    ["Seasonal Collection"] = "Coleção Sazonal",
    ["Collected Skill Cards"] = "Cartas de Habilidade Coletadas",
    ["Known Spells"] = "Feitiços Conhecidos",
}


-- Complemento das abas do C. Item, spell e NPC continuam vindo das bases deles; não duplica aqui.
local CHARACTER_EXTRA = {
    -- Navegação / cabeçalhos
    ["Overview"] = "Visão geral",
    ["General"] = "Geral",
    ["Statistics"] = "Estatísticas",
    ["Stats"] = "Atributos",
    ["Attributes"] = "Atributos",
    ["Advanced"] = "Avançado",
    ["Equipment"] = "Equipamento",
    ["Titles"] = "Títulos",
    ["Title"] = "Título",
    ["None"] = "Nenhum",
    ["None Selected"] = "Nenhum selecionado",
    ["Select"] = "Selecionar",
    ["Selected"] = "Selecionado",
    ["Current"] = "Atual",
    ["Total"] = "Total",
    ["Progress"] = "Progresso",
    ["Requirements"] = "Requisitos",
    ["Requirement"] = "Requisito",
    ["Requires"] = "Requer",
    ["Locked"] = "Bloqueado",
    ["Unlocked"] = "Desbloqueado",
    ["Enabled"] = "Ativado",
    ["Disabled"] = "Desativado",
    ["Show"] = "Mostrar",
    ["Hide"] = "Ocultar",
    ["Reset"] = "Redefinir",
    ["Apply"] = "Aplicar",
    ["Cancel"] = "Cancelar",
    ["Okay"] = "OK",
    ["OK"] = "OK",

    -- Pets / companheiros / montarias
    ["Pet Info"] = "Informações do Mascote",
    ["Companion Info"] = "Informações do Companheiro",
    ["Mount Info"] = "Informações da Montaria",
    ["Companion Pets"] = "Mascotes Companheiros",
    ["Vanity Pets"] = "Mascotes Cosméticos",
    ["Critter Companions"] = "Companheiros Cosméticos",
    ["Ground"] = "Terrestre",
    ["Flying"] = "Voadora",
    ["Aquatic"] = "Aquática",
    ["Usable"] = "Utilizável",
    ["Not Usable"] = "Não utilizável",
    ["Random Mount"] = "Montaria aleatória",
    ["Random Favorite"] = "Favorito aleatório",
    ["Set as Favorite"] = "Marcar como favorito",
    ["Remove from Favorites"] = "Remover dos favoritos",
    ["Summon Random Favorite Mount"] = "Invocar montaria favorita aleatória",
    ["Summon a random favorite mount"] = "Invocar uma montaria favorita aleatória",
    ["You have no companions."] = "Você não possui companheiros.",
    ["You have no mounts."] = "Você não possui montarias.",
    ["You have no pets."] = "Você não possui mascotes.",
    ["Right Click to summon and dismiss this companion."] = "Clique com o botão direito para invocar ou dispensar este companheiro.",
    ["Right Click to summon and dismiss this mount."] = "Clique com o botão direito para invocar ou dispensar esta montaria.",

    -- Reputação
    ["Alliance"] = "Aliança",
    ["Horde"] = "Horda",
    ["Other"] = "Outros",
    ["Classic"] = "Clássico",
    ["The Burning Crusade"] = "The Burning Crusade",
    ["Wrath of the Lich King"] = "Wrath of the Lich King",
    ["Reputation Bar"] = "Barra de Reputação",
    ["Show Reputation as Experience Bar"] = "Exibir reputação como barra de experiência",
    ["Show as Experience"] = "Exibir como experiência",
    ["Active"] = "Ativo",
    ["Inactive Factions"] = "Facções inativas",
    ["Active Factions"] = "Facções ativas",
    ["Reputation with this faction determines how they react to you."] = "Sua reputação com esta facção determina como ela reage a você.",
    ["You are at war with this faction."] = "Você está em guerra com esta facção.",
    ["You are not at war with this faction."] = "Você não está em guerra com esta facção.",

    -- Facções clássicas / TBC / WotLK mais usadas
    ["Alliance Forces"] = "Forças da Aliança",
    ["Horde Forces"] = "Forças da Horda",
    ["Stormpike Guard"] = "Guarda de Lançatroz",
    ["League of Arathor"] = "Liga de Arathor",
    ["Silverwing Sentinels"] = "Sentinelas da Asa de Prata",
    ["Frostwolf Clan"] = "Clã Lobo do Gelo",
    ["Warsong Outriders"] = "Pioneiros do Brado Guerreiro",
    ["The Defilers"] = "Os Profanadores",
    ["Thorium Brotherhood"] = "Irmandade do Tório",
    ["Wintersaber Trainers"] = "Treinadores de Sabres-do-inverno",
    ["Zandalar Tribe"] = "Tribo Zandalar",
    ["Shen'dralar"] = "Shen'dralar",
    ["The Aldor"] = "Os Aldor",
    ["The Scryers"] = "Os Áugures",
    ["The Sha'tar"] = "Os Sha'tar",
    ["Shattered Sun Offensive"] = "Ofensiva Sol Partido",
    ["Keepers of Time"] = "Defensores do Tempo",
    ["The Consortium"] = "O Consórcio",
    ["Netherwing"] = "Asa Etérea",
    ["Sha'tari Skyguard"] = "Guarda Aérea Sha'tari",
    ["Ashtongue Deathsworn"] = "Juramorte Grislíngua",
    ["Kurenai"] = "Kurenai",
    ["The Mag'har"] = "Os Mag'har",
    ["Honor Hold"] = "Fortaleza da Honra",
    ["Thrallmar"] = "Thrallmar",
    ["Lower City"] = "Bairro Inferior",
    ["The Violet Eye"] = "O Olho Violeta",
    ["The Scale of the Sands"] = "A Escama das Areias",
    ["Ogri'la"] = "Ogri'la",
    ["Sporeggar"] = "Sporeggar",
    ["Tranquillien"] = "Tranquillien",
    ["Argent Crusade"] = "Cruzada Argêntea",
    ["Knights of the Ebon Blade"] = "Cavaleiros da Lâmina de Ébano",
    ["Kirin Tor"] = "Kirin Tor",
    ["The Wyrmrest Accord"] = "Acordo do Repouso das Serpes",
    ["The Kalu'ak"] = "Os Kalu'ak",
    ["Frenzyheart Tribe"] = "Tribo Coração Frenético",
    ["The Oracles"] = "Os Oráculos",
    ["The Sons of Hodir"] = "Os Filhos de Hodir",
    ["Alliance Vanguard"] = "Vanguarda da Aliança",
    ["Explorers' League"] = "Liga dos Exploradores",
    ["Valiance Expedition"] = "Expedição Valentia",
    ["The Silver Covenant"] = "Pacto de Prata",
    ["Horde Expedition"] = "Expedição da Horda",
    ["Hand of Vengeance"] = "Mão da Vingança",
    ["The Sunreavers"] = "Os Fendessol",
    ["The Taunka"] = "Taunka",
    ["Warsong Offensive"] = "Ofensiva do Brado Guerreiro",
    ["Ashen Verdict"] = "Veredito Cinzento",

    -- Perícias / profissões
    ["Skill Name"] = "Nome da perícia",
    ["Skill Rank"] = "Nível da perícia",
    ["Skill Description"] = "Descrição da perícia",
    ["Skill Points"] = "Pontos de perícia",
    ["Available Skill Points"] = "Pontos de perícia disponíveis",
    ["Primary Skills"] = "Perícias Primárias",
    ["Secondary Professions"] = "Profissões Secundárias",
    ["Weapon Proficiencies"] = "Proficiências com Armas",
    ["Armor Proficiencies"] = "Proficiências com Armaduras",
    ["Languages"] = "Idiomas",
    ["Language"] = "Idioma",
    ["Unlearn Profession"] = "Desaprender profissão",
    ["Unlearn this profession"] = "Desaprender esta profissão",
    ["You can learn a new profession."] = "Você pode aprender uma nova profissão.",
    ["You cannot learn any more professions."] = "Você não pode aprender mais profissões.",
    ["Profession Level"] = "Nível da profissão",
    ["Profession Rank"] = "Grau da profissão",
    ["Specialization"] = "Especialização",
    ["Specializations"] = "Especializações",
    ["Alchemy Specialization"] = "Especialização de Alquimia",
    ["Potion Master"] = "Mestre de Poções",
    ["Elixir Master"] = "Mestre de Elixires",
    ["Transmutation Master"] = "Mestre de Transmutação",
    ["Armorsmith"] = "Armeiro",
    ["Weaponsmith"] = "Forjador de Armas",
    ["Master Axesmith"] = "Mestre Ferreiro de Machados",
    ["Master Hammersmith"] = "Mestre Ferreiro de Martelos",
    ["Master Swordsmith"] = "Mestre Ferreiro de Espadas",
    ["Gnomish Engineering"] = "Engenharia Gnômica",
    ["Goblin Engineering"] = "Engenharia Goblínica",
    ["Dragonscale Leatherworking"] = "Couraria Dragônica",
    ["Elemental Leatherworking"] = "Couraria Elemental",
    ["Tribal Leatherworking"] = "Couraria Tribal",
    ["Mooncloth Tailoring"] = "Alfaiataria com Lunatrama",
    ["Shadoweave Tailoring"] = "Alfaiataria com Umbratrama",
    ["Spellfire Tailoring"] = "Alfaiataria com Fogo Místico",
    ["Smelting"] = "Fundição",
    ["Disenchant"] = "Desencantar",
    ["Prospecting"] = "Prospecção",
    ["Milling"] = "Moagem",
    ["Pick Lock"] = "Arrombar Fechadura",
    ["Poisons"] = "Venenos",

    -- Moedas
    ["Currency List"] = "Lista de Moedas",
    ["Currency Info"] = "Informações da Moeda",
    ["Token"] = "Ficha",
    ["Tokens"] = "Fichas",
    ["Unused"] = "Não utilizadas",
    ["Unused Currency"] = "Moedas não utilizadas",
    ["Miscellaneous"] = "Diversos",
    ["Honor"] = "Honra",
    ["Arena Points"] = "Pontos de Arena",
    ["Honor Points"] = "Pontos de Honra",
    ["Amount"] = "Quantidade",
    ["Quantity"] = "Quantidade",
    ["Maximum"] = "Máximo",
    ["Weekly Maximum"] = "Máximo semanal",
    ["Total Earned"] = "Total obtido",

    -- Livros / coleção / interface do conteúdo
    ["Books & Guides"] = "Livros e guias",
    ["Personal Guide"] = "Guia pessoal",
    ["Open Book"] = "Abrir livro",
    ["Use"] = "Usar",
    ["Preview"] = "Visualizar",
    ["Model"] = "Modelo",
    ["Source"] = "Fonte",
    ["Sources"] = "Fontes",
    ["Obtained From"] = "Obtido de",
    ["Not yet collected"] = "Ainda não coletado",
    ["Already collected"] = "Já coletado",
}

for en, pt in pairs(CHARACTER_EXTRA) do
    if A.CharacterPanelExact[en] == nil then A.CharacterPanelExact[en] = pt end
end

A.CharacterPanelPatterns = {
    { "^Level%s+(%d+)$", "Nível %1" },
    { "^Collected%s+(%d+)%s*/%s*(%d+)$", "Coletado %1 / %2" },
    { "^Collected:%s*(%d+)%s*/%s*(%d+)$", "Coletado: %1 / %2" },
    { "^Known%s+(%d+)%s*/%s*(%d+)$", "Conhecido %1 / %2" },
    { "^Known:%s*(%d+)%s*/%s*(%d+)$", "Conhecido: %1 / %2" },
    { "^Skill:%s*([%d%.,]+)%s*/%s*([%d%.,]+)$", "Perícia: %1 / %2" },
    { "^Skill%s+([%d%.,]+)%s*/%s*([%d%.,]+)$", "Perícia %1 / %2" },
    { "^Requires%s+Level%s+(%d+)$", "Requer nível %1" },
    { "^Requires%s+level%s+(%d+)$", "Requer nível %1" },
    { "^Requires%s+Riding%s+%((%d+)%)$", "Requer Montaria (%1)" },
    { "^Showing%s+(%d+)%s+of%s+(%d+)$", "Exibindo %1 de %2" },
    { "^Page%s+(%d+)%s+of%s+(%d+)$", "Página %1 de %2" },
    { "^(%d+)%s+Mounts%s+Collected$", "%1 montarias coletadas" },
    { "^(%d+)%s+Pets%s+Collected$", "%1 mascotes coletados" },
    { "^(%d+)%s+Companions%s+Collected$", "%1 mascotes coletados" },
    { "^Available%s+Skill%s+Points:%s*(%d+)$", "Pontos de perícia disponíveis: %1" },
    { "^Skill%s+Points:%s*(%d+)$", "Pontos de perícia: %1" },
}

local TITLE_RACES = {
    ["Blood Elf"] = "Elfo Sangrento", ["Night Elf"] = "Elfo Noturno",
    ["Draenei"] = "Draenei", ["Dwarf"] = "Anão", ["Gnome"] = "Gnomo",
    ["Human"] = "Humano", ["Orc"] = "Orc", ["Tauren"] = "Tauren",
    ["Troll"] = "Troll", ["Undead"] = "Renegado",
}

local TITLE_CLASSES = {
    ["Necromancer"] = "Necromante", ["Runemaster"] = "Mestre das Runas",
    ["Barbarian"] = "Bárbaro", ["Witch Doctor"] = "Médico Bruxo",
    ["Felsworn"] = "Devoto Vil", ["Witch Hunter"] = "Caçador de Bruxas",
    ["Stormbringer"] = "Arauto da Tempestade", ["Knight of Xoroth"] = "Cavaleiro de Xoroth",
    ["Guardian"] = "Guardião", ["Templar"] = "Templário", ["Bloodmage"] = "Mago Sangrento",
    ["Ranger"] = "Patrulheiro", ["Chronomancer"] = "Cronomante", ["Pyromancer"] = "Piromante",
    ["Cultist"] = "Cultista", ["Starcaller"] = "Arauto Estelar", ["Sun Cleric"] = "Clérigo Solar",
    ["Tinker"] = "Engenhoqueiro", ["Venomancer"] = "Venomante", ["Reaper"] = "Ceifador",
    ["Primalist"] = "Primalista",
}

local function TranslateLevelRaceClass(text)
    local original = text
    local level, rest = text:match("^Level%s+(%d+)%s+(.+)$")
    if not level then
        level, rest = text:match("^Nível%s+(%d+)%s+(.+)$")
    end
    if not level or not rest then return nil end

    -- Cultist -> Cultista e Primalist -> Primalista são casos perigosos: o nome
    -- inglês é prefixo do português. Um passe antigo em cima de "Cultista" virava
    -- "Cultistaa", depois "Cultistaaa" e assim por diante. Primeiro conserta
    -- qualquer texto já contaminado e depois impede retradução do token pronto.
    rest = rest:gsub("Cultista+", "Cultista")
    rest = rest:gsub("Primalista+", "Primalista")

    -- O cliente pode traduzir "Level" antes deste passe e colorir somente alguns
    -- tokens. O teste do texto PT antes do gsub torna a operação idempotente sem
    -- remover códigos de cor existentes.
    for enRace, ptRace in pairs(TITLE_RACES) do
        if enRace ~= ptRace and not rest:find(ptRace, 1, true) then
            local replaced, count = rest:gsub(enRace, ptRace, 1)
            if count > 0 then
                rest = replaced
                break
            end
        end
    end
    for enClass, ptClass in pairs(TITLE_CLASSES) do
        if enClass ~= ptClass and not rest:find(ptClass, 1, true) then
            local replaced, count = rest:gsub(enClass, ptClass, 1)
            if count > 0 then
                rest = replaced
                break
            end
        end
    end

    -- Esse descritor aparece bastante em tooltips do Ascension.
    rest = rest:gsub("%(Player%)$", "(Jogador)")

    local translated = "Nível " .. level .. " " .. rest
    return translated ~= original and translated or nil
end

local cache = {}
local cacheCount = 0
local CACHE_LIMIT = 1024

local function Remember(text, value)
    if cacheCount >= CACHE_LIMIT then
        cache = {}
        cacheCount = 0
    end
    if cache[text] == nil then cacheCount = cacheCount + 1 end
    cache[text] = value or false
    return value
end

local function TranslateExactToken(text)
    if type(text) ~= "string" or text == "" then return nil end
    return A.CharacterPanelExact[text]
end

local function TranslateCompound(text)
    -- Rótulo + valor: "Standing: Friendly", "Profession: Blacksmithing".
    local left, right = text:match("^([^:]+):%s*(.+)$")
    if left and right then
        local lpt = TranslateExactToken(left)
        local rpt = TranslateExactToken(right)
        if lpt or rpt then return (lpt or left) .. ": " .. (rpt or right) end
    end

    -- Linhas de perícia que o cliente monta dinamicamente.
    local base, cur, max = text:match("^(.-)%s+%(([%d%.,]+)%s*/%s*([%d%.,]+)%)$")
    if base and cur and max then
        local bpt = TranslateExactToken(base)
        if bpt then return bpt .. " (" .. cur .. "/" .. max .. ")" end
    end
    base, cur, max = text:match("^(.-)%s+([%d%.,]+)%s*/%s*([%d%.,]+)$")
    if base and cur and max then
        local bpt = TranslateExactToken(base)
        if bpt then return bpt .. " " .. cur .. "/" .. max end
    end

    -- "Friendly (3000/6000)", "Exalted (999/1000)" etc.
    base, cur, max = text:match("^(.-)%s+%(([%d%.,]+)%s*/%s*([%d%.,]+)%)$")
    if base and cur and max then
        local bpt = TranslateExactToken(base)
        if bpt then return bpt .. " (" .. cur .. "/" .. max .. ")" end
    end

    -- Sufixos simples usados em filtros e listas.
    local prefix, count = text:match("^(.-)%s+%((%d+)%)$")
    if prefix and count then
        local ppt = TranslateExactToken(prefix)
        if ppt then return ppt .. " (" .. count .. ")" end
    end

    return nil
end

local function TranslatePlain(text)
    local exact = A.CharacterPanelExact[text]
    if exact then return exact end

    for i = 1, #A.CharacterPanelPatterns do
        local pair = A.CharacterPanelPatterns[i]
        local translated, changed = text:gsub(pair[1], pair[2])
        if changed > 0 and translated ~= text then return translated end
    end

    return TranslateCompound(text)
end

function A.TranslateCharacterPanelLine(text)
    if type(text) ~= "string" or text == "" then return nil end
    local cached = cache[text]
    if cached ~= nil then return cached ~= false and cached or nil end

    local translated = TranslateLevelRaceClass(text) or TranslatePlain(text)
    if translated then return Remember(text, translated) end

    local lead, body, trail = text:match("^(%s*)(.-)(%s*)$")
    if body and body ~= text then
        translated = TranslateLevelRaceClass(body) or TranslatePlain(body)
        if translated then return Remember(text, (lead or "") .. translated .. (trail or "")) end
    end

    local colorOpen, inner, colorClose = text:match("^(|[cC]%x%x%x%x%x%x%x%x)(.-)(|[rR])$")
    if inner and inner ~= "" then
        translated = TranslateLevelRaceClass(inner) or TranslatePlain(inner)
        if translated then return Remember(text, colorOpen .. translated .. colorClose) end
    end

    local left, innerParen, right = text:match("^(%()(.-)(%))$")
    if innerParen and innerParen ~= "" then
        translated = TranslatePlain(innerParen)
        if translated then return Remember(text, left .. translated .. right) end
    end

    return Remember(text, nil)
end
