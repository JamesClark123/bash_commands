# Returns the single most relevant branch name for a given ref,
# excluding child branches when possible.
get_branch_for_ref () {
    ref=$(get_parent_child_hash $1)
    if (has_child $ref)
    then
        childHash=$(get_child_hash $ref)
        git branch --contains $1 --no-contains $childHash | tail -n 1 | sed 's/*/ /'  | xargs
    else
        git branch --contains $1 | tail -n 1 | sed 's/*/ /'  | xargs
    fi
}
