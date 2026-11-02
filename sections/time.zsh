DOOM_TIME_SHOW="${DOOM_TIME_SHOW=true}"
DOOM_TIME_PREFIX="${DOOM_TIME_PREFIX="["}"
DOOM_TIME_SUFFIX="${DOOM_TIME_SUFFIX="]"}"
DOOM_TIME_FORMAT="${DOOM_TIME_FORMAT=false}"
DOOM_TIME_12HR="${DOOM_TIME_12HR=true}"
DOOM_TIME_COLOR="${DOOM_TIME_COLOR="yellow"}"

doom_time() {
  [[ $DOOM_TIME_SHOW == false ]] && return

  local format=%D{%T}
  [[ $DOOM_TIME_12HR == true ]] && format=%D{%r}
  [[ $DOOM_TIME_FORMAT != false ]] && format=$DOOM_TIME_FORMAT

  doom_segment TIME "$format"
}
