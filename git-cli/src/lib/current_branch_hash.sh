# Returns the full hash for the currently checked-out branch.
current_branch_hash () {
    branch_hash $(current_branch_name)
}
