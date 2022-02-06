stty -ixon # Disable ctrl-s and ctrl-q.

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# load modules
zinit light zsh-users/zsh-completions
zinit ice has'fzf'; zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light jeffreytse/zsh-vi-mode

zinit ice has'ssh-agent' wait lucid; zinit snippet OMZP::ssh-agent

# Load starship theme
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit as"program" has'go' make'!' atclone'./direnv hook zsh > zhook.zsh' \
    atpull'%atclone' pick"direnv" src"zhook.zsh" for \
        direnv/direnv

zinit ice wait"1" lucid
zinit light chisui/zsh-nix-shell

zinit ice has'fzf' wait"" lucid; zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
zinit ice has'fzf' wait"" lucid; zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
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

setopt appendhistory notify histexpiredupsfirst histsavenodups incappendhistorytime histnostore histignorespace
unsetopt beep

# vi mode
set -o vi
bindkey -v
export KEYTIMEOUT=1

export FZF_DEFAULT_OPTS="-m"
command -v fd > /dev/null && export FZF_DEFAULT_COMMAND="fd"

alias dots="git --git-dir=$HOME/.dots --work-tree=$HOME"
alias dotmodules="dots submodule update --recursive --remote"
alias venv="source ~/.venvs/venv/bin/activate"
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
