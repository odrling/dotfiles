
# load modules
bgnotify_threshold=0
for i in ~/.zsh/*/*.zsh; do
    source "$i"
done

source ~/.zsh/omz/oh-my-zsh/lib/spectrum.zsh
source ~/.zsh/omz/oh-my-zsh/plugins/ssh-agent/ssh-agent.plugin.zsh


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


# PATH
export PATH="$HOME/.local/bin:$PATH"
if which ruby > /dev/null 2>&1; then
    export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
fi

export EDITOR=nvim
#export TERM="xterm"

alias venv="source ~/.venv/bin/activate"
alias dots="git --git-dir=$HOME/.dots --work-tree=$HOME"
alias top="htop"
alias dotmodules="dots submodule update --recursive --remote"
alias ytdl="youtube-dl"
alias pass="gopass"
alias vi="nvim"
alias vim="nvim"
alias cat="bat"
alias ls="ls --color"
alias grep="ag"

export FZF_DEFAULT_OPTS="-m"
export FZF_DEFAULT_COMMAND='fd --type f'

[ -f ~/.config/bookmarks.zsh ] && . ~/.config/bookmarks.zsh

alias vid="fd -0 -t f . ~/Videos | fzf --read0 --print0 --tac | xargs -0 -r mpv"
alias s="vim \$(fd -t f . $HOME/.local/bin | fzf --tac --with-nth=5.. -d/ -e)"

function start_tmux() {
    if type tmux &> /dev/null; then
        #if not inside a tmux session, and if no session is started, start a new session
        if [[ -z "$TMUX" && -z $TERMINAL_CONTEXT ]]; then
            (tmux -2 attach || tmux -2 new-session)
        fi
    fi
}

[ -f ~/.zshrc.local ] && . ~/.zshrc.local
