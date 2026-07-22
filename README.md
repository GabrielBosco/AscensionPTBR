# AscensionPTBR

Adaptação comunitária **não oficial** do addon **AscensionES** para **Português do Brasil (pt-BR)**, criada para jogadores brasileiros do **Project Ascension**.

> **Importante:** este projeto é gratuito, não comercial e não possui vínculo oficial com o Project Ascension, a Blizzard Entertainment ou o World of Warcraft.

---

## Sobre o projeto

O **AscensionPTBR** adapta para Português do Brasil os textos, nomes, descrições, missões, interface e demais conteúdos localizáveis do addon **AscensionES**.

A proposta não é traduzir palavra por palavra. O objetivo é oferecer uma localização natural em pt-BR, com:

- concordância e gramática revisadas;
- frases adaptadas ao contexto do jogo;
- terminologia consistente;
- preservação de variáveis, IDs, códigos de cor e estruturas Lua;
- manutenção dos textos originais em inglês usados internamente pelo addon;
- revisão de conteúdos exclusivos do Project Ascension.

---

## Créditos e autorização

Este projeto é baseado no **AscensionES**, criado originalmente por **HideXs**.

- **Criador original:** HideXs
- **Projeto original:** AscensionES
- **Repositório original:** <https://github.com/HideXs/AscensionES>
- **Adaptação pt-BR:** <GabrielBosco>

HideXs concedeu autorização expressa para que esta adaptação brasileira seja publicada e distribuída gratuitamente no GitHub, desde que:

1. o crédito original seja mantido;
2. o projeto informe claramente que é baseado no AscensionES;
3. exista um link para o repositório original;
4. a adaptação seja identificada como não oficial;
5. o projeto permaneça gratuito e não comercial;
6. os créditos e avisos de autoria originais sejam preservados.

Essas condições são respeitadas neste repositório.

Consulte também:

- [CREDITS.md](CREDITS.md)
- [PERMISSION.md](PERMISSION.md)
- [LICENSE-NOTICE.md](LICENSE-NOTICE.md)

---

## Instalação

1. Baixe a versão mais recente na página de **Releases**.
2. Extraia a pasta do addon.
3. Copie a pasta para:

```text
World of Warcraft\Interface\AddOns\
```

4. Confirme que o arquivo `.toc` está diretamente dentro da pasta do addon.
5. Abra o jogo e ative o addon na tela de seleção de personagens.
6. Quando necessário, marque a opção para carregar addons desatualizados.

### Estrutura esperada

```text
Interface
└── AddOns
    └── AscensionPTBR
        ├── AscensionPTBR.toc
        ├── Core.lua
        ├── Quests.lua
        └── ...
```

---

## Compatibilidade

- World of Warcraft 3.3.5a
- Project Ascension
- Estrutura baseada no AscensionES

A compatibilidade pode variar conforme atualizações do servidor, do cliente ou do addon original.

---

## Status da tradução

A localização está em desenvolvimento contínuo. Alguns conteúdos podem permanecer em inglês quando:

- o texto precisa ser mantido por compatibilidade;
- o nome é interno, técnico ou usado como identificador;
- não existe contexto suficiente para uma adaptação segura;
- o conteúdo foi adicionado recentemente;
- uma tradução automática poderia alterar o significado.

Trechos em espanhol, traduções literais, erros de concordância ou textos quebrados podem ser relatados na aba **Issues**.

---

## Como relatar um erro

Ao abrir uma Issue, inclua:

- texto exibido no jogo;
- tradução sugerida;
- nome da habilidade, missão, NPC ou janela;
- print da tela, quando possível;
- arquivo relacionado, caso saiba;
- versão do addon instalada.

### Exemplo

```text
Texto atual:
"Aumenta dano recebido em 10%."

Sugestão:
"Aumenta em 10% o dano recebido."

Local:
Descrição da habilidade X.

Arquivo:
SpellTips.lua
```

---

## Contribuições

Contribuições são bem-vindas, desde que respeitem:

- a estrutura original do addon;
- os créditos de HideXs e do AscensionES;
- o caráter gratuito e não comercial;
- a preservação das chaves e textos de referência em inglês;
- a preservação de placeholders como `%s`, `%d`, `$N`, `{{1}}`, `|cFFFFFFFF` e `|r`;
- a terminologia já adotada no projeto;
- a revisão humana antes do envio.

Leia [CONTRIBUTING.md](CONTRIBUTING.md) antes de enviar um Pull Request.

---

## Regras importantes para tradução

Não altere:

- IDs de missões, habilidades ou NPCs;
- chaves inglesas usadas para correspondência;
- variáveis de formatação;
- códigos de cor;
- sequências de escape;
- estrutura das tabelas Lua;
- créditos e comentários de autoria originais.

A tradução deve priorizar o sentido no jogo, e não uma conversão literal.

---

## Uso comercial

Este projeto não pode ser vendido, licenciado comercialmente, incluído em pacotes pagos ou usado para obter receita direta.

O addon e suas traduções devem permanecer gratuitos.

---

## Isenção de responsabilidade

Este é um projeto comunitário e não oficial.

**Project Ascension**, **World of Warcraft**, **Warcraft**, **Blizzard Entertainment** e demais nomes, marcas e conteúdos relacionados pertencem aos seus respectivos proprietários.

Este repositório não reivindica propriedade sobre o código, textos, recursos ou marcas do projeto original.

---

## Agradecimentos

Agradecimentos especiais a:

- **HideXs**, pela criação do AscensionES e pela autorização concedida;
- aos colaboradores do AscensionES;
- à comunidade brasileira do Project Ascension;
- aos jogadores que testam, revisam e enviam correções.

---

## Links

- AscensionES original: <https://github.com/HideXs/AscensionES>
- Releases do AscensionPTBR: <https://github.com/GabrielBosco/AscensionPTBR>
- Issues: <https://github.com/GabrielBosco/AscensionPTBR/issues>
