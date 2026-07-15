# Alacritty + tmux + Neovim

## Responsibilities

- **Alacritty:** window, font, scrollback, and the official Aura theme.
- **tmux:** sessions, windows, panes, navigation, and resize.
- **Neovim:** editing, LSP, completion, Neo-tree, and Git tools.

Alacritty does not remap keys. The direct shortcuts below are handled by tmux itself.

## Start and recover

```bash
alacritty-tmux          # default session: main
alacritty-tmux work     # named session
```

Detach with `Ctrl+B d`; run the same command later to reconnect while the tmux server is alive.

## tmux

### Direct shortcuts

| Shortcut | Action |
| --- | --- |
| `Alt` + arrow | Focus the pane in that direction |
| `Alt+Shift` + arrow | Create a pane in that direction |
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
| `Space w` | Save |
| `Space q` | Close current window |
| `Space do` | Open working-tree diff |
| `Space dc` | Close diff view |
| `Ctrl+Space` | Open completion |
