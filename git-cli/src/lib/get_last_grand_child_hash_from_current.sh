# Same as get_last_grand_child_hash but starts from the current branch tip.
get_last_grand_child_hash_from_current () {
    get_last_grand_child_hash $(current_branch_hash)
}
