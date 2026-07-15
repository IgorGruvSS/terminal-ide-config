# Guia do Neovim

Este guia descreve a configuração que realmente existe em `nvim/`. A tecla
líder é `Space`; portanto, `Space ff` significa pressionar `Space`, soltar e
depois pressionar `f` duas vezes.

## Descobrir comandos sem decorar tudo

| Ação | Atalho ou comando |
| --- | --- |
| Ver os próximos atalhos disponíveis | Pressione `Space` e aguarde o WhichKey |
| Pesquisar todos os atalhos registrados | `Space fk` |
| Abrir o gerenciador de plugins | `:Lazy` |
| Ver os atalhos do painel atual do Neo-tree | `?` dentro do Neo-tree |
| Ver os atalhos da tela atual do Diffview | `g?` dentro do Diffview |
| Ver os atalhos de um seletor Telescope | `Ctrl+/` no seletor |
| Inspecionar LSPs ativos | `:checkhealth vim.lsp` |
| Diagnosticar formatadores | `:ConformInfo` |

Esses comandos são a melhor saída quando você lembra do recurso, mas não do
atalho. O `Space fk`, em particular, funciona como um cheatsheet pesquisável.

## Fluxos principais

### Encontrar e abrir arquivos com Telescope

O Telescope é a busca rápida do editor. Use-o quando você sabe parte do nome
de um arquivo, algum texto do código ou quer voltar para um buffer já aberto.

| Atalho | Ação |
| --- | --- |
| `Space ff` | Procurar arquivos no projeto |
| `Space fg` | Procurar texto dentro dos arquivos (`live grep`) |
| `Space fb` | Listar e trocar entre buffers abertos |
| `Space fh` | Pesquisar a ajuda do Neovim |
| `Space fk` | Pesquisar atalhos registrados |

Controles dentro de qualquer seletor do Telescope:

| Atalho | Ação |
| --- | --- |
| `Ctrl+N` / `Ctrl+P` ou setas | Próximo / item anterior |
| `Enter` | Abrir o item selecionado |
| `Ctrl+V` | Abrir em split vertical |
| `Ctrl+X` | Abrir em split horizontal |
| `Ctrl+T` | Abrir em nova aba do Neovim |
| `Ctrl+U` / `Ctrl+D` | Rolar a prévia para cima / baixo |
| `Ctrl+C` | Fechar o seletor |
| `Ctrl+/` | Mostrar os atalhos disponíveis |

Casos de uso rápidos:

- arquivo pelo nome: `Space ff`, digite parte do caminho e pressione `Enter`;
- referência textual ainda sem LSP: `Space fg`, digite o texto procurado;
- arquivo já aberto: `Space fb` em vez de procurar novamente no disco;
- arquivo encontrado em outro painel: use `Ctrl+V` ou `Ctrl+X` no resultado.

### Explorar e manipular arquivos com Neo-tree

Use o Neo-tree para entender a estrutura do projeto e para operações de
arquivo. Para simplesmente chegar a um arquivo conhecido, Telescope costuma
ser mais rápido.

| Atalho global | Ação |
| --- | --- |
| `Space e` | Abrir ou fechar a árvore |
| `Space o` | Levar o foco para a árvore |

Controles dentro do Neo-tree:

| Atalho | Ação |
| --- | --- |
| `Enter` | Abrir arquivo ou expandir diretório |
| `Space` | Expandir ou recolher o nó |
| `s` | Abrir arquivo em split vertical |
| `S` | Abrir arquivo em split horizontal |
| `t` | Abrir em nova aba do Neovim |
| `a` / `A` | Criar arquivo / diretório |
| `r` | Renomear |
| `d` | Excluir |
| `y` / `x` / `p` | Copiar / recortar / colar |
| `c` / `m` | Copiar / mover informando o destino |
| `H` | Mostrar ou ocultar arquivos filtrados |
| `/` | Buscar dentro da árvore |
| `Backspace` | Subir um diretório |
| `.` | Tornar o diretório selecionado a raiz da árvore |
| `[g` / `]g` | Mudança Git anterior / seguinte |
| `P` | Ativar ou fechar a prévia flutuante |
| `R` | Atualizar a árvore |
| `q` | Fechar a árvore |
| `?` | Mostrar todos os atalhos do painel |

