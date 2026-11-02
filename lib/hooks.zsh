zmodload zsh/datetime

doom_preexec() {
  doom_exec_time_start
}

doom_precmd() {
  typeset -g DOOM_RETVAL=$?
  doom_exec_time_stop
  gitstatus_query -d $PWD MY
  doom_render_prompts
}
