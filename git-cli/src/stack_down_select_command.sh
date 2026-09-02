branches=($(get_upstream_branches_for_ref HEAD))

if [[ ${#branches[@]} -eq 0 ]]; then
    echo "No branches between the current commit and the merge base with main"
    exit 0
fi

target=$(choose_branch "Select the upstream branch to check out" "${branches[@]}") || exit 1

git checkout "$target"
