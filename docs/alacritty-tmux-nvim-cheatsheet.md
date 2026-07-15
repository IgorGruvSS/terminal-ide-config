# Alacritty + tmux + Neovim

## Responsibilities

- **Alacritty:** window, font, scrollback, and the official Aura theme.
- **tmux:** sessions, windows, panes, navigation, and resize.
- **Neovim:** editing, LSP, completion, Neo-tree, and Git tools.

No terminal key is remapped to tmux. Use the tmux prefix `Ctrl+B` for its operations.

## Start and recover

```bash
alacritty-tmux          # default session: main
alacritty-tmux work     # named session
```

Detach with `Ctrl+B d`; run the same command later to reconnect while the tmux server is alive.

## tmux

| Keys after `Ctrl+B` | Action |
| --- | --- |
| `|` / `-` | Horizontal / vertical split |
| `h j k l` | Focus pane |
| `H J K L` | Resize pane |
| `z` | Zoom/restore pane |
| `c` | New window |
| `n` / `p` | Next / previous window |
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
