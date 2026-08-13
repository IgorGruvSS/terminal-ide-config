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

O perfil salvo contém somente o modo (`light` ou `dark`); o perfil Catppuccin é
fixo. Sem uma seleção salva, o sincronizador usa o modo `light`.

## Trocar o tema

Liste o perfil disponível e escolha o modo:

```bash
alacritty-theme list
alacritty-theme set dark
alacritty-theme set light
```

Para preservar o perfil escolhido e alternar somente conforme a preferência
claro/escuro do KDE Plasma, use:

```bash
alacritty-theme system
```

O serviço instalado para o portal do KDE também executa essa sincronização
quando a preferência do sistema muda. Dentro do Neovim, `:ThemeSync` força a
leitura do estado e `:ThemeCurrent` informa a seleção atual.

## Tema instalado

Catppuccin é o único tema instalado e o sincronizador usa `catppuccin-latte`
no modo claro e `catppuccin-macchiato` no modo escuro. Para reaplicar o estado
salvo dentro do Neovim, use `:ThemeSync`; `:ThemeCurrent` mostra o modo atual.

## Melhorias visuais

| Plugin | Efeito |
| --- | --- |
| `nvim-treesitter` | Highlight estrutural |
| `rainbow-delimiters.nvim` | Cores em delimitadores aninhados |
| `indent-blankline.nvim` | Guias de indentação e escopo |
| `nvim-highlight-colors` | Símbolo `■` ao lado de cores |
| `nvim-web-devicons` | Ícones por tipo de arquivo |
| `render-markdown.nvim` | Renderização enriquecida de Markdown |
