
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

git commit "${custom_args[@]}" "${other_args[@]}"
