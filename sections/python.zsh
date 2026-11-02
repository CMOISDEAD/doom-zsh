DOOM_PYTHON_SHOW="${DOOM_PYTHON_SHOW=true}"
DOOM_PYTHON_PREFIX="${DOOM_PYTHON_PREFIX=""}"
DOOM_PYTHON_SUFFIX="${DOOM_PYTHON_SUFFIX=""}"
DOOM_PYTHON_SYMBOL="${DOOM_PYTHON_SYMBOL=" "}"
DOOM_PYTHON_COLOR="${DOOM_PYTHON_COLOR="220"}"

doom_python() {
  [[ $DOOM_PYTHON_SHOW == false ]] && return

  local -a sources=((.python-version|requirements.txt|pyproject.toml|*.py)(N[1]))
  [[ -n $VIRTUAL_ENV || -n $sources ]] || return

  local binary=${commands[python]:-$commands[python3]}
  [[ -n $binary ]] || return

  doom_cached python $binary --version
  local version=${REPLY#Python }
  [[ -n $version ]] || return

  [[ -n $VIRTUAL_ENV ]] && version+=" (${VIRTUAL_ENV:t})"

  doom_segment PYTHON "${version//\%/%%}"
}
