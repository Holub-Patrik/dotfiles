#!/bin/bash

git_repos=("$HOME/neorg-notes" "$HOME/dotfiles" "$HOME/school/kiv-ph")

pull() {
	git pull
}


for repo in ${!git_repos[@]}; do
	cd ${git_repos[$repo]}
	if output=$(git status --porcelain) && ! [ -z "$output" ]; then
		echo -e "\033[1m\033[38;5;40mPulling: ${git_repos[$repo]}\033[0m\n"
		pull
	fi
done

for repo_loc in "$@"
do
	cd "$repo_loc"
	if output=$(git status --porcelain) && ! [ -z "$output" ]; then
		echo -e "\033[1m\033[38;5;40mPulling: $repo_loc\033[0m\n"
		pull
	fi
done