Os arquivos ocultos e ignorados pelo Git continuam visíveis por configuração;
eles aparecem com indicação visual diferente, em vez de desaparecerem.

### Navegar e refatorar com LSP

O LSP fornece entendimento semântico do código: definição, referências,
renomeação, ações de código e diagnósticos. Os atalhos abaixo só existem em um
buffer ao qual um servidor LSP conseguiu se conectar.

| Atalho | Ação |
| --- | --- |
| `gd` | Ir para a definição do símbolo |
| `gr` | Listar referências do símbolo |
| `K` | Mostrar documentação e tipo sob o cursor |
| `Space rn` | Renomear símbolo no projeto |
| `Space ca` | Mostrar ações de código disponíveis |
| `[d` / `]d` | Diagnóstico anterior / seguinte |
| `Space d` | Abrir detalhes do diagnóstico atual |

Servidores previstos na configuração:

| Linguagem | Executável procurado |
| --- | --- |
| Go | `gopls` |
| Lua | `lua-language-server` |
| JavaScript / TypeScript | `typescript-language-server` |
| Python | `basedpyright`, com fallback para `pyright` |
| JSON | `vscode-json-language-server` |
| YAML | `yaml-language-server` |

Se `gd` ou `Space rn` não fizer nada, rode `:checkhealth vim.lsp`. A
configuração ignora silenciosamente servidores cujo executável não esteja
instalado.

### Autocompletar com nvim-cmp

O menu combina sugestões do LSP, palavras do buffer atual e caminhos do sistema
de arquivos.

| Atalho em modo de inserção | Ação |
| --- | --- |
| `Ctrl+Space` | Abrir a conclusão manualmente |
| `Enter` | Confirmar o item selecionado |
| `Tab` | Confirmar a sugestão visível; sem menu, mantém o Tab normal |
| `Shift+Tab` | Selecionar a sugestão anterior |
| `Ctrl+E` | Cancelar o menu |

### Revisar mudanças e histórico com Diffview

O Diffview oferece uma revisão visual do Git dentro do Neovim.

| Atalho global | Ação |
| --- | --- |
| `Space do` | Comparar working tree e index |
| `Space df` | Comparar `origin/develop...HEAD`, incluindo mudanças locais |
| `Space dh` | Abrir histórico Git do arquivo atual |
| `Space dc` | Fechar o Diffview |

O `Space df` pressupõe que o repositório tenha a referência
`origin/develop`. Para outra base, use, por exemplo,
`:DiffviewOpen origin/main...HEAD --imply-local`.

Controles mais úteis dentro do Diffview:

| Atalho | Ação |
| --- | --- |
| `Tab` / `Shift+Tab` | Próximo / arquivo anterior |
| `Enter` | Abrir o diff selecionado no painel de arquivos |
| `s` ou `-` | Stage / unstage do arquivo selecionado |
| `S` / `U` | Stage de todos / unstage de todos |
| `gf` | Voltar ao arquivo editável |
| `Space e` | Focar o painel de arquivos |
| `Space b` | Mostrar ou ocultar o painel de arquivos |
| `g?` | Ajuda dos atalhos válidos na tela atual |

O plugin Gitsigns complementa esse fluxo mostrando na coluna lateral quais
linhas foram adicionadas, alteradas ou removidas. Ele não possui atalhos
customizados nesta configuração.

### Salvar e formatar

| Atalho ou comportamento | Ação |
| --- | --- |
| `Space w` | Salvar o arquivo |
| `Space as` | Ativar ou desativar o salvamento automático |
| `Space q` | Fechar a janela atual |
| `Esc` | Limpar o destaque da última busca |

O auto-save começa **desativado**. Quando ativado, salva depois de 1,5 segundo
sem alterações e também ao sair do buffer, perder o foco ou encerrar o editor.

O Conform tenta formatar automaticamente a cada salvamento:

| Arquivos | Formatadores |
| --- | --- |
| Lua | `stylua` |
| Go | `goimports`, com fallback para `gofmt` |
| JavaScript, TypeScript e JSX/TSX | `prettier` |
| JSON, YAML e Markdown | `prettier` |
| Python | `black` |

Os formatadores são programas externos. Use `:ConformInfo` quando o arquivo
não for formatado. O Prettier está configurado para rodar somente quando o
Conform encontra um diretório de projeto adequado.

