#!/bin/bash

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DOTFILES_DIR="$ROOT_DIR/dotfiles"

source "$ROOT_DIR/setup/utils.sh"

LIBREWOLF_DISTRIBUTION_DIR="/usr/share/librewolf/distribution"
LIBREWOLF_PROFILE_ROOT="$HOME/.config/librewolf/librewolf"

if [ ! -d "$LIBREWOLF_PROFILE_ROOT" ]; then
    librewolf -CreateProfile default-default
fi

LIBREWOLF_PROFILE_DIR=$(find "$LIBREWOLF_PROFILE_ROOT" \
    -maxdepth 1 \
    -type d \
    -name 'default-*' \
    -print -quit)

if [ -n "$LIBREWOLF_PROFILE_DIR" ] && [ -d "$LIBREWOLF_PROFILE_DIR" ]; then
    mkdir -p "$LIBREWOLF_PROFILE_DIR/chrome"

    link "$DOTFILES_DIR/.config/librewolf/librewolf/default/user.js" \
        "$LIBREWOLF_PROFILE_DIR/user.js"

    link "$DOTFILES_DIR/.config/librewolf/librewolf/default/chrome/userChrome.css" \
        "$LIBREWOLF_PROFILE_DIR/chrome/userChrome.css"

    sudo mkdir -p "$LIBREWOLF_DISTRIBUTION_DIR"

    link_root "$DOTFILES_DIR/.config/librewolf/librewolf/default/policies.json" \
        "$LIBREWOLF_DISTRIBUTION_DIR/policies.json"

    link "$DOTFILES_DIR/.librewolf/Custom Themes" \
        "$HOME/.librewolf/Custom Themes"
else
    error_msg "Failed to create Librewolf profile"
fi

success_msg "Successfully created Librewolf profile 'default-default'"
