#!/usr/bin/env zsh
# Returns 0 if the current HEAD hash has an associated local branch.
current-hash-has-branch () {
    currHash=$(current-hash)
    currBranch=$(get-branch-for-ref $currHash)
    if contains $currBranch "HEAD detached at"
    then
        return 1 # Current hash does not have a branch
    else
        return 0 # It does
    fi
}
