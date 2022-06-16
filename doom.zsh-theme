# Put your custom themes in this folder.
# Example:

source ./gitstatus/gitstatus.prompt.zsh

# Section segments
RIGHT_SEPARATOR=""
LEFT_SEPARATOR=""
CONNECTION_1="╭"
CONNECTION_2="─"
CONNECTION_3="╰"
CONNECTION_4="─"

# Git icons
ZSH_THEME_GIT_PROMPT_PREFIX="  "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} %f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} %f"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ﲅ%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➦%f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ✂%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%} ✱%f"

# Variable
TIME="0s"

############################################
# TODO: Move to another file

# Vi Mode
VI_MODE_SHOW="${VI_MODE_SHOW=true}"
VI_MODE_PREFIX="${VI_MODE_PREFIX=" Vi-Mode:"}"
VI_MODE_SUFFIX="${VI_MODE_SUFFIX="$PROMPT_DEFAULT_SUFFIX"}"
VI_MODE_INSERT="${VI_MODE_INSERT="Insert"}"
VI_MODE_NORMAL="${VI_MODE_NORMAL="Normal"}"
VI_MODE_VISUAL="${VI_MODE_VISUAL="Visual"}"

# Rust
RUST_SHOW="${RUST_SHOW=true}"
RUST_PREFIX="${RUST_PREFIX="$PROMPT_DEFAULT_PREFIX"}"
RUST_SUFFIX="${RUST_SUFFIX="$PROMPT_DEFAULT_SUFFIX"}"
RUST_SYMBOL="${RUST_SYMBOL="%F{09}%f "}"
RUST_VERBOSE_VERSION="${RUST_VERBOSE_VERSION=false}"

# Python
SPACESHIP_PYENV_SHOW="${SPACESHIP_PYENV_SHOW=true}"
SPACESHIP_PYENV_SYMBOL="${SPACESHIP_PYENV_SYMBOL=""}"

# AWS
SPACESHIP_AWS_SHOW="${SPACESHIP_AWS_SHOW=true}"
SPACESHIP_AWS_PREFIX="${SPACESHIP_AWS_PREFIX="using "}"
SPACESHIP_AWS_SUFFIX="${SPACESHIP_AWS_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_AWS_SYMBOL="${SPACESHIP_AWS_SYMBOL="☁️ "}"
SPACESHIP_AWS_COLOR="${SPACESHIP_AWS_COLOR="208"}"

exists() {
  command -v "$1" >/dev/null 2>&1
}

vi_mode() {
  [[ $VI_MODE_SHOW == true ]] || return

  if bindkey | grep "vi-quoted-insert" > /dev/null 2>&1; then # check if vi-mode enabled
    local mode_indicator="${VI_MODE_INSERT}"

    case "${KEYMAP}" in
      main|viins)
      mode_indicator="${VI_MODE_INSERT}"
      ;;
      vicmd)
      mode_indicator="${VI_MODE_NORMAL}"
      ;;
    esac

    echo \
      "%F{76}" \
      "$VI_MODE_PREFIX" \
      "$mode_indicator" \
      "$VI_MODE_SUFFIX%f"
  fi
}

doom_rust() {
  [[ $RUST_SHOW == false ]] && return

  # If there are Rust-specific files in current directory
  [[ -f Cargo.toml ]] || return

  exists rustc || return

  local rust_version=$(rustc --version | cut -d' ' -f2)

  if [[ $RUST_VERBOSE_VERSION == false ]]; then
  	local rust_version=$(echo $rust_version | cut -d'-' -f1) # Cut off -suffixes from version. "v1.30.0-beta.11" or "v1.30.0-nightly"
  fi

  echo \
    "$RUST_PREFIX" \
    "${RUST_SYMBOL}v${rust_version}" \
    "$RUST_SUFFIX"
}

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

spaceship_aws() {
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

############################################

function right_triangle() {
   echo $'\ue0b0'
}

function left_triangle() {
   echo $'\ue0b2'
}

function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    export TIME="${timer_show}s"
    unset timer
  fi
}

function prompt_status(){
  echo "%F{255}$(left_triangle)%f%K{255}%F{black} %(?..%{$fg[red]%}%f)  %f%k%F{black}%K{255}$(left_triangle)%f%k"
}

function prompt_shell(){
  echo "%F{255}$(left_triangle)%f%K{255}%F{black}  zsh %F{black}$(left_triangle)%f%k"
}

function prompt_performance(){
  echo "%F{blue}$(left_triangle)%f%F{255}%K{blue}$(doom_pyenv)$(doom_rust)%F{black}$(left_triangle)%f%k"
}

function prompt_exectime(){
  if [[ $TIME ]]; then
    echo "%F{245}$(left_triangle)%f%K{245}%F{black} $TIME %k%F{245}$(right_triangle)%f"
  fi
}

function prompt_git(){
  if [[ -n $(git_prompt_info) ]]; then
    echo "%F{blue}$(left_triangle)%f%K{blue}%F{255}  on%f $GITSTATUS_PROMPT %k%F{blue}$(right_triangle)%f"
  fi
}

function prompt_time(){
  echo "%F{13}  %t |%f"
}

function prompt_dir(){
  echo "%F{33} %0~ |%f"
}

PROMPT='$(prompt_status)$(prompt_shell)$(prompt_performance)$(prompt_exectime)
%F{245}$CONNECTION_1$CONNECTION_2%f $(prompt_time) $(prompt_dir) $(vi_mode)
%F{245}$CONNECTION_3$CONNECTION_4%f '

RPROMPT='$(prompt_git)'