### Ler e editar Markdown

`render-markdown.nvim` estiliza títulos, listas, checkboxes, tabelas e blocos
de código em arquivos Markdown. Ele é carregado apenas nesse tipo de arquivo.

| Comando | Ação |
| --- | --- |
| `:RenderMarkdown toggle` | Alternar entre fonte e visual renderizado |
| `:RenderMarkdown buf_toggle` | Alternar apenas no buffer atual |
| `:RenderMarkdown preview` | Abrir uma prévia renderizada ao lado |

## Temas instalados

Existem três plugins de tema. O tema ativo e persistente é **Aura Dark**,
definido por `vim.cmd.colorscheme("aura-dark")` em `nvim/init.lua`.

| Plugin | Temas disponíveis | Situação atual |
| --- | --- | --- |
| `baliestri/aura-theme` | `aura-dark`, `aura-dark-soft-text`, `aura-soft-dark`, `aura-soft-dark-soft-text` | `aura-dark` ativo |
| `catppuccin/nvim` | `catppuccin-latte`, `catppuccin-frappe`, `catppuccin-macchiato`, `catppuccin-mocha` | Instalado, inativo |
| `getomni/neovim` | `omni` | Instalado, inativo |

Para experimentar durante a sessão atual:

```vim
:colorscheme catppuccin-mocha
:colorscheme omni
:colorscheme aura-dark
```

Para tornar a troca permanente, altere a chamada `vim.cmd.colorscheme(...)` em
`nvim/init.lua`. A configuração reaplica cores próprias para tags TSX/JSX após
cada troca de tema.

## Inventário completo de plugins

### Recursos usados diretamente

| Plugin | Para que serve | Como você usa |
| --- | --- | --- |
| `telescope.nvim` | Busca arquivos, texto, buffers, ajuda e atalhos | `Space f...` |
| `neo-tree.nvim` | Árvore e operações de arquivos | `Space e`, `Space o` |
| `nvim-lspconfig` | Configura servidores de linguagem | `gd`, `gr`, `K`, `Space r...`, diagnósticos |
| `nvim-cmp` | Menu de autocompletar | `Ctrl+Space`, `Tab`, `Enter` |
| `diffview.nvim` | Diff, histórico e stage visual do Git | `Space d...` |
| `auto-save.nvim` | Salvamento automático com debounce | `Space as`; desativado ao iniciar |
| `conform.nvim` | Formatação automática ao salvar | Automático; `:ConformInfo` para diagnóstico |
| `render-markdown.nvim` | Renderização enriquecida de Markdown | Automático em Markdown; `:RenderMarkdown ...` |
| `which-key.nvim` | Exibe continuações dos atalhos | Pressione `Space` e aguarde |

### Melhorias visuais automáticas

| Plugin | Para que serve | Atalho |
| --- | --- | --- |
| `gitsigns.nvim` | Marca linhas adicionadas, alteradas e removidas | Nenhum customizado |
| `nvim-treesitter` | Parsing e highlight estrutural mais preciso | Automático |
| `rainbow-delimiters.nvim` | Colore pares aninhados de delimitadores | Automático |
| `indent-blankline.nvim` | Guias verticais de indentação e escopo | Automático |
| `nvim-highlight-colors` | Mostra `■` com a cor de valores hex, RGB e HSL | Automático |
| `nvim-web-devicons` | Ícones por tipo de arquivo | Automático no Neo-tree e em outros painéis |
| Aura, Catppuccin e Omni | Esquemas de cores | `:colorscheme ...` |

### Infraestrutura e dependências

| Plugin | Consumidor / função |
| --- | --- |
| `lazy.nvim` | Instala, carrega e atualiza todos os plugins; interface em `:Lazy` |
| `plenary.nvim` | Biblioteca usada por Telescope, Neo-tree e Diffview |
| `nui.nvim` | Componentes de interface usados pelo Neo-tree |
| `telescope-fzf-native.nvim` | Ordenação nativa mais rápida para o Telescope |
| `cmp-nvim-lsp` | Sugestões do LSP no nvim-cmp |
| `cmp-buffer` | Palavras do buffer no nvim-cmp |
| `cmp-path` | Caminhos de arquivos no nvim-cmp |

Essas dependências não precisam ser acionadas diretamente.
