#
# Gitstatus
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

DOOM_GIT_SHOW="${DOOM_GIT_SHOW=true}"
DOOM_GIT_PREFIX="${DOOM_GIT_PREFIX=""}"
DOOM_GIT_SUFFIX="${DOOM_GIT_SUFFIX=""}"
DOOM_GIT_COLOR="${DOOM_GIT_COLOR="yellow"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# git prompt structure 'master ⇣42⇡42 ⇠42⇢42 *42 merge ~42 +42 !42 ?42'
doom_gitstatus() {
    [[ $DOOM_GIT_SHOW == true ]] || return
    gitstatus_query 'MY' || return 1  # error
    [[ $VCS_STATUS_RESULT == 'ok-sync' ]] || return 0  # not a git repo

    local p
    local where  # branch name, tag or commit

    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
        where=$VCS_STATUS_LOCAL_BRANCH
    elif [[ -n $VCS_STATUS_TAG ]]; then
        p+='%f#'
        where=$VCS_STATUS_TAG
    else
        p+='%f@'
        where=${VCS_STATUS_COMMIT[1,8]}
    fi

    (( $#where > 32 )) && where[13,-13]="…"  # truncate long branch names and tags
    p+="%F{green}${where//\%/%%}"             # escape %

    # ⇣42 if behind the remote.
    (( VCS_STATUS_COMMITS_BEHIND )) && p+=" %F{blue}⇣${VCS_STATUS_COMMITS_BEHIND}%f"
    # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
    (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && p+=" "
    (( VCS_STATUS_COMMITS_AHEAD  )) && p+="%F{green}⇡${VCS_STATUS_COMMITS_AHEAD}%f"
    # ⇠42 if behind the push remote.
    (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" %F{yellow}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}%f"
    (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" "
    # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
    (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && p+="%F{green}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}%f"
    # *42 if have stashes.
    (( VCS_STATUS_STASHES        )) && p+=" %F{cyan}*${VCS_STATUS_STASHES}%f"
    # 'merge' if the repo is in an unusual state.
    [[ -n $VCS_STATUS_ACTION     ]] && p+=" %F{red}${VCS_STATUS_ACTION}%f"
    # ~42 if have merge conflicts.
    (( VCS_STATUS_NUM_CONFLICTED )) && p+=" %F{red}~${VCS_STATUS_NUM_CONFLICTED}%f"
    # +42 if have staged changes.
    (( VCS_STATUS_NUM_STAGED     )) && p+=" %F{green}+${VCS_STATUS_NUM_STAGED}%f"
    # !42 if have unstaged changes.
    (( VCS_STATUS_NUM_UNSTAGED   )) && p+=" %F{yellow}!${VCS_STATUS_NUM_UNSTAGED}%f"
    # ?42 if have untracked files. It's really a question mark, your font isn't broken.
    (( VCS_STATUS_NUM_UNTRACKED  )) && p+=" %F{blue}?${VCS_STATUS_NUM_UNTRACKED}%f"

    echo \
        "$DOOM_GIT_PREFIX" \
        "$p" \
        "$DOOM_GIT_SUFFIX%f"
}
