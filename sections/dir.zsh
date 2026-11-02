#
# Working directory
#
# Current directory. Return only three last items of path

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

DOOM_DIR_SHOW="${DOOM_DIR_SHOW=true}"
DOOM_DIR_PREFIX="${DOOM_DIR_PREFIX=" in "}"
DOOM_DIR_SUFFIX="${DOOM_DIR_SUFFIX=""}"
DOOM_DIR_TRUNC="${DOOM_DIR_TRUNC=3}"
DOOM_DIR_COLOR="${DOOM_DIR_COLOR="cyan"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

doom_dir() {
  [[ $DOOM_DIR_SHOW == false ]] && return
  local dir="%$DOOM_DIR_TRUNC~"
  echo "%F{$DOOM_DIR_COLOR}$DOOM_DIR_PREFIX$dir$DOOM_DIR_SUFFIX%f"
}
