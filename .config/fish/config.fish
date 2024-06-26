# .config/fish/config.fish

if status is-login
    source ~/.profile
end

if status is-interactive
    fish_vi_key_bindings 2> /dev/null

    # OSC-7
    function update_cwd_osc --on-variable PWD --description 'Notify terminals when $PWD changes'
        if status --is-command-substitution || set -q INSIDE_EMACS
            return
        end
        printf \e\]7\;file://%s%s\e\\ $hostname (string escape --style=url $PWD)
    end

    update_cwd_osc # Run once since we might have inherited PWD from a parent shell

    # fish overrides it at some point when used as a login shell (?)
    export CDPATH="$ODRCDPATH"

    export VENV_SUFFIX=".fish"
    source ~/.shaliases
end

