#
# Rust
#
# Rust is a systems programming language sponsored by Mozilla Research.
# Link: https://www.rust-lang.org

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------
source $DOOM_ROOT/sections/helpers/exists.zsh

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

RUST_SHOW="${RUST_SHOW=true}"
RUST_PREFIX="${RUST_PREFIX="$PROMPT_DEFAULT_PREFIX"}"
RUST_SUFFIX="${RUST_SUFFIX="$PROMPT_DEFAULT_SUFFIX"}"
RUST_SYMBOL="${RUST_SYMBOL="%F{09}%f "}"
RUST_VERBOSE_VERSION="${RUST_VERBOSE_VERSION=false}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

doom_rust() {
  [[ $RUST_SHOW == false ]] && return

  # If there are Rust-specific files in current directory
  [[ -f Cargo.toml ]] || return

  exists rustc || return

  local rust_version=$(rustc --version | cut -d' ' -f2)

  if [[ $RUST_VERBOSE_VERSION == false ]]; then
  	local rust_version=$(echo $rust_version | cut -d'-' -f1) # Cut off -suffixes from version. "v1.30.0-beta.11" or "v1.30.0-nightly"
  fi

  echo \
    "$RUST_PREFIX" \
    "${RUST_SYMBOL}v${rust_version}" \
    "$RUST_SUFFIX"
}
