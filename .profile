export BROWSER=firefox
export EDITOR=vi

export FZF_DEFAULT_OPTS="-m --no-mouse"
export FZF_DEFAULT_COMMAND="find . -type f | cut -d'/' -f2-"
export XDG_CONFIG_HOME="$HOME/.config"
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

export LESS="-R -z-2 -j4"

# fix java swing applications
export _JAVA_AWT_WM_NONREPARENTING=1

export SFEED_URL_FILE=$HOME/.sfeed/urls

[ -f ~/.profile.local ] && . ~/.profile.local

export PNPM_HOME="/home/odrling/.local/share/pnpm"
export PATH="$HOME/.local/bin:$HOME/.local/odrbin:$PNPM_HOME:$PATH:$HOME/.luarocks/bin:$HOME/.go/bin"

[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && . "$HOME/.nix-profile/etc/profile.d/nix.sh"

if [ "$(tty)" = '/dev/tty1' ]; then
	pgrep xinit || exec startx
fi
