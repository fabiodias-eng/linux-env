#!/bin/bash

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

source "$ROOT_DIR/setup/utils.sh"

# Build Suckless DWM
msg "Installing DWM"
cd "$ROOT_DIR/dwm"
sudo make clean install
cd ".."

# Build DWM Blocks
msg "Installing DWM Blocks"
cd "$ROOT_DIR/dwmblocks"
sudo make clean install
cd ".."

# Build Suckless ST terminal emulator 
msg "Installing ST"
cd "$ROOT_DIR/st"
sudo make clean install
cd ".."

# Build Suckless Dmenu
msg "Installing Dmenu"
cd "$ROOT_DIR/dmenu"
sudo make clean install
cd ".."

# Build git-credential-libsecret
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret
if [ -d /usr/share/doc/git/contrib/credential/libsecret ]; then
    msg "Insalling Git Credential Libsecret"
    sudo install \
    /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret \
    /usr/local/bin/
fi
