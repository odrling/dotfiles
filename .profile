export BROWSER=firefox
export EDITOR=vi

export PATH="$HOME/.local/bin:$PATH:$HOME/.vim/fzf/bin"

export FZF_DEFAULT_OPTS="-m --no-mouse"
export FZF_DEFAULT_COMMAND="find . -type f | cut -d'/' -f2-"

# fix java swing applications
export _JAVA_AWT_WM_NONREPARENTING=1

# start ssh-agent
eval $(ssh-agent)

[ -f ~/.profile.local ] && . ~/.profile.local

if [ "$(tty)" = '/dev/tty1' ]; then
	pgrep xinit || exec startx
fi

