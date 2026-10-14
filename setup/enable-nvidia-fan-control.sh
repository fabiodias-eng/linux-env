#!/bin/bash

config="/etc/X11/Xwrapper.config"

if ! grep -q '^needs_root_rights=' "$config"; then
    echo "needs_root_rights=yes" | sudo tee -a "$config" >/dev/null
else
    sudo sed -i \
        's/^needs_root_rights=.*/needs_root_rights=yes/' \
        "$config"
fi
