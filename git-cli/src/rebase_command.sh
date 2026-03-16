
custom_args=()

if [[ ${#other_custom_args[@]} -eq 0 ]]; then
    targetOptions=(main Select)
    targetMode=$(gum choose "${targetOptions[@]}" --header "Select rebase target mode" --limit 1)
    target="main"

    if [[ "$targetMode" == "Select" ]]; then
        target=$(gum filter $(get_all_local_branches) --header "Select target" --limit 1)
    fi

    custom_args+=(-i --autosquash --onto $target)

    baseModeOptions=("Merge base" HEAD~ Select)
    selectBaseMode=$(gum choose "${baseModeOptions[@]}" --header "Select base mode" --limit 1)
    base="HEAD~"

    if [[ "$selectBaseMode" == "Select" ]]; then
        baseCommits=$(git log --oneline)
        base=$(gum filter "${baseCommits[@]}" --header "Select base" --limit 1 | awk '{print $1}')
    fi

    if [[ "$selectBaseMode" == "Merge base" ]]; then
        base=$(git merge-base HEAD $target | tail -n 1)
    fi

    custom_args+=("$base")

    currentBranch=$(current_branch_name)

    custom_args+=($currentBranch)
fi

git rebase "${custom_args[@]}" "${other_args[@]}"
