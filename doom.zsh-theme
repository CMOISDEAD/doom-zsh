# Doom ZSH theme
#
# Author: CMOISDEAD, camilodavila.vercel.app
# License: MIT
# https://github.com/CMOISDEAD/doom-zsh

typeset -g DOOM_ROOT=${${(%):-%x}:A:h}

autoload -Uz add-zsh-hook
setopt prompt_subst prompt_percent

(( ${+DOOM_SECTIONS_LEFT} )) || typeset -ga DOOM_SECTIONS_LEFT=(
	logo
	time
	user
	host
	dir
	node
	rust
	pyenv
	exec_time
	new_line
	status
	char
)

DOOM_SEPARATOR="${DOOM_SEPARATOR=" "}"

(( ${+DOOM_SECTIONS_RIGHT} )) || typeset -ga DOOM_SECTIONS_RIGHT=(gitstatus)

() {
	local file
	for file in "$DOOM_ROOT"/lib/*.zsh(N) "$DOOM_ROOT"/sections/*.zsh(N); do
		builtin source "$file"
	done
}

gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'

PROMPT='${DOOM_PROMPT}'
RPROMPT='${DOOM_RPROMPT}'

add-zsh-hook preexec doom_preexec
add-zsh-hook precmd doom_precmd
