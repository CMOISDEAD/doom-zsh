#
# Doom ZSH (a spaceship (and more...) inspiration theme)
#
# Author: Camilo Davila, godemperordoom.com
# License: MIT
# https://github.com/CMOISDEAD/doom-zsh

# ------------------------------------------------------------------------------
# ROOT VARIABLE
# Set a root path of 
# ------------------------------------------------------------------------------
DOOM_ROOT="$HOME/.oh-my-zsh/custom/themes/doom"

# ------------------------------------------------------------------------------
# GIT STATUS
# Sourcing Git Status Plugin
# ------------------------------------------------------------------------------
source "$DOOM_ROOT/gitstatus/gitstatus.prompt.zsh"
source "$DOOM_ROOT/sections/zvm.zsh"

DOOM_SECTIONS=(
  #user          # Username section
  #gradle        # Gradle section
  #maven         # Maven section
  #package       # Package version
  #node          # Node.js section
  #ruby          # Ruby section
  #elm           # Elm section
  #elixir        # Elixir section
  #xcode         # Xcode section
  #swift         # Swift section
  #golang        # Go section
  #php           # PHP section
  #rust          # Rust section
  #haskell       # Haskell Stack section
  #julia         # Julia section
  #docker        # Docker section
  #aws           # Amazon Web Services section
  #gcloud        # Google Cloud Platform section
  #venv          # virtualenv section
  #conda         # conda virtualenv section
  #pyenv         # Pyenv section
  #dotnet        # .NET section
  #ember         # Ember.js section
  #ibmcloud      # IBM Cloud section
  #battery       # Battery level and status
  #jobs          # Background jobs indicator
)

# ------------------------------------------------------------------------------
# SECTIONS
# Sourcing sections the prompt consists of
# ------------------------------------------------------------------------------
for section in $DOOM_SECTIONS
do
  source "$DOOM_ROOT/sections/$section.zsh"
done

prompt_section(){ #HACK: I feel this a litle bit slow
  prompt=""
  [[ -z $DOOM_SECTIONS ]] && return
  for section in $DOOM_SECTIONS
  do
    prompt+="$(doom_$section)"
  done
 
  echo $prompt
}

# ------------------------------------------------------------------------------
# VARIABLES
# Mis of variables
# ------------------------------------------------------------------------------

# Section segments
RIGHT_SEPARATOR=""
LEFT_SEPARATOR=""
CONNECTION_1="╭"
CONNECTION_2="─"
CONNECTION_3="╰"
CONNECTION_4="─"

# Variable
TIME="0s"

# ------------------------------------------------------------------------------
# SETUP
# Setup requirements for prompt
# ------------------------------------------------------------------------------

right_triangle() {
   echo $'\ue0b0'
}

left_triangle() {
   echo $'\ue0b2'
}

preexec() {
  timer=${timer:-$SECONDS}
}

precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    export TIME="${timer_show}s"
    unset timer
  fi
}

prompt_status(){
  echo "%F{255}$(left_triangle)%f%K{255}%F{black} %(?..%{$fg[red]%}%f)  %f%k%F{black}%K{255}$(left_triangle)%f%k"
}

prompt_shell(){
  echo "%F{255}$(left_triangle)%f%K{255}%F{black}  zsh %F{black}$(left_triangle)%f%k"
}

prompt_dev_status(){
  echo "%F{blue}$(left_triangle)%f%F{255}%K{blue}$(prompt_section)%F{black}$(left_triangle)%f%k"
}

prompt_exectime(){
  if [[ $TIME ]]; then
    echo "%F{245}$(left_triangle)%f%K{245}%F{black} $TIME %k%F{245}$(right_triangle)%f"
  fi
}

prompt_git(){
  if [[ -n $(git_prompt_info) ]]; then
    echo "%F{blue}$(left_triangle)%f%K{blue}%F{255}  on%f $GITSTATUS_PROMPT %k%F{blue}$(right_triangle)%f"
  fi
}

prompt_time(){
  echo "%F{13}  %t |%f"
}

prompt_dir(){
  echo "%F{33} %0~ |%f"
}

# ------------------------------------------------------------------------------
# PROMPTS
# An entry point of prompt
# ------------------------------------------------------------------------------

PROMPT='$(prompt_status)$(prompt_shell)$(prompt_dev_status)$(prompt_exectime)
%F{245}$CONNECTION_1$CONNECTION_2%f $(prompt_time) $(prompt_dir) $(doom_vi_mode)
%F{245}$CONNECTION_3$CONNECTION_4%f '

RPROMPT='$(prompt_git)'
