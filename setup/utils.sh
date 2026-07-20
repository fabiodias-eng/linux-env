#!/bin/bash

header_msg() {
    echo "─────────────────────────────────────────────────────────────────────────────────────────"
    echo "$1"
    echo
}

normal_msg() {
    echo "─❯ $1"
}

success_msg() {
    echo "[Success] ─❯ $1"
}

error_msg() {
    echo "[Error] ─❯ $1"
}

link() {
    if [ ! -e "$1" ]; then
        error_msg "Missing source: $1"
        return 1
    fi

    if ln -sfn "$1" "$2"; then
        success_msg "$1 → $2"
    else
        error_msg "Unable to create symlink: $2"
        return 1
    fi
}
