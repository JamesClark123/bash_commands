
branch="${args[branch]}"

stay="${args[--stay]}"

if [[ -z ${args[branch]} ]]; then
  branches=($(git branch --format='%(refname:short)'))
  branch=$(gum choose "${branches[@]}" --header "Select a branch to update")
fi

git checkout "$branch"
git fetch --prune
git pull

if [[ "$stay" == "false" ]]; then
  git checkout -
fi
