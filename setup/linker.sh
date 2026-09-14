#!/bin/bash

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DOTFILES_DIR="$ROOT_DIR/dotfiles"

source "$ROOT_DIR/setup/utils.sh"

# Create directories"
header_msg "Creating directories"
mkdir -p "$HOME"/.config
mkdir -p "$HOME"/.local
mkdir -p "$HOME"/.local/bin
mkdir -p "$HOME"/.local/lib
mkdir -p "$HOME"/.local/share
mkdir -p "$HOME"/.local/state

# Link dotfiles to the user home directory
header_msg "Creating symlinks"
link "$DOTFILES_DIR/.config/dunst" "$HOME/.config/dunst"
link "$DOTFILES_DIR/.config/gtk-3.0" "$HOME/.config/gtk-3.0"
link "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
link "$DOTFILES_DIR/.config/tmux" "$HOME/.config/tmux"
link "$DOTFILES_DIR/.config/volumeicon" "$HOME/.config/volumeicon"
link "$DOTFILES_DIR/.config/parcellite" "$HOME/.config/parcellite"
link "$DOTFILES_DIR/.local/bin/custom-notifier" "$HOME/.local/bin/custom-notifier"
link "$DOTFILES_DIR/.local/bin/volume-control" "$HOME/.local/bin/volume-control"
link "$DOTFILES_DIR/.local/bin/dunst-theme" "$HOME/.local/bin/dunst-theme"
link "$DOTFILES_DIR/.local/bin/bluetooth" "$HOME/.local/bin/bluetooth"
link "$DOTFILES_DIR/.local/bin/screenshot-handler" "$HOME/.local/bin/screenshot-handler"
link "$DOTFILES_DIR/.local/bin/dwmblocks-theme" "$HOME/.local/bin/dwmblocks-theme"
link "$DOTFILES_DIR/.local/bin/tmux-status" "$HOME/.local/bin/tmux-status"
link "$DOTFILES_DIR/.local/bin/shortcuts" "$HOME/.local/bin/shortcuts"
link "$DOTFILES_DIR/.local/share/fonts" "$HOME/.local/share/fonts"
link "$DOTFILES_DIR/.Xresources" "$HOME/.Xresources"
link "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
link "$DOTFILES_DIR/.profile" "$HOME/.profile"
link "$DOTFILES_DIR/.xinitrc" "$HOME/.xinitrc"
