# Returns the full hash of HEAD.
current-hash () {
    git show-ref --hash --head --verify HEAD
}
