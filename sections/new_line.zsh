DOOM_NEW_LINE_SHOW="${DOOM_NEW_LINE_SHOW=true}"

doom_new_line() {
  [[ $DOOM_NEW_LINE_SHOW == false ]] && return

  REPLY=$'\n'
}
