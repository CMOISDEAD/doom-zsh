#
# Execution time
#
# Execution time of the last command.

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

DOOM_EXEC_TIME_SHOW="${DOOM_EXEC_TIME_SHOW=true}"
DOOM_EXEC_TIME_PREFIX="${DOOM_EXEC_TIME_PREFIX="took "}"
DOOM_EXEC_TIME_SUFFIX="${DOOM_EXEC_TIME_SUFFIX="$DOOM_PROMPT_DEFAULT_SUFFIX"}"
DOOM_EXEC_TIME_COLOR="${DOOM_EXEC_TIME_COLOR="yellow"}"
DOOM_EXEC_TIME_ELAPSED="${DOOM_EXEC_TIME_ELAPSED=2}"
DOOM_EXEC_TIME_duration="${DOOM_EXEC_TIME_duration=""}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------
# FIX: Move this functions to a utils file.
doom_displaytime() {
    local T=$1
    local D=$((T/60/60/24))
    local H=$((T/60/60%24))
    local M=$((T/60%60))
    local S=$((T%60))
    [[ $D > 0 ]] && printf '%dd ' $D
    [[ $H > 0 ]] && printf '%dh ' $H
    [[ $M > 0 ]] && printf '%dm ' $M
    printf '%ds' $S
}

preexec() {
    timer=$(($(date +%s%0N)/1000000))
}

precmd() {
    if [ $timer ]; then
        now=$(($(date +%s%0N)/1000000))
        elapsed=$(($now-$timer))
        local time=$elapsed/1000

        export DOOM_EXEC_TIME_duration="${time}"
        unset timer
    fi
}

doom_exec_time() {
    [[ $DOOM_EXEC_TIME_SHOW == false ]] && return

    if [[ $DOOM_EXEC_TIME_duration -ge $DOOM_EXEC_TIME_ELAPSED ]]; then
        echo \
            "%F{$DOOM_EXEC_TIME_COLOR}" \
            "$DOOM_EXEC_TIME_PREFIX" \
            "$(doom_displaytime $DOOM_EXEC_TIME_duration)" \
            "$DOOM_EXEC_TIME_SUFFIX%f"
    fi
}
