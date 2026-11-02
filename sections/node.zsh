DOOM_NODE_SHOW="${DOOM_NODE_SHOW=true}"
DOOM_NODE_PREFIX="${DOOM_NODE_PREFIX=""}"
DOOM_NODE_SUFFIX="${DOOM_NODE_SUFFIX=""}"
DOOM_NODE_SYMBOL="${DOOM_NODE_SYMBOL="node "}"
DOOM_NODE_DEFAULT_VERSION="${DOOM_NODE_DEFAULT_VERSION=""}"
DOOM_NODE_COLOR="${DOOM_NODE_COLOR="46"}"

doom_node() {
  [[ $DOOM_NODE_SHOW == false ]] && return
  [[ -f package.json || -d node_modules ]] || return

  if (( $+commands[fnm] )); then
    doom_cached node fnm current
  elif (( $+functions[nvm] )); then
    doom_cached node nvm current
  elif (( $+commands[nodenv] )); then
    doom_cached node nodenv version-name
  elif (( $+commands[node] )); then
    doom_cached node node -v
  else
    return
  fi

  local version=$REPLY
  [[ -n $version && $version != (system|node|none) ]] || return
  [[ $version == $DOOM_NODE_DEFAULT_VERSION ]] && return

  doom_segment NODE "$version"
}
