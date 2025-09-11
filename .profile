# shellcheck shell=sh
export BROWSER=firefox
export EDITOR=vi

export FZF_DEFAULT_OPTS="-m --no-mouse"
export FZF_DEFAULT_COMMAND="find . -type f | cut -d'/' -f2-"
export XDG_CONFIG_HOME="$HOME/.config"
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

# fcitx
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

export S6_SCANDIR="$HOME/.s6/scandir"

export SWAYIDLE_LOCK=300
export SWAYIDLE_TURN_OFF=270

export GTK_THEME=Arc

export LESSCOLORIZER="highlight -O ansi"
export LESS="-R -z-2 -j4 -F"

command -v delta >/dev/null 2>&1 && export GIT_PAGER=delta

# fix java swing applications
export _JAVA_AWT_WM_NONREPARENTING=1

# don’t download another go toolchain
export GOTOOLCHAIN=local

export SFEED_URL_FILE=$HOME/.sfeed/urls

export NEOVIDE_MULTIGRID=1

export PNPM_HOME="/home/odrling/.local/share/pnpm"
export PATH="$HOME/.local/bin:$HOME/.local/odrbin:$PNPM_HOME:$PATH:$HOME/.luarocks/bin:$HOME/.go/bin"

export FZF_DEFAULT_OPTS="-m"
command -v fd > /dev/null && export FZF_DEFAULT_COMMAND="fd"

export GPG_TTY=$(tty)

ODRCDPATH=".:$HOME/git"

export GRAPHICAL_TTY=1

export GITSTATUS_AUTO_INSTALL=0
export GITSTATUS_DAEMON=/usr/libexec/gitstatus/gitstatusd

export UV_PYTHON_PREFERENCE=system
export UV_PYTHON_DOWNLOADS=never

export FREETYPE_PROPERTIES="cff:no-stem-darkening=0"

export ELECTRON_OZONE_PLATFORM_HINT=auto

export TZ=:/etc/localtime

[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && . "$HOME/.nix-profile/etc/profile.d/nix.sh"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

ulimit -c unlimited

[ "$(tty)" = '/dev/tty1' ] && STARTSESSION=1

[ -f ~/.profile.local ] && . ~/.profile.local

export CDPATH="$ODRCDPATH"
[ -e "${XDG_CACHE_DIR}" ] && GOPATH=${XDG_CACHE_DIR}/go || GOPATH=~/.cache/go
export GOPATH

command -v systemd-tmpfiles > /dev/null && systemd-tmpfiles --user --create
command -v sd-tmpfiles > /dev/null && sd-tmpfiles --user --create

if [ -t 0 ]; then
    [ "${STARTSESSION}" = 1 ] && exec startsession

    if [ -n "$SSH_CONNECTION" ]; then
        export PINENTRY_USER_DATA="USE_CURSES=1"
    else
        GRAPHICAL_TTY=0
    fi

    exec $SHELL
fi
