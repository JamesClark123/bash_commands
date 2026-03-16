#!/usr/bin/env zsh
# Same as get-last-grand-child-hash but starts from the current branch tip.
get-last-grand-child-hash-from-current () {
    get-last-grand-child-hash $(current-branch-hash)
}
