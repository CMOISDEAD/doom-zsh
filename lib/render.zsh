doom_segment() {
  local name=$1 content=$2
  local prefix=DOOM_${name}_PREFIX suffix=DOOM_${name}_SUFFIX
  local symbol=DOOM_${name}_SYMBOL color=DOOM_${name}_COLOR

  REPLY="${(P)prefix}${(P)symbol}${content}${(P)suffix}"
  [[ -n ${(P)color} ]] && REPLY="%F{${(P)color}}$REPLY%f"
}

doom_render() {
  local section output

  for section in "$@"; do
    (( $+functions[doom_$section] )) || continue
    REPLY=
    doom_$section
    [[ -n $REPLY ]] || continue
    [[ -n $output && $output[-1] != $'\n' && $REPLY != $'\n' ]] && output+=$DOOM_SEPARATOR
    output+=$REPLY
  done

  REPLY=$output
}

doom_render_prompts() {
  doom_render $DOOM_SECTIONS_LEFT
  typeset -g DOOM_PROMPT=$REPLY
  doom_render $DOOM_SECTIONS_RIGHT
  typeset -g DOOM_RPROMPT=$REPLY
}
