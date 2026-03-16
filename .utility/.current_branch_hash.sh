#!/usr/bin/env zsh
# Returns the full hash for the currently checked-out branch.
currentBranchHash () {
    branchHash $(currentBranchName)
}
