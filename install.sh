#!/usr/bin/env bash
set -euo pipefail

root_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
zshrc="$HOME/.zshrc"
marker='# terminal-ide-config PATH'
path_line="export PATH=\"$root_dir/bin:\$PATH\""
shell_marker='# terminal-ide-config shell integration'
shell_line="source \"$root_dir/shell/zsh/terminal-ide.zsh\""
desktop_dir="$HOME/.local/share/applications"
desktop_file="$desktop_dir/Alacritty.desktop"
lazygit_version="0.62.0"
lazygit_dir="$root_dir/.local/bin"
lazygit_bin="$lazygit_dir/lazygit"

if ! command -v alacritty >/dev/null || ! command -v tmux >/dev/null || ! command -v nvim >/dev/null \
  || ! command -v curl >/dev/null || ! command -v fc-list >/dev/null \
  || ! command -v sha256sum >/dev/null || ! command -v tar >/dev/null; then
  printf 'Install the prerequisites first: sudo dnf install alacritty tmux neovim git curl coreutils fontconfig\n' >&2
  exit 1
fi

install_lazygit() {
  local architecture archive_name checksum download_url temp_dir archive

  if [ -x "$lazygit_bin" ] && "$lazygit_bin" --version 2>/dev/null | grep -Fq "version=$lazygit_version"; then
    printf 'LazyGit %s is already installed in the repository runtime.\n' "$lazygit_version"
    return
  fi

  case "$(uname -m)" in
    x86_64)
      architecture="x86_64"
      checksum="c57dd766436a42c2da52c3138034f55ca6d8bb935983ee8ae272f0d0386aca6a"
      ;;
    aarch64 | arm64)
      architecture="arm64"
      checksum="5f97dd0201194ee17a8b5a9655bf6c6d3f596af4399674746bc77056544fed70"
      ;;
    *)
      printf 'Unsupported architecture for the bundled LazyGit installer: %s\n' "$(uname -m)" >&2
      exit 1
      ;;
  esac

  archive_name="lazygit_${lazygit_version}_linux_${architecture}.tar.gz"
  download_url="https://github.com/jesseduffield/lazygit/releases/download/v${lazygit_version}/${archive_name}"
  temp_dir="$(mktemp -d)"
  archive="$temp_dir/$archive_name"
  trap 'rm -rf "$temp_dir"' RETURN

  printf 'Downloading LazyGit %s...\n' "$lazygit_version"
  curl -fL "$download_url" -o "$archive"
  printf '%s  %s\n' "$checksum" "$archive" | sha256sum -c -

  mkdir -p "$lazygit_dir"
  tar -xzf "$archive" -C "$temp_dir" lazygit
  install -m 0755 "$temp_dir/lazygit" "$lazygit_bin"
}

install_lazygit

if ! grep -Fqx "$path_line" "$zshrc" 2>/dev/null; then
  {
    printf '\n%s\n' "$marker"
    printf '%s\n' "$path_line"
  } >> "$zshrc"
fi

if ! grep -Fqx "$shell_line" "$zshrc" 2>/dev/null; then
  {
    printf '\n%s\n' "$shell_marker"
    printf '%s\n' "$shell_line"
  } >> "$zshrc"
fi

mkdir -p "$desktop_dir"
sed "s|@TERMINAL_IDE_CONFIG_DIR@|$root_dir|g" \
  "$root_dir/desktop/Alacritty.desktop.in" > "$desktop_file"

if command -v update-desktop-database >/dev/null; then
  update-desktop-database "$desktop_dir"
fi

printf 'Open a new zsh session, then run: alacritty-tmux\n'
printf 'Shift+Enter inserts a newline in supported TUIs and interactive zsh.\n'
printf 'The KDE application entry now uses this repository configuration.\n'
printf 'LazyGit %s is available through: lazygit\n' "$lazygit_version"
printf 'For Neovim plugins, run: nvim "+Lazy sync"\n'
