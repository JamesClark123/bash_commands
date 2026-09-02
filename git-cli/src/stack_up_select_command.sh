branches=($(get_downstream_branches_for_ref HEAD))

if [[ ${#branches[@]} -eq 0 ]]; then
    echo "No branches downstream of the current commit"
    exit 0
fi

target=$(choose_branch "Select the downstream branch to check out" "${branches[@]}") || exit 1

git checkout "$target"
