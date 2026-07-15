#!/usr/bin/env bash
set -euo pipefail

root_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
zshrc="$HOME/.zshrc"
marker='# terminal-ide-config PATH'
path_line="export PATH=\"$root_dir/bin:\$PATH\""

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

printf 'Open a new zsh session, then run: alacritty-tmux\n'
printf 'For Neovim plugins, run: nvim "+Lazy sync"\n'
