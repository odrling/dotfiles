# .config/fish/config.fish

fish_vi_key_bindings 2> /dev/null # bind: Key with name “btab” does not have any mapping

alias dots="git --git-dir=$HOME/.dots --work-tree=$HOME"

for init in ~/.config/fish/modules/*/init.fish
    source "$init"
end
