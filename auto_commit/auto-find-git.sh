#!/bin/sh
ignore=()
ignore+=("$HOME/Arch-Hyprland/")
ignore+=("$HOME/Odin/")

locs=$(find ~/ -type d -name ".git" 2>/dev/null | 
	grep -v ".*/\..*\.git" | 
	grep -v "find.*" | 
	sed -e 's/.git//')

filtered_locs=()
for should_ignore in "${ignore[@]}" 
do
	for loc in "${locs[@]}"
	do
		filtered_locs+=($(grep "$should_ignore" -v <<< "$loc"))
	done
	locs=("${filtered_locs[@]}")
	filtered_locs=()
done

for loc in "${locs[@]}"
do
	echo -n -e "\033[38;5;40mChecking: ${loc}\033[0m"
	cd "$loc"
	git fetch --quiet --no-tags --recurse-submodules=no

  LOCAL=$(git rev-parse @)
	REMOTE=$(git rev-parse @{u})
	BASE=$(git merge-base @ @{u})

	uncommited_changes=$(git status --porcelain)

	if [ -n "${uncommited_changes}" ]; then 
		echo -n -e "\n\033[38;5;135mWorking tree not clean. Commit and push? [y|N]: \033[0m"
		read -p "" interaction
		interaction=${interaction:-n}
		if [ "$interaction" = "y" ]; then
			git add ./
			read -p "Please enter commit msg: " commit_msg
			git commit -m "$commit_msg"
			git push
		fi
	elif [ "$LOCAL" = "$REMOTE" ]; then
		echo " | Up to date"
	elif [ "$LOCAL" = "$BASE" ]; then
		echo -n -e "\n\033[38;5;135mPull: ${loc}? [y|N]:\033[0m "
		read -p "" interaction
		interaction=${interaction:-n}
		if [ "$interaction" = "y" ]; then
			git pull
		fi
	elif [ "$REMOTE" = "$BASE" ]; then
		echo -n -e "\n\033[38;5;135mPush: ${loc}? [y|N]:\033[0m "
		read -p "" interaction
		interaction=${interaction:-n}
		if [ "$interaction" = "y" ]; then
			git push
		fi
	else
		echo -e " | \033[38;5;196mDiverged\033[0m"
	fi
done
