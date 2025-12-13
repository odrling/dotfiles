local dotsdir = vim.fn.expand("$HOME/.dots")
local dotsroot = vim.fn.expand("$HOME")

local function _is_dots_file(file)
    cmd = {
        "git", "--git-dir", dotsdir, "--work-tree", dotsroot,
        "ls-files", "--error-unmatch", file
    }
    vim.fn.system(cmd)
    return vim.v.shell_error == 0
end

local function is_dots_file(file)
    return (
        string.len(file) > 0 and
        vim.fn.filereadable(file) and
        _is_dots_file(file)
    )
end

local function set_git_dir()
    vim.env.GIT_DIR = dotsdir
    vim.env.GIT_WORK_TREE = dotsroot
end

local function unset_git_dir()
    vim.env.GIT_DIR = nil
    vim.env.GIT_WORK_TREE = nil
end

function dots_post_update()
    vim.cmd.TSUpdate()
end

vim.api.nvim_create_autocmd('BufReadPre', {
    pattern = '*',
    callback = function()
        local file = vim.fn.expand('%:p')
        if is_dots_file(file) then
            set_git_dir()
        else
            unset_git_dir()
        end
    end,
})
