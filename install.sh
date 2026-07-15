#!/usr/bin/env bash
set -euo pipefail

root_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
zshrc="$HOME/.zshrc"
marker='# terminal-ide-config PATH'
path_line="export PATH=\"$root_dir/bin:\$PATH\""
desktop_dir="$HOME/.local/share/applications"
desktop_file="$desktop_dir/Alacritty.desktop"

if ! command -v alacritty >/dev/null || ! command -v tmux >/dev/null || ! command -v nvim >/dev/null; then
  printf 'Install the prerequisites first: sudo dnf install alacritty tmux neovim git\n' >&2
  exit 1
fi

if ! grep -Fqx "$path_line" "$zshrc" 2>/dev/null; then
  {
    printf '\n%s\n' "$marker"
    printf '%s\n' "$path_line"
  } >> "$zshrc"
fi

mkdir -p "$desktop_dir"
sed "s|@TERMINAL_IDE_CONFIG_DIR@|$root_dir|g" \
  "$root_dir/desktop/Alacritty.desktop.in" > "$desktop_file"

if command -v update-desktop-database >/dev/null; then
  update-desktop-database "$desktop_dir"
fi

printf 'Open a new zsh session, then run: alacritty-tmux\n'
printf 'The KDE application entry now uses this repository configuration.\n'
printf 'For Neovim plugins, run: nvim "+Lazy sync"\n'
