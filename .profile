export BROWSER=firefox
export EDITOR=vi
export PRIMARY_SCREEN=eDP1
export CONNECT_INTERFACE="wlp2s0"

export PATH="$HOME/.local/bin:$PATH:$HOME/.vim/fzf/bin"

export FZF_DEFAULT_OPTS="-m --no-mouse"
export FZF_DEFAULT_COMMAND="find . -type f | cut -d'/' -f2-"

[ -f ~/.local_env ] && . ~/.local_env

if [ "$(tty)" = '/dev/tty1' ]; then
	pgrep xinit || exec startx
fi

