#!/usr/bin/env bash
set -euo pipefail

root_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
os_release="/etc/os-release"
zshrc="$HOME/.zshrc"
marker='# terminal-ide-config PATH'
path_line="export PATH=\"$root_dir/bin:\$PATH\""
shell_marker='# terminal-ide-config shell integration'
shell_line="source \"$root_dir/shell/zsh/terminal-ide.zsh\""
desktop_dir="$HOME/.local/share/applications"
desktop_file="$desktop_dir/Alacritty.desktop"
systemd_user_dir="$HOME/.config/systemd/user"
theme_sync_service="$systemd_user_dir/alacritty-theme-sync.service"
lazygit_version="0.62.0"
lazygit_dir="$root_dir/.local/bin"
lazygit_bin="$lazygit_dir/lazygit"
nvim_version="0.12.4"
nvim_min_version="0.12.0"
nvim_dir="$root_dir/.local/opt/nvim-$nvim_version"
nvim_bin="$root_dir/.local/bin/nvim"
tree_sitter_version="0.26.11"
tree_sitter_dir="$root_dir/.local/opt/tree-sitter-$tree_sitter_version"
tree_sitter_bin="$root_dir/.local/bin/tree-sitter"
nerd_font_version="3.4.0"
font_checksum="76f05ff3ace48a464a6ca57977998784ff7bdbb65a6d915d7e401cd3927c493c"
font_family="JetBrainsMono Nerd Font"
font_dir="$HOME/.local/share/fonts/terminal-ide-config"
skip_system_packages=false

# Make repository-managed tools available to the plugin bootstrap that runs
# later in this script.
export PATH="$root_dir/.local/bin:$PATH"

usage() {
  cat <<'EOF'
Usage: ./install.sh [--skip-system-packages]

Installs the missing Ubuntu/Fedora packages, a compatible Neovim, the
JetBrainsMono Nerd Font and the repository-managed LazyGit. Use
--skip-system-packages only when the required system packages are already
available or when package installation is managed elsewhere.
EOF
}

case "${1-}" in
  "") ;;
  --skip-system-packages) skip_system_packages=true ;;
  -h | --help) usage; exit 0 ;;
  *) usage >&2; exit 2 ;;
esac

if [ ! -r "$os_release" ]; then
  printf 'Unsupported Linux distribution: %s is unavailable.\n' "$os_release" >&2
  exit 1
fi

# shellcheck disable=SC1090
. "$os_release"

has_usable_alacritty() {
  local candidate launcher_path candidate_path path_candidate

  launcher_path="$(readlink -f "$root_dir/bin/alacritty")"
  for path_candidate in \
    "${ALACRITTY_BIN:-}" \
    "$(command -v alacritty 2>/dev/null || true)" \
    /usr/local/bin/alacritty \
    /usr/bin/alacritty; do
    candidate="$path_candidate"
    [ -n "$candidate" ] && [ -x "$candidate" ] || continue
    candidate_path="$(readlink -f "$candidate" 2>/dev/null || printf '%s' "$candidate")"
    if [ "$candidate_path" != "$launcher_path" ]; then
      return 0
    fi
  done

  command -v flatpak >/dev/null 2>&1 && flatpak info org.alacritty.Alacritty >/dev/null 2>&1
}

install_system_packages() {
  local -a packages=("$@")

  case "$ID" in
    ubuntu | debian)
      printf 'Installing missing prerequisites with apt...\n'
      sudo apt-get update
      sudo apt-get install -y "${packages[@]}"
      ;;
    fedora)
      printf 'Installing missing prerequisites with dnf...\n'
      sudo dnf install -y "${packages[@]}"
      ;;
    *)
      printf 'Unsupported distribution: %s. Supported distributions: Ubuntu and Fedora.\n' "$ID" >&2
      exit 1
      ;;
  esac
}

missing_packages=()
if ! has_usable_alacritty; then
  missing_packages+=(alacritty)
fi

