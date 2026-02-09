# base packages that I use on daily basis / need for regural use

# kitty kitty-terminfo kitty-shell-integration \
sudo pacman -S base-devel git \
	zsh zsh-syntax-highlighting \
	ghostty ghostty-terminfo ghostty-shell-integration \
	clang rustup lldb odin zig python nodejs npm python-pipx uv cmake libc++ onetbb \
	neovim python-pynvim tree-sitter-cli \
	stow \
	sbctl vivaldi ncspot \
	yazi 7zip fzf eza micro bat ncdu \
	nwg-displays fuzzel quickshell hyprpaper \
	unzip

git config --global user.email "23bulohp@gmail.com"
git config --global user.name "Holub Patrik"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
