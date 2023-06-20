#
# Username
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

# --------------------------------------------------------------------------
# | DOOM_USER_SHOW      | show username on local | show username on remote |
# |---------------------+------------------------+-------------------------|
# | false               | never                  | never                   |
# | always              | always                 | always                  |
# | true                | if needed              | always                  |
# | needed              | if needed              | if needed               |
# --------------------------------------------------------------------------

DOOM_USER_SHOW="${DOOM_USER_SHOW=always}"
DOOM_USER_PREFIX="${DOOM_USER_PREFIX=" "}"
DOOM_USER_SUFFIX="${DOOM_USER_SUFFIX=""}"
DOOM_USER_COLOR="${DOOM_USER_COLOR="blue"}"
DOOM_USER_COLOR_ROOT="${DOOM_USER_COLOR_ROOT="red"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

doom_user() {
  [[ $DOOM_USER_SHOW == false ]] && return

  if [[ $DOOM_USER_SHOW == 'always' ]] \
  || [[ $LOGNAME != $USER ]] \
  || [[ $UID == 0 ]] \
  || [[ $DOOM_USER_SHOW == true && -n $SSH_CONNECTION ]]
  then
    local 'user_color'

    if [[ $USER == 'root' ]]; then
      user_color="%F{$DOOM_USER_COLOR_ROOT}"
    else
      user_color="%F{$DOOM_USER_COLOR}"
    fi

    echo "$user_color$DOOM_USER_PREFIX%n$DOOM_USER_SUFFIX%f"
  fi
}
