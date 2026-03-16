# Returns 0 if the current HEAD hash has a corresponding remote branch on origin.
current_hash_has_remote_branch () {
    currBranch=$(get_branch_for_ref $(current_hash))
    git show-ref --verify --quiet refs/remotes/origin/$currBranch
}
