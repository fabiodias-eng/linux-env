#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

sudo apt update

# Core System
sudo apt install -y \
    wget curl git unzip \
    ca-certificates \
    gnupg

# Build / Dev Toolchain
sudo apt install -y \
    build-essential cmake ninja-build pkg-config gdb clang-tidy \
    python3 python3-pip python3-venv python3-dev \
    nodejs npm \
    lua5.4 luarocks

sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

sudo apt install ripgrep fd-find
ln -s $(which fdfind) ~/.local/bin/fd

# x11 Display
sudo apt install -y \
    xorg xinit x11-xserver-utils

# x11 Dev Libs
sudo apt install -y \
    libx11-dev \
    libxft-dev \
    libxinerama-dev \
    libxrandr-dev \
    libxext-dev \
    libx11-xcb-dev \
    libxcb1-dev \
    libxcb-util0-dev \
    libxcb-xinerama0-dev \
    libxcb-randr0-dev

# System services / Plumbing
sudo apt install -y \
    dbus-user-session \
    lxpolkit \
    network-manager \
    brightnessctl \
    tlp \
    blueman \
    mtp-tools \
    jmtpfs \
    libmtp-runtime \
    gvfs \
    gvfs-backends \
    gvfs-fuse \
    udisks2

# Notification / SysTray
    sudo apt install -y \
    libnotify-bin \
    dunst \
    network-manager-gnome --no-install-recommends \
    volumeicon-alsa

# Audio
sudo apt install -y \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    wireplumber \
    pavucontrol \

# Apps / Utilities

# Librewolf
sudo apt install -y extrepo
sudo extrepo enable librewolf
sudo extrepo update librewolf
sudo apt install -y librewolf

sudo apt install -y \
    thunar \
    code \
    gimp \
    inkscape \
    krita \
    audacity \
    kdenlive \
    obs-studio \
    feh \
    xcompmgr \
    maim slop \
    xclip xsel \
    ffmpeg \
    p7zip-full \
    xdg-utils xdg-user-dirs xdg-desktop-portal \
    htop 
if apt-cache show fastfetch >/dev/null 2>&1; then
    sudo apt install -y fastfetch
elif apt-cache show neofetch >/dev/null 2>&1; then
    sudo apt install -y neofetch
fi

# Fonts
sudo apt install -y \
    fonts-noto \
    fonts-noto-color-emoji \
    fonts-dejavu \
    fonts-freefont-ttf

# Icons
sudo apt install papirus-icon-theme

# Themes
sudo apt install arc-theme
