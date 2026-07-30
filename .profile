# shellcheck shell=sh
command -v systemd-tmpfiles > /dev/null && systemd-tmpfiles --user --create
command -v sd-tmpfiles > /dev/null && sd-tmpfiles --user --create

. ~/.config/environment
[ -f ~/.profile.local ] && . ~/.profile.local

[ "$(tty)" = '/dev/tty1' ] && STARTSESSION=1
[ "$(tty)" = '/dev/tty7' ] && STARTSESSION=1

if [ -t 0 ]; then
    if [ -n "$SSH_CONNECTION" ]; then
        export PINENTRY_USER_DATA="USE_CURSES=1"
    else
        GRAPHICAL_TTY=0
    fi

    [ -z "${STARTSESSION}" ] && exec $SHELL
fi
