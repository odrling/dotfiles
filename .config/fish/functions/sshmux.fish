function sshmux
	ssh $argv -t '~/.local/bin/tmux-session'
end
