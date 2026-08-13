# Plugins do Neovim

## Índice

- [Organização das configurações](#organização-das-configurações)
- [Recursos diretos](#recursos-diretos)
- [Melhorias automáticas](#melhorias-automáticas)
- [Infraestrutura](#infraestrutura)

## Organização das configurações

`nvim/lua/config/lazy.lua` importa o núcleo e as diferenças locais;
`nvim/lazyvim.json` registra os Extras oficiais gerenciáveis por `:LazyExtras`:

```text
plugins/
├── coding/     ajustes de LSP, completion, formatação e Treesitter
├── editing/    auto-save e múltiplos cursores
├── git/        atalhos adicionais do Diffview
├── interface/  navegação e melhorias visuais da interface
└── themes/     esquemas de cores
```

Os Extras habilitados são: nvim-cmp, Neo-tree, Telescope, DAP core, Go, Python,
Vue/TypeScript, JSON, YAML, Markdown e SQL. Eles são imports, não cópias da
configuração interna do LazyVim.

## Recursos diretos

| Plugin | Finalidade | Uso principal |
| --- | --- | --- |
| `telescope.nvim` | Busca | `Space f...` |
| `neo-tree.nvim` | Árvore e arquivos | `Space e`, `Space o` |
| `nvim-lspconfig` | Servidores de linguagem | `gd`, `gr`, `K`, `Space r...` |
| `nvim-cmp` | Autocomplete | `Ctrl+Space`, `Tab`, `Enter` |
| `diffview.nvim` | Diff e histórico | `Space g...` |
| Snacks LazyGit | LazyGit flutuante | `Space gg` |
| `auto-save.nvim` | Auto-save opcional | `Space as` |
| `conform.nvim` | Formatação ao salvar | `:ConformInfo` |
| `render-markdown.nvim` | Markdown enriquecido | `:RenderMarkdown ...` |
| `which-key.nvim` | Descoberta de atalhos | Pressione `Space` |
| `multicursor.nvim` | Edição de ocorrências simultâneas | `Alt+D` |
| `nvim-dap` / `nvim-dap-ui` | Debug Go e Python | `Space d...` |
| `vim-dadbod-ui` | Consultas SQL | `Space D...` |

## Melhorias automáticas

| Plugin | Finalidade |
| --- | --- |
| `gitsigns.nvim` | Sinais de alterações Git |
| `nvim-treesitter` | Parsing e highlight |
| `rainbow-delimiters.nvim` | Delimitadores aninhados |
| `indent-blankline.nvim` | Guias de indentação |
| `nvim-highlight-colors` | Prévia de cores |
| `nvim-web-devicons` | Ícones |
| Aura, Alabaster, Catppuccin, Flexoki, GitHub e Modus | Temas sincronizados com o Alacritty |

## Gerenciar sem adivinhar specs

1. Procure primeiro em `:LazyExtras`; a interface registra o Extra oficial em
   `nvim/lazyvim.json`, que deve ser revisado e versionado.
2. Para um plugin sem Extra, consulte a documentação oficial e crie um arquivo
   pequeno em `nvim/lua/plugins/<responsabilidade>/`; não copie a configuração
   inteira de outro starter.
3. Execute `nvim '+Lazy sync'`, revise `:Lazy` e versione a alteração do
   `nvim/lazy-lock.json`.
4. Ferramentas externas aparecem em `:Mason`; o instalador resolve a lista
   declarativa dos Extras e customizações. Use `:checkhealth`,
   `:checkhealth vim.lsp` e `:ConformInfo` para diagnosticar.

## Infraestrutura

| Plugin | Consumidor ou função |
| --- | --- |
| `lazy.nvim` | Instala e carrega plugins |
| `mason.nvim` | Instala servidores, formatadores, linters e adaptadores |
| `plenary.nvim` | Telescope, Neo-tree, Diffview e LazyGit |
| `nui.nvim` | Neo-tree |
| `telescope-fzf-native.nvim` | Ordenação nativa do Telescope |
| `cmp-nvim-lsp` | Completion do LSP |
| `cmp-buffer` | Palavras do buffer |
| `cmp-path` | Caminhos |

Essas dependências não precisam ser acionadas diretamente.