for requirement in \
  'tmux:tmux' \
  'git:git' \
  'curl:curl' \
  'fc-list:fontconfig' \
  'sha256sum:coreutils' \
  'tar:tar' \
  'unzip:unzip' \
  'zsh:zsh' \
  'make:make' \
  'cc:gcc'; do
  command="${requirement%%:*}"
  package="${requirement#*:}"
  if ! command -v "$command" >/dev/null 2>&1; then
    missing_packages+=("$package")
  fi
done

if ((${#missing_packages[@]})); then
  if "$skip_system_packages"; then
    printf 'System prerequisites are missing. Re-run without --skip-system-packages.\n' >&2
    exit 1
  fi
  install_system_packages "${missing_packages[@]}"
fi

version_at_least() {
  [ "$(printf '%s\n%s\n' "$2" "$1" | sort -V | head -n 1)" = "$2" ]
}

system_nvim_bin() {
  local candidate version

  for candidate in /usr/local/bin/nvim /usr/bin/nvim; do
    if [ -x "$candidate" ]; then
      version="$($candidate --version | sed -n '1s/^NVIM v//p')"
      if [ -n "$version" ] && version_at_least "$version" "$nvim_min_version"; then
        printf '%s\n' "$candidate"
        return 0
      fi
    fi
  done

  return 1
}

install_neovim() {
  local architecture archive_name checksum download_url temp_dir archive extracted_dir

  if [ -x "$nvim_bin" ] && version_at_least "$("$nvim_bin" --version | sed -n '1s/^NVIM v//p')" "$nvim_min_version"; then
    printf 'Neovim %s is already installed in the repository runtime.\n' "$nvim_version"
    return
  fi

  if system_nvim_bin >/dev/null; then
    printf 'A compatible system Neovim is already available.\n'
    return
  fi

  case "$(uname -m)" in
    x86_64)
      architecture="x86_64"
      checksum="012bf3fcac5ade43914df3f174668bf64d05e049a4f032a388c027b1ebd78628"
      ;;
    aarch64 | arm64)
      architecture="arm64"
      checksum="ceb7e88c6b681f0515d135dcdfad54f5eb4373b25ce6172197cd9a69c758063f"
      ;;
    *)
      printf 'Unsupported architecture for the bundled Neovim installer: %s\n' "$(uname -m)" >&2
      exit 1
      ;;
  esac

  archive_name="nvim-linux-${architecture}.tar.gz"
  download_url="https://github.com/neovim/neovim/releases/download/v${nvim_version}/${archive_name}"
  temp_dir="$(mktemp -d)"
  archive="$temp_dir/$archive_name"
  trap 'rm -rf "$temp_dir"' RETURN

  printf 'Downloading Neovim %s...\n' "$nvim_version"
  curl -fL "$download_url" -o "$archive"
  printf '%s  %s\n' "$checksum" "$archive" | sha256sum -c -

  tar -xzf "$archive" -C "$temp_dir"
  extracted_dir="$temp_dir/nvim-linux-${architecture}"
  if [ ! -x "$extracted_dir/bin/nvim" ]; then
    printf 'The Neovim archive did not contain the expected executable.\n' >&2
    exit 1
  fi

  mkdir -p "$(dirname "$nvim_dir")" "$(dirname "$nvim_bin")"
  rm -rf "$nvim_dir"
  mv "$extracted_dir" "$nvim_dir"
  ln -sfn "$nvim_dir/bin/nvim" "$nvim_bin"
}

