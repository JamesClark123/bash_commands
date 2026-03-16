#!/usr/bin/env zsh
# Returns the child hash of the current HEAD's parent-child pair.
get-current-child-hash () {
    ret="$(get-current-parent-child-hash)"
    get-child-hash $ret
}
