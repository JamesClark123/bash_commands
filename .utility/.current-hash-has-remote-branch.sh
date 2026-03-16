#!/usr/bin/env zsh
# Returns 0 if the current HEAD hash has a corresponding remote branch on origin.
current-hash-has-remote-branch () {
    currBranch=$(get-branch-for-ref $(current-hash))
    git show-ref --verify --quiet refs/remotes/origin/$currBranch
}
