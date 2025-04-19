#!/bin/bash

git_repos=("$HOME/neorg-notes" "$HOME/dotfiles" "$HOME/school/kiv-ph")

push() {
	git add ./
	git commit -m "new commit from bash-script"
	git push
}


for repo in ${!git_repos[@]}; do
	echo -e "\033[1m\033[38;5;40mPushing: ${git_repos[$repo]}\033[0m\n"
	cd ${git_repos[$repo]}
	push
done

for repo_loc in "$@"
do
	echo -e "\033[1m\033[38;5;40mPushing: $repo_loc\033[0m\n"
	cd "$repo_loc"
	push
done
