# Defined in - @ line 0
function dots --description 'alias dots=git --git-dir=/home/odrling/.dots --work-tree=/home/odrling'
	git --git-dir=/home/odrling/.dots --work-tree=/home/odrling $argv;
end
