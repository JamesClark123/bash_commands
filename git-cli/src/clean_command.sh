

git fetch --prune --prune-tags

allTargets=$(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}')

selectedTargets=$(gum choose ${allTargets[@]} --no-limit --header "Select none to delete all")
: "${selectedTargets:=${allTargets[@]}}"

git branch -D ${selectedTargets[@]}

echo "${#selectedTargets[@]} local branches deleted"
