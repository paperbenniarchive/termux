#!/bin/bash

if ! ping -c 1 google.com &>/dev/null; then
    echo "internet access required"
    exit 1
fi

if ! command -v termux-setup-storage &>/dev/null; then
    echo "error: not running on termux"
    exit 1
fi

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
checkcommand ranger
checkcommand nvim neovim

cd $PREFIX/tmp
git clone --depth=1 https://github.com/paperbenni/termux.git
cd termux

chmod +x *.sh
cat bashrc.sh >~/.bashrc
