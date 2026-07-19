#!/bin/bash

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DOTFILES_DIR="$ROOT_DIR/dotfiles"

source "$ROOT_DIR/setup/utils.sh"

# Create direcoties"
msg "Creating directories"
mkdir -p $HOME/.config
mkdir -p $HOME/.local
mkdir -p $HOME/.librewolf

# Copy dotfiles to the user home directory
msg "Copying $DOTFILES_DIR/.config to $HOME"
cp -r "$DOTFILES_DIR/.config" $HOME

msg "Copying $DOTFILES_DIR/.librewolf to $HOME"
cp -r "$DOTFILES_DIR/.librewolf" $HOME

msg "Copying $DOTFILES_DIR/.local to $HOME"
cp -r "$DOTFILES_DIR/.local" $HOME

msg "Copying $DOTFILES_DIR/.Xresources to $HOME"
cp "$DOTFILES_DIR/.Xresources" $HOME

msg "Copying $DOTFILES_DIR/.bashrc to $HOME"
cp "$DOTFILES_DIR/.bashrc" $HOME

msg "Copying $DOTFILES_DIR/.profile to $HOME"
cp "$DOTFILES_DIR/.profile" $HOME

msg "Copying $DOTFILES_DIR/.xinitrc to $HOME"
cp "$DOTFILES_DIR/.xinitrc" $HOME

# Configure git credential secret
msg "Setting up GIT credential helper"
git config --global credential.helper git-credential-libsecret

# Configure network interface to NetworkManager
msg "Setting up the netplan for network interface"
sudo tee /etc/netplan/01-network-manager.yaml > /dev/null \
<<EOF
network:
  version: 2
  renderer: NetworkManager
EOF
echo "Netplan file stored at:"
echo "/etc/netplan/01-network-manager.yaml"
sudo netplan generate
sudo netplan apply
