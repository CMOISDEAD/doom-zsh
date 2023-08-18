#
# Hostname
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

DOOM_HOST_SHOW="${DOOM_HOST_SHOW=true}"
DOOM_HOST_SHOW_FULL="${DOOM_HOST_SHOW_FULL=false}"
DOOM_HOST_PREFIX="${DOOM_HOST_PREFIX="@"}"
DOOM_HOST_SUFFIX="${DOOM_HOST_SUFFIX=""}"
DOOM_HOST_COLOR="${DOOM_HOST_COLOR="yellow"}"
DOOM_HOST_COLOR_SSH="${DOOM_HOST_COLOR_SSH="green"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# If there is an ssh connections, current machine name.
doom_host() {
  [[ $DOOM_HOST_SHOW == false ]] && return

  if [[ $DOOM_HOST_SHOW == 'always' ]] || [[ -n $SSH_CONNECTION ]]; then
    local host_color host

    # Determination of what color should be used
    if [[ -n $SSH_CONNECTION ]]; then
      host_color=$DOOM_HOST_COLOR_SSH
    else
      host_color=$DOOM_HOST_COLOR
    fi

    if [[ $DOOM_HOST_SHOW_FULL == true ]]; then
      host="%M"
    else
      host="%m"
    fi

    echo "$DOOM_HOST_PREFIX$host" 
  fi
}
