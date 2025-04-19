pull() {
	git pull
}

push() {
	git add ./
	git commit -m "Holub Patrik auto-commit"
	git push
}

for loc in $(find ~/ -type d -name ".git" 2>/dev/null | 
	grep -v ".*/\..*\.git" | 
	grep -v "find.*" | 
	sed -e 's/.git//'); do

	read -p "Interact with: ${loc}? [y|n]: " interaction
	interaction=${interaction:-n}

	if [ "$interaction" = "y" ]; then
		read -p "[P]ull/[p]ush? " command
		command=${command:-P}
		if [ "$command" = "P" ]; then
			cd "$loc"
			pull
		elif [ "$command" = "p" ]; then
			cd "$loc"
			push
		else
			echo "Invalid command"
		fi

	elif [ "$interaction" = "n" ]; then
		echo "continuing..."
	else
		echo "Invalid interaction"
	fi
		
done
