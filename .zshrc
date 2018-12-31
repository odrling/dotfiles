
if ! which antibody > /dev/null 2>1; then 
    echo "installing antibody"
    curl -sL git.io/antibody | sh -s
fi

[ ! -f ~/.antibody/plugins.sh ] && antibody bundle < ~/.antibody/plugins > ~/.antibody/plugins.sh

[ -f ~/.bash.command-not-found ] && source ~/.bash.command-not-found
source ~/.antibody/plugins.sh

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename "${HOME}/.zshrc"
zstyle ':completion:*' rehash true

[[ $UID -eq 0 ]] || () {
    local i
    local -T SUDO_PATH sudo_path
    local -U sudo_path
    sudo_path=($path {,/usr{,/local}}/sbin(N-/))
    for i in sudo{,x} su{,x}
    do   zstyle ":completion:*:$i:*" environ PATH="$SUDO_PATH"
    done
}

autoload -Uz compinit && compinit

zstyle ':completion::complete:*' use-cache 1
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

# Prompt
autoload -U colors && colors
PROMPT="%B%{$FG[081]%}%n%{$reset_color%}%b%{$FG[245]%}@%{$reset_color%}%B%{$FG[206]%}%m%{$reset_color%}%b %{$fg[245]%}%B%c%b %(!.%{$FG[001]%}#.%{$FG[081]%}$)%{$reset_color%} "


export PATH="$HOME/.local/bin:$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export EDITOR=vim
#export TERM="xterm"

alias venv="source ~/.venv/bin/activate"
alias dots="git --git-dir=$HOME/.dots --work-tree=$HOME"
alias top="htop"
alias dotmodules="dots submodule update --recursive --remote"
alias ytdl="youtube-dl"
alias pass="gopass"
