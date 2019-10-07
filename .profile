export BROWSER=firefox
export EDITOR=vi

export PATH="$HOME/.local/bin:$PATH:$HOME/.vim/fzf/bin"

export FZF_DEFAULT_OPTS="-m --no-mouse"
export FZF_DEFAULT_COMMAND="find . -type f | cut -d'/' -f2-"

[ -f ~/.profile.local ] && . ~/.profile.local

if [ "$(tty)" = '/dev/tty1' ]; then
	pgrep xinit || exec startx
fi

