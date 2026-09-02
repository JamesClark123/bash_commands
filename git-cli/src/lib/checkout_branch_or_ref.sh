# Checks out the local branch pointing at the given ref when one exists,
# otherwise checks out the ref directly (detached HEAD).
checkout_branch_or_ref () {
    local branch
    branch=$(get_branches_pointing_at_ref "$1" | head -n 1)

    if [[ -n "$branch" ]]; then
        git checkout "$branch"
    else
        git checkout "$1"
    fi
}
