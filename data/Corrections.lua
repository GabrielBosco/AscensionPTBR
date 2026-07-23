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

