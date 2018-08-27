
mkdir -p ~/.antigen

if [ ! -f ~/.antigen/antigen.zsh ]; then
    curl -Ls git.io/antigen > ~/.antigen/antigen.zsh
fi

source ~/.antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle pass
antigen bundle ssh-agent

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle chrissicool/zsh-bash

antigen theme gentoo

antigen apply

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

autoload -Uz compinit promptinit
compinit
promptinit; prompt gentoo

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

export PATH="$HOME/.local/bin:$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export EDITOR=vim
#export TERM="xterm"

alias sshmoethyst="ssh -t amoethyst '~/.local/bin/tmux-session'"
alias venv="source ~/.venv/bin/activate"
alias dots="git --git-dir=$HOME/.dots --work-tree=$HOME"
alias mstream="mpv --no-resume-playback"
alias mpodcast="mpv --no-video"

