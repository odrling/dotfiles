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

# prompt
if command -v starship 2>&1 > /dev/null; then
    source <(starship init bash --print-full-init)
fi

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
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd

command -v direnv 2>&1 > /dev/null && source <(direnv hook bash)

. ~/.shaliases

[ -f ~/.bashrc.local ] && . ~/.bashrc.local

true  # always succeed
