#
# Working directory
#
# Current directory. Return only three last items of path

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

DOOM_DIR_SHOW="${DOOM_DIR_SHOW=true}"
DOOM_DIR_PREFIX="${SPACESHIP_DIR_PREFIX=" in "}"
DOOM_DIR_SUFFIX=""
DOOM_DIR_TRUNC="${SPACESHIP_DIR_TRUNC=3}"
DOOM_DIR_TRUNC_PREFIX="${SPACESHIP_DIR_TRUNC_PREFIX=}"
DOOM_DIR_TRUNC_REPO="${SPACESHIP_DIR_TRUNC_REPO=true}"
DOOM_DIR_COLOR="${SPACESHIP_DIR_COLOR="cyan"}"
DOOM_DIR_LOCK_SYMBOL="${SPACESHIP_DIR_LOCK_SYMBOL=" "}"
DOOM_DIR_LOCK_COLOR="${SPACESHIP_DIR_LOCK_COLOR="red"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

doom_dir() {
  [[ $DOOM_DIR_SHOW == false ]] && return
  local dir="%$DOOM_DIR_TRUNC~"
  echo "%F{$DOOM_DIR_COLOR}$SPACESHIP_DIR_PREFIX$dir$SPACESHIP_DIR_SUFFIX%f"
}
