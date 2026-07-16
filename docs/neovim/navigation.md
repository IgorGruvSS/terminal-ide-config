# Descoberta e navegação no Neovim

## Índice

- [Telescope](#telescope)
- [Controles do Telescope](#controles-do-telescope)
- [Neo-tree](#neo-tree)
- [Controles do Neo-tree](#controles-do-neo-tree)

## Telescope

Use Telescope quando souber parte do nome do arquivo, algum texto do código ou
quiser voltar a um buffer aberto.

| Atalho | Ação |
| --- | --- |
| `Space ff` | Procurar arquivos |
| `Space fg` | Procurar texto no projeto |
| `Space fb` | Listar buffers |
| `Space fh` | Pesquisar ajuda |
| `Space fk` | Pesquisar atalhos |

## Controles do Telescope

| Atalho | Ação |
| --- | --- |
| `Ctrl+N` / `Ctrl+P` ou setas | Próximo / item anterior |
| `Enter` | Abrir |
| `Ctrl+V` / `Ctrl+X` | Abrir em split vertical / horizontal |
| `Ctrl+T` | Abrir em nova aba |
| `Ctrl+U` / `Ctrl+D` | Rolar a prévia |
| `Ctrl+C` | Fechar |
| `Ctrl+/` | Mostrar ajuda |

## Neo-tree

Use Neo-tree para explorar a estrutura e manipular arquivos. Para chegar
rapidamente a um arquivo conhecido, prefira Telescope.

| Atalho global | Ação |
| --- | --- |
| `Space e` | Abrir ou fechar a árvore |
| `Space o` | Focar a árvore |

## Controles do Neo-tree

| Atalho | Ação |
| --- | --- |
| `Enter` | Abrir arquivo ou expandir diretório |
| `Space` | Expandir ou recolher nó |
| `s` / `S` | Abrir em split vertical / horizontal |
| `t` | Abrir em nova aba |
| `a` / `A` | Criar arquivo / diretório |
| `r` / `d` | Renomear / excluir |
| `y` / `x` / `p` | Copiar / recortar / colar |
| `c` / `m` | Copiar / mover informando destino |
| `H` | Mostrar ou ocultar filtrados |
| `/` | Buscar na árvore |
| `Backspace` | Subir um diretório |
| `.` | Tornar o diretório a raiz |
| `[g` / `]g` | Mudança Git anterior / seguinte |
| `P` | Alternar prévia flutuante |
| `R` / `q` / `?` | Atualizar / fechar / ajuda |

Arquivos ocultos e ignorados pelo Git continuam visíveis por configuração.
