# Returns the full hash for the given branch name.
branch_hash () {
    git show-ref --verify --hash refs/heads/$1
}
