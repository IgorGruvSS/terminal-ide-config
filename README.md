# Terminal IDE config

Portable, single-directory configuration for a terminal workflow based on **kitty**, **tmux**, and **Neovim**.

All configuration, launchers, documentation, and local runtime state live in this repository. It intentionally does not use symbolic links.

## What each layer does

```text
kitty → terminal window and key forwarding
tmux  → persistent sessions, windows, and panes
nvim  → editing, LSP, completion, file tree, and Git tools
```

`kitty-tmux` is the usual entry point. It opens kitty with this repository's configuration and attaches to a persistent tmux session.

## Layout

```text
bin/       portable launchers for kitty, tmux, nvim, and session helpers
kitty/     kitty configuration, theme, and static session layout
nvim/      Neovim configuration and plugin lockfile
tmux.conf  tmux configuration
docs/      workflow guides and the complete keymap cheatsheet
```

Runtime state and downloaded Neovim plugins are created under `.local/`, `.cache/`, and `.state/`; they stay inside the repository directory but are deliberately not versioned.

## Fedora installation

```bash
sudo dnf install kitty tmux neovim git
git clone https://github.com/IgorGruvSS/terminal-ide-config.git ~/terminal-ide-config
cd ~/terminal-ide-config
./install.sh
exec zsh
kitty-tmux
```

The installer only prepends this repository's `bin/` directory to `PATH`. It does not create symlinks or copy configuration into `~/.config`.

On first Neovim launch, install the locked plugins:

```bash
nvim '+Lazy sync'
```

## Commands

| Command | Purpose |
| --- | --- |
| `kitty-tmux [session]` | Open kitty and attach/create a tmux session (default: `main`) |
| `kitty-save-session [file]` | Save the current kitty layout to ignored runtime state |
| `kitty` | Run kitty with this repository's configuration |
| `tmux` | Run tmux with this repository's configuration |
| `nvim` | Run Neovim with configuration, plugins, cache, and state contained here |

## Updating and troubleshooting

Edit files in this repository, then commit the change. Press `Ctrl+B`, then `r` inside tmux to reload its configuration.

For a complete working keymap and recovery guide, read [the cheatsheet](docs/kitty-tmux-nvim-cheatsheet.md).
