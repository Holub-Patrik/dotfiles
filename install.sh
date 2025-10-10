sudo pacman -Syy && sudo pacman -Syu
sudo pacman -S sbctl
echo "Please configure secure boot as possible\nNOTE:Be careful if you have Limine"
git config --global user.email "23bulohp@gmail.com"
git config --global user.name "Holub Patrik"
sudo pacman -S neovim clang go zig zsh-syntax-highliting zsh stow kitty nodejs npm
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
sh <(curl -L https://raw.githubusercontent.com/JaKooLit/Arch-Hyprland/main/auto-install.sh)
