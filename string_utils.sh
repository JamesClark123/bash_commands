#!/usr/bin/env zsh
#
# String Utility Functions
# General-purpose string helpers used across other utilities.
#

# Returns 0 if $2 is a substring of $1, else 1.
contains() {
    string="$1"
    substring="$2"
    if [ "${string#*"$substring"}" != "$string" ]; then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

# Returns 0 if the parent-child hash string contains a child (i.e. has a space).
hasChild () {
    string=$1 # The parent child hash
    substring=" "
    contains $string $substring
}

# Extracts the child hash from a parent-child hash string (second token).
getChildHash () {
    echo $1 | cut -d " " -f 2 # The parent child hash
}
