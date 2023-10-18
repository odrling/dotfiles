export BROWSER=firefox
export EDITOR=vi

export FZF_DEFAULT_OPTS="-m --no-mouse"
export FZF_DEFAULT_COMMAND="find . -type f | cut -d'/' -f2-"
export XDG_CONFIG_HOME="$HOME/.config"
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring
export S6_SCANDIR="$HOME/.s6/scandir"

export GTK_THEME=Arc

export LESS="-R -z-2 -j4"

# fix java swing applications
export _JAVA_AWT_WM_NONREPARENTING=1

export SFEED_URL_FILE=$HOME/.sfeed/urls

export PNPM_HOME="/home/odrling/.local/share/pnpm"
export PATH="$HOME/.local/bin:$HOME/.local/odrbin:$PNPM_HOME:$PATH:$HOME/.luarocks/bin:$HOME/.go/bin"

[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && . "$HOME/.nix-profile/etc/profile.d/nix.sh"

if test -z "${XDG_RUNTIME_DIR}"; then
  export XDG_RUNTIME_DIR=/tmp/$(id -u)-runtime-dir
  if ! test -d "${XDG_RUNTIME_DIR}"; then
    mkdir "${XDG_RUNTIME_DIR}"
    chmod 0700 "${XDG_RUNTIME_DIR}"
  fi
fi

export DWL_STATUS_PIPE="$XDG_RUNTIME_DIR/dwl_status"

ulimit -c unlimited

[ -f ~/.profile.local ] && . ~/.profile.local

[ "$(tty)" = '/dev/tty1' ] && exec startsession
