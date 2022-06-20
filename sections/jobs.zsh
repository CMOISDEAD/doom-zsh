#
# Background jobs
#

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------
source $HOME/.oh-my-zsh/custom/themes/doom/sections/helpers/exists.zsh

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_JOBS_SHOW="${SPACESHIP_JOBS_SHOW=true}"
SPACESHIP_JOBS_PREFIX="${SPACESHIP_JOBS_PREFIX=""}"
SPACESHIP_JOBS_SUFFIX="${SPACESHIP_JOBS_SUFFIX=""}"
SPACESHIP_JOBS_SYMBOL="${SPACESHIP_JOBS_SYMBOL="✦"}"
SPACESHIP_JOBS_COLOR="${SPACESHIP_JOBS_COLOR="123"}"
SPACESHIP_JOBS_AMOUNT_PREFIX="${SPACESHIP_JOBS_AMOUNT_PREFIX=""}"
SPACESHIP_JOBS_AMOUNT_SUFFIX="${SPACESHIP_JOBS_AMOUNT_SUFFIX=""}"
SPACESHIP_JOBS_AMOUNT_THRESHOLD="${SPACESHIP_JOBS_AMOUNT_THRESHOLD=1}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show icon if there's a working jobs in the background
doom_jobs() { # NOTE: Weird left space on symbol.
  [[ $SPACESHIP_JOBS_SHOW == false ]] && return

  local jobs_amount=$( jobs -d | awk '!/pwd/' | wc -l | tr -d " ")

  [[ $jobs_amount -gt 0 ]] || return

  if [[ $jobs_amount -le $SPACESHIP_JOBS_AMOUNT_THRESHOLD ]]; then
    jobs_amount=''
    SPACESHIP_JOBS_AMOUNT_PREFIX=''
    SPACESHIP_JOBS_AMOUNT_SUFFIX=''
  fi

  echo \
    "%F{$SPACESHIP_JOBS_COLOR}" \
    "$SPACESHIP_JOBS_PREFIX" \
    "${SPACESHIP_JOBS_SYMBOL}${SPACESHIP_JOBS_AMOUNT_PREFIX}${jobs_amount}${SPACESHIP_JOBS_AMOUNT_SUFFIX}" \
    "$SPACESHIP_JOBS_SUFFIX%f"
}
