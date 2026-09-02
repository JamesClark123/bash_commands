# Returns the local branches stacked downstream of the given ref — branches
# whose tip contains the ref but is not the ref itself — nearest first,
# excluding main and master (one per line).
get_downstream_branches_for_ref () {
    local refHash branch tip
    refHash=$(git rev-parse "$1")

    for branch in $(get_stack_branches_for_ref "$refHash"); do
        tip=$(branch_hash "$branch")
        [[ "$tip" == "$refHash" ]] && continue
        echo "$(git rev-list --count "$tip") $branch"
    done | sort -n | cut -d ' ' -f 2
}
