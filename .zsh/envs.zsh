# shellcheck shell=zsh

local die() {
    echo -e " ${NOCOLOR-\e[1;31m*\e[0m }${*}" >&2
    return 1
}

local einfo() {
    echo -e " ${NOCOLOR-\e[1;32m*\e[0m }${*}" >&2
}

local ewarn() {
    echo -e " ${NOCOLOR-\e[1;33m*\e[0m }${*}" >&2
}

function source_up() {
    # no-op for compatibility
    ewarn "source_up was called, should be removed in .envrc"
}


function odr-load-venv() {
    local VENV="$1"
    [ -d "$VENV" ] || die "$VENV does not exist"

    export VIRTUAL_ENV=$VENV
    odr-PATH_prepend "$VENV/bin"
    einfo "loaded venv $VENV"
}


local function python-minor-version() {
    echo $(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
}

local function layout() {
    case $1 in
        python3)
            odr-load-venv "$PWD/.direnv/python-$(python-minor-version)"
            ;;
        *)
            ewarn "unsupported layout $1"
    esac
}

function odr-PATH_prepend() {
    export PATH="$1:$PATH"
}

function odr-PATH_append() {
    export PATH="$PATH:$1"
}

local ODRDEBUG=0

function odr-debug-load() {
    [ "$ODRDEBUG" = "1" ] && return

    # export CC=clang
    export CC_LD=mold
    export PYTHONASYNCDEBUG=1
    export PYTHONWARNINGS=default

    case "$1" in
        less) $VENV
            export CFLAGS="-O2 -pipe"
            ;;
        *)
            export CFLAGS="-O2 -pipe -ggdb3 -fsanitize=undefined,address -Wall -Wextra -D_FORTIFY_SOURCE=3"
    esac

    ODRDEBUG=1
    einfo "loaded debug environment"
}

function odr-debug() {
    local arg
    if [ "$1" = auto ]; then
        arg=""
        [ -f .odrdebugless ] && arg=less
    else
        arg="$1"
    fi

    odr-debug-load $arg
}

local loadenvrc() {
    if [ -f "$1/.envrc" ]; then
        einfo "loading $1/.envrc"
        cat "$1/.envrc" >&2
        source "$1/.envrc"
    fi

    [ "$1" = "/" ] && return
    loadenvrc "$(dirname "$1")"
}

function odr-loadenvrc() {
    loadenvrc "$PWD"
}

function odr-load-poetry() {
    [ -f poetry.lock ] || return
    local VENV=$(poetry env info --path)

    if [[ -z $VENV || ! -d $VENV/bin ]]; then
        echo 'No poetry virtual environment found. Use `poetry install` to create one first.'
        return 2
    fi

    odr-load-venv "$VENV"
    export POETRY_ACTIVE=1
}

local function odr-defaultenv() {
    odr-load-poetry
    odr-loadenvrc
}

function odr-envs() {
    case "$PWD" in
        "$HOME/git/misc")
            odr-debug auto
            ;;
        "$HOME/git/"*)
            odr-debug auto && odr-defaultenv 
            ;;
        *) return
    esac
}


chpwd_functions+=(odr-envs)

odr-envs
