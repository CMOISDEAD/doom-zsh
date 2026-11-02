DOOM_GIT_SHOW="${DOOM_GIT_SHOW=true}"
DOOM_GIT_PREFIX="${DOOM_GIT_PREFIX=""}"
DOOM_GIT_SUFFIX="${DOOM_GIT_SUFFIX=""}"

doom_gitstatus() {
  [[ $DOOM_GIT_SHOW == false ]] && return
  [[ $VCS_STATUS_RESULT == ok-sync ]] || return

  local p
  local where

  if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
      where=$VCS_STATUS_LOCAL_BRANCH
  elif [[ -n $VCS_STATUS_TAG ]]; then
      p+='%f#'
      where=$VCS_STATUS_TAG
  else
      p+='%f@'
      where=${VCS_STATUS_COMMIT[1,8]}
  fi

  (( $#where > 32 )) && where[13,-13]="…"
  p+="%F{green}${where//\%/%%}"
  (( VCS_STATUS_COMMITS_BEHIND )) && p+=" %F{blue}⇣${VCS_STATUS_COMMITS_BEHIND}%f"
  (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && p+=" "
  (( VCS_STATUS_COMMITS_AHEAD  )) && p+="%F{green}⇡${VCS_STATUS_COMMITS_AHEAD}%f"
  (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" %F{yellow}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}%f"
  (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" "
  (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && p+="%F{green}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}%f"
  (( VCS_STATUS_STASHES        )) && p+=" %F{cyan}*${VCS_STATUS_STASHES}%f"
  [[ -n $VCS_STATUS_ACTION     ]] && p+=" %F{red}${VCS_STATUS_ACTION}%f"
  (( VCS_STATUS_NUM_CONFLICTED )) && p+=" %F{red}~${VCS_STATUS_NUM_CONFLICTED}%f"
  (( VCS_STATUS_NUM_STAGED     )) && p+=" %F{green}+${VCS_STATUS_NUM_STAGED}%f"
  (( VCS_STATUS_NUM_UNSTAGED   )) && p+=" %F{yellow}!${VCS_STATUS_NUM_UNSTAGED}%f"
  (( VCS_STATUS_NUM_UNTRACKED  )) && p+=" %F{blue}?${VCS_STATUS_NUM_UNTRACKED}%f"

  doom_segment GIT "$p%f"
}
