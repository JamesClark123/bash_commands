# Prompts the user to choose one of the given commit hashes, each shown as
# "<short-hash> <subject> [branches]". Auto-selects when only one is given.
# Usage: choose_commit <header> <hash>...
# Echoes the chosen full hash; returns 1 if the prompt is cancelled.
choose_commit () {
    local header=$1
    shift

    if [[ $# -eq 1 ]]; then
        git rev-parse "$1"
        return 0
    fi

    local hash line branches chosen options=()
    for hash in "$@"; do
        line=$(git log -1 --format='%h %s' "$hash")
        branches=$(get_branches_pointing_at_ref "$hash" | paste -s -d ',' -)
        if [[ -n "$branches" ]]; then
            line="$line [$branches]"
        fi
        options+=("$line")
    done

    chosen=$(gum choose "${options[@]}" --header "$header" --limit 1) || return 1
    [[ -z "$chosen" ]] && return 1

    git rev-parse "$(echo "$chosen" | awk '{print $1}')"
}
