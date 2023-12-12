stty -ixon # Disable ctrl-s and ctrl-q.

# load modules
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
[ -z "$NVIM" ] && source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh

if command -v fzf >/dev/null; then
    source ~/.bash/fzf/shell/completion.zsh
    source ~/.bash/fzf/shell/key-bindings.zsh
    source ~/.bash/fzf-tab-completion/zsh/fzf-zsh-completion.sh
fi

command -v direnv 2>&1 > /dev/null && source <(direnv hook zsh)

if command -v starship 2>&1 > /dev/null; then
    source <(starship init zsh --print-full-init)
else
    autoload -Uz promptinit
    promptinit; prompt gentoo
fi

function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

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

. ~/.shaliases

[ -f ~/.zshrc.local ] && . ~/.zshrc.local

fpath+=~/.zfunc

autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit && complete -o bashdefault -o default -o nospace -C qpdf qpdf
