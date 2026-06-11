sudo pacman -S kvantum xdg-desktop-portal-gtk xsettingsd
paru -S gnome-themes-extra gnome-themes-extra-gtk2 phinger-cursors
gsettings set org.gnome.desktop.interface color-sheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gkt-theme 'Adwaita-dark'
kvantummanager --set "oled-accent"

# Set system-wide default cursor theme fallback (SDDM, boot, and sandbox apps)
echo -e "[Icon Theme]\nInherits=phinger-cursors-light" | sudo tee /usr/share/icons/default/index.theme


