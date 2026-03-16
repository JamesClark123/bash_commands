
branch="${args[branch]}"

if [[ -z "$branch" ]]; then
  branches=($(git branch --format='%(refname:short)'))
  branch=$(gum choose "${branches[@]}" --header "Select a branch to update")
fi

git checkout "$branch"
git fetch --prune
git pull
git checkout -
