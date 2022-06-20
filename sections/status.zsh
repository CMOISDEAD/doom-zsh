#
# Exit code
#
# Show exit code of last executed command

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_EXIT_CODE_SHOW="${SPACESHIP_EXIT_CODE_SHOW=true}"
SPACESHIP_EXIT_CODE_PREFIX="${SPACESHIP_EXIT_CODE_PREFIX=""}"
SPACESHIP_EXIT_CODE_SUFFIX="${SPACESHIP_EXIT_CODE_SUFFIX=""}"
SPACESHIP_EXIT_CODE_SYMBOL="${SPACESHIP_EXIT_CODE_SYMBOL="✘"}"
SPACESHIP_EXIT_CODE_COLOR="${SPACESHIP_EXIT_CODE_COLOR="red"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

doom_status() {
  [[ $SPACESHIP_EXIT_CODE_SHOW == false || $RETVAL == 0 ]] && return

  echo "%F{$SPACESHIP_EXIT_CODE_COLOR}$SPACESHIP_EXIT_CODE_PREFIX${SPACESHIP_EXIT_CODE_SYMBOL} $RETVAL$SPACESHIP_EXIT_CODE_SUFFIX%f "
}
