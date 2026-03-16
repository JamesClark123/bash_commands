#!/usr/bin/env zsh
# Returns the hash of the first commit on the current branch that diverged from main.
first-base-commit-off-main () {
    git log main..HEAD --pretty=format:"%h" | tail -1
}
