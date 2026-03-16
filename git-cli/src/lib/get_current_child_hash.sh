# Returns the child hash of the current HEAD's parent-child pair.
get_current_child_hash () {
    ret="$(get_current_parent_child_hash)"
    get_child_hash $ret
}
