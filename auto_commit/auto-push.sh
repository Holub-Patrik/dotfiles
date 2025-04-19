#!/bin/bash

git_repos=("$HOME/neorg-notes" "$HOME/dotfiles" "$HOME/school/kiv-ph")

for repo in ${!git_repos[@]}; do
	echo -e "\033[1m\033[38;5;40mPushing: ${git_repos[$repo]}\033[0m\n"
	cd ${git_repos[$repo]}
	git add ./
	git commit -m "new commit from auto-commit"
	git push
done
