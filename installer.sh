#!/bin/bash

set -e

echo "Initializing submodules..."
git submodule update --init --recursive

bash setup/packages.sh
bash setup/external_packages.sh
bash setup/build.sh
bash setup/configure.sh
