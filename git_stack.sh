#
# Git Stack Functions
# Tools for managing stacked branches — navigating, rebasing, and force-pushing
# a chain of branches built on top of each other.
#

# List branches matching one or more glob patterns.
gbl () {
    local str=()
    for var in $*;
        str+=("*$var*");

    OUTPUT="$(script -q /dev/null git branch -l ${str[@]})"
    echo "$OUTPUT"
}

# Rebase the current branch onto $1, moving only the tip commit (HEAD~).
grt () {
    echo "$(git rebase --onto $1 HEAD~ $(git branch --show-current | tail -n 1))"
}

# Rebase onto $1 and update all stacked branch refs automatically.
grs () {
    git rebase $1 --update-refs
}

# Internal: recursively force-pushes each branch in the stack starting from HEAD.
# Walks the parent-child chain until no more children are found.
_gpfs () {
    if (currentHashHasBranch && currentHashHasRemoteBranch)
    then
        branchName=$(getBranchForRef $(currentHash))
        git checkout -q $branchName
        echo "Force pushing $branchName"
        git push -f -q
    else
        echo "Skipping $(currentHash)"
    fi

    parentChildHash=$(getParentChildHash $(currentHash))

    if (hasChild $parentChildHash)
    then
        childHash=$(getChildHash $parentChildHash)
        echo "Checking out $childHash"
        git checkout -q $childHash
        _gpfs
    else
        echo "Done force pushing stack"
    fi
}

# Force-push all branches in the current stack, then return to the original branch.
gpfs () {
    firstCommit=$(firstBaseCommitOffMain)
    currentBranch=$(currentBranchName)
    gco $firstCommit
    _gpfs
    gco $currentBranch
}

# Amend the current commit, then rebase the entire stack on top of it.
# Leaves you back on the branch you started from.
gcars () {
    lastRef=$(getLastGrandChildHashFromCurrent)
    lastBranch=$(getBranchForRef $lastRef)
    echo "Amending commit..."
    gca
    baseRef=$(currentBranchHash)
    baseBranchName=$(currentBranchName)
    echo "Rebasing stack..."
    gco $lastBranch
    grs $baseBranchName
    gco $baseBranchName
}

# Navigate to the tip (end) of the current stack.
gtse () {
    lastRef=$(getLastGrandChildHashFromCurrent)
    lastBranch=$(getBranchForRef $lastRef)
    gco $lastBranch
}

# Navigate to the start (base) of the current stack — the first branch off main.
gtss () {
    firstCommit=$(firstBaseCommitOffMain)
    firstBranch=$(getBranchForRef $firstCommit)
    gco $firstBranch
}
