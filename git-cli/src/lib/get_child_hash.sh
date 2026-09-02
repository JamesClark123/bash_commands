# Extracts the first child hash (second token) from a "<parent> <child...>"
# hash string. Joins all args with spaces so unquoted call sites still work.
get_child_hash () {
    echo "$*" | cut -d " " -f 2
}
