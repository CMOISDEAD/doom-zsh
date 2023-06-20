#
# Background jobs
#

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------
source $DOOM_ROOT/sections/helpers/exists.zsh

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

DOOM_JOBS_SHOW="${DOOM_JOBS_SHOW=true}"
DOOM_JOBS_PREFIX="${DOOM_JOBS_PREFIX=""}"
DOOM_JOBS_SUFFIX="${DOOM_JOBS_SUFFIX=""}"
DOOM_JOBS_SYMBOL="${DOOM_JOBS_SYMBOL="✦"}"
DOOM_JOBS_COLOR="${DOOM_JOBS_COLOR="123"}"
DOOM_JOBS_AMOUNT_PREFIX="${DOOM_JOBS_AMOUNT_PREFIX=""}"
DOOM_JOBS_AMOUNT_SUFFIX="${DOOM_JOBS_AMOUNT_SUFFIX=""}"
DOOM_JOBS_AMOUNT_THRESHOLD="${DOOM_JOBS_AMOUNT_THRESHOLD=1}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show icon if there's a working jobs in the background
doom_jobs() { # NOTE: Weird left space on symbol.
  [[ $DOOM_JOBS_SHOW == false ]] && return

  local jobs_amount=$( jobs -d | awk '!/pwd/' | wc -l | tr -d " ")

  [[ $jobs_amount -gt 0 ]] || return

  if [[ $jobs_amount -le $DOOM_JOBS_AMOUNT_THRESHOLD ]]; then
    jobs_amount=''
    DOOM_JOBS_AMOUNT_PREFIX=''
    DOOM_JOBS_AMOUNT_SUFFIX=''
  fi

  echo \
    "%F{$DOOM_JOBS_COLOR}" \
    "$DOOM_JOBS_PREFIX" \
    "${DOOM_JOBS_SYMBOL}${DOOM_JOBS_AMOUNT_PREFIX}${jobs_amount}${DOOM_JOBS_AMOUNT_SUFFIX}" \
    "$DOOM_JOBS_SUFFIX%f"
}
