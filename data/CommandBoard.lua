AscensionPTBR = AscensionPTBR or {}

-- Mural de Ordens do Chefe Guerreiro.
-- Mantém as missões do mural coerentes entre janela da missão, mapa e rastreador.
local A = AscensionPTBR

local BOARD = {
    [14229] = {
        title = "Ordens do Chefe Guerreiro: Hibérnia!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Harlo Wigglesworth, em Hibérnia.

Ele precisa de sua ajuda para conter a ameaça dos pelursos Invernosos. Para chegar a Hibérnia, siga para leste a partir do norte da Selva Maleva e atravesse o Domínio dos Presamatos.

O destino chama!]=],
        o = "Apresente-se a Harlo Wigglesworth em Visteterna, Hibérnia.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14230] = {
        title = "Ordens do Chefe Guerreiro: Selva Maleva!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Greta Mosshoof, na Selva Maleva.

O Círculo Cenariano precisa de sua ajuda para libertar a Selva Maleva do domínio de demônios e outras criaturas corrompidas. Para chegar ao Santuário Esmeralda, siga para o norte a partir do Vale Gris e permaneça na estrada até alcançar o santuário.

O destino chama!]=],
        o = "Apresente-se a Greta Mosshoof no Santuário Esmeralda, na Selva Maleva.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14231] = {
        title = "Ordens do Chefe Guerreiro: Vale Gris!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Mitsuwa, no Vale Gris.

Ela precisa de sua ajuda para defender nossas terras do avanço dos elfos noturnos e de seus aliados. Para chegar ao Vale Gris, siga pela Estrada do Ouro ao norte da Encruzilhada, nos Sertões Setentrionais.

O destino chama!]=],
        o = "Apresente-se a Mitsuwa no Assentamento Zoram'gar, no Vale Gris.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14232] = {
        title = "Ordens do Chefe Guerreiro: Sertões!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Sergra Darkthorn, na Encruzilhada, nos Sertões.

Ela precisa de sua ajuda para defender este posto vital contra javaliços, centauros e forças da Aliança. Para chegar à Encruzilhada, viaje para o sul a partir de Durotar ou para o norte a partir de Mulgore.

O destino chama!]=],
        o = "Apresente-se a Sergra Darkthorn na Encruzilhada, nos Sertões.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14233] = {
        title = "Ordens do Chefe Guerreiro: Vila Catraca!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Mebok Mizzyrix, em Vila Catraca, nos Sertões.

Para chegar a Vila Catraca, siga para leste a partir da Encruzilhada ou acompanhe a costa vindo do sul. Os goblins prometem pagamento justo e muitas oportunidades para quem estiver disposto a emprestar suas lâminas, feitiços ou astúcia à causa.

O destino chama!]=],
        o = "Apresente-se a Mebok Mizzyrix em Vila Catraca, nos Sertões.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14234] = {
        title = "Ordens do Chefe Guerreiro: Cordilheira das Torres de Pedra!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Maggran Earthbinder, no Retiro Rocha do Sol, na Cordilheira das Torres de Pedra.

As Torres de Pedra estão sob ameaça! As harpias selvagens da tribo Furissangue atacam nossas linhas de suprimento e aterrorizam nossos aliados, enquanto os goblins traiçoeiros da Empreendimentos S.A. exploram os recursos da região sem se importar com a destruição que deixam para trás.

Para chegar ao Retiro Rocha do Sol, viaje para sudoeste a partir dos Sertões.

O destino chama!]=],
        o = "Apresente-se a Maggran Earthbinder no Retiro Rocha do Sol, na Cordilheira das Torres de Pedra.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14235] = {
        title = "Ordens do Chefe Guerreiro: Desolação!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Takata Steelblade, no Entreposto do Espírito que Anda, em Desolação.

Os valentes guerreiros da Horda em Desolação precisam de sua ajuda para repelir os exércitos da Aliança e antigos demônios.

Para chegar ao Entreposto do Espírito que Anda, siga para o sul a partir do Vale Carbonizado, na Cordilheira das Torres de Pedra.

O destino chama!]=],
        o = "Apresente-se a Takata Steelblade no Entreposto do Espírito que Anda, em Desolação.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14236] = {
        title = "Ordens do Chefe Guerreiro: Pântano Vadeoso!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Krog, na Aldeia Muralha Verde, no Pântano Vadeoso.

