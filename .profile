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
export SWAYIDLE_TURN_OFF=600

export GTK_THEME=Arc

export LESS="-R -z-2 -j4 -F"

# fix java swing applications
export _JAVA_AWT_WM_NONREPARENTING=1

export SFEED_URL_FILE=$HOME/.sfeed/urls

export NEOVIDE_MULTIGRID=1
export PIPX_DEFAULT_PYTHON=/usr/bin/python3.12

export PNPM_HOME="/home/odrling/.local/share/pnpm"
export PATH="$HOME/.local/bin:$HOME/.local/odrbin:$PNPM_HOME:$PATH:$HOME/.luarocks/bin:$HOME/.go/bin"

export FZF_DEFAULT_OPTS="-m"
command -v fd > /dev/null && export FZF_DEFAULT_COMMAND="fd"

export GPG_TTY=$(tty)
[ -n "$SSH_CONNECTION" ] && export PINENTRY_USER_DATA="USE_CURSES=1"

[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && . "$HOME/.nix-profile/etc/profile.d/nix.sh"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.default"

export DWL_STATUS_PIPE="$XDG_RUNTIME_DIR/dwl_status"

ulimit -c unlimited

[ -f ~/.profile.local ] && . ~/.profile.local

[ "$(tty)" = '/dev/tty1' ] && exec startsession
