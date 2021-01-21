
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    if checkinternet || curl -s cht.sh &> /dev/null
    then
        print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
        command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
        command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
            print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
            print -P "%F{160}▓▒░ The clone has failed.%f%b"
    fi
fi


autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

source "$HOME/.zinit/bin/zinit.zsh"


zinit snippet OMZL::git.zsh
zinit ice wait"1" lucid
zinit light zsh-users/zsh-autosuggestions
zinit ice wait"1" lucid
zinit light zsh-users/zsh-completions
zinit ice wait"1" lucid

autoload -Uz compinit
compinit

zinit light agkozak/zsh-z

bindkey -e

clear
set -o vi

export PATH=$PATH:~/bin

yt(){
    if ! [ -e ~/storage/shared/Music ]
    then
        echo "please set up your music directory first"
        return 1
    fi

    cd ~/storage/shared/Music
    youtube-dl -x "$@"
}

musicback(){
    if ! [ -e ~/storage/shared/Music ]
    then
        echo "not backing up"
        return
    fi
    rclone sync -P ~/storage/shared/Music music:Music
}

pullmusic(){
    if ! [ -e ~/storage/shared/Music ]
    then
        echo "not pulling up"
        return
    fi
    rclone sync -P music:Music ~/storage/shared/Music
}

alias a="cd ~/storage/shared || termux-setup-storage"
alias q=exit
alias v=nvim
alias t=task
alias g=git

zstyle ':completion:*' menu yes select

bindkey '^R' history-incremental-search-backward
