#!/usr/bin/env zsh
# Returns all branch names that contain the given ref.
get-branches-for-ref () {
    git branch --contains $1 | tail -n 1 | sed 's/*/ /' | xargs
}
