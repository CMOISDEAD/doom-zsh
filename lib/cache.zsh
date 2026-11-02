typeset -gA DOOM_CACHE

doom_cached() {
  local key=$1
  shift
  (( $+DOOM_CACHE[$key] )) || DOOM_CACHE[$key]=$("$@" 2>/dev/null)
  REPLY=$DOOM_CACHE[$key]
}

doom_cache_clear() {
  DOOM_CACHE=()
}
