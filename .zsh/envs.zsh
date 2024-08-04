# -----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <florianbadie@odrling.xyz> wrote this file. As long as you retain this notice
# you can do whatever you want with this stuff. If we meet some day, and you
# think this stuff is worth it, you can buy me a beer in return.   odrling
# -----------------------------------------------------------------------------

# shellcheck shell=zsh

die() {
    echo -e " ${NOCOLOR-\e[1;31m*\e[0m }${*}" >&2
    return 1
}

einfo() {
    echo -e " ${NOCOLOR-\e[1;32m*\e[0m }${*}" >&2
}

ewarn() {
    echo -e " ${NOCOLOR-\e[1;33m*\e[0m }${*}" >&2
}

odr-load-venv() {
    local VENV="$1"
    [ -d "$VENV" ] || die "$VENV does not exist"

    export VIRTUAL_ENV=$VENV
    odr-PATH_prepend "$VENV/bin"
    einfo "loaded venv $VENV"
}


odr-python-minor-version() {
    echo $(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
}

odr-PATH_prepend() {
    export PATH="$1:$PATH"
}

odr-PATH_append() {
    export PATH="$PATH:$1"
}

odr-allow-envrc() {
    git config --local odr.loadenvrc 1
    [ "$1" = --git ] && git config --local odr.loadgitenvrc 1
    odr-loadenvrc "$PWD"
}

odr-warn-envrc() {
    [ -f "$1/.envrc" ] && ewarn "$1/.envrc exists but won't be loaded. Use allow-envrc to load it."
    [ "$1" != "/" ] && odr-warn-envrc "$(dirname "$1")"
}

odr-check-source() {
    if ! [ "$(git ls-files "$1" | wc -l)" -eq 0 ]; then
        if [ "$(git config --local odr.loadgitenvrc)" != 1 ]; then
            die "$1 is in a git repository."
            die "This could be dangerous, anyone else could update this file in a PR."
            die "If this is fine you can allow this file to be loaded with allow-envrc --git"
            return $?
        fi
    fi

    einfo "loading $1"
    cat "$1" >&2
    source "$1"
}

odr-loadenvrc() {
    if [ "$(git config odr.loadenvrc)" != 1 ]; then
        git rev-parse --is-inside-work-tree &>/dev/null && odr-warn-envrc "$PWD"
        return
    fi

    parentdir="$(dirname "$1")"
    [ "$1" != "${parentdir}" ] && odr-loadenvrc "${parentdir}"
    [ -f "$1/.envrc" ] && odr-check-source "$1/.envrc"
}

odr-load-poetry() {
    [ -f poetry.lock ] || return 1
    local VENV=$(poetry env info --path)

    if [[ -z $VENV || ! -d $VENV/bin ]]; then
        ewarn 'No poetry virtual environment found. Use `poetry install` to create one first.'
        return 2
    fi

    odr-load-venv "$VENV"
    export POETRY_ACTIVE=1
}

create-python-venv() {
    VENVDIR="${PWD}/.venv/python-$(odr-python-minor-version)"
    python -m venv "${VENVDIR}"
}

odr-enable-python-venv() {
    git config odr.pythonvenv 1
    odr-load-python-venv
}

odr-disable-python-venv() {
    git config odr.pythonvenv 0
    deactivate
}

odr-load-python-venv() {
    if [ -f poetry.lock ]; then
        odr-load-poetry
    elif [ -f pyproject.toml ]; then
        VENVDIR="${PWD}/.venv/python-$(odr-python-minor-version)"
        if [ -d "$VENVDIR" ]; then
            odr-load-venv "$VENVDIR"
        else
            ewarn "found pyproject.toml file but no local venv"
        fi
    elif [ "$(git config odr.pythonvenv)" = 1 ]; then
        VENVDIR="${PWD}/.venv/python-$(odr-python-minor-version)"
        if [ -d "$VENVDIR" ]; then
            odr-load-venv "$VENVDIR"
        else
            ewarn "found git config odr.pythonvenv but no local venv"
        fi
    else
        return 1
    fi

    odr-detect-python-hooks
}

odr-display-hooks() {
    [ -n "${DETECTED_HOOKS}" ] && 
        einfo "Detected hooks: ${DETECTED_HOOKS}. Enable them with enable-detected-hooks"
    git config --get-regexp odrhooks\. 2>/dev/null
}

odr-detect-python-hooks() {
    local possible_hooks=(ruff isort black pyright)
    local hooks=()

    for hook in ${possible_hooks[@]}; do
        grep $hook pyproject.toml &>/dev/null && odr-add-detected-hooks $hook
    done
}

odr-add-detected-hooks() {
    for name in "${@}"; do
        [ "$(git config odrhooks.${name})" != 1 ] && DETECTED_HOOKS+=("${name}")
    done
}

odr-detect-hooks() {
    [ -f "meson.build" ] && odr-add-detected-hooks muon mesonfmt mesontest
    [ -f "go.mod" ] && odr-add-detected-hooks gofmt goerrcheck
}

odr_previous_dir=''

odr-defaultenv() {
    [ "$PWD" = "${odr_previous_dir}" ] && return
    DETECTED_HOOKS=()
    odr_previous_dir="$PWD"
    odr-load-python-venv
    odr-loadenvrc
    odr-detect-hooks
    odr-display-hooks
}

odr-envs() {
    odr-defaultenv
}

enable-hook() {
    for hook in $@; do
        einfo "Enabling $hook hook"
        git config --local "odrhooks.$hook" 1
    done
}

disable-hook() {
    for hook in $@; do
        einfo "Disabling $hook hook"
        git config --local "odrhooks.$hook" 0
    done
}

enable-detected-hooks() {
    enable-hook "${DETECTED_HOOKS[@]}"
}

source_up() {
    ewarn "source_up was called and is a no-op, should be removed in .envrc"
}

layout() {
    ewarn "layout was called and is a no-op, should be removed in .envrc"
}

case "$0" in
    *bash)
        precmd_functions+=(odr-envs) ;;
    *zsh)
        chpwd_functions+=(odr-envs) ;;
esac

alias allow-envrc=odr-allow-envrc

odr-envs
