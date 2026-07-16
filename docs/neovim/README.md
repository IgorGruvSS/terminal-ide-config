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
- [Git dentro do Neovim](git.md): LazyGit, Diffview e Gitsigns.
- [Aparência e temas](appearance.md): Aura, temas alternativos e melhorias
  visuais.
- [Plugins](plugins.md): inventário completo e estrutura das configurações.

## Descobrir comandos

| Ação | Atalho ou comando |
| --- | --- |
| Ver continuações disponíveis | Pressione `Space` e aguarde o WhichKey |
| Pesquisar todos os atalhos | `Space fk` |
| Abrir o gerenciador de plugins | `:Lazy` |
| Ajuda do Neo-tree | `?` dentro do painel |
| Ajuda do Diffview | `g?` dentro do painel |
| Ajuda do LazyGit | `?` dentro do painel |
| Ajuda de um seletor Telescope | `Ctrl+/` |
| Inspecionar LSPs | `:checkhealth vim.lsp` |
| Diagnosticar formatadores | `:ConformInfo` |

`Space fk` é o cheatsheet pesquisável do próprio editor.

## Atalhos globais essenciais

| Atalho | Ação |
| --- | --- |
| `Space ff` | Encontrar arquivo |
| `Space fg` | Encontrar texto |
| `Space e` / `Space o` | Alternar / focar Neo-tree |
| `Space w` | Salvar |
| `Space gg` | Abrir LazyGit |
| `Space do` | Abrir diff do working tree |
| `Space as` | Alternar auto-save |
| `Space q` | Fechar a janela atual |
