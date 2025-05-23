#! /bin/zsh
#
# zsh-fzy.plugin.zsh
# Copyright (C) 2018 Adrian Perez <aperez@igalia.com>
#
# Distributed under terms of the MIT license.
#

if command -v fzf > /dev/null 2>&1; then
  eval $(fzf --zsh)
  return 0
elif command -v fzy > /dev/null 2>&1; then
  ZSH_FZY=fzy
else
  return 1
fi
ZSH_FZY_TMUX="${0:A:h}/fzy-tmux"

function fzy-history-default-command
{
	builtin fc -l -n -r 1
}

function fzy-file-default-command
{
	command find -L . \( -path '*/\.*' -o -fstype dev -o -fstype proc \) -prune \
		-o -type f -print \
		-o -type d -print \
		-o -type l -print 2> /dev/null | sed 1d | cut -b3-
}

function fzy-cd-default-command
{
	command find -L . \( -path '*/\.*' -o -fstype dev -o -fstype proc \) -prune \
		-o -type d -print 2> /dev/null | sed 1d | cut -b3-
}

function fzy-proc-default-command
{
	command ps -ef | sed 1d
}

function __fzy_cmd
{
	emulate -L zsh

	local widget=$1
	shift

	local -a args=( )
	local value
	if zstyle -s ":fzy:${widget}" prompt value ; then
		args+=( "--prompt=${value}" )
	else
		args+=( "--prompt=${widget} >> " )
	fi
	if zstyle -s ":fzy:${widget}" lines value ; then
		if [[ ${value} = min:* ]]; then
			local pos
			print '\e[6n' > /dev/tty
			read -rsd 'R' pos < /dev/tty
			pos=${pos#*\[}
			pos=${pos%;*}
			value=${value#min:}
			local available_lines=$(( LINES - pos - 1 ))
			if [[ ${available_lines} -gt ${value} ]]; then
				value=${available_lines}
			fi
		fi
		args+=( -l "${value}" )
	fi
	if zstyle -t ":fzy:${widget}" show-scores ; then
		args+=( -s )
	fi

	local -a cmd
	zstyle -a ":fzy:${widget}" command cmd || cmd=( )
	if [[ ${#cmd} -eq 0 ]] ; then
		cmd=("fzy-${widget}-default-command")
	fi

	[ "${ZSH_FZY}" = fzf ] && [ "${widget}" = history ] && args+=( --scheme=history )
	if zstyle -t :fzy:tmux enabled && [[ -n ${TMUX} ]] ; then
		"${cmd[@]}" | "${ZSH_FZY_TMUX}" -- "${args[@]}" "$@"
	else
		"${cmd[@]}" | "${ZSH_FZY}" "${args[@]}" "$@"
	fi
}

function __fzy_fsel
{
	__fzy_cmd file | while read -r item ; do
		echo -n "${(q)item} "
	done
	echo
}

function __fzy_psel
{
	__fzy_cmd proc | awk '{print $2}' | tr '\n' ' '
}

function fzy-file-widget
{
	emulate -L zsh
	zle -I
	LBUFFER="${LBUFFER}$(__fzy_fsel)"
	zle reset-prompt
}

function fzy-cd-widget
{
	emulate -L zsh
	zle -I
	cd "${$(__fzy_cmd cd):-.}"
	zle reset-prompt
}

function fzy-history-widget
{
	emulate -L zsh
	zle -I
	local S=$(__fzy_cmd history -q "${LBUFFER//$/\\$}")
	if [[ -n $S ]] ; then
		LBUFFER=$S
	fi
	zle reset-prompt
}

function fzy-proc-widget
{
	emulate -L zsh
	zle -I
	LBUFFER="${LBUFFER}$(__fzy_psel)"
	zle reset-prompt
}

zle -N fzy-file-widget
zle -N fzy-cd-widget
zle -N fzy-history-widget
zle -N fzy-proc-widget

bindkey '\ec' fzy-cd-widget
bindkey '^T'  fzy-file-widget
bindkey '^R'  fzy-history-widget
bindkey '^P'  fzy-proc-widget
