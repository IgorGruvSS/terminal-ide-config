# Neovim

Esta documentação descreve a configuração real em `nvim/`. A tecla líder é
`Space`: `Space ff` significa pressionar `Space`, soltar e pressionar `f` duas
vezes.

## Índice

- [Começar pelo contexto](#começar-pelo-contexto)
- [Descobrir comandos](#descobrir-comandos)
- [Atalhos globais essenciais](#atalhos-globais-essenciais)

## Começar pelo contexto

- [Descoberta e navegação](navigation.md): Telescope e Neo-tree.
- [Edição e inteligência de código](coding.md): LSP, completion, formatação,
  auto-save, alterações externas e Markdown.
- [Debug e SQL](debugging-sql.md): DAP para Go/Python e Dadbod sem segredos.
- [Git dentro do Neovim](git.md): LazyGit, Diffview e Gitsigns.
- [Aparência e temas](appearance.md): Catppuccin sincronizado entre Alacritty,
  Neovim e KDE.
- [Plugins](plugins.md): inventário completo e estrutura das configurações.
- [Matriz da migração](migracao-lazyvim.md): equivalências e decisões de conflito.

## Descobrir comandos

| Ação | Atalho ou comando |
| --- | --- |
| Ver continuações disponíveis | Pressione `Space` e aguarde o WhichKey |
| Pesquisar todos os atalhos | `Space fk` |
| Abrir o gerenciador de plugins | `:Lazy` |
| Examinar Extras oficiais | `:LazyExtras` |
| Examinar ferramentas externas | `:Mason` |
| Ajuda do Neo-tree | `?` dentro do painel |
| Ajuda do Diffview | `g?` dentro do painel |
| Ajuda do LazyGit | `?` dentro do painel |
| Ajuda de um seletor Telescope | `Ctrl+/` |
| Inspecionar LSPs | `:checkhealth vim.lsp` |
| Diagnosticar formatadores | `:ConformInfo` |
| Diagnóstico geral | `:checkhealth` |

`Space fk` é o cheatsheet pesquisável do próprio editor.

## Atalhos globais essenciais

| Atalho | Ação |
| --- | --- |
| `Space ff` | Encontrar arquivo |
| `Space fg` / `Space fr` | Buscar texto literal / regex |
| `Space fb` | Listar buffers abertos |
| `Space e` / `Space o` | Alternar / focar Neo-tree |
| `Space w` | Salvar |
| `Space gg` | Abrir LazyGit |
| `Space go` | Abrir diff do working tree |
| `Space dc` | Continuar uma sessão de debug |
| `Space as` | Alternar auto-save |
| `Alt+D` / `Alt+Shift+D` | Adicionar / pular ocorrência multicursor |
| `Space yp` | Copiar caminho absoluto do arquivo atual |
| `Space yr` | Copiar caminho relativo do arquivo atual |
| `Space qs` | Restaurar uma sessão |
| `Space qS` | Escolher uma sessão para restaurar |
| `Space ql` | Restaurar a última sessão |
| `Space qd` | Excluir uma sessão |

## O que cada camada faz

- **LazyVim** fornece defaults coerentes e Extras oficiais para linguagens,
  Telescope, Neo-tree, completion, DAP e SQL.
- **lazy.nvim** baixa, trava e carrega os plugins descritos em Lua.
- **Mason** instala executáveis externos reproduzíveis, como servidores LSP,
  Black, Delve e debugpy; dependências fixadas pelo projeto continuam locais.
- **LSP** fornece navegação, diagnósticos, rename e ações de código.
- **Conform** escolhe e executa os formatadores ao salvar.
- **DAP** conecta o Neovim aos debuggers de Go e Python.

As customizações pequenas ficam em `nvim/lua/config/` e
`nvim/lua/plugins/`. O lockfile continua em `nvim/lazy-lock.json` e todo o
runtime continua em `.local/`, `.state/` e `.cache/` deste repositório.