O pântano está tomado por inimigos de todos os tipos, e as forças da Aliança na região são perigosamente fortes.

Para chegar ao Pântano Vadeoso, siga o caminho que parte da região leste dos Sertões Meridionais em direção à Aldeia Muralha Verde.

O destino chama!]=],
        o = "Apresente-se a Krog na Aldeia Muralha Verde, no Pântano Vadeoso.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14237] = {
        title = "Ordens do Chefe Guerreiro: Feralas!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar ao Mandingueiro Uzer'i, na Aldeia Mojache, em Feralas.

Ajude a Horda a proteger a grande floresta contra a Aliança e os Temível Totem.

Para chegar à Aldeia Mojache, viaje para o sul a partir de Desolação e entre em Feralas.

O destino chama!]=],
        o = "Apresente-se ao Mandingueiro Uzer'i na Aldeia Mojache, em Feralas.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14238] = {
        title = "Ordens do Chefe Guerreiro: Mil Agulhas!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Hagar Lightninghoof, na Aldeia Vento Livre, em Mil Agulhas.

A Horda precisa fortalecer sua presença nas terras áridas de Mil Agulhas e se defender do avanço da Aliança e das tribos hostis de centauros.

Para chegar à Aldeia Vento Livre, viaje para o sul a partir dos Sertões e siga os caminhos sinuosos até o coração de Mil Agulhas. Torres imensas e vastos cânions aguardam sua chegada.

O destino chama!]=],
        o = "Apresente-se a Hagar Lightninghoof na Aldeia Vento Livre, em Mil Agulhas.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14239] = {
        title = "Ordens do Chefe Guerreiro: Tanaris!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar ao Engenheiro-chefe Bilgewhizzle, em Tanaris.

A Horda precisa de sua ajuda para obter concessões do barão local e garantir acesso aos valiosos recursos da região. Para chegar a Geringontzan, siga para o sul a partir de Mil Agulhas.

O destino chama!]=],
        o = "Apresente-se ao Engenheiro-chefe Bilgewhizzle em Geringontzan, Tanaris.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14240] = {
        title = "Ordens do Chefe Guerreiro: Cratera Un'Goro!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Williden Marshal, no Refúgio do Marshal, na Cratera Un'Goro.

A Horda precisa de seu apoio às Expedições Marshal enquanto elas desvendam os segredos das feras ancestrais, da flora singular e dos poderosos cristais da Cratera Un'Goro. Para chegar à cratera, saia pelo oeste de Tanaris e siga a estrada até o Refúgio do Marshal.

O destino chama!]=],
        o = "Apresente-se a Williden Marshal no Refúgio do Marshal, na Cratera Un'Goro.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14241] = {
        title = "Ordens do Chefe Guerreiro: Silithus!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar ao Arauto do Vento Proudhorn, em Silithus.

Nossos aliados do Círculo Cenariano precisam de sua ajuda para conter a ofensiva do Martelo do Crepúsculo. Para chegar a Silithus, siga pela estrada noroeste que sai da Cratera Un'Goro.

O destino chama!]=],
        o = "Apresente-se ao Arauto do Vento Proudhorn no Forte Cenariano, em Silithus.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14242] = {
        title = "Ordens do Chefe Guerreiro: Floresta de Pinhaprata!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Dalar Dawnweaver, no Sepulcro, na Floresta de Pinhaprata.

Agora, mais do que nunca, sua ajuda é necessária para expulsar os inimigos que infestam a região e os worgens selvagens que rondam pelas sombras.

Para chegar à Floresta de Pinhaprata, viaje para o sul a partir das Clareiras de Tirisfal, atravessando as Ruínas de Lordaeron.

O destino chama!]=],
        o = "Apresente-se a Dalar Dawnweaver no Sepulcro, na Floresta de Pinhaprata.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14243] = {
        title = "Ordens do Chefe Guerreiro: Contraforte de Eira dos Montes!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar ao Necroguarda Samsa, na Serraria Tarren, no Contraforte de Eira dos Montes.

A Aliança avança sobre nossas terras, e a Camarilha se torna mais ousada a cada dia. Sua força é necessária para assegurar nossa posição e repelir essas ameaças.

