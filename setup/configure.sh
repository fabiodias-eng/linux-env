#!/bin/bash

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DOTFILES_DIR="$ROOT_DIR/dotfiles"

source "$ROOT_DIR/setup/utils.sh"

# Create direcoties"
header_msg "Creating directories"
mkdir -p $HOME/.config
mkdir -p $HOME/.local
mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/lib
mkdir -p $HOME/.local/share
mkdir -p $HOME/.local/state
mkdir -p $HOME/.librewolf

# Copy dotfiles to the user home directory
header_msg "Creating symlinks"
link "$DOTFILES_DIR/.config/dunst" "$HOME/.config/dunst"
link "$DOTFILES_DIR/.config/gtk-3.0" "$HOME/.config/gtk-3.0"
link "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
link "$DOTFILES_DIR/.config/tmux" "$HOME/.config/tmux"
link "$DOTFILES_DIR/.config/volumeicon" "$HOME/.config/volumeicon"
link "$DOTFILES_DIR/.librewolf/Custom Themes" "$HOME/.librewolf/Custom Themes"
link "$DOTFILES_DIR/.local/bin/custom-notifier" "$HOME/.local/bin/custom-notifier"
link "$DOTFILES_DIR/.local/bin/volume-control" "$HOME/.local/bin/volume-control"
link "$DOTFILES_DIR/.local/bin/dunst-theme" "$HOME/.local/bin/dunst-theme"
link "$DOTFILES_DIR/.local/bin/dwmblocks-theme" "$HOME/.local/bin/dwmblocks-theme"
link "$DOTFILES_DIR/.local/share/fonts" "$HOME/.local/share/fonts"
link "$DOTFILES_DIR/.Xresources" "$HOME/.Xresources"
link "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
link "$DOTFILES_DIR/.profile" "$HOME/.profile"
link "$DOTFILES_DIR/.xinitrc" "$HOME/.xinitrc"

if command -v snap >/dev/null 2>&1; then
	sudo snap remove --purge $(snap list | awk 'NR>1 {Print $1}') 2>/dev/null || true
	sudo apt purge -y snapd
	sudo rm -rf /snap /var/snap /var/lib/snapd $HOME/snap
	success_msg "Snap removed"
else
	normal_msg "Snap not installed"
fi

if command -v flatpack >/dev/null 2>&1; then
	sudo flatpack uninstall --all -y 	
	sudo apt purge -y flatpack
	sudo rm -rf $HOME/.local/share/flatpack /var/lib/flatpack
	success_msg "Flatpack removed"

else
	normal_msg "Flatpack not installed"
fi

# Create video group
header_msg "Adding video to groups"
sudo usermod -aG video $USER

# Configure timezone and clock
header_msg "Setting up timezone and clock"
ZONE=$(curl -fsS https://ipinfo.io/timezone 2>&1)
if [ -n "$ZONE" ]; then
	sudo ln -sfn "/usr/share/zoneinfo/$ZONE" "/etc/localtime"
	sudo timedatectl set-timezone "$ZONE"
	sudo timedatectl set-ntp true
	success_msg "Timezone configured to $ZONE"
else
    error_msg "Failed to setup up clock timezone"
    exit 1
fi

# Configure network interface to NetworkManager
header_msg "Setting up the netplan for network interface"
normal_msg "Cleaning up old Netplan configuration"
sudo rm -rf /etc/netplan/*
normal_msg "Adding new Netplan configuration"
sudo tee /etc/netplan/01-network-manager.yaml > /dev/null \
<<EOF
network:
  version: 2
  renderer: NetworkManager
EOF
normal_msg "Netplan file stored at: /etc/netplan/01-network-manager.yaml"
sudo netplan generate
sudo netplan apply
sleep 5
normal_msg "Disabling unused systemd-networkd services"
sudo systemctl disable systemd-networkd.service
sudo systemctl disable systemd-networkd.socket
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd.service
sudo systemctl mask systemd-networkd.socket
sudo systemctl mask systemd-networkd-wait-online.service
sudo systemctl daemon-reload
