#!/bin/bash

set -e

dotfiles="$(pwd)/dotfiles"
cp -r $dotfiles/.config $HOME
cp -r $dotfiles/.librewolf $HOME
cp -r $dotfiles/.local $HOME
cp $dotfiles/.Xresources $HOME
cp $dotfiles/.bashrc $HOME
cp $dotfiles/.profile $HOME
cp $dotfiles/.xinitrc $HOME
