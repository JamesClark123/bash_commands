# Returns 0 if the given "<parent> <child...>" hash string has a child hash.
# Joins all args with spaces so unquoted call sites still work.
has_child () {
    [[ "$*" == *" "* ]]
}
