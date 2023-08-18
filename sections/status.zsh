#
# Exit code
#
# Show exit code of last executed command

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

DOOM_EXIT_CODE_SHOW="${DOOM_EXIT_CODE_SHOW=true}"
DOOM_EXIT_CODE_PREFIX="${DOOM_EXIT_CODE_PREFIX=""}"
DOOM_EXIT_CODE_SUFFIX="${DOOM_EXIT_CODE_SUFFIX=""}"
DOOM_EXIT_CODE_SYMBOL="${DOOM_EXIT_CODE_SYMBOL="✘"}"
DOOM_EXIT_CODE_COLOR="${DOOM_EXIT_CODE_COLOR="red"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

doom_status() {
  [[ $DOOM_EXIT_CODE_SHOW == false || $RETVAL == 0 ]] && return

  echo "%F{$DOOM_EXIT_CODE_COLOR}${DOOM_EXIT_CODE_PREFIX}${DOOM_EXIT_CODE_SYMBOL} $RETVAL${SPACESHIP_EXIT_CODE_SUFFIX}%f "
}
