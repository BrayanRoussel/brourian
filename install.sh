#!/usr/bin/env bash
set -e

echo "[1/4] Actualizando e instalando programas básicos..."
sudo apt update
sudo apt install -y xorg xinit i3 kitty polybar rofi picom feh fastfetch network-manager pipewire pipewire-audio wireplumber pavucontrol git rsync zsh

echo "[2/4] Copiando tus configuraciones..."
mkdir -p ~/.config ~/Wallpapers ~/.local/share/fonts
[ -d configs ] && cp -r configs/* ~/.config/
[ -f home/.zshrc ] && cp home/.zshrc ~/.zshrc
[ -d assets/Wallpapers ] && cp -r assets/Wallpapers/* ~/Wallpapers/
[ -d assets/fonts ] && cp -r assets/fonts/* ~/.local/share/fonts/

echo "[3/4] Generando ~/.xinitrc para iniciar i3..."
echo "exec i3" > ~/.xinitrc

echo "[4/4] Habilitando servicios..."
sudo systemctl enable NetworkManager

echo "¡Listo! Escribe 'startx' para entrar a tu escritorio."
EOF
