DOOM_GITSTATUS_DIR="${DOOM_GITSTATUS_DIR=""}"

doom_git_load_gitstatus() {
  (( $+functions[gitstatus_start] )) && return

  local dir
  for dir in \
    $DOOM_GITSTATUS_DIR \
    $HOME/gitstatus \
    ${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/themes/powerlevel10k/gitstatus \
    /usr/share/gitstatus \
    /usr/share/zsh-theme-powerlevel10k/gitstatus; do
    if [[ -r $dir/gitstatus.plugin.zsh ]]; then
      builtin source $dir/gitstatus.plugin.zsh
      return
    fi
  done

  return 1
}

doom_git_init() {
  typeset -g DOOM_GIT_BACKEND=

  if doom_git_load_gitstatus \
    && gitstatus_stop DOOM \
    && gitstatus_start -s -1 -u -1 -c -1 -d -1 DOOM; then
    DOOM_GIT_BACKEND=gitstatus
  elif (( $+commands[git] )); then
    DOOM_GIT_BACKEND=git
  fi
}

doom_git_read() {
  typeset -g VCS_STATUS_RESULT=
  typeset -g VCS_STATUS_LOCAL_BRANCH= VCS_STATUS_COMMIT=
  typeset -gi VCS_STATUS_COMMITS_AHEAD=0 VCS_STATUS_COMMITS_BEHIND=0
  typeset -gi VCS_STATUS_NUM_CONFLICTED=0 VCS_STATUS_NUM_STAGED=0
  typeset -gi VCS_STATUS_NUM_UNSTAGED=0 VCS_STATUS_NUM_UNTRACKED=0

  local output
  output=$(command git --no-optional-locks status --porcelain=v2 --branch 2>/dev/null) || return

  local line
  local -a fields
  for line in ${(f)output}; do
    case $line in
      '# branch.oid '*) VCS_STATUS_COMMIT=${line##* } ;;
      '# branch.head (detached)') ;;
      '# branch.head '*) VCS_STATUS_LOCAL_BRANCH=${line#\# branch.head } ;;
      '# branch.ab '*)
        fields=(${=line})
        VCS_STATUS_COMMITS_AHEAD=${fields[3]#+}
        VCS_STATUS_COMMITS_BEHIND=${fields[4]#-}
        ;;
      '1 '*|'2 '*)
        [[ $line[3] == . ]] || (( VCS_STATUS_NUM_STAGED++ ))
        [[ $line[4] == . ]] || (( VCS_STATUS_NUM_UNSTAGED++ ))
        ;;
      'u '*) (( VCS_STATUS_NUM_CONFLICTED++ )) ;;
      '? '*) (( VCS_STATUS_NUM_UNTRACKED++ )) ;;
    esac
  done

  VCS_STATUS_RESULT=ok-sync
}

doom_git_query() {
  case $DOOM_GIT_BACKEND in
    gitstatus) gitstatus_query -d $PWD DOOM || VCS_STATUS_RESULT= ;;
    git) doom_git_read ;;
  esac
}
