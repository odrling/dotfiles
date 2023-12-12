# .config/fish/config.fish

if status is-login
    source ~/.profile
end

if status is-interactive
    fish_vi_key_bindings 2> /dev/null # bind: Key with name “btab” does not have any mapping

    for init in ~/.config/fish/modules/*/init.fish
        source "$init"
    end

    # OSC-7
    function update_cwd_osc --on-variable PWD --description 'Notify terminals when $PWD changes'
        if status --is-command-substitution || set -q INSIDE_EMACS
            return
        end
        printf \e\]7\;file://%s%s\e\\ $hostname (string escape --style=url $PWD)
    end

    update_cwd_osc # Run once since we might have inherited PWD from a parent shell

    command -v fzf >/dev/null && source ~/.bash/fzf/shell/key-bindings.fish
    command -v starship >/dev/null && starship init fish | source
    command -v direnv >/dev/null && direnv hook fish | source

    source ~/.shaliases
end

