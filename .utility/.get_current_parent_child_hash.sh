#!/usr/bin/env zsh
# Same as getParentChildHash but for the current branch's tip.
get-current-parent-child-hash () {
    getParentChildHash $(currentBranchHash)
}
