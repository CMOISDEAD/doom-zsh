#
# Doom ZSH (a spaceship (and more...) inspiration) theme.
#
# Author: CMOISDEAD, camilodavila.vercel.app
# License: MIT
# https://github.com/CMOISDEAD/doom-zsh

# ------------------------------------------------------------------------------
# VARIABLE
# set global variables
# ------------------------------------------------------------------------------

DOOM_ROOT="$HOME/.oh-my-zsh/custom/themes/doom"

# ------------------------------------------------------------------------------
# GITSTATUS.PLUGIN
# initialize gitstatus.plugin
# ------------------------------------------------------------------------------

# the flags enable unstaget, untracked and more counters.
gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
gitstatus_query -d $PWD MY

# ------------------------------------------------------------------------------
# SETUP
# setup requirements of the prompt
# ------------------------------------------------------------------------------

DOOM_SECTIONS_LEFT=(
	logo           # Custom logo
	time           # Time stampts section
	user           # Username section
	host           # Hostname section
	dir            # Current directory section
	node           # Node.js section
	rust           # Rust section
	pyenv          # Pyenv section
	#aws            # Amazon Web Services section

	exec_time      # Execution time
	#vi_mode        # Vi-mode indicator
	#jobs           # Background jobs indicator
	new_line       # Line break
	status         # Last command return status.
	char           # Prompt character

	# NOTE: this sections still on work. (help wanted)
	#gradle        # Gradle section
	#maven         # Maven section
	#package       # Package version
	#ruby          # Ruby section
	#elm           # Elm section
	#elixir        # Elixir section
	#xcode         # Xcode section
	#swift         # Swift section
	#golang        # Go section
	#php           # PHP section
	#haskell       # Haskell Stack section
	#julia         # Julia section
	#docker        # Docker section
	#gcloud        # Google Cloud Platform section
	#venv          # virtualenv section
	#conda         # conda virtualenv section
	#dotnet        # .NET section
	#ember         # Ember.js section
	#kubectl       # Kubectl context section
	#terraform     # Terraform workspace section
	#ibmcloud      # IBM Cloud section
)

DOOM_SECTIONS_RIGHT=(
	gitstatus # Git section ( branch status )
	#battery       # Battery level and status
)

DOOM_LIBS=(
	"lib/hooks.zsh" # Zsh hooks
)

# ------------------------------------------------------------------------------
# SOURCE SECTIONS
# sourcing sections, hooks, etc
# ------------------------------------------------------------------------------

# Load internals
for lib in "${DOOM_LIBS[@]}"; do
	builtin source "$DOOM_ROOT/$lib"
done

# Load sections
for section in "${DOOM_SECTIONS_LEFT[@]}" "${DOOM_SECTIONS_RIGHT[@]}"; do
	if [[ -f "$DOOM_ROOT/sections/$section.zsh" ]]; then
		source "$DOOM_ROOT/sections/$section.zsh"
	else
		echo "Section '$section' was not loaded."
	fi
done

# ------------------------------------------------------------------------------
# PROMPTS
# entry point of prompts
# ------------------------------------------------------------------------------

doom_prompt() {
	# Retrieve exit code of last command to use in status and char
	prompt=""

	[[ -z $DOOM_SECTIONS_LEFT ]] && return
	for section in $DOOM_SECTIONS_LEFT; do
		prompt+="$(doom_$section)"
	done

	echo $prompt
}

doom_rprompt() {
	rprompt=""

	[[ -z $DOOM_SECTIONS_RIGHT ]] && return
	for section in $DOOM_SECTIONS_RIGHT; do
		rprompt+="$(doom_$section)"
	done

	echo $rprompt
}

PROMPT='$(doom_prompt)'
RPROMPT='$(doom_rprompt)'

# ------------------------------------------------------------------------------
# HOOKS
# add custom hooks functions
# ------------------------------------------------------------------------------

add-zsh-hook preexec prompt_doom_preexec
add-zsh-hook precmd prompt_doom_precmd
add-zsh-hook chpwd prompt_doom_chpwd
