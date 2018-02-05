
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

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen theme gentoo

antigen apply

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/odrling/.zshrc'
zstyle ':completion:*' rehash true

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

export PATH=~/.local/bin:$PATH
export EDITOR=vim

alias sshmoethyst="ssh -t amoethyst 'tmux attach -t default || tmux new -t default'"
alias venv="source ~/.venv/bin/activate"
alias dots="git --git-dir=$HOME/.dots --work-tree=$HOME"
