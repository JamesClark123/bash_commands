#!/usr/bin/env zsh
# Returns the name of the currently checked-out branch.
current-branch-name () {
    git branch --show-current | tail -n 1
}
