#
# Doom ZSH (a spaceship (and more...) inspiration) theme.
#
# Author: Camilo Davila, godemperordoom.com
# License: MIT
# https://github.com/CMOISDEAD/doom-zsh

# ------------------------------------------------------------------------------
# ROOT VARIABLE
# Set a root path of
# ------------------------------------------------------------------------------

# DOOM_ROOT="$HOME/.oh-my-zsh/custom/themes/doom"
DOOM_ROOT="$HOME/Documents/git/doom-prompt"

# ------------------------------------------------------------------------------
# SETUP
# Setup requirements for prompt
# ------------------------------------------------------------------------------

DOOM_SECTIONS_LEFT=(
  time # Time stampts section
  user # Username section
  #host          # Hostname section
  dir # Current directory section
  #node          # Node.js section
  #rust          # Rust section
  #aws           # Amazon Web Services section
  #pyenv         # Pyenv section

  # --------- TODO: This sections still on work.
  #gradle        # Gradle section
  #maven         # Maven section
  #package       # Package version
  #ruby          # Ruby section
  #elm           # Elm section
  #elixir        # Elixir section
  #xcode         # Xcode section
  #swift         # Swift section
  #golang        # Go section
  #php           # PHP section
  #haskell       # Haskell Stack section
  #julia         # Julia section
  #docker        # Docker section
  #gcloud        # Google Cloud Platform section
  #venv          # virtualenv section
  #conda         # conda virtualenv section
  #dotnet        # .NET section
  #ember         # Ember.js section
  #kubectl       # Kubectl context section
  #terraform     # Terraform workspace section
  #ibmcloud      # IBM Cloud section
  # ---------

  exec_time # Execution time
  #vi_mode       # Vi-mode indicator
  #jobs          # Background jobs indicator
  new_line # Line break
  status   # Last command return status.
  char     # Prompt character
)

DOOM_SECTIONS_RIGHT=(
  gitstatus # Git section ( branch status )
  #battery       # Battery level and status
)

# ------------------------------------------------------------------------------
# SOURCE SECTIONS
# Sourcing sections of prompt order
# ------------------------------------------------------------------------------

for section in "${DOOM_SECTIONS_LEFT[@]}" "${DOOM_SECTIONS_RIGHT[@]}"; do
  if [[ -f "$DOOM_ROOT/sections/$section.zsh" ]]; then
    source "$DOOM_ROOT/sections/$section.zsh"
  else
    echo "Section '$section' was not loaded."
  fi
done

# ------------------------------------------------------------------------------
# PROMPTS
# An entry point of prompt
# ------------------------------------------------------------------------------

doom_prompt() {
  # Retrieve exit code of last command to use in status and char
  RETVAL=$?
  prompt=""

  [[ -z $DOOM_SECTIONS_LEFT ]] && return
  for section in $DOOM_SECTIONS_LEFT; do
    prompt+="$(doom_$section)"
  done

  echo $prompt
}

doom_rprompt() {
  prompt=""

  [[ -z $DOOM_SECTIONS_RIGHT ]] && return
  for section in $DOOM_SECTIONS_RIGHT; do
    prompt+="$(doom_$section)"
  done

  echo $prompt
}

PROMPT='$(doom_prompt)'
RPROMPT='$(doom_rprompt)'

# ------------------------------------------------------------------------------
# VARIABLES
# Mis of variables
# ------------------------------------------------------------------------------
