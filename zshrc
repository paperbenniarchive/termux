
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
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

autoload -Uz compinit
compinit

zinit light agkozak/zsh-z

bindkey -e

clear
set -o vi

export PATH=$PATH:~/bin

if [ -e ~/storage/shared/external-1/Music ]
then
    export MUSIC="$HOME/storage/external-1/Music"
else
    export MUSIC="$HOME/storage/shared/Music"
fi

yt(){
    if ! [ -e "$MUSIC" ]
    then
        echo "please set up your music directory first"
        return 1
    fi

    cd "$MUSIC"
    youtube-dl -x --format bestaudio --add-metadata "$@"
}

musicback(){
    if ! [ -e "$MUSIC" ]
    then
        echo "not backing up"
        return
    fi
    rclone sync -P "$MUSIC" music:Music
}

pullmusic(){
    if ! [ -e "$MUSIC" ]
    then
        echo "not pulling up"
        return
    fi
    rclone sync -P music:Music "$MUSIC"
}

alias s="cd ~/storage/shared || termux-setup-storage"
alias q=exit
alias v=nvim
alias t=task
alias g=git
alias tc="task status:comlpeted"
alias ta="task add"
alias a=yatext
compdef _task yatext


zstyle ':completion:*' menu yes select

bindkey '^R' history-incremental-search-backward
