custom_args=()

if [[ ${#other_args[@]} -eq 0 ]]; then

    commitType=$(gum choose "Amend" "Amend no edit" "Fixup" "Squash" --header "Select commit type" --limit 1)

    if [[ "$commitType" == "Amend" ]]; then
        custom_args+=(--amend)
    elif [[ "$commitType" == "Amend no edit" ]]; then
        custom_args+=(--amend --no-edit)
    elif [[ "$commitType" == "Fixup" ]]; then
        custom_args+=(--fixup HEAD)
        custom_args+=(-m $(gum input --width 50 --placeholder "Enter commit message"))
    elif [[ "$commitType" == "Squash" ]]; then
        custom_args+=(--squash HEAD)
        custom_args+=(-m $(gum input --width 50 --placeholder "Enter commit message"))
    fi

fi

baseBranch=$(current_branch_name)

if [[ -z "$baseBranch" ]]; then
    echo "Cannot update a stack from a detached HEAD"
    exit 1
fi

if [[ "$baseBranch" == "main" || "$baseBranch" == "master" ]]; then
    echo "Refusing to restack from $baseBranch; use \`g c\` to commit here"
    exit 1
fi

oldBase=$(current_hash)

# Capture the stack layout before committing, while the old commit is still
# the tip of the current branch.
stackBranches=($(get_stack_branches_for_ref "$oldBase" | grep -v -x "$baseBranch"))
terminalBranches=($(get_terminal_branches_for_ref "$oldBase" | grep -v -x "$baseBranch"))

git commit "${custom_args[@]}" "${other_args[@]}" || exit $?

newBase=$(current_branch_hash)

if [[ "$newBase" == "$oldBase" ]]; then
    echo "No new commit was created; nothing to restack"
    exit 0
fi

if [[ ${#terminalBranches[@]} -eq 0 ]]; then
    echo "No branches are stacked on this commit; nothing to restack"
    exit 0
fi

# Map of rewritten commits (old hash -> new hash), seeded with the replaced
# commit. Extended after every rebase so forked stacks rebase from their moved
# fork point instead of duplicating the shared commits.
mapOld=("$oldBase")
mapNew=("$newBase")

for terminal in "${terminalBranches[@]}"; do
    terminalTip=$(branch_hash "$terminal")

    # Rebase from the closest already-rewritten ancestor of this branch.
    rebaseFrom=""
    rebaseOnto=""
    bestDepth=-1
    for i in $(seq 0 $((${#mapOld[@]} - 1))); do
        if git merge-base --is-ancestor "${mapOld[$i]}" "$terminalTip"; then
            depth=$(git rev-list --count "${mapOld[$i]}")
            if [[ $depth -gt $bestDepth ]]; then
                bestDepth=$depth
                rebaseFrom="${mapOld[$i]}"
                rebaseOnto="${mapNew[$i]}"
            fi
        fi
    done

    if [[ -z "$rebaseFrom" ]]; then
        echo "Skipping $terminal (no rewritten ancestor found)"
        continue
    fi

    preTips=()
    for branch in "${stackBranches[@]}"; do
        preTips+=("$(branch_hash "$branch")")
    done

    echo "Rebasing $terminal onto $(git rev-parse --short "$rebaseOnto")"
    if ! git rebase --update-refs --onto "$rebaseOnto" "$rebaseFrom" "$terminal"; then
        echo "Rebase of $terminal failed. Resolve the conflicts and finish with"
        echo "\`g r --continue\`, then restack any remaining branches manually."
        exit 1
    fi

    # Record every branch ref the rebase moved so later forks rebase from the
    # rewritten commits.
    for i in $(seq 0 $((${#stackBranches[@]} - 1))); do
        postTip=$(branch_hash "${stackBranches[$i]}")
        if [[ "$postTip" != "${preTips[$i]}" ]]; then
            mapOld+=("${preTips[$i]}")
            mapNew+=("$postTip")
        fi
    done
done

git checkout -q "$baseBranch"
echo "Restacked ${#terminalBranches[@]} branch(es) onto $(git rev-parse --short "$newBase")"
