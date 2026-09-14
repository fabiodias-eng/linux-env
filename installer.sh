#!/bin/bash

set -e

show_help() {
    echo "Usage: $0 [option]"
    echo
    echo "Options:"
    echo "  gpu    Install NVIDIA GPU drivers"
    echo "  help   Show this help message"
}

HAS_GPU=0

case "$1" in
gpu)
    HAS_GPU=1
    ;;
help | -h | --help)
    show_help
    exit 0
    ;;
esac

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$ROOT_DIR/setup/utils.sh"

header_msg "Initializing Setup"
sudo echo

header_msg "Initializing GIT Submodule"
git submodule update --init --recursive

header_msg "Configuring Environment"
bash "$ROOT_DIR/setup/configure.sh"

header_msg "Installing System Packages"
bash "$ROOT_DIR/setup/packages.sh" "$HAS_GPU"

header_msg "Installing External Packages"
bash "$ROOT_DIR/setup/external_packages.sh"

header_msg "Building Custom Components"
bash "$ROOT_DIR/setup/build.sh"

header_msg "Configuring Librewolf Profile"
bash "$ROOT_DIR/setup/configure-librewolf.sh"

header_msg "Setup Complete"
echo Restarting in 10 seconds...
sleep 10
sudo reboot
