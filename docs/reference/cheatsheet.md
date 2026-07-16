# Alacritty + tmux + Neovim

## Índice

- [Responsabilidades](#responsibilities)
- [Iniciar e recuperar](#start-and-recover)
- [Atalhos do terminal](#terminal)
- [tmux](#tmux)
- [Neovim](#neovim)
- [LazyGit](#lazygit)

## Responsibilities

- **Alacritty:** window, font, scrollback, and the official Aura theme.
- **tmux:** sessions, windows, panes, navigation, and resize.
- **Neovim:** editing, LSP, completion, Neo-tree, and Git tools.

Alacritty owns the `Shift+Enter` translation. The pane and window shortcuts are
handled by tmux itself.

## Start and recover

```bash
alacritty-tmux          # default session: main
alacritty-tmux work     # named session
```

Detach with `Ctrl+B d`; run the same command later to reconnect while the tmux server is alive.

## Terminal

| Shortcut | Action |
| --- | --- |
| `Shift+Enter` | Insert a newline without submitting in supported TUIs and zsh |
| `Enter` | Submit the message or execute the command |

See the [keyboard guide](keyboard.md) for the complete routing and diagnosis.

## tmux

### Direct shortcuts

| Shortcut | Action |
| --- | --- |
| `Alt` + arrow | Focus the pane in that direction |
| `Alt+Shift` + arrow | Create a pane in that direction |
| `Ctrl+Alt` + arrow | Resize the pane in that direction |
| `Ctrl+Shift+Left` | Previous tmux window |
| `Ctrl+Shift+Right` | Next tmux window |
| `Alt+Z` | Zoom/restore the current pane |

### Prefix fallback

| Keys after `Ctrl+B` | Action |
| --- | --- |
| `|` / `-` | Horizontal / vertical split |
| `h j k l` | Focus pane |
| `H J K L` | Resize pane |
| `z` | Zoom/restore pane |
| `x` | Close the current pane (asks for confirmation) |
| `c` | New window |
| `n` / `p` | Next / previous window |
| `,` | Rename the current window |
| `&` | Close the current window (asks for confirmation) |
| `$` | Rename the current session |
| `r` | Reload tmux configuration |

## Neovim

| Shortcut | Action |
| --- | --- |
| `Space e` | Toggle Neo-tree |
| `Space o` | Focus Neo-tree |
| `Space ff` | Find files |
| `Space fg` | Find text in the project |
| `Space fb` | Find open buffers |
| `Space fk` | Search registered keymaps |
| `Space w` | Save |
| `Space q` | Close current window |
| `Space gg` | Open LazyGit at the current file's Git root |
| `Space do` | Open working-tree diff |
| `Space df` | Open branch diff against `origin/develop` |
| `Space dh` | Open current file history |
| `Space dc` | Close diff view |
| `Space as` | Toggle auto-save (disabled at startup) |
| `Ctrl+Space` | Open completion |

Files changed by external editors or agents are checked automatically. Clean
buffers reload with a notification; buffers with local changes show a conflict
warning instead of being overwritten.

For the plugin inventory, workflows, theme variants, and contextual controls,
read the [Neovim documentation index](../neovim/README.md).

## LazyGit

Open it with `Space gg` inside Neovim or run `lazygit` inside a repository.

| Shortcut | Action |
| --- | --- |
| `h j k l` / arrows | Navigate panels and items |
| `1` / `2` / `3` / `4` / `5` | Status / files / branches / commits / stash |
| `Space` | Stage/unstage or select the contextual item |
| `Enter` | Open the selected item or diff |
| `c` in files | Commit staged changes |
| `p` / `P` | Pull / push |
| `f` in remotes | Fetch |
| `?` | Show contextual shortcuts |
| `q` | Close LazyGit |

Read the [LazyGit guide](../git/lazygit.md) for stage by hunk, log, branches,
rebase and safety notes.
