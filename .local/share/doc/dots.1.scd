DOTS(1)

# NAME

dots - manage dotfiles

# SYNOPSIS

*dots* update
*dots* add [OPTIONS]... [<files>]
*dots* commit [OPTIONS]...

# DESCRIPTION

dots is a wrapper around _git_(1) to manage configuration for various user
programs (aka dotfiles). It uses _~/.dots_ as a git directory and _~_ as its worktree, so it is fairly transparent to the user, while still allowing to version files.

# COMMANDS

All regular git commands are available to use and won’t be described here.

_dots update_ should be used to update the dotfiles. It fetches new commits,
checks the signature of the latest commit, updates git submodules and runs
post-update commands (for nvim, uv tools, ...).

# SEE ALSO

_git_(1)
