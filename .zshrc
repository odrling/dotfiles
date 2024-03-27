stty -ixon # Disable ctrl-s and ctrl-q.

# load modules
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
# Disable the cursor style feature
ZVM_CURSOR_STYLE_ENABLED=false
[ -z "$NVIM" ] && source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh

if command -v fzf >/dev/null; then
    source ~/.bash/fzf/shell/completion.zsh
    source ~/.bash/fzf/shell/key-bindings.zsh
    source ~/.bash/fzf-tab-completion/zsh/fzf-zsh-completion.sh
    bindkey '^T' fzf-completion
    bindkey '^I' $fzf_default_completion
fi

# osc-7 support for foot
function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
chpwd_functions+=(chpwd-osc7-pwd)

# completion settings
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s zstyle :compinstall filename "${HOME}/.zshrc" zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' use-cache 1

autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit && complete -o bashdefault -o default -o nospace -C qpdf qpdf

# history file settings
export HISTFILE=~/.histfile
export HISTSIZE=100000
export SAVEHIST=100000
setopt appendhistory notify histexpiredupsfirst histsavenodups \
       incappendhistorytime histnostore histignorespace share_history

unsetopt beep

# vcs prompt info
autoload -Uz vcs_info
vcs_info_format() {
    [ -n "${vcs_info_msg_0_}" ] && vcs_info_formatted=" ${vcs_info_msg_0_}" || vcs_info_formatted=""
}

zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' check-for-changes true

# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

precmd_functions+=(vcs_info vcs_info_format)

# prompt
[ "$GRAPHICAL_TTY" = 1 ] && shell_char=❯ || shell_char=$
[ -n "$SSH_CONNECTION" ] && prompt_host='%B%F{red}%n@%m%f '

setopt prompt_subst
PROMPT='${prompt_host}%F{blue}%4~%f%b%F{green}${vcs_info_formatted}%f %(?.%F{green}.%F{red})${shell_char}%f '

# set format for the time command
TIMEFMT="%J  %mU user %mS system %P  cpu  %*E total"

# set tty for gpg-agent
export GPG_TTY="$(tty)"
odr-update-gpg-agent() {
    gpg-connect-agent updatestartuptty /bye &>/dev/null
}
preexec_functions+=(odr-update-gpg-agent)


source ~/.zsh/envs.zsh

# local config
. ~/.shaliases
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
