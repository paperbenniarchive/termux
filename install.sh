#!/bin/bash

echo "installing paperbenni's termux config"
pkg upgrade

checkcommand() {
    if ! command -v "$1" &>/dev/null; then
        if [ -n "$2" ]; then
            apt-get install -y "$2"
        else
            apt-get install -y "$1"
        fi
    fi
}

checkcommand curl
checkcommand neovim
checkcommand git

cd $PREFIX/tmp
git clone --depth=1 https://github.com/paperbenni/termux.git
cd termux

chmod +x *.sh
