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

cryptomator() {
    header_msg "Downloading $1"
    wget -O $ROOT_DIR/dotfiles/.local/share/Cryptomator/cryptomator-1.19.3-x86_64.AppImage "https://release-assets.githubusercontent.com/github-production-release-asset/16446099/b07cdcff-08e2-4c38-8f65-1dbd47d821a1?sp=r&sv=2018-11-09&sr=b&spr=https&se=2026-09-09T03%3A05%3A19Z&rscd=attachment%3B+filename%3Dcryptomator-1.19.3-x86_64.AppImage&rsct=application%2Foctet-stream&skoid=96c2d410-5711-43a1-aedd-ab1947aa7ab0&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skt=2026-09-09T02%3A04%3A53Z&ske=2026-09-09T03%3A05%3A19Z&sks=b&skv=2018-11-09&sig=ba1UBz4yCPA%2FypqROVA%2FRxD5M8zbXowJ5cjF6ktkAB4%3D&jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmVsZWFzZS1hc3NldHMuZ2l0aHVidXNlcmNvbnRlbnQuY29tIiwia2V5Ijoia2V5MSIsImV4cCI6MTc4ODkyMTMxOCwibmJmIjoxNzg4OTE5NTE4LCJwYXRoIjoicmVsZWFzZWFzc2V0cHJvZHVjdGlvbi5ibG9iLmNvcmUud2luZG93cy5uZXQifQ.KG2izqJvzXdxdjbyVhqLTvN8flH4MK4f0bVvqEiftkE&response-content-disposition=attachment%3B%20filename%3Dcryptomator-1.19.3-x86_64.AppImage&response-content-type=application%2Foctet-stream"
    sudo chmod +X $ROOT/dotfiles/.local/share/Cryptomator/cryptomator-1.19.3-x86_64.AppImage
}

main() {
    wallker "Wallker"
    neovim "Neovim"
    tmux_plugin_manager "Tmux Plugin Manager"
    treesitter_cli "Tree-Sitter CLI"
    discord "Discord"
    vscode "VSCode"
    printer "Epson Drivers"
    cryptomator "Cryptomator App Image"
}

main "$@"
