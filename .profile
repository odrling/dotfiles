export BROWSER=firefox
export EDITOR=vi
export DEFAULT_OUTPUT="HDMI1"
export CONNECT_INTERFACE="wlp2s0"

export PATH="$HOME/.local/bin:$PATH"

if [ "$(tty)" = '/dev/tty1' ]; then
	pgrep xinit || exec startx
fi

