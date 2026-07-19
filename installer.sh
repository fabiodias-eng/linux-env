#!/bin/bash

set -e

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$ROOT_DIR/setup/utils.sh"

msg  "Initializing Setup"
sudo  echo

msg  "Initializing GIT Submodule"
git submodule update --init --recursive

msg  "Installing System Packages"
bash "$ROOT_DIR/setup/packages.sh"

msg  "Installing External Packages"
bash "$ROOT_DIR/setup/external_packages.sh"

msg  "Building Custom Components"
bash "$ROOT_DIR/setup/build.sh"

msg  "Configuring Environment"
bash "$ROOT_DIR/setup/configure.sh"

msg  "Setup Complete"
