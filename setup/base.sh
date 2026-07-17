# base packages that I use on daily basis / need for regural use

sudo pacman -S base-devel git \
	zsh zsh-syntax-highlighting \
	clang rustup lldb llvm odin zig python nodejs npm python-pipx uv cmake libc++ onetbb \
	kitty kitty-terminfo kitty-shell-integration \
	neovim python-pynvim tree-sitter-cli \
	stow \
	sbctl vivaldi ncspot \
	7zip fzf eza micro bat ncdu \
	nwg-displays \
	libqalculate \
	unzip man man-db \
	xorg-xrdb

git config --global user.email "23bulohp@gmail.com"
git config --global user.name "Holub Patrik"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..

paru -S noctalia-git

kitten desktop-ui enable-portal
