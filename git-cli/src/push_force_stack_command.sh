branches=($(get_stack_branches_for_ref HEAD))

if [[ ${#branches[@]} -eq 0 ]]; then
    echo "No branches found at or above the current commit"
    exit 0
fi

pushed=0
for branch in "${branches[@]}"; do
    if git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
        echo "Force pushing $branch"
        git push --force origin "$branch" || exit $?
        pushed=$((pushed + 1))
    else
        echo "Skipping $branch (no origin/$branch to update)"
    fi
done

echo "Done force pushing stack ($pushed branch(es) pushed)"
