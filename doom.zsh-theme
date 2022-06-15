# Put your custom themes in this folder.
# Example:

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
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ~%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ﴬ%f"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✗%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➦%f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ✂%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%} ✱%f"

TIME="0s"

right_triangle() {
   echo $'\ue0b0'
}

left_triangle() {
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
  echo "%F{255}$(left_triangle)%f%K{255}%F{black}  %n %F{black}$(left_triangle)%f%k"
}

function prompt_performance(){
  echo "%F{blue}$(left_triangle)%f%F{255}%K{blue} CPU: 17.37% | MEM: 6/7GB   %F{black}$(left_triangle)%f%k"
}

function prompt_exectime(){
  if [[ $TIME ]]; then
    echo "%F{245}$(left_triangle)%f%K{245}%F{black} $TIME %k%F{245}$(right_triangle)%f"
  fi
}

function prompt_git(){
  if [[ -n $(git_prompt_info) ]]; then
    echo "%F{cyan}$(left_triangle)%f%K{cyan}%F{black} $(git_prompt_info)$(git_prompt_status) %k%F{cyan}$(right_triangle)%f"
  fi
}

function prompt_time(){
  echo "%F{255}  %T |%f"
}

function prompt_dir(){
  path=$(pwd)
  if [[ $path == $HOME ]]; then
    echo "%F{255} %f"
  else
    echo "%F{255} ﰲ  ﰲ  ﰲ %1~%f"
  fi 
}

PROMPT='$(prompt_status)$(prompt_shell)$(prompt_performance)$(prompt_exectime)
%F{255}$CONNECTION_1$CONNECTION_2%f $(prompt_time) $(prompt_dir)
%F{255}$CONNECTION_3$CONNECTION_4%f '

RPROMPT='$(prompt_git)'
