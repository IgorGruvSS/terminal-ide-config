# Kitty — Guia rápido de navegação e setup

Config: `~/terminal-ide-config/kitty/kitty.conf`
Recarregar config sem fechar: `Ctrl+Shift+F5`
Abrir config no editor: `Ctrl+Shift+F2`

---

## Zoom (tamanho da fonte)

| Ação                   | Atalho             |
|------------------------|--------------------|
| Zoom in (fonte maior)  | `Ctrl+Shift++`     |
| Zoom out (fonte menor) | `Ctrl+Shift+-`     |
| Reset zoom             | `Ctrl+Shift+Backspace` |

Zoom é por janela OS. Para mudar permanente, edite `font_size` no kitty.conf.

---

## Navegação entre panes

| Ação                      | Atalho (configurado) |
|---------------------------|----------------------|
| Mover foco pra esquerda   | `Alt+←`              |
| Mover foco pra direita    | `Alt+→`              |
| Mover foco pra cima       | `Alt+↑`              |
| Mover foco pra baixo      | `Alt+↓`              |

No modo `kitty-tmux`, esses atalhos controlam os panes do tmux.

---

## Maximizar / restaurar pane (zoom de um pane só)

| Ação                        | Atalho             |
|-----------------------------|---------------------|
| Toggle fullscreen do pane   | `Ctrl+Shift+Z`     |
| Toggle fullscreen do pane   | `Ctrl+Alt+M`       |

No modo `kitty-tmux`, esses atalhos acionam o zoom do tmux.

---

## Criar e fechar panes

| Ação                        | Atalho                 |
|-----------------------------|------------------------|
| Novo split vertical (lado)  | `Ctrl+Shift+Enter`    |
| Novo split horizontal (abaixo) | `Ctrl+Shift+O`    |
| Fechar pane atual           | `Ctrl+Shift+W`        |

No modo `kitty-tmux`, esses atalhos controlam panes do tmux. Fechar pane usa
o prompt de confirmação do tmux.

---

## Redimensionar panes

| Ação            | Atalho               |
|-----------------|----------------------|
| Mais estreito   | `Ctrl+Shift+←`      |
| Mais largo      | `Ctrl+Shift+→`      |
| Mais alto       | `Ctrl+Shift+↑`      |
| Mais baixo      | `Ctrl+Shift+↓`      |
| Modo resize     | `Ctrl+Shift+R` (setas pra ajustar, Esc pra sair) |

No modo `kitty-tmux`, esses atalhos redimensionam panes do tmux.

---

## Tabs

| Ação                | Atalho             |
|---------------------|---------------------|
| Nova tab            | `Ctrl+Shift+T`     |
| Ir pra tab 1..9     | `Ctrl+Shift+1..9` |
| Próxima tab         | `Ctrl+Shift+PageDown` |
| Tab anterior        | `Ctrl+Shift+PageUp` |
| Fechar tab          | `Ctrl+Shift+Q`     |

No modo `kitty-tmux`, tabs equivalem a janelas do tmux. Fechar tab usa o
prompt de confirmação do tmux.

---

## Salvar / restaurar sessão

### Kitty puro

Salvar estado atual das tabs, panes, layouts e diretórios:

```bash
kitty-save-session
```

Isso grava em:

```text
~/terminal-ide-config/.state/kitty/sessions/last.conf
```

Restaurar depois:

```bash
kitty --session ~/terminal-ide-config/.state/kitty/sessions/last.conf
```

Salvar com outro nome:

```bash
kitty-save-session ~/terminal-ide-config/.state/kitty/sessions/work.conf
kitty --session ~/terminal-ide-config/.state/kitty/sessions/work.conf
```

### Kitty + tmux

Para sobreviver a crash do kitty, deixe o estado dentro do tmux:

```bash
kitty-tmux
```

Isso abre/anexa na sessão tmux `main`. Para uma sessão nomeada:

```bash
kitty-tmux work
```

Se o kitty crashar, rode o mesmo comando de novo:

```bash
kitty-tmux work
```

Os processos, panes e diretórios continuam no tmux enquanto o servidor tmux
estiver vivo.

