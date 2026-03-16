#!/usr/bin/env zsh
#
# Git Ref & Branch Helper Functions
# Low-level helpers for resolving branch names, commit hashes,
# and parent-child relationships in the git DAG.
#


source "$BASH_COMMANDS_DIR/.utility/.current_branch_name.sh"
source "$BASH_COMMANDS_DIR/.utility/.current_hash.sh"
source "$BASH_COMMANDS_DIR/.utility/.branch_hash.sh"
source "$BASH_COMMANDS_DIR/.utility/.current_branch_hash.sh"
source "$BASH_COMMANDS_DIR/.utility/.get_parent_child_hash.sh"
source "$BASH_COMMANDS_DIR/.utility/.get_current_parent_child_hash.sh"
source "$BASH_COMMANDS_DIR/.utility/.get-branches-for-ref.sh"
source "$BASH_COMMANDS_DIR/.utility/.get-branch-for-ref.sh"
source "$BASH_COMMANDS_DIR/.utility/.current-hash-has-branch.sh"
source "$BASH_COMMANDS_DIR/.utility/.current-hash-has-remote-branch.sh"
source "$BASH_COMMANDS_DIR/.utility/.get-current-child-hash.sh"
source "$BASH_COMMANDS_DIR/.utility/.get-last-grand-child-hash.sh"
source "$BASH_COMMANDS_DIR/.utility/.get-last-grand-child-hash-from-current.sh"
source "$BASH_COMMANDS_DIR/.utility/.first-base-commit-off-main.sh"
