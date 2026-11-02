DOOM_VI_MODE_SHOW="${DOOM_VI_MODE_SHOW=true}"
DOOM_VI_MODE_PREFIX="${DOOM_VI_MODE_PREFIX="--"}"
DOOM_VI_MODE_SUFFIX="${DOOM_VI_MODE_SUFFIX="--"}"
DOOM_VI_MODE_COLOR="${DOOM_VI_MODE_COLOR="76"}"
DOOM_VI_MODE_INSERT="${DOOM_VI_MODE_INSERT="INSERT"}"
DOOM_VI_MODE_NORMAL="${DOOM_VI_MODE_NORMAL="NORMAL"}"
DOOM_VI_MODE_VISUAL="${DOOM_VI_MODE_VISUAL="VISUAL"}"
DOOM_VI_MODE_VISUAL_LINE="${DOOM_VI_MODE_VISUAL_LINE="VISUAL-L"}"
DOOM_VI_MODE_REPLACE="${DOOM_VI_MODE_REPLACE="REPLACE"}"

doom_vi_mode() {
  [[ $DOOM_VI_MODE_SHOW == false ]] && return
  [[ $(bindkey -lL main) == *viins* ]] || return

  local mode=$DOOM_VI_MODE_INSERT

  if [[ -n $ZVM_MODE ]]; then
    case $ZVM_MODE in
      $ZVM_MODE_NORMAL) mode=$DOOM_VI_MODE_NORMAL ;;
      $ZVM_MODE_VISUAL) mode=$DOOM_VI_MODE_VISUAL ;;
      $ZVM_MODE_VISUAL_LINE) mode=$DOOM_VI_MODE_VISUAL_LINE ;;
      $ZVM_MODE_REPLACE) mode=$DOOM_VI_MODE_REPLACE ;;
    esac
  elif [[ $KEYMAP == vicmd ]]; then
    mode=$DOOM_VI_MODE_NORMAL
  fi

  doom_segment VI_MODE "$mode"
}

doom_vi_mode_refresh() {
  (( $DOOM_SECTIONS_LEFT[(I)vi_mode] || $DOOM_SECTIONS_RIGHT[(I)vi_mode] )) || return
  doom_render_prompts
  zle reset-prompt
}

if [[ -o interactive ]]; then
  autoload -Uz add-zle-hook-widget
  zle -N doom_vi_mode_refresh
  add-zle-hook-widget keymap-select doom_vi_mode_refresh
fi
