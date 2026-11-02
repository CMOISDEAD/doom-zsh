# Doom ZSH theme
#
# Author: CMOISDEAD, camilodavila.vercel.app
# License: MIT
# https://github.com/CMOISDEAD/doom-zsh

typeset -g DOOM_ROOT=${${(%):-%x}:A:h}

autoload -Uz add-zsh-hook
setopt prompt_subst prompt_percent

(( ${+DOOM_SECTIONS_LEFT} )) || typeset -ga DOOM_SECTIONS_LEFT=(
	user
	host
	dir
	node
	rust
	python
	exec_time
	jobs
	new_line
	status
	char
)

DOOM_SEPARATOR="${DOOM_SEPARATOR=" "}"

(( ${+DOOM_SECTIONS_RIGHT} )) || typeset -ga DOOM_SECTIONS_RIGHT=(git)

() {
	local file
	for file in "$DOOM_ROOT"/lib/*.zsh(N) "$DOOM_ROOT"/sections/*.zsh(N); do
		builtin source "$file"
	done
}

PROMPT='${DOOM_PROMPT}'
RPROMPT='${DOOM_RPROMPT}'

add-zsh-hook preexec doom_preexec
add-zsh-hook precmd doom_precmd
add-zsh-hook chpwd doom_cache_clear
