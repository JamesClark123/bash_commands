
flags=()

if [[ ${args[--graph]} == 1 ]]; then
  flags+=(--graph --pretty=oneline --abbrev-commit --decorate)
fi

git log "${flags[@]}" "${other_args[@]}"
