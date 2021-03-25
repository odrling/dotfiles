
stty -ixon # Disable ctrl-s and ctrl-q.

# ssh-agent
start_ssh_agent() {
	ssh-agent | grep -v \^echo > "$SSH_ENV"
	chmod 1600 "$SSH_ENV"
}

SSH_ENV="/tmp/.ssh_env.$USER"
if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV"
    ps q $SSH_AGENT_PID > /dev/null || start_ssh_agent
else
    start_ssh_agent
fi
. "$SSH_ENV"

# load modules
bgnotify_threshold=0
for i in ~/.zsh/*/*.plugin.zsh; do
    source "$i"
done

source ~/.zsh/omz/oh-my-zsh/lib/spectrum.zsh
source ~/.zsh/command-not-found

source ~/.vim/fzf/shell/completion.zsh
source ~/.vim/fzf/shell/key-bindings.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

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

NIX_BUILD_SHELL=zsh

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Prompt
autoload -U colors && colors
PROMPT="%B%{$FG[081]%}%n%{$reset_color%}%b%{$FG[245]%}@%{$reset_color%}%B%{$FG[206]%}%m%{$reset_color%}%b %{$fg[245]%}%B%c%b %(!.%{$FG[001]%}#.%{$FG[081]%}$)%{$reset_color%} "

export FZF_DEFAULT_OPTS="-m --no-mouse"
export FZF_DEFAULT_COMMAND="find . -not \( -name .git -prune \) -type f | sed 's|^\./||'"

alias dots="git --git-dir=$HOME/.dots --work-tree=$HOME"
alias dotmodules="dots submodule update --recursive --remote"
alias venv="source ~/.venvs/venv/bin/activate"
alias top="htop"
alias ytdl="youtube-dl"

alias s="vi ~/.local/bin/\$(stest -lx ~/.local/bin | fzf --tac -e)"

alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"

[ -f ~/.local_env ] && . ~/.local_env
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
