DOOM_EXEC_TIME_SHOW="${DOOM_EXEC_TIME_SHOW=true}"
DOOM_EXEC_TIME_PREFIX="${DOOM_EXEC_TIME_PREFIX="took "}"
DOOM_EXEC_TIME_SUFFIX="${DOOM_EXEC_TIME_SUFFIX=""}"
DOOM_EXEC_TIME_COLOR="${DOOM_EXEC_TIME_COLOR="yellow"}"
DOOM_EXEC_TIME_ELAPSED="${DOOM_EXEC_TIME_ELAPSED=2}"

doom_exec_time_start() {
  typeset -g DOOM_EXEC_TIME_start=$EPOCHREALTIME
}

doom_exec_time_stop() {
  typeset -gi DOOM_EXEC_TIME_duration=0
  [[ -n $DOOM_EXEC_TIME_start ]] || return

  (( DOOM_EXEC_TIME_duration = EPOCHREALTIME - DOOM_EXEC_TIME_start ))
  unset DOOM_EXEC_TIME_start
}

doom_exec_time() {
  [[ $DOOM_EXEC_TIME_SHOW == false ]] && return
  (( DOOM_EXEC_TIME_duration >= DOOM_EXEC_TIME_ELAPSED )) || return

  local -i total=$DOOM_EXEC_TIME_duration
  local elapsed="$(( total % 60 ))s"

  (( total >= 60 )) && elapsed="$(( total / 60 % 60 ))m $elapsed"
  (( total >= 3600 )) && elapsed="$(( total / 3600 % 24 ))h $elapsed"
  (( total >= 86400 )) && elapsed="$(( total / 86400 ))d $elapsed"

  doom_segment EXEC_TIME "$elapsed"
}
