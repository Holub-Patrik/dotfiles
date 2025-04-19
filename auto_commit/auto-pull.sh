#!/bin/bash

git_repos=("$HOME/neorg-notes" "$HOME/dotfiles" "$HOME/school/kiv-ph")

pull() {
	git pull
}


for repo in ${!git_repos[@]}; do
	echo -e "\033[1m\033[38;5;40mPulling: ${git_repos[$repo]}\033[0m\n"
	cd ${git_repos[$repo]}
	pull
done

for repo_loc in "$@"
do
	echo -e "\033[1m\033[38;5;40mPulling: $repo_loc\033[0m\n"
	cd "$repo_loc"
	pull
done
