zmodload zsh/parameter

DOOM_JOBS_SHOW="${DOOM_JOBS_SHOW=true}"
DOOM_JOBS_PREFIX="${DOOM_JOBS_PREFIX=""}"
DOOM_JOBS_SUFFIX="${DOOM_JOBS_SUFFIX=""}"
DOOM_JOBS_SYMBOL="${DOOM_JOBS_SYMBOL="✦"}"
DOOM_JOBS_COLOR="${DOOM_JOBS_COLOR="123"}"
DOOM_JOBS_AMOUNT_THRESHOLD="${DOOM_JOBS_AMOUNT_THRESHOLD=1}"

doom_jobs() {
  [[ $DOOM_JOBS_SHOW == false ]] && return

  local -i amount=$#jobstates
  (( amount )) || return

  if (( amount > DOOM_JOBS_AMOUNT_THRESHOLD )); then
    doom_segment JOBS " $amount"
  else
    doom_segment JOBS ""
  fi
}