install_tree_sitter() {
  local architecture archive_name checksum download_url temp_dir archive

  if [ -x "$tree_sitter_bin" ] && "$tree_sitter_bin" --version 2>/dev/null | grep -Fq "$tree_sitter_version"; then
    printf 'tree-sitter %s is already installed in the repository runtime.\n' "$tree_sitter_version"
    return
  fi

  case "$(uname -m)" in
    x86_64)
      architecture="x64"
      checksum="ff1b7f9863f2faafd78dc0e66d902ee85b37f709b314b22c009f51caf233eebd"
      ;;
    aarch64 | arm64)
      architecture="arm64"
      checksum="db28509fe6db8902f9d14c43c486858c7486b42c3a96b30e811e73f105762336"
      ;;
    *)
      printf 'Unsupported architecture for the bundled tree-sitter installer: %s\n' "$(uname -m)" >&2
      exit 1
      ;;
  esac

  archive_name="tree-sitter-cli-linux-$architecture.zip"
  download_url="https://github.com/tree-sitter/tree-sitter/releases/download/v${tree_sitter_version}/$archive_name"
  temp_dir="$(mktemp -d)"
  archive="$temp_dir/$archive_name"
  trap 'rm -rf "$temp_dir"' RETURN

  printf 'Downloading tree-sitter %s...\n' "$tree_sitter_version"
  curl -fL "$download_url" -o "$archive"
  printf '%s  %s\n' "$checksum" "$archive" | sha256sum -c -

  unzip -jo "$archive" -d "$temp_dir" >/dev/null
  if [ ! -x "$temp_dir/tree-sitter" ]; then
    printf 'The tree-sitter archive did not contain the expected executable.\n' >&2
    exit 1
  fi

  mkdir -p "$(dirname "$tree_sitter_dir")" "$(dirname "$tree_sitter_bin")"
  rm -rf "$tree_sitter_dir"
  mkdir -p "$tree_sitter_dir"
  install -m 0755 "$temp_dir/tree-sitter" "$tree_sitter_dir/tree-sitter"
  ln -sfn "$tree_sitter_dir/tree-sitter" "$tree_sitter_bin"
}

install_nerd_font() {
  local archive_name download_url temp_dir archive

  if fc-list --format '%{family}\n' | grep -Fxq "$font_family"; then
    printf '%s is already installed.\n' "$font_family"
    return
  fi

  archive_name="JetBrainsMono.zip"
  download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${nerd_font_version}/${archive_name}"
  temp_dir="$(mktemp -d)"
  archive="$temp_dir/$archive_name"
  trap 'rm -rf "$temp_dir"' RETURN

  printf 'Downloading JetBrainsMono Nerd Font %s...\n' "$nerd_font_version"
  curl -fL "$download_url" -o "$archive"
  printf '%s  %s\n' "$font_checksum" "$archive" | sha256sum -c -

  mkdir -p "$font_dir"
  unzip -jo "$archive" '*.ttf' -d "$font_dir" >/dev/null
  fc-cache -f "$font_dir"
}

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

install_neovim
install_tree_sitter
install_nerd_font
install_lazygit

printf 'Synchronizing Neovim plugins...\n'
"$root_dir/bin/nvim" --headless "+Lazy! sync" +qa

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

if command -v gdbus >/dev/null && command -v systemctl >/dev/null; then
  mkdir -p "$systemd_user_dir"
  sed "s|@TERMINAL_IDE_CONFIG_DIR@|$root_dir|g" \
    "$root_dir/systemd/alacritty-theme-sync.service.in" > "$theme_sync_service"
  if systemctl --user daemon-reload && \
    systemctl --user enable --now alacritty-theme-sync.service; then
    :
  else
    printf 'Could not enable the Alacritty theme sync user service in this session.\n' >&2
  fi
else
  printf 'Alacritty theme sync was not enabled: gdbus and systemctl are required.\n' >&2
fi

printf 'Open a new zsh session, then run: alacritty-tmux\n'
printf 'Shift+Enter inserts a newline in supported TUIs and interactive zsh.\n'
printf 'The KDE application entry now uses this repository configuration.\n'
printf 'Alacritty now follows KDE’s light/dark preference.\n'
printf 'Neovim %s is available through: nvim\n' "$nvim_version"
printf 'tree-sitter %s is available through: tree-sitter\n' "$tree_sitter_version"
printf 'LazyGit %s is available through: lazygit\n' "$lazygit_version"
printf 'For Neovim plugins, run: nvim "+Lazy sync"\n'
