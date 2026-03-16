# Given a commit hash, returns a "<hash> <child-hash>" string if a child exists.
get_parent_child_hash () {
    git rev-list --children --all | grep ^$1
}
