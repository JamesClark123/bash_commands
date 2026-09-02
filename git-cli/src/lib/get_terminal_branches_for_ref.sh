# Returns the terminal (leaf) branches of the stack containing the given ref:
# branches that contain the ref and have no other branch stacked on top.
get_terminal_branches_for_ref () {
    local branch

    for branch in $(get_stack_branches_for_ref "$1"); do
        if is_terminal_branch "$branch"; then
            echo "$branch"
        fi
    done
}
