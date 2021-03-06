#
# Gitstatus
#

# ------------------------------------------------------------------------------
# GIT STATUS
# Sourcing Git Status Plugin
# ------------------------------------------------------------------------------
local DOOM_ROOT="$HOME/.oh-my-zsh/custom/themes/doom"
source "$DOOM_ROOT/gitstatus/gitstatus.prompt.zsh"

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

DOOM_GIT_SHOW="${DOOM_GIT_SHOW=true}"
DOOM_GIT_PREFIX="${DOOM_GIT_PREFIX=""}"
DOOM_GIT_SUFFIX="${DOOM_GIT_SUFFIX=""}"
DOOM_GIT_COLOR="${DOOM_GIT_COLOR="yellow"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

doom_gitstatus() {
  [[ $DOOM_GIT_SHOW == true ]] || return

  echo \
    "%F{$DOOM_GIT_COLOR}" \
    "$DOOM_GIT_PREFIX" \
    "$GITSTATUS_PROMPT" \
    "$DOOM_GIT_SUFFIX%f"
}
