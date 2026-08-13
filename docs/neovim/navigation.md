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
| `Space fg` | Procurar texto **literal** no projeto (`--fixed-strings`) |
| `Space fr` | Procurar texto como **regex ripgrep** |
| `Space fb` | Listar buffers |
| `Space fh` | Pesquisar ajuda |
| `Space fk` | Pesquisar atalhos |

As duas buscas usam smart case e a raiz do projeto calculada pelo LazyVim.
`Space fg` procura `foo(` exatamente, sem escapar o parêntese. `Space fr`
aceita, por exemplo, `foo\([^)]*\)` como expressão regular. `/` permanece a
busca regex nativa apenas no buffer atual.

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

## Buffers, janelas e abas

Um **buffer** é o texto de um arquivo (ou um texto ainda sem nome); uma
**janela** é uma vista de um buffer; uma **aba** organiza uma ou mais janelas.
Fechar um buffer não precisa fechar a janela nem o processo.

| Atalho | Ação |
| --- | --- |
| `H` / `L` | Buffer anterior / seguinte |
| `Space fb` | Listar buffers, inclusive modificados |
| `Space bd` | Fechar o buffer atual com segurança |
| `Space bo` | Fechar os outros buffers com segurança |

A linha superior mostra nome, modificação e diagnósticos. Ao fechar conteúdo
modificado, escolha **Salvar**, **Descartar** ou **Cancelar**. Em um buffer sem
nome, **Salvar** pede o caminho; cancelar preserva o texto. O grupo `Space q`
fica reservado às sessões do LazyVim; use `Space qs`, `Space qS`, `Space ql` e
`Space qd` para restaurar, escolher, restaurar a última e excluir sessões.
