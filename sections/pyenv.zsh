DOOM_PYENV_SHOW="${DOOM_PYENV_SHOW=true}"
DOOM_PYENV_PREFIX="${DOOM_PYENV_PREFIX=""}"
DOOM_PYENV_SUFFIX="${DOOM_PYENV_SUFFIX=""}"
DOOM_PYENV_SYMBOL="${DOOM_PYENV_SYMBOL=" "}"
DOOM_PYENV_COLOR="${DOOM_PYENV_COLOR="220"}"

doom_pyenv() {
  [[ $DOOM_PYENV_SHOW == false ]] && return

  local -a sources=((.python-version|requirements.txt|pyproject.toml|*.py)(N[1]))
  [[ -n $PYENV_VERSION || -n $sources ]] || return

  (( $+commands[pyenv] )) || return

  doom_segment PYENV "${$(pyenv version-name 2>/dev/null)//:/ }"
}
