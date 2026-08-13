# Aparência e temas do Neovim

## Índice

- [Perfis sincronizados](#perfis-sincronizados)
- [Trocar o tema](#trocar-o-tema)
- [Temas instalados](#temas-instalados)
- [Melhorias visuais](#melhorias-visuais)

## Perfis sincronizados

Alacritty e Neovim usam o mesmo perfil e modo (claro ou escuro). A seleção fica
em `.local/state/alacritty-theme`: o Alacritty a recarrega automaticamente e o
Neovim a aplica ao iniciar ou ao receber foco.

| Perfil | Neovim claro | Neovim escuro |
| --- | --- | --- |
| `catppuccin` | Catppuccin Latte | Catppuccin Macchiato |
| `catppuccin` | Catppuccin Latte | Catppuccin Macchiato |

Sem uma seleção salva, o Neovim usa Aura e preserva seu `background` atual.

## Trocar o tema

Liste os perfis disponíveis e escolha um par:

```bash
alacritty-theme list
alacritty-theme set catppuccin dark
alacritty-theme set catppuccin light
```

Para preservar o perfil escolhido e alternar somente conforme a preferência
claro/escuro do KDE Plasma, use:

```bash
alacritty-theme system
```

O serviço instalado para o portal do KDE também executa essa sincronização
quando a preferência do sistema muda. Dentro do Neovim, `:ThemeSync` força a
leitura do estado e `:ThemeCurrent` informa a seleção atual.

## Temas instalados

Além dos temas usados pelos perfis, Aura inclui variantes extras e Catppuccin
também disponibiliza frappe e mocha. É possível testar qualquer esquema durante
a sessão:


```vim
:colorscheme catppuccin-mocha
:colorscheme catppuccin-macchiato
```

Essas trocas são temporárias: `:ThemeSync`, uma nova sessão ou retornar o foco
ao Neovim restaura o perfil selecionado.

## Melhorias visuais

| Plugin | Efeito |
| --- | --- |
| `nvim-treesitter` | Highlight estrutural |
| `rainbow-delimiters.nvim` | Cores em delimitadores aninhados |
| `indent-blankline.nvim` | Guias de indentação e escopo |
| `nvim-highlight-colors` | Símbolo `■` ao lado de cores |
| `nvim-web-devicons` | Ícones por tipo de arquivo |
| `render-markdown.nvim` | Renderização enriquecida de Markdown |
