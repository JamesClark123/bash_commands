# Returns the hash of the first commit on the current branch that diverged from main.
first_base_commit_off_main () {
    git log main..HEAD --pretty=format:"%h" | tail -1
}
