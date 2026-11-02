#
# pyenv
#
# pyenv lets you easily switch between multiple versions of Python.
# Link: https://github.com/pyenv/pyenv

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------
source $DOOM_ROOT/sections/helpers/exists.zsh

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

DOOM_PYENV_SHOW="${DOOM_PYENV_SHOW=true}"
DOOM_PYENV_SYMBOL="${DOOM_PYENV_SYMBOL=""}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

doom_pyenv() {
  [[ $DOOM_PYENV_SHOW == false ]] && return

  # Show pyenv python version only for Python-specific folders
  [[ -n "$PYENV_VERSION" || -f .python-version || -f requirements.txt || -f pyproject.toml || -f *.py ]] || return

  exists pyenv || return # Do nothing if pyenv is not installed

  local pyenv_status=${$(pyenv version-name 2>/dev/null)//:/ }

  echo \
    "%F{220}" \
    "${DOOM_PYENV_SYMBOL} ${pyenv_status}" \
    "%f"
}
