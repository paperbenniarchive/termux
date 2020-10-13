#!/bin/bash

# a basic client for instantos quickmenu

if ! [ -e ~/.config/instantos/quickmenu ]; then
    mkdir -p ~/.config/instantos/
    pushd ~/.config/instantos/
    git clone --depth=1 https://github.com/paperbenni/quickmenus quickmenu

    popd
fi

cd ~/.config/instantos/quickmenu

unset CHOICE

while :; do
    CHOICE="$(ls -p | fzf)"
    {
        [ -z "$CHOICE" ] || ! [ -e "$CHOICE" ]
    } && exit

    if [ -d "$CHOICE" ]; then
        cd "$CHOICE" || exit 1
    elif [ -e "$CHOICE" ]; then
        PCHOICE="$(realpath "$CHOICE")"
        echo "$PCHOICE"
        chmod +x "$PCHOICE"
        eval "$PCHOICE"
        exit
    fi

done
