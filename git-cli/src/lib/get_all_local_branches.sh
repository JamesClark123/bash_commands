
get_all_local_branches() {
    git branch --format='%(refname:short)'
}
