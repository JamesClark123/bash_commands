# Returns the full hash of HEAD.
current_hash () {
    git show-ref --hash --head --verify HEAD
}
