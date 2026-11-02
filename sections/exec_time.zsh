#
# Execution time
#
# Execution time of the last command.

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

DOOM_EXEC_TIME_SHOW="${DOOM_EXEC_TIME_SHOW=true}"
DOOM_EXEC_TIME_PREFIX="${DOOM_EXEC_TIME_PREFIX="took "}"
DOOM_EXEC_TIME_SUFFIX="${DOOM_EXEC_TIME_SUFFIX=""}"
DOOM_EXEC_TIME_COLOR="${DOOM_EXEC_TIME_COLOR="yellow"}"
DOOM_EXEC_TIME_ELAPSED="${DOOM_EXEC_TIME_ELAPSED=2}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------
doom_displaytime() {
    local -i T=$1
    (( T >= 86400 )) && printf '%dd ' $(( T / 86400 ))
    (( T >= 3600 )) && printf '%dh ' $(( T / 3600 % 24 ))
    (( T >= 60 )) && printf '%dm ' $(( T / 60 % 60 ))
    printf '%ds' $(( T % 60 ))
}

doom_exec_time() {
    [[ $DOOM_EXEC_TIME_SHOW == false ]] && return

    if (( ${DOOM_EXEC_TIME_duration:-0} >= DOOM_EXEC_TIME_ELAPSED )); then
        echo \
            "%F{$DOOM_EXEC_TIME_COLOR}" \
            "$DOOM_EXEC_TIME_PREFIX" \
            "$(doom_displaytime $DOOM_EXEC_TIME_duration)" \
            "$DOOM_EXEC_TIME_SUFFIX%f"
    fi
}
