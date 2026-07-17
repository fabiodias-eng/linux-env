#!/bin/bash

set -e

DIR=$(pwd)

# Build Suckless DWM
echo "Installing DWM"
cd "$DIR/dwm"
sudo make clean install
cd ".."

# Build DWM Blocks
echo "Installing DWM Blocks"
cd "$DIR/dwmblocks"
sudo make clean install
cd ".."

# Build Suckless ST terminal emulator 
echo "Installing ST"
cd "$DIR/st"
sudo make clean install
cd ".."

# Build Suckless Dmenu
echo "Installing Dmenu"
cd "$DIR/dmenu"
sudo make clean install
cd ".."

# Build git-credential-libsecret
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret
if [ -d /usr/share/doc/git/contrib/credential/libsecret ]; then
    sudo install \
    /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret \
    /usr/local/bin/
fi
