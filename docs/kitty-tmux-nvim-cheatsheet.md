# Kitty + tmux + Neovim cheatsheet

The original live cheatsheet is retained here as the reference for the active terminal workflow.

## Entry point

Run `kitty-tmux` to open or reattach to the default `main` tmux session. Pass a name to use another session: `kitty-tmux work`.

## Layer responsibilities

- **kitty:** terminal UI, rendering, notifications, and forwarding ergonomic shortcuts to tmux.
- **tmux:** persistence, panes, windows, and process continuity.
- **Neovim:** editing, navigation, LSP, completion, Git integration, and Neo-tree.
- **Codex:** multiline input uses `Shift+Enter` or `Ctrl+J`; model mode cycling uses `Shift+Tab`.

## Kitty-forwarded tmux shortcuts

| Shortcut | Action |
| --- | --- |
| `Alt` + arrows | Focus tmux pane |
| `Ctrl+Alt+M` or `Ctrl+Shift+Z` | Zoom/restore current pane |
| `Ctrl+Shift+Enter` | Horizontal split |
| `Ctrl+Shift+O` | Vertical split |
| `Ctrl+Shift` + arrows | Resize pane |
| `Ctrl+Shift+T` | New tmux window |
| `Ctrl+Shift+PageUp/PageDown` | Previous/next tmux window |

## tmux prefix shortcuts

The prefix is `Ctrl+B`.

| Keys after prefix | Action |
| --- | --- |
| `d` | Detach from session |
| `|` / `-` | Split horizontally / vertically |
| `h j k l` | Move between panes |
| `H J K L` | Resize pane |
| `r` | Reload this repository's tmux configuration |

## Neovim essentials

| Shortcut | Action |
| --- | --- |
| `Space e` | Toggle Neo-tree |
| `Space o` | Focus Neo-tree |
| `Space w` | Save |
| `Space q` | Close current window |
| `Space do` | Open working-tree diff |
| `Space dc` | Close diff view |
| `Ctrl+Space` | Open completion |
| `Tab` / `Shift+Tab` | Navigate completion, or indent normally when it is closed |
| `Enter` | Confirm completion |

## Recovery

Detach with `Ctrl+B d`; later run `kitty-tmux` again. The tmux server holds the active session until it is stopped or the computer restarts.
