DOOM_RUST_SHOW="${DOOM_RUST_SHOW=true}"
DOOM_RUST_PREFIX="${DOOM_RUST_PREFIX=""}"
DOOM_RUST_SUFFIX="${DOOM_RUST_SUFFIX=""}"
DOOM_RUST_SYMBOL="${DOOM_RUST_SYMBOL=" "}"
DOOM_RUST_COLOR="${DOOM_RUST_COLOR="09"}"
DOOM_RUST_VERBOSE_VERSION="${DOOM_RUST_VERBOSE_VERSION=false}"

doom_rust() {
  [[ $DOOM_RUST_SHOW == false ]] && return
  [[ -f Cargo.toml ]] || return
  (( $+commands[rustc] )) || return

  local version=${${(s: :)"$(rustc --version 2>/dev/null)"}[2]}
  [[ $DOOM_RUST_VERBOSE_VERSION == true ]] || version=${version%%-*}

  doom_segment RUST "v$version"
}
