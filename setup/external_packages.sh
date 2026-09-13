#!/bin/bash

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

source "$ROOT_DIR/setup/utils.sh"

wallker() {
    header_msg "Installing $1"
    bash "$ROOT_DIR/wallker/install.sh"
}

neovim() {
    header_msg "Installing $1"
    wget -O /tmp/nvim.tar.gz "https://github.com/neovim/neovim/releases/download/v0.12.3/nvim-linux-x86_64.tar.gz"
    tar xzvf /tmp/nvim.tar.gz -C $HOME/.local --strip-components=1
    sudo rm -rf /tmp/nvim.tar.gz
}

tmux_plugin_manager() {
    header_msg "Installing $1"
    git clone https://github.com/tmux-plugins/tpm $ROOT_DIR/dotfiles/.config/tmux/plugins/tpm
}

treesitter_cli() {
    header_msg "Installing $1"
    wget -O /tmp/tree-sitter.tar.gz "https://github.com/tree-sitter/tree-sitter/releases/download/v0.26.11/tree-sitter-cli-linux-x64.zip"
    unzip /tmp/tree-sitter.tar.gz -d $HOME/.local/bin
    sudo rm -rf /tmp/tree-sitter.tar.gz
}

discord() {
    header_msg "Installing $1"
    wget -O /tmp/discord.deb "https://discord.com/api/download?platform=linux&format=deb"
    sudo apt install -y /tmp/discord.deb
    sudo rm /tmp/discord.deb
}

vscode() {
    header_msg "Installing $1"
    wget -O /tmp/code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    sudo apt install -y /tmp/code.deb || sudo apt -f install -y
    sudo rm /tmp/code.deb
}

printer() {
    header_msg "Installing $1"a

    # Epson Printer Utility
    sudo apt install -y $ROOT_DIR/setup/deb-packages/epson-printer-utility_1.2.3-1_amd64.deb

    # Epson ESC/P-R driver
    sudo apt install -y $ROOT_DIR/setup/deb-packages/epson-inkjet-printer-escpr_1.8.8-1_amd64.deb

    # Epson Scan
    epson_bundle="$ROOT_DIR/setup/deb-packages/epson_bundle"
    sudo mkdir -p "$epson_bundle"
    sudo tar -xzf \
        "$ROOT_DIR/setup/deb-packages/epsonscan2-bundle-6.7.90.0.x86_64.deb.tar.gz" \
        -C "$epson_bundle" \
        --strip-components=1
    sudo bash "$epson_bundle/install.sh"
    sudo rm -rf "$epson_bundle"
}

main() {
    wallker "Wallker"
    neovim "Neovim"
    tmux_plugin_manager "Tmux Plugin Manager"
    treesitter_cli "Tree-Sitter CLI"
    discord "Discord"
    vscode "VSCode"
    printer "Epson Drivers"
}

main "$@"
