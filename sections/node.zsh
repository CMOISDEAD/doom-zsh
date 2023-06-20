#
# Node.js
#
# Node.js is a JavaScript runtime built on Chrome's V8 JavaScript engine.
# Link: https://nodejs.org/

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------
source $DOOM_ROOT/sections/helpers/exists.zsh

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------
DOOM_NODE_SHOW="${DOOM_NODE_SHOW=true}"
DOOM_NODE_PREFIX="${SPACESHIP_NODE_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
DOOM_NODE_SUFFIX="${SPACESHIP_NODE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
DOOM_NODE_SYMBOL="${SPACESHIP_NODE_SYMBOL="⬢ "}"
DOOM_NODE_DEFAULT_VERSION="${SPACESHIP_NODE_DEFAULT_VERSION=""}"
DOOM_NODE_COLOR="${SPACESHIP_NODE_COLOR="46"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of node, exception system.
doom_node() {
  [[ $DOOM_NODE_SHOW == false ]] && return

  # Show NODE status only for JS-specific folders
  [[ -f package.json || -d node_modules ]] || return

  local 'node_version'

  if exists fnm; then
    node_version=$(fnm current 2>/dev/null)
    [[ $node_version == "system" || $node_version == "node" ]] && return
  elif exists nvm; then
    node_version=$(nvm current 2>/dev/null)
    [[ $node_version == "system" || $node_version == "node" ]] && return
  elif exists nodenv; then
    node_version=$(nodenv version-name)
    [[ $node_version == "system" || $node_version == "node" ]] && return
  elif exists node; then
    node_version=$(node -v 2>/dev/null)
  else
    return
  fi

  [[ $node_version == $DOOM_NODE_DEFAULT_VERSION ]] && return

  echo \
    "%F{$DOOM_NODE_COLOR}" \
    "$DOOM_NODE_PREFIX" \
    "${DOOM_NODE_SYMBOL}${node_version}" \
    "$DOOM_NODE_SUFFIX%f"
}
