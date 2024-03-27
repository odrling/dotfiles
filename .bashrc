# -----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <florianbadie@odrling.xyz> wrote this file. As long as you retain this notice
# you can do whatever you want with this stuff. If we meet some day, and you
# think this stuff is worth it, you can buy me a beer in return.   odrling
# -----------------------------------------------------------------------------
# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
[[ $- != *i* ]] && return

## options
shopt -s cdspell      # correct minor spelling errors in cd
shopt -s checkhash    # try the hashtable first
shopt -s checkjobs    # show jobs status before exiting
shopt -s checkwinsize # update term size
shopt -s dirspell     # spelling correction on dir names
shopt -s extglob      # extended globs
shopt -s globstar     # allow to use **
shopt -s histappend   # append to history instead of overwriting it
shopt -s histverify   # don't execute history, show line before
shopt -s nocaseglob   # no case on pathname expansion
shopt -s nocasematch  # no case on matching
shopt -s progcomp_alias # completion for aliases
export HISTCONTROL=ignoredups:ignorespace:erasedups
export HISTFILESIZE=
export HISTIGNORE="&:bg:fg:ls:history:exit:clear:pwd:vi:jobs"
export HISTSIZE=
export HISTTIMEFORMAT="%y/%m/%d %T "
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

## Completions
[ -f /etc/bash_completion ] && . /etc/bash_completion
. ~/.bash/completions

# fzf
if command -v fzf 2>&1 > /dev/null; then
    source ~/.bash/fzf/shell/key-bindings.bash
    source ~/.bash/fzf/shell/completion.bash
fi

source ~/.bash/bash-preexec/bash-preexec.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=auto
source ~/.bash/git-prompt.sh

# OSC-7
osc7_cwd() {
    local strlen=${#PWD}
    local encoded=""
    local pos c o
    for (( pos=0; pos<strlen; pos++ )); do
        c=${PWD:$pos:1}
        case "$c" in
            [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
            * ) printf -v o '%%%02X' "'${c}" ;;
        esac
        encoded+="${o}"
    done
    printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
precmd_functions+=(osc7_cwd)

# set tty for gpg-agent
export GPG_TTY="$(tty)"
export PINENTRY_USER_DATA="USE_CURSES=1"

odr-update-gpg-agent() {
    gpg-connect-agent updatestartuptty /bye &>/dev/null
}
preexec_functions+=(odr-update-gpg-agent)

# prompt
[ "$GRAPHICAL_TTY" = 1 ] && shell_char=❯ || shell_char=$

blue='\[\033[01;34m\]'
green='\[\033[01;32m\]'
red='\[\033[01;31m\]'
reset='\[\033[00m\]'

[ -n "$SSH_CONNECTION" ] && prompt_host="${red}\u@\h "

set_prompt() {
    [ "$?" != 0 ] && prompt_color="$red" || prompt_color="$green"
    PS1="${prompt_host}${blue}\w${green}$(__git_ps1) ${prompt_color}${shell_char}${reset} "
}
precmd_functions+=(set_prompt)

. ~/.shaliases
[ -f ~/.bashrc.local ] && . ~/.bashrc.local

true  # always succeed
