DOOM_NODE_SHOW="${DOOM_NODE_SHOW=true}"
DOOM_NODE_PREFIX="${DOOM_NODE_PREFIX=""}"
DOOM_NODE_SUFFIX="${DOOM_NODE_SUFFIX=""}"
DOOM_NODE_SYMBOL="${DOOM_NODE_SYMBOL="⬢ "}"
DOOM_NODE_DEFAULT_VERSION="${DOOM_NODE_DEFAULT_VERSION=""}"
DOOM_NODE_COLOR="${DOOM_NODE_COLOR="46"}"

doom_node() {
  [[ $DOOM_NODE_SHOW == false ]] && return
  [[ -f package.json || -d node_modules ]] || return

  local version

  if (( $+commands[fnm] )); then
    version=$(fnm current 2>/dev/null)
  elif (( $+functions[nvm] )); then
    version=$(nvm current 2>/dev/null)
  elif (( $+commands[nodenv] )); then
    version=$(nodenv version-name 2>/dev/null)
  elif (( $+commands[node] )); then
    version=$(node -v 2>/dev/null)
  fi

  [[ -n $version && $version != (system|node|none) ]] || return
  [[ $version == $DOOM_NODE_DEFAULT_VERSION ]] && return

  doom_segment NODE "$version"
}
