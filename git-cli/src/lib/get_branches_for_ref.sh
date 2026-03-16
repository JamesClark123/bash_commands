# Returns all branch names that contain the given ref.
get_branches_for_ref () {
    git branch --contains $1 | tail -n 1 | sed 's/*/ /' | xargs
}
