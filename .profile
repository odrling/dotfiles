export BROWSER=firefox
export EDITOR=vi

export FZF_DEFAULT_OPTS="-m --no-mouse"
export FZF_DEFAULT_COMMAND="find . -type f | cut -d'/' -f2-"
export XDG_CONFIG_HOME="$HOME/.config"

export LESS="-R -z-2 -j4"

# fix java swing applications
export _JAVA_AWT_WM_NONREPARENTING=1

[ -f ~/.profile.local ] && . ~/.profile.local

export PNPM_HOME="/home/odrling/.local/share/pnpm"
export PATH="$HOME/.local/bin:$HOME/.local/odrbin:$PNPM_HOME:$PATH:$HOME/.luarocks/bin:$HOME/.go/bin"

if [ "$(tty)" = '/dev/tty1' ]; then
	pgrep xinit || exec startx
fi
