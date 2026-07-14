#!/bin/bash

set -e

DIR=$(pwd)

echo "Installing DWM"
cd "$DIR/dwm"
sudo make clean install
cd ".."

echo "Installing DWM Blocks"
cd "$DIR/dwmblocks"
sudo make clean install
cd ".."

echo "Installing ST"
cd "$DIR/st"
sudo make clean install
cd ".."

echo "Installing Dmenu"
cd "$DIR/dmenu"
sudo make clean install
cd ".."
