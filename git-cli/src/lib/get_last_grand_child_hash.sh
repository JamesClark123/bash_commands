# Recursively walks the commit chain from $1, returning the last descendant hash.
get_last_grand_child_hash () {
    ref=$1
    parentChildHash=$(get_parent_child_hash $1)
    if (has_child $parentChildHash);
    then
        newRef=$(get_child_hash $parentChildHash)
        echo $(get_last_grand_child_hash $newRef)
    else
        echo $1
    fi
}
