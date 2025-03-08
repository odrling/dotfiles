# -----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <florianbadie@odrling.xyz> wrote this file. As long as you retain this notice
# you can do whatever you want with this stuff. If we meet some day, and you
# think this stuff is worth it, you can buy me a beer in return.   odrling
# -----------------------------------------------------------------------------
stty -ixon # Disable ctrl-s and ctrl-q.

# load modules
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
# source zvm immediately
ZVM_INIT_MODE=sourcing
[ -z "$NVIM" ] && source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh

source ~/.zsh/fzy.zsh

source ~/.zsh/envs.zsh

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

# history file settings
export HISTFILE=~/.histfile
export HISTSIZE=100000
export SAVEHIST=100000
setopt appendhistory notify histexpiredupsfirst histsavenodups \
       incappendhistorytime histnostore histignorespace share_history

setopt noclobber
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

odr-set-begin-cmd-time() {
    begin_cmd_time=${SECONDS}
}

odr-set-end-cmd-time() {
    cmd_run_time=""
    if [ -n "${begin_cmd_time}" ]; then
        local cmd_time_spent=$(( SECONDS - begin_cmd_time ))
        [ "${cmd_time_spent}" -gt 2 ] && cmd_run_time=[${cmd_time_spent}s]
        unset begin_cmd_time
    fi
}

precmd_functions+=(odr-set-end-cmd-time vcs_info vcs_info_format)

# prompt
[ "$GRAPHICAL_TTY" = 1 ] && shell_char=❯ || shell_char=$
[ -n "$SSH_CONNECTION" ] && prompt_host='%B%F{red}%n@%m%f '

setopt prompt_subst
PROMPT='${prompt_host}%F{blue}%4~%f%b%F{green}${vcs_info_formatted}%f %(?.%F{green}.%F{red})${cmd_run_time}${shell_char}%f $(echo -e \\a)'

# set format for the time command
TIMEFMT="%J  %mU user %mS system %P  cpu  %*E total"

# set tty for gpg-agent
export GPG_TTY="$(tty)"
export PINENTRY_USER_DATA="USE_CURSES=1"
odr-update-gpg-agent() {
    gpg-connect-agent updatestartuptty /bye &>/dev/null
}
preexec_functions+=(odr-update-gpg-agent odr-set-begin-cmd-time)

# local config
. ~/.shaliases
[ -f ~/.zshrc.local ] && . ~/.zshrc.local

true # always succeed
