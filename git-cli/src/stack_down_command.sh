parents=($(git rev-list --parents -n 1 HEAD))
parents=("${parents[@]:1}")

if [[ ${#parents[@]} -eq 0 ]]; then
    echo "Already at the bottom of the stack"
    exit 0
fi

target=$(choose_commit "Select the commit to move down to" "${parents[@]}") || exit 1

checkout_branch_or_ref "$target"
