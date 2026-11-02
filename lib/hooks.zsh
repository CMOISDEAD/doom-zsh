zmodload zsh/datetime

doom_preexec() {
  doom_exec_time_start
  [[ $1 == *(asdf|fnm|mise|nodenv|nvm|pyenv|rustup)* ]] && doom_cache_clear
}

doom_precmd() {
  typeset -g DOOM_RETVAL=$?
  doom_exec_time_stop
  [[ $DOOM_CACHE_PATH == $PATH ]] || doom_cache_clear
  typeset -g DOOM_CACHE_PATH=$PATH
  doom_git_query
  doom_render_prompts
}
