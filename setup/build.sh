#!/bin/bash

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

source "$ROOT_DIR/setup/utils.sh"

# Build Suckless DWM
header_msg "Bulding DWM"
cd "$ROOT_DIR/dwm"
if sudo make clean install; then
    success_msg "DWM Installed"
else
    error_msg "Failed to build DWM"
    exit 1
fi
cd ".."

# Build DWM Blocks
header_msg "Building DWM Blocks"
cd "$ROOT_DIR/dwmblocks"
if sudo make clean install; then
    success_msg "DWM Blocks Installed"
else
    error_msg "Failed to build DWM Blocks"
    exit 1
fi
cd ".."

# Build Suckless ST terminal emulator 
header_msg "Building ST Terminal Emulator"
cd "$ROOT_DIR/st"
if sudo make clean install; then
    success_msg "ST Installed"
else
    error_msg "Failed to build ST Terminal Emulator"
    exit 1
fi
cd ".."

# Build Suckless Dmenu
header_msg "Building Dmenu"
cd "$ROOT_DIR/dmenu"
if sudo make clean install; then
    success_msg "Dmenu Installed"
else
    error_msg "Failed to build Dmenu"
    exit 1
fi
cd ".."

# Build git-credential-libsecret
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret
if [ -d /usr/share/doc/git/contrib/credential/libsecret ]; then
    header_msg "Building Git Credential Libsecret"
    sudo install \
    /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret \
    /usr/local/bin/

    normal_msg "Setting up GIT credential helper"
    git config --global credential.helper git-credential-libsecret

    success_msg "Git Credential Libsecret Installed"
else
    error_msg "Failed to install Git Credential Libsecret"
    exit 1
fi
