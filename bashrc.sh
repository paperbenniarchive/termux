alias a="cd ~/storage/shared"
alias q=exit

pb() {
    source /usr/share/paperbash/import.sh || return 1
    pb $@
}

gclone() {
    git clone --depth=1 https://github.com/$1.git
}

export PATH=$PATH:~/bin
