# Returns 0 if the current HEAD hash has an associated local branch.
current_hash_has_branch () {
    currHash=$(current_hash)
    currBranch=$(get_branch_for_ref $currHash)
    if contains $currBranch "HEAD detached at"
    then
        return 1
    else
        return 0
    fi
}
