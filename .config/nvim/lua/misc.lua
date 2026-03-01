vim.opt.number = true
vim.opt.relativenumber = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.list = true
vim.opt.listchars = "tab:│\\x20,nbsp: ,trail:~,extends:>,space: "

vim.opt.wrap = true
vim.opt.textwidth = 79

vim.opt.scrolloff = 5

-- default tabs/space settings
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

vim.o.winborder = 'rounded'

-- no swapfile/backup
vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false

-- don’t let the default gentoo autocmds do their things
vim.api.nvim_del_augroup_by_name("gentoo")

-- use system vim syntaxes/ftdetect
vim.opt.rtp:append('/usr/share/vim/vimfiles')
