#!/usr/bin/env zsh
# Returns the single most relevant branch name for a given ref,
# excluding child branches when possible.
get-branch-for-ref () {
    ref=$(get-parent-child-hash $1)
    if (has-child $ref)
    then
        childHash=$(get-child-hash $ref)
        git branch --contains $1 --no-contains $childHash | tail -n 1 | sed 's/*/ /'  | xargs
    else
        git branch --contains $1 | tail -n 1 | sed 's/*/ /'  | xargs
    fi
}
