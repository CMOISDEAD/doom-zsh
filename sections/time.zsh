#
# Time
#
# Current time

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

DOOM_TIME_SHOW="${DOOM_TIME_SHOW=true}"
DOOM_TIME_PREFIX="${DOOM_TIME_PREFIX="["}"
DOOM_TIME_SUFFIX="${DOOM_TIME_SUFFIX="]"}"
DOOM_TIME_FORMAT="${DOOM_TIME_FORMAT=false}"
DOOM_TIME_12HR="${DOOM_TIME_12HR=true}"
DOOM_TIME_COLOR="${DOOM_TIME_COLOR="yellow"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

doom_time() {
  [[ $DOOM_TIME_SHOW == false ]] && return

  local 'time_str'

  if [[ $DOOM_TIME_FORMAT != false ]]; then
    time_str="${DOOM_TIME_FORMAT}"
  elif [[ $DOOM_TIME_12HR == true ]]; then
    time_str="%D{%r}"
  else
    time_str="%D{%T}"
  fi

  echo "%F{$DOOM_TIME_COLOR}$DOOM_TIME_PREFIX" \
    "$time_str" \
    "$DOOM_TIME_SUFFIX%f"
}
