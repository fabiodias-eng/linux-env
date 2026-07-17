#!/bin/bash

set -e

# Copy dotfiles to the user home directory
dotfiles="$(pwd)/dotfiles"
cp -r $dotfiles/.config $HOME
cp -r $dotfiles/.librewolf $HOME
cp -r $dotfiles/.local $HOME
cp $dotfiles/.Xresources $HOME
cp $dotfiles/.bashrc $HOME
cp $dotfiles/.profile $HOME
cp $dotfiles/.xinitrc $HOME

# Configure git credential secret
git config --global credential.helper git-credential-libsecret
