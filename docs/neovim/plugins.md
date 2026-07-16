# Plugins do Neovim

## Índice

- [Organização das configurações](#organização-das-configurações)
- [Recursos diretos](#recursos-diretos)
- [Melhorias automáticas](#melhorias-automáticas)
- [Infraestrutura](#infraestrutura)

## Organização das configurações

`nvim/lua/plugins/init.lua` importa categorias explícitas:

```text
plugins/
├── coding/     LSP, completion, formatação e Treesitter
├── editing/    comportamento de edição e tipos de documento
├── git/        LazyGit, Diffview e Gitsigns
├── interface/  navegação e melhorias visuais da interface
└── themes/     esquemas de cores
```

Essa separação é apenas estrutural; o lockfile e o comportamento dos plugins
continuam os mesmos.

## Recursos diretos

| Plugin | Finalidade | Uso principal |
| --- | --- | --- |
| `telescope.nvim` | Busca | `Space f...` |
| `neo-tree.nvim` | Árvore e arquivos | `Space e`, `Space o` |
| `nvim-lspconfig` | Servidores de linguagem | `gd`, `gr`, `K`, `Space r...` |
| `nvim-cmp` | Autocomplete | `Ctrl+Space`, `Tab`, `Enter` |
| `diffview.nvim` | Diff e histórico | `Space d...` |
| `lazygit.nvim` | LazyGit flutuante | `Space gg` |
| `auto-save.nvim` | Auto-save opcional | `Space as` |
| `conform.nvim` | Formatação ao salvar | `:ConformInfo` |
| `render-markdown.nvim` | Markdown enriquecido | `:RenderMarkdown ...` |
| `which-key.nvim` | Descoberta de atalhos | Pressione `Space` |

## Melhorias automáticas

| Plugin | Finalidade |
| --- | --- |
| `gitsigns.nvim` | Sinais de alterações Git |
| `nvim-treesitter` | Parsing e highlight |
| `rainbow-delimiters.nvim` | Delimitadores aninhados |
| `indent-blankline.nvim` | Guias de indentação |
| `nvim-highlight-colors` | Prévia de cores |
| `nvim-web-devicons` | Ícones |
| Aura, Catppuccin e Omni | Temas |

## Infraestrutura

| Plugin | Consumidor ou função |
| --- | --- |
| `lazy.nvim` | Instala e carrega plugins |
| `plenary.nvim` | Telescope, Neo-tree, Diffview e LazyGit |
| `nui.nvim` | Neo-tree |
| `telescope-fzf-native.nvim` | Ordenação nativa do Telescope |
| `cmp-nvim-lsp` | Completion do LSP |
| `cmp-buffer` | Palavras do buffer |
| `cmp-path` | Caminhos |

Essas dependências não precisam ser acionadas diretamente.
