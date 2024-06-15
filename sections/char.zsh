#
# Prompt character
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

DOOM_CHAR_PREFIX="${SPACESHIP_CHAR_PREFIX=""}"
DOOM_CHAR_SUFFIX="${DOOM_CHAR_SUFFIX=""}"
DOOM_CHAR_SYMBOL="${SPACESHIP_CHAR_SYMBOL="󰁔 "}"
DOOM_CHAR_SYMBOL_ROOT="${SPACESHIP_CHAR_SYMBOL_ROOT="$SPACESHIP_CHAR_SYMBOL"}"
DOOM_CHAR_SYMBOL_SECONDARY="${SPACESHIP_CHAR_SYMBOL_SECONDARY="$SPACESHIP_CHAR_SYMBOL"}"
DOOM_CHAR_COLOR_SUCCESS="${SPACESHIP_CHAR_COLOR_SUCCESS="green"}"
DOOM_CHAR_COLOR_FAILURE="${SPACESHIP_CHAR_COLOR_FAILURE="red"}"
DOOM_CHAR_COLOR_SECONDARY="${SPACESHIP_CHAR_COLOR_SECONDARY="yellow"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Paint $PROMPT_SYMBOL in red if previous command was fail and
# paint in green if everything was OK.
doom_char() {
    local 'color' 'char'

    if [[ $RETVAL -ne 0 ]]; then
        color="$DOOM_CHAR_COLOR_FAILURE"
    else
        color="$DOOM_CHAR_COLOR_SUCCESS"
    fi

    if [[ $UID -eq 0 ]]; then
        char="$DOOM_CHAR_SYMBOL_ROOT"
    else
        char="$DOOM_CHAR_SYMBOL"
    fi

    echo "%F{$color}$DOOM_CHAR_PREFIX$char$SPACESHIP_CHAR_SUFFIX%f"
}
