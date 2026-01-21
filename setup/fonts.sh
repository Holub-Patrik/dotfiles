#!/bin/bash

sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji
sudo pacman -S ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common

# Define paths
FONT_CONFIG_DIR="$HOME/.config/fontconfig"
FONT_CONFIG_FILE="$FONT_CONFIG_DIR/fonts.conf"

# Create directory if it doesn't exist
mkdir -p "$FONT_CONFIG_DIR"

# Backup existing config if present
if [ -f "$FONT_CONFIG_FILE" ]; then
    echo "Backing up existing fonts.conf to fonts.conf.bak"
    mv "$FONT_CONFIG_FILE" "$FONT_CONFIG_FILE.bak"
fi

# Write the new configuration
echo "Generating $FONT_CONFIG_FILE..."
cat > "$FONT_CONFIG_FILE" <<EOF
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
<fontconfig>
  <alias>
    <family>Monaspace Neon NF</family>
    <prefer>
      <family>Monaspace Neon NF</family>
      <family>Noto Sans CJK JP</family>
      <family>Noto Sans CJK KR</family>
      <family>Noto Sans CJK SC</family>
      <family>Noto Sans CJK TC</family>
    </prefer>
  </alias>
</fontconfig>
EOF

# Update font cache
echo "Updating font cache..."
fc-cache -f

echo "Done. Noto Sans CJK JP is now the preferred fallback for Monaspace Neon NF."