`tmux.conf` habilita teclas estendidas para o kitty. Isso mantém atalhos de
apps TUI funcionando dentro do tmux, incluindo `Shift+Enter` para nova linha no
chat do Codex.

Abrir pelo arquivo de sessão do kitty:

```bash
kitty --session ~/terminal-ide-config/kitty/sessions/tmux.conf
```

Atalhos tmux configurados em `~/terminal-ide-config/tmux.conf`:

| Ação                    | Atalho tmux |
|-------------------------|-------------|
| Split vertical          | `Prefix` `|` |
| Split horizontal        | `Prefix` `-` |
| Foco esquerda/baixo/cima/direita | `Prefix` `h/j/k/l` |
| Resize esquerda/baixo/cima/direita | `Prefix` `H/J/K/L` |
| Maximizar/restaurar pane | `Prefix` `z` |
| Nova janela/tab tmux    | `Prefix` `c` |
| Próxima janela          | `Prefix` `n` |
| Janela anterior         | `Prefix` `p` |
| Ir para janela 1..9     | `Prefix` `1..9` |

`Prefix` é `Ctrl+B`, a menos que seja alterado no tmux.

Para persistir também após reboot/logout, use `tmux-resurrect` ou
`tmux-continuum`. Sem esses plugins, tmux protege contra crash do kitty, mas
não contra reinício do sistema.

---

## Scrollback (ver histórico de output)

| Ação                       | Atalho              |
|----------------------------|----------------------|
| Scroll up                  | `Ctrl+Shift+PgUp`  |
| Scroll down                | `Ctrl+Shift+PgDn`  |
| Scroll up uma linha        | `Ctrl+Shift+K`     |
| Scroll down uma linha      | `Ctrl+Shift+J`     |
| Ver scrollback no pager    | `Ctrl+Shift+H`     |
| Buscar no scrollback       | `Ctrl+Shift+/`     |

---

## Dim / foco visual

O config atual usa `inactive_text_alpha 0.55` — panes sem foco ficam
com texto translúcido pra destacar o pane ativo. Ajuste o valor:
- `0.4` — muito dim (foco muito forte)
- `0.55` — moderado (atual)
- `0.7` — dim suave
- `1.0` — sem dim (todos iguais)

A borda ativa também é azul (`#89b4fa`) vs cinza escuro nas inativas.

---

## Temas

```bash
# Listar e escolher um tema interativamente:
kitten themes

# Aplicar direto:
kitten themes --reload-in=all Catppuccin-Mocha
```

O tema ativo é incluído por `kitty/kitty.conf`.

---

## Fontes

```bash
# Listar fontes instaladas (buscar mono):
fc-list : family | grep -i mono | sort -u

# Testar uma fonte:
kitty --override font_family="JetBrainsMono Nerd Font" --override font_size=10
```

Atual: `JetBrainsMono Nerd Font` (inclui ícones pro neovim/devicons).

---

## Atalhos úteis extras

| Ação                          | Atalho              |
|-------------------------------|----------------------|
| Copiar                        | `Ctrl+Shift+C`     |
| Colar                         | `Ctrl+Shift+V`     |
| Fullscreen (janela toda)      | `Ctrl+Shift+F11`   |
| Selecionar com mouse + copiar | Selecionar → solta = copia |
| URL click                     | `Ctrl+Click` no link |
| Unicode input                 | `Ctrl+Shift+U`     |

---

## Setup rápido pós-instalação

```bash
# 1. Instalar JetBrains Mono Nerd Font (se não tiver)
# Baixar de: https://github.com/ryanoasis/nerd-fonts/releases
# Extrair TTFs em ~/.local/share/fonts/ e rodar:
fc-cache -fv

# 2. Escolher tema
kitten themes

# 3. Recarregar config
# Ctrl+Shift+F5 dentro do kitty

# 4. Testar ícones nerd font
echo -e "\ue0b0 \ue0b2 \uf113 \uf015 \uf121 \uf1d3"
```

---

## Referência completa

- Config: `man kitty.conf` ou https://sw.kovidgoyal.net/kitty/conf/
- Atalhos: `kitty --list-actions` ou https://sw.kovidgoyal.net/kitty/actions/
- FAQ: https://sw.kovidgoyal.net/kitty/faq/
