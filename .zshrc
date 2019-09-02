
# load modules
bgnotify_threshold=0
for i in ~/.zsh/*/*.zsh; do
    source "$i"
done

source ~/.zsh/omz/oh-my-zsh/lib/spectrum.zsh

# vi key bindings
set -o vi

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s zstyle :compinstall filename "${HOME}/.zshrc" zstyle ':completion:*' rehash true

[[ $UID -eq 0 ]] || () {
    local i
    local -T SUDO_PATH sudo_path
    local -U sudo_path
    sudo_path=($path {,/usr{,/local}}/sbin(N-/))
    for i in sudo{,x} su{,x} doas{,x}
    do   zstyle ":completion:*:$i:*" environ PATH="$SUDO_PATH"
    done
}

autoload -Uz compinit && compinit

zstyle ':completion::complete:*' use-cache 1
export HISTFILE=~/.histfile
export HISTSIZE=10000
export SAVEHIST=10000
setopt appendhistory autocd notify histexpiredupsfirst histsavenodups incappendhistorytime histnostore histignorespace
unsetopt beep
bindkey -e

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Prompt
autoload -U colors && colors
PROMPT="%B%{$FG[081]%}%n%{$reset_color%}%b%{$FG[245]%}@%{$reset_color%}%B%{$FG[206]%}%m%{$reset_color%}%b %{$fg[245]%}%B%c%b %(!.%{$FG[001]%}#.%{$FG[081]%}$)%{$reset_color%} "

export FZF_DEFAULT_OPTS="-m --no-mouse"
export FZF_DEFAULT_COMMAND="find . -type f | sed 's|^\./||'"

alias dots="git --git-dir=$HOME/.dots --work-tree=$HOME"
alias dotmodules="dots submodule update --recursive --remote"
alias venv="source ~/.venv/bin/activate"
alias top="htop"
alias ytdl="youtube-dl"
alias vi="nvim"
alias vim="nvim"

alias s="vim ~/.local/bin/\$(stest -lx ~/.local/bin | fzf --tac -e)"

[ -f ~/.local_env ] && . ~/.local_env
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
