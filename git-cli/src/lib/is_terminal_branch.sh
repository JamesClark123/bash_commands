# Returns 0 if the given branch is a terminal (leaf) branch of its stack,
# i.e. no other local branch's tip is a descendant of its tip.
is_terminal_branch () {
    local tip other
    tip=$(branch_hash "$1")

    for other in $(git branch --contains "$tip" --format='%(refname:short)' | grep -v '^('); do
        [[ "$other" == "$1" ]] && continue
        [[ "$(branch_hash "$other")" != "$tip" ]] && return 1
    done

    return 0
}
