# Kitty + tmux + Neovim cheatsheet

> Historical detailed reference kept from the original live setup. The portable entry point is now `kitty-tmux` from this repository; the canonical short guide is [kitty-tmux-nvim-cheatsheet.md](kitty-tmux-nvim-cheatsheet.md).

Atualizado em 2026-06-15.

Este arquivo documenta o que esta configurado e funcionando no fluxo atual:
kitty como terminal, tmux como persistencia de sessoes/panes/tabs, Neovim como editor, Neo-tree como file tree e Codex rodando dentro disso.

## Camadas

| Camada | Responsabilidade |
|---|---|
| kitty | Janela do terminal, fonte, tema, notificacoes e envio de atalhos para tmux |
| tmux | Sessoes persistentes, panes e tabs/janelas |
| Neovim | Edicao de texto/codigo |
| Neo-tree | Navegacao e operacoes de arquivos dentro do Neovim |
| Codex TUI | Chat/agente dentro do terminal |

## Comecar e reaver sessoes tmux

| Acao | Comando |
|---|---|
| Abrir ou reanexar na sessao principal | `kitty-tmux` |
| Abrir ou reanexar em uma sessao nomeada | `kitty-tmux work` |
| Listar sessoes tmux abertas | `tmux ls` |
| Reanexar manualmente em uma sessao | `tmux attach -t work` |
| Criar/anexar manualmente | `tmux new-session -A -s work` |
| Renomear sessao atual | `Ctrl+B` `:` e depois `rename-session novo_nome` |
| Renomear sessao por comando | `tmux rename-session -t antigo novo` |

Observacao: se o kitty crashar, rode `kitty-tmux` ou `kitty-tmux work` de novo. Os processos continuam no tmux enquanto o servidor tmux estiver vivo.

## Prefixo tmux

O prefixo padrao do tmux continua sendo:

```text
Ctrl+B
```

Quando a tabela disser `Prefix`, leia como `Ctrl+B`.

## Panes

Os atalhos abaixo sao do kitty, mas ele envia os comandos equivalentes para o tmux.

| Acao | Atalho atual | Quem usa de verdade |
|---|---|---|
| Criar split vertical, abrindo pane a direita | `Ctrl+Shift+Enter` | kitty -> tmux `Prefix` `|` |
| Criar split horizontal, abrindo pane abaixo | `Ctrl+Shift+O` | kitty -> tmux `Prefix` `-` |
| Fechar pane atual | `Ctrl+Shift+W` | kitty -> tmux `Prefix` `x` |
| Maximizar/restaurar pane | `Ctrl+Alt+M` | kitty -> tmux `Prefix` `z` |
| Maximizar/restaurar pane | `Ctrl+Shift+Z` | kitty -> tmux `Prefix` `z` |

## Navegar entre panes

| Acao | Atalho atual | Quem usa de verdade |
|---|---|---|
| Foco para esquerda | `Alt+Left` | kitty -> tmux `Prefix` `h` |
| Foco para direita | `Alt+Right` | kitty -> tmux `Prefix` `l` |
| Foco para cima | `Alt+Up` | kitty -> tmux `Prefix` `k` |
| Foco para baixo | `Alt+Down` | kitty -> tmux `Prefix` `j` |

## Redimensionar panes

| Acao | Atalho atual | Quem usa de verdade |
|---|---|---|
| Diminuir largura para a esquerda | `Ctrl+Shift+Left` | kitty -> tmux `Prefix` `H` |
| Aumentar largura para a direita | `Ctrl+Shift+Right` | kitty -> tmux `Prefix` `L` |
| Aumentar altura para cima | `Ctrl+Shift+Up` | kitty -> tmux `Prefix` `K` |
| Aumentar altura para baixo | `Ctrl+Shift+Down` | kitty -> tmux `Prefix` `J` |

No tmux direto, os comandos sao repetiveis: segure `Ctrl+B`, solte, e use `H/J/K/L` conforme precisar. Pelos atalhos do kitty, basta repetir o atalho.

