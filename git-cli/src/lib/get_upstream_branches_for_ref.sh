# Returns the local branches upstream of the given ref — branches whose tip is
# a strict ancestor of the ref — nearest first, searching no farther than the
# merge base with main (or master), inclusive. Excludes main and master
# themselves (one per line).
get_upstream_branches_for_ref () {
    local refHash mainBranch mergeBase branch tip
    refHash=$(git rev-parse "$1")

    mainBranch=main
    git show-ref --verify --quiet refs/heads/main || mainBranch=master
    git show-ref --verify --quiet "refs/heads/$mainBranch" || return 1

    mergeBase=$(git merge-base "$refHash" "$mainBranch") || return 1

    for branch in $(git branch --format='%(refname:short)' | grep -v '^(' | grep -v -x -e 'main' -e 'master'); do
        tip=$(branch_hash "$branch")
        [[ "$tip" == "$refHash" ]] && continue
        git merge-base --is-ancestor "$tip" "$refHash" || continue
        git merge-base --is-ancestor "$mergeBase" "$tip" || continue
        echo "$(git rev-list --count "$tip") $branch"
    done | sort -rn | cut -d ' ' -f 2
}
