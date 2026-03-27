git tag "${other_args[@]}"

if [[ ${args[--sync]} == 1 || -n ${args[--sync]} ]]; then
  git push origin --tags
fi
