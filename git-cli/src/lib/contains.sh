# Returns 0 if $2 is a substring of $1, else 1.
contains () {
    local string="$1"
    local substring="$2"

    if [ "${string#*"$substring"}" != "$string" ]; then
        return 0
    else
        return 1
    fi
}
