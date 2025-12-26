sudo pacman -Syy && sudo pacman -Syu
sudo pacman -S sbctl
echo "Please configure secure boot as soon as possible\nNOTE:Be careful if you have Limine"
sudo pacman -S git neovim clang go zsh zig zsh-syntax-highliting stow kitty nodejs npm
git config --global user.email "23bulohp@gmail.com"
git config --global user.name "Holub Patrik"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
sh <(curl -L https://raw.githubusercontent.com/JaKooLit/Arch-Hyprland/main/auto-install.sh)
