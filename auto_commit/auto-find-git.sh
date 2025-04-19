pull() {
	git pull
}

push() {
	git add ./
	read -p "Please enter a commit msg: " msg
	msg=${msg:- "Holub Patrik auto-commit"}
	git commit -m "$msg"
	git push
}

# some comment

for loc in $(find ~/ -type d -name ".git" 2>/dev/null | 
	grep -v ".*/\..*\.git" | 
	grep -v "find.*" | 
	sed -e 's/.git//'); do
	
	echo -e "\033[38;5;40mChecking: ${loc}\033[0m"
	cd "$loc"
	
	if output=$(git status --porcelain) && ! [ -z "$output" ]; then
		echo -e "\033[38;5;220mWorking Tree isn't clean\033[0m\n"
		git status

		echo -n -e "\033[38;5;135mInteract with: ${loc}? [y|n]:\033[0m "
		read -p "" interaction
		interaction=${interaction:-n}

		if [ "$interaction" = "y" ]; then

			read -p "[P]ull/[p]ush? " command
			command=${command:-P}

			if [ "$command" = "P" ]; then
				pull

			elif [ "$command" = "p" ]; then
				push

			else
				echo "Invalid command"
			fi

		elif [ "$interaction" = "n" ]; then
			echo "continuing..."
		else
			echo "Invalid interaction"
		fi

	fi
		
done
