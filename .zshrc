stty -ixon # Disable ctrl-s and ctrl-q.

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
mkdir -p "$(dirname $ZINIT_HOME)"
[ -f "$ZINIT_HOME/zinit.zsh" ] || git clone --depth 1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# fixes conflict with zsh-autosuggestions
# Do the initialization when the script is sourced (i.e. Initialize instantly)
ZVM_INIT_MODE=sourcing
# avoid showing a syntax highlighting mess
ZVM_VI_INS_LEGACY_UNDO=1

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent quiet yes

# load modules
zinit light zsh-users/zsh-completions
zinit ice has'fzf'; zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light z-shell/F-Sy-H
[ -z "$NVIM" ] && (zinit ice wait ""; zinit light jeffreytse/zsh-vi-mode)

zinit ice has'ssh-agent' wait silent; zinit snippet OMZP::ssh-agent

zinit as"program" has'go' atclone'make && ./direnv hook zsh > zhook.zsh' \
    atpull'%atclone' pick"direnv" src"zhook.zsh" for \
        direnv/direnv

zinit ice wait"1" lucid
zinit light chisui/zsh-nix-shell

zinit ice has'fzf' wait lucid; zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
zinit ice has'fzf' wait lucid; zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
zinit ice wait"1" lucid
zinit snippet https://raw.githubusercontent.com/hkbakke/bash-insulter/master/src/bash.command-not-found

if command -v starship 2>&1 > /dev/null; then
    source <(starship init zsh --print-full-init)
else
    autoload -Uz promptinit
    promptinit; prompt gentoo
fi

# completion settings
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s zstyle :compinstall filename "${HOME}/.zshrc" zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' use-cache 1

# root commands completion for sudo/doas
[[ $UID -eq 0 ]] || () {
    local i
    local -T SUDO_PATH sudo_path
    local -U sudo_path
    sudo_path=($path {,/usr{,/local}}/sbin(N-/))
    for i in sudo{,x} su{,x} doas{,x}
    do   zstyle ":completion:*:$i:*" environ PATH="$SUDO_PATH"
    done
}

# history file settings
export HISTFILE=~/.histfile
export HISTSIZE=100000
export SAVEHIST=100000
setopt appendhistory notify histexpiredupsfirst histsavenodups \
       incappendhistorytime histnostore histignorespace share_history

unsetopt beep

export FZF_DEFAULT_OPTS="-m"


command -v fd > /dev/null && export FZF_DEFAULT_COMMAND="fd"

alias venv="source ~/.venvs/venv/bin/activate"
alias ytdl="yt-dlp"
alias ag="ag --nogroup"
alias s="vi ~/.local/bin/\$(stest -lx ~/.local/bin | fzf --tac -e)"
alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"
alias fd="fd --hidden"
alias ls="ls --color=auto"

export NEOVIDE_MULTIGRID=1
alias neovide="neovide --nofork"

export PIPX_DEFAULT_PYTHON=/usr/bin/python3.11

export GPG_TTY=$(tty)
[ -n "$SSH_CONNECTION" ] && export PINENTRY_USER_DATA="USE_CURSES=1"

[ -f ~/.zshrc.local ] && . ~/.zshrc.local

fpath+=~/.zfunc

autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit && complete -o bashdefault -o default -o nospace -C qpdf qpdf

zinit cdreplay -q
