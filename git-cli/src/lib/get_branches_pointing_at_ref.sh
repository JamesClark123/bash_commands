# Returns the local branch names whose tip is exactly the given ref.
get_branches_pointing_at_ref () {
    git for-each-ref refs/heads --points-at "$1" --format='%(refname:short)'
}
