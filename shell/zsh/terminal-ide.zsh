# Alacritty sends Shift+Enter as CSI u so applications can distinguish it from
# Enter. In zsh, insert a literal newline into the current command line.
[[ -o interactive ]] || return 0

terminal-ide-insert-newline() {
  LBUFFER+=$'\n'
}

zle -N terminal-ide-insert-newline
bindkey -M emacs $'\e[13;2u' terminal-ide-insert-newline
bindkey -M viins $'\e[13;2u' terminal-ide-insert-newline

_terminal_ide_font() {
  local -a actions families

  actions=(
    'current:mostrar a fonte da janela atual'
    'list:listar as fontes monoespaçadas disponíveis'
    'reset:restaurar a fonte configurada no repositório'
  )
  families=("${(@f)$(font list 2>/dev/null)}")

  _describe 'ação' actions
  _describe 'fonte monoespaçada' families
}

if (( $+functions[compdef] )); then
  compdef _terminal_ide_font font
fi
