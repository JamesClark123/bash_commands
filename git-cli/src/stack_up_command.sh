children=($(get_child_hashes_for_ref HEAD))

if [[ ${#children[@]} -eq 0 ]]; then
    echo "Already at the top of the stack"
    exit 0
fi

target=$(choose_commit "Select the commit to move up to" "${children[@]}") || exit 1

checkout_branch_or_ref "$target"
