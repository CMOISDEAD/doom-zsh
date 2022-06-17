#
# Amazon Web Services (AWS)
#
# The AWS Command Line Interface (CLI) is a unified tool to manage AWS services.
# Link: https://aws.amazon.com/cli/

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------
source $HOME/.oh-my-zsh/custom/themes/doom/sections/helpers/exists.zsh

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------
SPACESHIP_AWS_SHOW="${SPACESHIP_AWS_SHOW=true}"
SPACESHIP_AWS_PREFIX="${SPACESHIP_AWS_PREFIX="using "}"
SPACESHIP_AWS_SUFFIX="${SPACESHIP_AWS_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_AWS_SYMBOL="${SPACESHIP_AWS_SYMBOL="☁️ "}"
SPACESHIP_AWS_COLOR="${SPACESHIP_AWS_COLOR="208"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

doom_aws() {
  [[ $SPACESHIP_AWS_SHOW == false ]] && return

  # Check if the AWS-cli is installed
  exists aws || return

  # Is the current profile not the default profile
  [[ -z $AWS_PROFILE ]] || [[ "$AWS_PROFILE" == "default" ]] && return

  # Show prompt section
  echo \
    "%F{$SPACESHIP_AWS_COLOR}" \
    "$SPACESHIP_AWS_PREFIX" \
    "${SPACESHIP_AWS_SYMBOL}$AWS_PROFILE" \
    "$SPACESHIP_AWS_SUFFIX%f"
}
