# Same as get_parent_child_hash but for the current branch's tip.
get_current_parent_child_hash () {
    get_parent_child_hash $(current_branch_hash)
}