## Tabs / janelas tmux

No seu fluxo atual, "tab" equivale a "window" do tmux.

| Acao | Atalho atual | Quem usa de verdade |
|---|---|---|
| Nova tab/window | `Ctrl+Shift+T` | kitty -> tmux `Prefix` `c` |
| Tab/window anterior | `Ctrl+Shift+PageUp` | kitty -> tmux `Prefix` `p` |
| Proxima tab/window | `Ctrl+Shift+PageDown` | kitty -> tmux `Prefix` `n` |
| Ir para tab/window 1..9 | `Ctrl+Shift+1..9` | kitty -> tmux `Prefix` `1..9` |
| Fechar tab/window atual | `Ctrl+Shift+Q` | kitty -> tmux `Prefix` `&` |
| Renomear tab/window atual | `Ctrl+B` `,` | tmux |

## Scroll no historico do tmux

| Acao | Atalho |
|---|---|
| Entrar no modo scroll/copy | `Ctrl+B` `[` |
| Subir pagina | `PageUp` |
| Descer pagina | `PageDown` |
| Sair do modo scroll/copy | `q` ou `Esc` |

## Codex multiline

| Acao | Atalho | Quem usa |
|---|---|---|
| Inserir nova linha no chat | `Shift+Enter` | kitty envia newline |
| Inserir nova linha no chat | `Ctrl+J` | Codex TUI |
| Alternar modo/modelo quando a TUI oferece esse atalho | `Shift+Tab` | kitty envia BackTab -> tmux repassa |

O Codex esta configurado com `insert_newline = "ctrl-j"`, e o kitty mapeia `Shift+Enter` para o mesmo newline.

## Neovim: basico do config atual

Leader esta configurado como espaco:

```text
Leader = Space
```

| Acao | Atalho | Quem usa |
|---|---|---|
| Limpar highlight de busca | `Esc` | Neovim |
| Salvar arquivo | `Space w` | Neovim |
| Fechar janela/buffer atual | `Space q` | Neovim |
| Abrir/fechar Neo-tree | `Space e` | Neovim -> Neo-tree |
| Focar Neo-tree | `Space o` | Neovim -> Neo-tree |
| Abrir Diffview | `Space do` | Neovim -> Diffview |
| Fechar Diffview | `Space dc` | Neovim -> Diffview |
| Historico de arquivo no Diffview | `Space dh` | Neovim -> Diffview |
| Buscar arquivos | `Space ff` | Telescope |
| Buscar texto no projeto | `Space fg` | Telescope |
| Listar buffers | `Space fb` | Telescope |
| Help tags | `Space fh` | Telescope |
| Toggle auto-save | `Space as` | auto-save.nvim |

## Neovim: LSP

Esses atalhos aparecem quando um LSP esta anexado ao buffer.

| Acao | Atalho |
|---|---|
| Ir para definicao | `gd` |
| Ver referencias | `gr` |
| Hover/documentacao | `K` |
| Renomear simbolo | `Space rn` |
| Code action | `Space ca` |
| Diagnostico anterior | `[d` |
| Proximo diagnostico | `]d` |

## Neovim: autocomplete

Autocomplete usa `nvim-cmp` com fontes de LSP, arquivos/caminhos e palavras do buffer.

| Acao | Atalho |
|---|---|
| Abrir menu de completion manualmente | `Ctrl+Space` |
| Aceitar sugestao selecionada | `Enter` |
| Aceitar primeira sugestao com o menu aberto | `Tab` |
| Voltar para sugestao anterior | `Shift+Tab` |
| Fechar menu de completion | `Ctrl+E` |

Quando o menu nao esta aberto, `Tab` continua funcionando como tab/indent normal.

## Neovim: inicio/fim da linha

