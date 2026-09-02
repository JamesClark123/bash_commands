# Returns the local branches whose history contains the given ref, excluding
# main and master (one per line).
get_stack_branches_for_ref () {
    git branch --contains "$1" --format='%(refname:short)' | grep -v '^(' | grep -v -x -e 'main' -e 'master'
}
