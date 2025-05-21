#!/bin/bash
bin_folder="build"

clean () {
	rm -rf "$bin_folder"
	rm compile_commands.json
}

build() {
	if [ ! -d "$bin_folder" ]; then
		mkdir build
	fi

	if [ ! -d "$bin_folder/CMakeFiles/" ]; then
		read -p 'C++ compiler to use (CXX|clang++): ' cxx
		# default to env var if set, otherwise clang++
		cxx=${cxx:-$CXX}
		cxx=${cxx:-clang++}
		read -p 'C compiler to use (CC|clang): ' cc
		#default to env var if set, otherwise clang++
		cc=${cc:-$CC}
		cc=${cc:-clang}
		read -p 'Build type (Release): ' bd_type
		bd_type=${bd_type:-Release}

		cd "$bin_folder"
		cmake -DCMAKE_BUILD_TYPE=$bd_type\
			-DCMAKE_CXX_COMPILER=$cxx\
			-DCMAKE_C_COMPILER=$cc\
			-DCMAKE_EXPORT_COMPILE_COMMANDS=ON\
			..
		cd ..
		ln -sf "$bin_folder"/compile_commands.json compile_commands.json
	fi

	make -C $bin_folder
}

run() {
	./"$bin_folder"/"$1" ${@:2}
}

for char in $(echo $1 | sed -e 's/\(.\)/\1\n/g'); do
	if [ "$char" = "c" ]; then
		clean
	fi

	if [ "$char" = "b" ]; then
		build
		echo ""
	fi

	if [ "$char" = "r" ]; then
		if [ ! -f "$bin_folder/$2" ]; then
			build
		fi
		
		run ${@:2}
	 fi
done

if [ "$1" = "h" ]; then
	echo "./build.sh <what to do> <folder to use>"
	echo "<what to do>"
	echo "b = build"
	echo "r = run"
	echo "br | rb = build & run"
	echo "c = clean"
	echo "<folder to use>"
	echo "data/<folder to use>/[mereni.csv & stanice.csv]"
fi
