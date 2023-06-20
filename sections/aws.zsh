#
# Amazon Web Services (AWS)
#
# The AWS Command Line Interface (CLI) is a unified tool to manage AWS services.
# Link: https://aws.amazon.com/cli/

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------
source $DOOM_ROOT/sections/helpers/exists.zsh

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------
DOOM_AWS_SHOW="${DOOM_AWS_SHOW=true}"
DOOM_AWS_PREFIX="${DOOM_AWS_PREFIX="using "}"
DOOM_AWS_SUFFIX="${DOOM_AWS_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
DOOM_AWS_SYMBOL="${DOOM_AWS_SYMBOL="☁️ "}"
DOOM_AWS_COLOR="${DOOM_AWS_COLOR="208"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

doom_aws() {
  [[ $DOOM_AWS_SHOW == false ]] && return

  # Check if the AWS-cli is installed
  exists aws || return

  # Is the current profile not the default profile
  [[ -z $AWS_PROFILE ]] || [[ "$AWS_PROFILE" == "default" ]] && return

  # Show prompt section
  echo \
    "%F{$DOOM_AWS_COLOR}" \
    "$DOOM_AWS_PREFIX" \
    "${DOOM_AWS_SYMBOL}$AWS_PROFILE" \
    "$DOOM_AWS_SUFFIX%f"
}
