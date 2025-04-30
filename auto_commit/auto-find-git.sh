#!/bin/bash
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

	remote_head=$(git rev-parse @)
  local_head=$(git rev-parse @{u})
	base_head=($(git rev-parse @ @{u}))

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
	elif [ "$local_head" = "$remote_head" ]; then
		echo " | Up to date"
	elif [ "$local_head" = "${base_head[0]}" ]; then
		echo -n -e "\n\033[38;5;135mPull: ${loc}? [y|N]:\033[0m "
		read -p "" interaction
		interaction=${interaction:-n}
		if [ "$interaction" = "y" ]; then
			git pull
		fi
	elif [ "$local_head" = "${base_head[1]}" ]; then
		echo -n -e "\n\033[38;5;135mPush: ${loc}? [y|N]:\033[0m "
		read -p "" interaction
		interaction=${interaction:-n}
		if [ "$interaction" = "y" ]; then
			git push
		fi
	else
		echo -e "\033[38;5;196mDiverged\033[0m"
	fi
done

#testing another script
