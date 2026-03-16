#!/usr/bin/env zsh
# Recursively walks the commit chain from $1, returning the last descendant hash.
get-last-grand-child-hash () {
    ref=$1
    parentChildHash=$(get-parent-child-hash $1)
    if (has-child $parentChildHash);
    then
        newRef=$(get-child-hash $parentChildHash)
        echo $(get-last-grand-child-hash $newRef)
    else
        echo $1
    fi
}