Para chegar à Serraria Tarren, siga a estrada para o sul através da Floresta de Pinhaprata e pegue a bifurcação a leste que leva ao Contraforte de Eira dos Montes.

O destino chama!]=],
        o = "Apresente-se ao Necroguarda Samsa na Serraria Tarren, no Contraforte de Eira dos Montes.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14244] = {
        title = "Ordens do Chefe Guerreiro: Planalto Arathi!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Tor'gan, na Ruína do Martelo, no Planalto Arathi.

As forças de Stromgarde estão inquietas, e a traição da Camarilha ameaça nossas operações. Precisamos de sua coragem para assegurar nossa posição e esmagar esses inimigos.

Para chegar ao Planalto Arathi, viaje para leste a partir do Contraforte de Eira dos Montes e siga pela estrada além da Muralha de Thoradin.

O destino chama!]=],
        o = "Apresente-se a Tor'gan na Ruína do Martelo, no Planalto Arathi.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14245] = {
        title = "Ordens do Chefe Guerreiro: Terras Agrestes!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Otho Moji'ko, na Aldeia Revatusco, nas Terras Agrestes.

Os trolls Ramatorpe, selvagens e sedentos de sangue, intensificaram seus ataques contra nossos aliados e profanaram as terras sagradas da região. Seus rituais sombrios e sua agressividade implacável não podem mais ser tolerados. Precisamos revidar com fúria e livrar estas terras da corrupção deles.

Para chegar à Aldeia Revatusco, entre nas Terras Agrestes pela passagem montanhosa a leste do Contraforte de Eira dos Montes e siga até a costa oriental.

O destino chama!]=],
        o = "Apresente-se a Otho Moji'ko na Aldeia Revatusco, nas Terras Agrestes.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14246] = {
        title = "Ordens do Chefe Guerreiro: Terras Pestilentas Ocidentais!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar ao Alto-Executor Derrington, no Baluarte, nas Terras Pestilentas Ocidentais.

Sua ajuda é necessária para repelir o Flagelo e recuperar a parte perdida de Andorhal.

Para chegar ao Baluarte, viaje para o sul a partir da Cidade Baixa, atravessando as Clareiras de Tirisfal. Siga a estrada até a fronteira leste, onde o Baluarte mantém guarda.

O destino chama!]=],
        o = "Apresente-se ao Alto-Executor Derrington no Baluarte, nas Terras Pestilentas Ocidentais.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14247] = {
        title = "Ordens do Chefe Guerreiro: Terras Pestilentas Orientais!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar à Arquimaga Angela Dosantos, nas Terras Pestilentas Orientais.

A Cruzada Argêntea precisa de sua ajuda para arrancar as Terras Pestilentas Orientais das garras do Flagelo.

Para encontrar Angela Dosantos na Capela Esperança da Luz, siga para nordeste passando pelo Cruzamento de Corin até chegar à capela, um refúgio em meio à desolação.

O destino chama!]=],
        o = "Apresente-se à Arquimaga Angela Dosantos na Capela Esperança da Luz, nas Terras Pestilentas Orientais.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14248] = {
        title = "Ordens do Chefe Guerreiro: Garganta Abrasadora!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Hansel Heavyhands, no Posto de Tório, na Garganta Abrasadora.

Heavyhands informa que os anões Ferro Negro da Garganta Abrasadora parecem estar se preparando para atacar. Seu dever é descobrir tudo o que puder sobre os planos deles e pôr um fim à ameaça. Você pode chegar à Garganta Abrasadora seguindo a estrada para oeste a partir dos Ermos.

O destino chama!]=],
        o = "Apresente-se a Hansel Heavyhands no Posto de Tório, na Garganta Abrasadora.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14249] = {
        title = "Ordens do Chefe Guerreiro: Ermos!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Gorn, em Karrath, nos Ermos.

Os anões Forjassombra, aliados do clã Ferro Negro, foram vistos reunindo forças nos Ermos. A presença deles ameaça nossos aliados e a estabilidade da região. Sua missão é caçá-los e eliminá-los antes que consigam colocar seus planos em prática.

Para chegar aos Ermos, viaje para leste a partir da Garganta Abrasadora. Karrath, nossa fortaleza na região, servirá como sua base de operações.

