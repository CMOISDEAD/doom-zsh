#
# Logo
#
# Custom logo, pimp your prompt

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

LOGO_SHOW="${LOGO_SHOW=true}"
LOGO_CONTENT="${LOGO_CONTENT="󰘧"}"
LOGO_PREFIX="${LOGO_PREFIX=" "}"
LOGO_SUFFIX="${LOGO_SUFFIX=" "}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------


doom_logo() {
  [[ $LOGO_SHOW == true ]] || return

  echo -n "${LOGO_PREFIX}${LOGO_CONTENT}${LOGO_SUFFIX}"
}
