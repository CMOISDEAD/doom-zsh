#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# HOOKS
# Zsh hooks for advanced actions
# custom hooks for sections
# ------------------------------------------------------------------------------

# Execution time start
doom_exec_time_start() {
  [[ $DOOM_EXEC_TIME_SHOW == false ]] && return

  # The Timer is started here, but the end is taken in prompt_doom_precmd,
  # as this method is a precmd hook and runs right before the prompt gets rendered.
  # So we can calculate the duration there.
  DOOM_EXEC_TIME_start=$EPOCHREALTIME
}

# Execution time end
doom_exec_time_stop() {
  [[ $DOOM_EXEC_TIME_SHOW == false ]] && return
  [[ -n $DOOM_EXEC_TIME_duration ]] && unset DOOM_EXEC_TIME_duration
  [[ -z $DOOM_EXEC_TIME_start ]] && return

  DOOM_EXEC_TIME_duration=$((EPOCHREALTIME - DOOM_EXEC_TIME_start))

  # Reset start time
  unset DOOM_EXEC_TIME_start
}

# A hook before every command
prompt_doom_precmd() {
  # Retrieve exit code of last command to use in exit_code
  # Must be captured before any other command in prompt is executed
  # Must be the very first line in all entry prompt functions, or the value
  # will be overridden by a different command execution - do not move this line!
  RETVAL=$?
  RETVALS=("$pipestatus[@]")

  # Stop measuring exec_time, must be the first precmd action
  doom_exec_time_stop
}

# A hook right before the command is started executing
prompt_doom_preexec() {
  # Start measuring exec_time right before executing the command
  doom_exec_time_start
}

# A hook after changing the working directory
prompt_doom_chpwd() {
  # spaceship::worker::eval builtin cd -q $PWD

  # Restart execution time recording once dir is changed
  doom_exec_time_start
}
