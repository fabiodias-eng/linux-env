#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

sudo apt update

core_packages() {
    sudo apt install -y \
        wget curl git unzip \
        ca-certificates \
        gnupg
}

dev_build_packages() {
    sudo apt install -y \
        build-essential cmake ninja-build pkg-config gdb clang-tidy \
        python3 python3-pip python3-venv python3-dev \
        nodejs npm \
        lua5.4 luarocks

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
}

x_packages() {
    sudo apt install -y \
        xorg \
        xinit \
        x11-xserver-utils
}

xlib_packages() {
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
}

graphic_packages() {
    sudo apt install -y \
        mesa-utils \
        mesa-va-drivers \
        mesa-vdpau-drivers \
        libva2 \
        vainfo \
        intel-media-va-driver
}

system_service_packages() {
    sudo apt install -y \
        dbus-user-session \
        lxpolkit \
        network-manager \
        brightnessctl \
        tlp \
        blueman \
        mtp-tools \
        libmtp-runtime \
        gvfs \
        gvfs-backends \
        gvfs-fuse \
        udisks2 \
        cups
    if apt-cache show jmtpfs >/dev/null 2>&1; then
        sudo apt install -y jmtpfs
    elif apt-cache show go-mtpfs >/dev/null 2>&1; then
        sudo apt install -y go-mtpfs
    fi
}

notification_packages() {
    sudo apt install -y \
        libnotify-bin \
        dunst \
        network-manager-gnome --no-install-recommends \
        pasystray
}

audio_packages() {
    sudo apt install -y \
        pipewire \
        pipewire-pulse \
        pipewire-alsa \
        wireplumber \
        pavucontrol
}

security_packages() {
    sudo apt install -y \
        gnome-keyring \
        libsecret-1-0 \
        libsecret-1-dev \
        libglib2.0-dev \
        libsecret-tools \
        seahorse
}

app_packages() {
    sudo apt install -y extrepo
    sudo extrepo enable librewolf
    sudo extrepo update librewolf
    sudo apt update
    sudo apt install -y librewolf

    sudo apt install -y \
        tmux \
        thunar \
        gimp \
        inkscape \
        krita \
        audacity \
        kdenlive \
        obs-studio \
        feh \
        adb \
        scrcpy \
        ripgrep \
        fd-find \
        tree-sitter-cli \
        xcompmgr \
        maim slop \
        xclip parcellite \
        ffmpeg \
        p7zip-full \
        xdg-utils xdg-user-dirs xdg-desktop-portal \
        htop \
        lxappearance \
        xdotool
    if apt-cache show fastfetch >/dev/null 2>&1; then
        sudo apt install -y fastfetch
    elif apt-cache show neofetch >/dev/null 2>&1; then
        sudo apt install -y neofetch
    fi
}

font_packages() {
    sudo apt install -y \
        fonts-noto \
        fonts-noto-color-emoji \
        fonts-dejavu \
        fonts-freefont-ttf
}

icon_packages() {
    sudo apt install papirus-icon-theme
}

theme_packages() {
    sudo apt install arc-theme
}

main() {
    core_packages
    dev_build_packages
    x_packages
    xlib_packages
    graphic_packages
    system_service_packages
    notification_packages
    audio_packages
    security_packages
    apps_packages
    font_packages
    icon_packages
    theme_packages
}

main "$@"
