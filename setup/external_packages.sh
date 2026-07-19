#!/bin/bash

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

source "$ROOT_DIR/setup/utils.sh"

# Create direcoties"
msg "Creating directories"
mkdir -p $HOME/.config
mkdir -p $HOME/.local
mkdir -p $HOME/.librewolf

# Neovim
msg "Installing Neovim"
wget -O /tmp/nvim.tar.gz "https://github.com/neovim/neovim/releases/download/v0.12.3/nvim-linux-x86_64.tar.gz"
tar xzvf /tmp/nvim.tar.gz -C $HOME/.local --strip-components=1 
sudo rm -rf /tmp/nvim.tar.gz

# Tree-sitter CLI
msg "Installing Tree-sitter CLI"
wget -O /tmp/tree-sitter.tar.gz "https://github.com/tree-sitter/tree-sitter/releases/download/v0.26.11/tree-sitter-cli-linux-x64.zip"
unzip /tmp/tree-sitter.tar.gz -d $HOME/.local/bin
sudo rm -rf /tmp/tree-sitter.tar.gz

# Discord
msg "Installing Discord"
wget -O /tmp/discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo apt install -y /tmp/discord.deb
sudo rm /tmp/discord.deb

# VS Code
msg "Installing VS Code"
wget -O /tmp/code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" 
sudo apt install -y /tmp/code.deb || sudo apt -f install -y

# Epson Printer Utility
#wget -O /tmp/epson-printer.deb \
#https://download-center.epson.com/f/module/ef3170ab-18fa-4e7e-83aa-af09cf37bdd1/epson-printer-utility_1.2.2-1_amd64.deb
#sudo apt install -y /tmp/epson-printer.deb || sudo apt -f install -y
#
## Epson ESC/P-R driver
#wget -O /tmp/epson-escpr.deb \
#https://download-center.epson.com/f/module/533ce7d5-5289-44e2-9670-c71194ae784c/epson-inkjet-printer-escpr_1.8.8-1_amd64.deb
#sudo apt install -y /tmp/epson-escpr.deb || sudo apt -f install -y
#
## Epson Scan
#wget -O /tmp/epson-scan.tar.gz \
#"https://download-center.epson.com/download/?module_id=5ff13ac7-4fe4-4b61-9f8b-71e5e2a1c786:6.7.87.0&device_id=L3250+Series&os=DEBX64&region=BR&language=en"
#tar -xf /tmp/epson-scan.tar.gz -C /tmp/epson-scan
#sudo bash /tmp/epson-scan/install.sh
