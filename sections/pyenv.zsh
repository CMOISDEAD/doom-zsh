#
# pyenv
#
# pyenv lets you easily switch between multiple versions of Python.
# Link: https://github.com/pyenv/pyenv

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------
source $HOME/.oh-my-zsh/custom/themes/doom/sections/helpers/exists.zsh

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_PYENV_SHOW="${SPACESHIP_PYENV_SHOW=true}"
SPACESHIP_PYENV_SYMBOL="${SPACESHIP_PYENV_SYMBOL=""}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

doom_pyenv() {
  [[ $SPACESHIP_PYENV_SHOW == false ]] && return

  # Show pyenv python version only for Python-specific folders
  [[ -n "$PYENV_VERSION" || -f .python-version || -f requirements.txt || -f pyproject.toml || -f *.py ]] || return

  exists pyenv || return # Do nothing if pyenv is not installed

  local pyenv_status=${$(pyenv version-name 2>/dev/null)//:/ }

  echo \
    "%F{220}" \
    "${SPACESHIP_PYENV_SYMBOL} ${pyenv_status}" \
    "%f"
}
