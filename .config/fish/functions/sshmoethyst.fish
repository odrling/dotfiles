# Defined in - @ line 0
function sshmoethyst --description alias\ sshmoethyst=ssh\ -t\ amoethyst\ \'\~/.local/bin/tmux-session\'
	ssh -t amoethyst '~/.local/bin/tmux-session' $argv;
end
