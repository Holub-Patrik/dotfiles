#!/bin/bash

git_repos=("$HOME/neorg-notes" "$HOME/dotfiles" "$HOME/school/kiv-ph")

push() {
	git add ./
	read -p "Please enter a commit msg: " msg
	msg=${msg:- "Holub Patrik auto-commit"}
	git commit -m "$msg"
	git push
}

for repo in ${!git_repos[@]}; do
	cd ${git_repos[$repo]}
	if output=$(git status --porcelain) && ! [ -z "$output" ]; then
		echo -e "\033[1m\033[38;5;40mPushing: ${git_repos[$repo]}\033[0m\n"
		push
	fi
done

for repo_loc in "$@"
do
	cd "$repo_loc"
	if output=$(git status --porcelain) && ! [ -z "$output" ]; then
		echo -e "\033[1m\033[38;5;40mPushing: $repo_loc\033[0m\n"
		push
	fi
done
