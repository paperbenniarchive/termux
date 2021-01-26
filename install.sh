#!/bin/bash

# this is my personal termux config
# run this on a fresh termux install

if ! command -v termux-setup-storage &>/dev/null; then
    echo "error: not running on termux"
    exit 1
fi

echo "installing paperbenni's termux config"

checkcommand() {
    if ! command -v "$1" &>/dev/null; then
        if [ -z "$HASUPDATED" ]; then
            pkg upgrade
            export HASUPDATED=true
        fi
        if [ -n "$2" ]; then
            apt-get install -y "$2"
        else
            apt-get install -y "$1"
        fi
    fi
}

checkcommand curl
checkcommand git
checkcommand ranger
checkcommand nvim neovim

if ! [ -e ~/storage/shared ]; then
    termux-setup-storage
fi

if [ -e ./zshrc ] && git status &>/dev/null; then
    echo "found termux repo"
else
    mkdir ~/workspace
    cd ~/workspace || exit 1
    git clone --depth=1 https://github.com/paperbenni/termux
    cd termux || exit 1
    git pull
fi

chmod +x ./*.sh
cat bashrc.sh >~/.bashrc
cat zshrc >~/.zshrc

mkdir ~/.termux
cp -r ./boot ~/.termux

if ! command -v i; then
    echo "installing instantos build tools"
    cd ~/workspace || exit 1
    git clone --depth=1 https://github.com/instantos/instantTOOLS
    cd instantTOOLS || exit 1
    git pull
    ./install.sh
fi

[ -e ~/.config/instantos/default ] || mkdir -p ~/.config/instantos/default

[ -e ~/.config/instantos/default/browser ] ||
    ln -s "$(which termux-open-url)" ~/.config/instantos/default/browser

if ! [ -e ~/.config/instantos/quickmenu ]; then
    cd ~/.config/instantos || exit 1
    git clone --depth=1 https://github.com/paperbenni/quickmenus quickmenu
fi

zsh -c "source ~/.zshrc && echo 'installed zinit'"

if [ -e ~/.zinit ]; then
    mkdir ~/.zinit/completions
    curl https://raw.githubusercontent.com/GothenburgBitFactory/taskwarrior/2.6.0/scripts/zsh/_task >~/.zinit/completions/_task
fi

echo "finished setting up paperbenni's termux"
