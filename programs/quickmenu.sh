#!/bin/bash

# a basic client for instantos quickmenu

if ! [ -e ~/.config/instantos/quickmenu ]
then
    mkdir -p ~/.config/instantos/
    pushd ~/.config/instantos/
    git clone --depth=1 https://github.com/paperbenni/quickmenus quickmenu

    popd
fi

cd ~/.config/instantos/quickmenu

unset CHOICE

while [ -z "$CHOICE" ]
do
    CHOICE="$(ls | fzf)"
    {
        [ -z "$CHOICE" ] || ! [ -e "$CHOICE" ] 
    } && exit
    if [ -d "$CHOICE" ]
    then
        cd "$CHOICE"
        continue
    fi
    if [ -e "$CHOICE" ]
    then
        "$(realpath "$CHOICE")"
        exit
    fi
    
    
done
