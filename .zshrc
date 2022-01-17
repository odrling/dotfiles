stty -ixon # Disable ctrl-s and ctrl-q.

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

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


zinit light zsh-users/zsh-completions
zinit ice has'fzf'; zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light jeffreytse/zsh-vi-mode

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait"1" lucid
zinit light Tarrasch/zsh-autoenv

zinit ice wait"1" lucid
zinit light t413/zsh-background-notify.git

zinit ice wait"1" lucid
zinit light chisui/zsh-nix-shell

zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
zinit ice wait"1" lucid
zinit snippet https://raw.githubusercontent.com/hkbakke/bash-insulter/master/src/bash.command-not-found

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


zstyle ':completion::complete:*' use-cache 1
export HISTFILE=~/.histfile
export HISTSIZE=100000
export SAVEHIST=100000
setopt appendhistory autocd notify histexpiredupsfirst histsavenodups incappendhistorytime histnostore histignorespace
unsetopt beep
bindkey -e

export NIX_BUILD_SHELL=zsh

# vi mode
set -o vi
bindkey -v
export KEYTIMEOUT=1

export FZF_DEFAULT_OPTS="-m --no-mouse"
export FZF_DEFAULT_COMMAND="fd"

alias dots="git --git-dir=$HOME/.dots --work-tree=$HOME"
alias dotmodules="dots submodule update --recursive --remote"
alias venv="source ~/.venvs/venv/bin/activate"
alias top="htop"
alias ytdl="yt-dlp"
alias ag="ag --nogroup"

alias s="vi ~/.local/bin/\$(stest -lx ~/.local/bin | fzf --tac -e)"

alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"

[ -f ~/.local_env ] && . ~/.local_env
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit && complete -o bashdefault -o default -o nospace -C qpdf qpdf

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh
