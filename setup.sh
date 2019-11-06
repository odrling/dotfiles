#!/bin/sh -e
alias dots="git --git-dir=$HOME/.dots --work-tree=$HOME"

dots init "$HOME"
dots remote add origin https://git.odrling.xyz/odrling/dotfiles.git
dots fetch origin master
[ -f "$HOME/.profile" ] && mv -vi "$HOME/.profile" "$HOME/.profile.local"
[ -f "$HOME/.zshrc" ] && mv -vi "$HOME/.zshrc" "$HOME/.zshrc.local"
dots checkout -b master --track origin/master
dots submodule update --init --recursive
