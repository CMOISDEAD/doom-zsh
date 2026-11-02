DOOM_GIT_SHOW="${DOOM_GIT_SHOW=true}"
DOOM_GIT_PREFIX="${DOOM_GIT_PREFIX=""}"
DOOM_GIT_SUFFIX="${DOOM_GIT_SUFFIX=""}"

doom_git_action() {
  local dir=$(command git rev-parse --git-dir 2>/dev/null)

  REPLY=
  if [[ -d $dir/rebase-merge || -d $dir/rebase-apply ]]; then
    REPLY=rebase
  elif [[ -f $dir/MERGE_HEAD ]]; then
    REPLY=merge
  elif [[ -f $dir/CHERRY_PICK_HEAD ]]; then
    REPLY=cherry-pick
  elif [[ -f $dir/REVERT_HEAD ]]; then
    REPLY=revert
  elif [[ -f $dir/BISECT_LOG ]]; then
    REPLY=bisect
  fi
}

doom_git_query() {
  typeset -g DOOM_GIT_status=

  [[ $DOOM_GIT_SHOW == false ]] && return
  (( $DOOM_SECTIONS_LEFT[(I)git] || $DOOM_SECTIONS_RIGHT[(I)git] )) || return
  (( $+commands[git] )) || return

  local output
  output=$(command git --no-optional-locks status --porcelain=v2 --branch --show-stash 2>/dev/null) || return

  local line branch commit
  local -i ahead behind conflicted staged unstaged untracked stashes
  local -a fields

  for line in ${(f)output}; do
    case $line in
      '# branch.oid '*) commit=${line##* } ;;
      '# branch.head (detached)') ;;
      '# branch.head '*) branch=${line#\# branch.head } ;;
      '# branch.ab '*)
        fields=(${=line})
        ahead=${fields[3]#+}
        behind=${fields[4]#-}
        ;;
      '# stash '*) stashes=${line##* } ;;
      '1 '*|'2 '*)
        [[ $line[3] == . ]] || (( ++staged ))
        [[ $line[4] == . ]] || (( ++unstaged ))
        ;;
      'u '*) (( ++conflicted )) ;;
      '? '*) (( ++untracked )) ;;
    esac
  done

  local where=$branch p
  if [[ -z $where ]]; then
    p='%f@'
    where=${commit[1,8]}
  fi

  (( $#where > 32 )) && where[13,-13]="…"
  p+="%F{green}${where//\%/%%}"
  (( behind )) && p+=" %F{blue}⇣$behind%f"
  (( ahead && !behind )) && p+=" "
  (( ahead )) && p+="%F{green}⇡$ahead%f"
  (( stashes )) && p+=" %F{cyan}*$stashes%f"
  doom_git_action
  [[ -n $REPLY ]] && p+=" %F{red}$REPLY%f"
  (( conflicted )) && p+=" %F{red}~$conflicted%f"
  (( staged )) && p+=" %F{green}+$staged%f"
  (( unstaged )) && p+=" %F{yellow}!$unstaged%f"
  (( untracked )) && p+=" %F{blue}?$untracked%f"

  DOOM_GIT_status="$p%f"
}

doom_git() {
  [[ -n $DOOM_GIT_status ]] || return

  doom_segment GIT "$DOOM_GIT_status"
}
