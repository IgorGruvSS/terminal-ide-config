# Terminal IDE config

Portable, single-directory configuration for a terminal workflow based on **Alacritty**, **tmux**, and **Neovim**.

All configuration, launchers, documentation, and local runtime state live in this repository. It intentionally does not use symbolic links.

## What each layer does

```text
Alacritty → terminal window, rendering, and theme
tmux      → persistent sessions, windows, and panes
nvim      → editing, LSP, completion, file tree, and Git tools
```

`alacritty-tmux` is the usual entry point. It opens Alacritty with this repository's configuration and attaches to a persistent tmux session.

## Layout

```text
alacritty/ Alacritty configuration and the official Aura theme
bin/       portable launchers for Alacritty, tmux, and Neovim
nvim/      Neovim configuration and plugin lockfile
tmux.conf  tmux configuration
docs/      workflow guides and the complete keymap cheatsheet
```

Runtime state and downloaded Neovim plugins are created under `.local/`, `.cache/`, and `.state/`; they stay inside the repository directory but are deliberately not versioned.

## Fedora installation

```bash
sudo dnf install alacritty tmux neovim git
git clone https://github.com/IgorGruvSS/terminal-ide-config.git ~/terminal-ide-config
cd ~/terminal-ide-config
./install.sh
exec zsh
alacritty-tmux
```

The installer only prepends this repository's `bin/` directory to `PATH`. It does not create symlinks or copy configuration into `~/.config`.
It also installs a user-level KDE desktop entry that starts Alacritty through
the repository launcher, ensuring the same configuration is used from both the
application menu and the shell.

On first Neovim launch, install the locked plugins:

```bash
nvim '+Lazy sync'
```

## Commands

| Command | Purpose |
| --- | --- |
| `alacritty-tmux [session]` | Open Alacritty and attach/create a tmux session (default: `main`) |
| `alacritty` | Run Alacritty with this repository's configuration |
| `tmux` | Run tmux with this repository's configuration |
| `nvim` | Run Neovim with configuration, plugins, cache, and state contained here |

## Updating and troubleshooting

Edit files in this repository, then commit the change. Press `Ctrl+B`, then `r` inside tmux to reload its configuration.

For the active workflow and keymap, read [the cheatsheet](docs/alacritty-tmux-nvim-cheatsheet.md).
