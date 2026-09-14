#!/bin/bash

set -e

source "$ROOT_DIR/setup/utils.sh"

# Enable Cups
sudo systemctl enable --now cups

if command -v snap >/dev/null 2>&1; then
    sudo snap remove --purge "$(snap list | awk 'NR>1 {Print $1}')" 2>/dev/null || true
    sudo apt purge -y snapd
    sudo rm -rf /snap /var/snap /var/lib/snapd "$HOME"/snap
    success_msg "Snap removed"
else
    normal_msg "Snap not installed"
fi

if command -v flatpack >/dev/null 2>&1; then
    sudo flatpack uninstall --all -y
    sudo apt purge -y flatpack
    sudo rm -rf "$HOME"/.local/share/flatpack /var/lib/flatpack
    success_msg "Flatpack removed"

else
    normal_msg "Flatpack not installed"
fi

# Create video group
header_msg "Adding video to groups"
sudo usermod -aG video "$USER"

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

# Set neovim as primary commit editor
header_msg "Setting Neovim as primary commit editor"
git config --global core.editor "nvim"

# Deactivate power button
header_msg "Disabling power button action"
sudo mkdir -p /etc/systemd/logind.conf.d
sudo tee /etc/systemd/logind.conf.d/50-powerkey.conf >/dev/null <<EOF
[Login]
HandlePowerKey=ignore
HandlePowerKeyLongPress=poweroff
IdleAction=ignore
EOF
sudo systemctl restart systemd-logind
success_msg "Power button action disabled"

# Configure network interface to NetworkManager
header_msg "Setting up the netplan for network interface"
normal_msg "Cleaning up old Netplan configuration"
sudo rm -rf /etc/netplan/*
normal_msg "Adding new Netplan configuration"
sudo tee /etc/netplan/01-network-manager.yaml >/dev/null \
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
sudo systemctl disable motd-news.service
sudo systemctl disable NetworkManager-wait-online.service
sudo systemctl disable apt-daily.timer apt-daily-upgrade.timer
sudo systemctl disable systemd-networkd.service
sudo systemctl disable systemd-networkd.socket
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask motd-news.service
sudo systemctl mask NetworkManager-wait-online.service
sudo systemctl mask apt-daily.service apt-daily-upgrade.service
sudo systemctl mask systemd-networkd.service
sudo systemctl mask systemd-networkd.socket
sudo systemctl mask systemd-networkd-wait-online.service
sudo systemctl daemon-reload
