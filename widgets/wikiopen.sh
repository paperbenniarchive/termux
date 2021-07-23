#!/bin/bash
# open a file from the wiki

cd ~/wiki/vimwiki || {
    echo "no wiki found"
    sleep 4
    exit 1
}

CHOICE="$(
    fd . | fzf
)"

[ -z "$CHOICE" ] && exit

if grep '\.wiki$' "$CHOICE"; then
    nvim "$CHOICE"
else
    termux-open "$CHOICE"
fi
