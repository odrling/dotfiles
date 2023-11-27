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

# load modules
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
[ -z "$NVIM" ] && (zinit ice wait ""; zinit light jeffreytse/zsh-vi-mode)

zinit ice wait"1" lucid
zinit light chisui/zsh-nix-shell

zinit ice has'fzf' wait lucid; zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
zinit ice has'fzf' wait lucid; zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
zinit ice wait"1" lucid
zinit snippet https://raw.githubusercontent.com/hkbakke/bash-insulter/master/src/bash.command-not-found

zinit ice has'fzf' wait lucid; zinit snippet ~/.bash/fzf-tab-completion/zsh/fzf-zsh-completion.sh
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

autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit && complete -o bashdefault -o default -o nospace -C qpdf qpdf

zinit cdreplay -q
