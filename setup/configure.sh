#!/bin/bash

set -e

# Theme set
gsettings set org.gnome.desktop.interface gtk-theme "Arc-Dark"

# Enable Laptop Touch Click
xinput set-prop 11 "libinput Tapping Enabled" 1

dotfiles="$(pwd)/dotfiles "
cp -r "$dotfiles/.config $HOME"
cp -r "$dotfiles/.librewolf $HOME"
cp -r "$dotfiles/.local $HOME"
cp "$dotfiles/.Xresources $HOME"
cp "$dotfiles/.bashrc $HOME"
cp "$dotfiles/.profile $HOME"
cp "$dotfiles/.xinitrc $HOME"
