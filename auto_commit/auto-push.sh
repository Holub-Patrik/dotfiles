#!/bin/bash

git_repos=("$HOME/neorg-notes" "$HOME/dotfiles" "$HOME/school/kiv-ph")

for repo in ${!git_repos[@]}; do
	echo "Pushing: ${git_repos[$repo]}"
	cd ${git_repos[$repo]}
	git add ./
	git commit -m "new commit from auto-commit"
	git push
done
