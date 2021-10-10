#!/bin/bash
# open a file from the wiki

openpath() {

    cd "$1" || {
        echo "error opening $1"
        sleep 4
        return 1
    }

    CHOICE="$(
        fd . | fzf
    )"

    [ -z "$CHOICE" ] && exit
    if ! [ -e "$CHOICE" ]; then
        return 1
    fi

    if [ -d "$CHOICE" ]; then
        openpath "$(realpath "$CHOICE")"
        return
    else
        if grep '\.wiki$' "$CHOICE"; then
            nvim "$CHOICE"
        else
            termux-open "$CHOICE"
        fi
    fi

}

openpath "$HOME/wiki"