O destino chama!]=],
        o = "Apresente-se a Gorn em Karrath, nos Ermos.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14250] = {
        title = "Ordens do Chefe Guerreiro: Pântano das Mágoas!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Dar, em Pedregal, no Pântano das Mágoas.

Para chegar ao Pântano das Mágoas, viaje para o sul a partir da Barreira do Inferno. Pedregal, nosso posto avançado na região, servirá como sua base de operações.

O destino chama!]=],
        o = "Apresente-se a Dar em Pedregal, no Pântano das Mágoas.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14251] = {
        title = "Ordens do Chefe Guerreiro: Selva do Espinhaço Setentrional!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar ao Comandante Aggro'gosh, no Acampamento Grom'gol.

O comandante precisa de sua ajuda para manter as rotas de suprimento abertas e livres da interferência dos habitantes locais e da inconveniente Aliança.

Para chegar a Grom'gol, pegue o zepelim na torre nos arredores de Orgrimmar ou na torre próxima à Cidade Baixa.

O destino chama!]=],
        o = "Apresente-se ao Comandante Aggro'gosh no Acampamento Grom'gol, na Selva do Espinhaço Setentrional.",
        c = "Pela força e pela fúria da Horda!",
    },
    [14252] = {
        title = "Ordens do Chefe Guerreiro: Angra do Butim!",
        d = [=[Todos os membros da Horda em boas condições físicas estão, por meio deste, convocados a se apresentar a Crank Fizzlebub, em Angra do Butim.

Viaje para o sul a partir da Selva do Espinhaço Setentrional e siga pela estrada até a movimentada cidade portuária goblin de Angra do Butim. Crank Fizzlebub pode ser encontrado perto das docas e precisa de ajuda em tarefas essenciais para manter o equilíbrio de poder na Selva do Espinhaço.

O destino chama!]=],
        o = "Apresente-se a Crank Fizzlebub em Angra do Butim, no sul da Selva do Espinhaço.",
        c = "Pela força e pela fúria da Horda!",
    },
}

local Q = A.QuestData
local T = A.QuestTitle
local TE = A.QuestTitleEN
local QX = A.QuestUIExact

for id, patch in pairs(BOARD) do
    local quest = Q and Q[id]
    local enTitle = TE and TE[id]

    if T and patch.title then T[id] = patch.title end

    if QX and enTitle and patch.title then
        QX[enTitle] = patch.title
    end

    if quest then
        if QX and quest.dEN and patch.d then QX[quest.dEN] = patch.d end
        if QX and quest.oEN and patch.o then QX[quest.oEN] = patch.o end
        if QX and quest.pEN and patch.p then QX[quest.pEN] = patch.p end
        if QX and quest.cEN and patch.c then QX[quest.cEN] = patch.c end

        if patch.d ~= nil then quest.d = patch.d end
        if patch.o ~= nil then quest.o = patch.o end
        if patch.p ~= nil then quest.p = patch.p end
        if patch.c ~= nil then quest.c = patch.c end
    end
end

-- O nome oficial ptBR do objeto e os textos que podem aparecer em tooltip/mapa.
local BOARD_NAME = "Mural de Ordens do Chefe Guerreiro"
if A.MapLabels then
    A.MapLabels["Warchief's Command Board"] = BOARD_NAME
    A.MapLabels["Warchief's Command board"] = BOARD_NAME
end
if A.UIStringsByEN then
    A.UIStringsByEN["Warchief's Command Board"] = BOARD_NAME
    A.UIStringsByEN["Warchief's Command board"] = BOARD_NAME
end
if QX then
    QX["Warchief's Command Board"] = BOARD_NAME
    QX["Warchief's Command board"] = BOARD_NAME
    QX["Warchief's Command"] = "Ordens do Chefe Guerreiro"
end

-- Fala do arauto que fica ao lado do mural.
if A.GossipEN2ES then
    A.GossipEN2ES[ [=[Lok'tar, $c. Behind me is the Warchief's Command board containing our leader's instructions to members of the Horde. It will tell you where your skills will best serve the Horde in battle against its foes.]=] ] = [=[Lok'tar, $c. Atrás de mim está o Mural de Ordens do Chefe Guerreiro, onde estão as instruções de nosso líder para os membros da Horda. O mural indicará onde suas habilidades poderão servir melhor à Horda na luta contra seus inimigos.]=]
end
