
branch="${args[branch]}"

if [[ -z ${args[branch]} ]]; then
  branches=($(git branch --format='%(refname:short)'))
  branch=$(gum choose "${branches[@]}" --header "Select a branch to update")
fi

git checkout "$branch"
git fetch --prune
git pull

if [[ ${args[--stay]} == 0 || -z ${args[--stay]} ]]; then
  git checkout -
fi
