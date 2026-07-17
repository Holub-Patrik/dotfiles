# base packages that I use on daily basis / need for regural use

sudo pacman -S base-devel git \
	hyprland hyprpolkitagent \
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

# noctalia and noctalia greeter
paru -S noctalia-git
paru -S noctalia-greeter-git

# setup noctalia greeter
sudo mkdir -p /etc/greetd

sudo tee /etc/greetd/config.toml >/dev/null <<'EOF'
[terminal]
vt = 1

[default_session]
command = "/usr/bin/noctalia-greeter-session"
user = "greeter"
EOF

# termchoose
kitten desktop-ui enable-portal
