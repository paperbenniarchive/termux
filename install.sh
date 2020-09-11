#!/bin/bash

# this is my personal termux config
# run this on a fresh termux install

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

if ! [ -e  ~/storage/shared ]
then
    termux-setup-storage
fi

if ! [ -e .bashrc ] || ! git status
then
    mkdir ~/workspace
    cd ~/workspace
    git clone --depth=1 https://github.com/paperbenni/termux
    cd termux
    git pull
fi

chmod +x *.sh
cat bashrc.sh >~/.bashrc

if ! command -v i
then
    echo "installing instantos build tools"
    cd ~/workspace
    git clone --depth=1 https://github.com/instantos/instantTOOLS
    cd instantTOOLS
    git pull
    ./bashrc.sh
fi

echo "finished setting up paperbenni's termux"
