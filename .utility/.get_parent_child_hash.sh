#!/usr/bin/env zsh
# Given a commit hash, returns a "<hash> <child-hash>" string if a child exists.
get-parent-child-hash () {
    git rev-list --children --all | grep ^$1 # The ref of the branch we're looking for
}
