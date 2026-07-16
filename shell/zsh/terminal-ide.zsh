# Alacritty sends Shift+Enter as CSI u so applications can distinguish it from
# Enter. In zsh, insert a literal newline into the current command line.
[[ -o interactive ]] || return 0

terminal-ide-insert-newline() {
  LBUFFER+=$'\n'
}

zle -N terminal-ide-insert-newline
bindkey -M emacs $'\e[13;2u' terminal-ide-insert-newline
bindkey -M viins $'\e[13;2u' terminal-ide-insert-newline
