DOOM_AWS_SHOW="${DOOM_AWS_SHOW=true}"
DOOM_AWS_PREFIX="${DOOM_AWS_PREFIX="using "}"
DOOM_AWS_SUFFIX="${DOOM_AWS_SUFFIX=""}"
DOOM_AWS_SYMBOL="${DOOM_AWS_SYMBOL="☁️ "}"
DOOM_AWS_COLOR="${DOOM_AWS_COLOR="208"}"

doom_aws() {
  [[ $DOOM_AWS_SHOW == false ]] && return
  (( $+commands[aws] )) || return
  [[ -n $AWS_PROFILE && $AWS_PROFILE != default ]] || return

  doom_segment AWS "${AWS_PROFILE//\%/%%}"
}
