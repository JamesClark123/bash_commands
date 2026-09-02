# Prompts the user to choose one of the given branch names, each shown as
# "<branch> <short-hash> <subject>". Auto-selects when only one is given.
# Usage: choose_branch <header> <branch>...
# Echoes the chosen branch name; returns 1 if the prompt is cancelled.
choose_branch () {
    local header=$1
    shift

    if [[ $# -eq 1 ]]; then
        echo "$1"
        return 0
    fi

    local branch chosen options=()
    for branch in "$@"; do
        options+=("$branch $(git log -1 --format='%h %s' "$branch")")
    done

    chosen=$(gum choose "${options[@]}" --header "$header" --limit 1) || return 1
    [[ -z "$chosen" ]] && return 1

    echo "$chosen" | awk '{print $1}'
}
