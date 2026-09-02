# Returns the direct child commit hashes of the given ref that are reachable
# from local branches (one full hash per line).
get_child_hashes_for_ref () {
    git rev-list --children --branches | awk -v ref="$(git rev-parse "$1")" '$1 == ref { for (i = 2; i <= NF; i++) print $i }'
}
