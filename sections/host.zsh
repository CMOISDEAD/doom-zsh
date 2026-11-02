DOOM_HOST_SHOW="${DOOM_HOST_SHOW=true}"
DOOM_HOST_SHOW_FULL="${DOOM_HOST_SHOW_FULL=false}"
DOOM_HOST_PREFIX="${DOOM_HOST_PREFIX="@"}"
DOOM_HOST_SUFFIX="${DOOM_HOST_SUFFIX=""}"
DOOM_HOST_COLOR="${DOOM_HOST_COLOR="yellow"}"
DOOM_HOST_COLOR_SSH="${DOOM_HOST_COLOR_SSH="green"}"

doom_host() {
  [[ $DOOM_HOST_SHOW == false ]] && return
  [[ $DOOM_HOST_SHOW == always || -n $SSH_CONNECTION ]] || return

  local host=%m
  [[ $DOOM_HOST_SHOW_FULL == true ]] && host=%M

  local DOOM_HOST_COLOR=$DOOM_HOST_COLOR
  [[ -n $SSH_CONNECTION ]] && DOOM_HOST_COLOR=$DOOM_HOST_COLOR_SSH

  doom_segment HOST "$host"
}
