# Aparência e temas do Neovim

## Índice

- [Tema ativo](#tema-ativo)
- [Temas instalados](#temas-instalados)
- [Trocar o tema](#trocar-o-tema)
- [Melhorias visuais](#melhorias-visuais)

## Tema ativo

O tema persistente é **Aura Dark**, definido por
`vim.cmd.colorscheme("aura-dark")` em `nvim/init.lua`.

## Temas instalados

| Plugin | Temas | Estado |
| --- | --- | --- |
| `baliestri/aura-theme` | quatro variantes Aura | `aura-dark` ativo |
| `catppuccin/nvim` | latte, frappe, macchiato e mocha | inativo |
| `getomni/neovim` | `omni` | inativo |

## Trocar o tema

Para experimentar durante a sessão:

```vim
:colorscheme catppuccin-mocha
:colorscheme omni
:colorscheme aura-dark
```

Para persistir, altere `vim.cmd.colorscheme(...)` em `nvim/init.lua`. As cores
customizadas de tags TSX/JSX são reaplicadas após cada troca.

## Melhorias visuais

| Plugin | Efeito |
| --- | --- |
| `nvim-treesitter` | Highlight estrutural |
| `rainbow-delimiters.nvim` | Cores em delimitadores aninhados |
| `indent-blankline.nvim` | Guias de indentação e escopo |
| `nvim-highlight-colors` | Símbolo `■` ao lado de cores |
| `nvim-web-devicons` | Ícones por tipo de arquivo |
| `render-markdown.nvim` | Renderização enriquecida de Markdown |