| Acao | Normal mode | Insert mode |
|---|---|---|
| Inicio absoluto da linha | `0` | `Ctrl+O` `0` |
| Primeiro caractere nao branco | `^` | `Ctrl+O` `^` |
| Fim da linha | `$` | `Ctrl+O` `$` |
| Ultimo caractere nao branco | `g_` | `Ctrl+O` `g_` |

## Neovim: palavras

| Acao | Atalho |
|---|---|
| Proxima palavra | `w` |
| Fim da palavra atual/proxima | `e` |
| Palavra anterior | `b` |
| Fim da palavra anterior | `ge` |

Para selecionar usando esses movimentos:

| Acao | Atalho |
|---|---|
| Comecar selecao por caractere | `v` |
| Selecionar ate proxima palavra | `v` depois `w` ou `e` |
| Selecionar ate palavra anterior | `v` depois `b` ou `ge` |
| Selecionar linhas inteiras | `V` |
| Selecao em bloco/coluna | `Ctrl+V` |

## Neovim: multiline, copiar, colar, cortar/deletar

| Acao | Atalho |
|---|---|
| Selecionar linha atual | `V` |
| Expandir selecao para baixo/cima | `j` / `k` depois de `V` |
| Copiar selecao | `y` |
| Cortar/deletar selecao | `d` |
| Copiar linha atual | `yy` |
| Cortar/deletar linha atual | `dd` |
| Colar depois do cursor/linha | `p` |
| Colar antes do cursor/linha | `P` |
| Apagar caractere atual | `x` |
| Undo | `u` |
| Redo | `Ctrl+R` |

## Neo-tree

Abrir/focar pelo Neovim:

| Acao | Atalho |
|---|---|
| Toggle Neo-tree | `Space e` |
| Focar Neo-tree | `Space o` |

Dentro do painel do Neo-tree:

| Acao | Atalho |
|---|---|
| Abrir arquivo ou expandir pasta | `Enter` |
| Expandir/recolher pasta | `Space` |
| Fechar node/pasta | `C` |
| Fechar todos os nodes | `z` |
| Atualizar tree | `R` |
| Criar arquivo | `a` |
| Criar diretorio | `A` |
| Deletar | `d` |
| Renomear | `r` |
| Copiar para clipboard interno do Neo-tree | `y` |
| Cortar para clipboard interno do Neo-tree | `x` |
| Colar do clipboard interno do Neo-tree | `p` |
| Limpar clipboard interno do Neo-tree | `Ctrl+R` |
| Abrir em split horizontal | `S` |
| Abrir em split vertical | `s` |
| Abrir em nova tab do Neovim | `t` |
| Subir para diretorio pai | `Backspace` |
| Definir diretorio atual como root | `.` |
| Mostrar/ocultar arquivos escondidos | `H` |
| Buscar dentro da tree | `/` |
| Limpar filtro | `Ctrl+X` |
| Fechar janela do Neo-tree | `q` |
| Ajuda do Neo-tree | `?` |

## Kitty puro ainda disponivel

O fluxo principal e tmux, mas ainda existe o script para salvar layout do kitty puro:

| Acao | Comando |
|---|---|
| Salvar sessao kitty atual | `kitty-save-session` |
| Restaurar sessao kitty salva | `kitty --session ~/terminal-ide-config/.state/kitty/sessions/last.conf` |

Preferencia atual: usar tmux para persistir processos/panes contra crash do kitty.

## Arquivos de config relevantes

| Arquivo | Uso |
|---|---|
| `kitty/kitty.conf` | Tema, fonte, remote control e atalhos kitty -> tmux |
| `tmux.conf` | Prefixo, splits, navegacao e resize de panes |
| `bin/kitty-tmux` | Abre ou reanexa em uma sessao tmux dentro do kitty |
| `bin/kitty-save-session` | Salva layout do kitty puro |
| `~/.codex/config.toml` | Config do Codex TUI, incluindo newline |
| `nvim/init.lua` | Leader e keymaps principais do Neovim |
| `nvim/lua/plugins/neotree.lua` | Config do Neo-tree |
