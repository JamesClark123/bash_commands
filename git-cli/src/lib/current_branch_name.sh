# Returns the name of the currently checked-out branch.
current_branch_name () {
    git branch --show-current | tail -n 1
}
