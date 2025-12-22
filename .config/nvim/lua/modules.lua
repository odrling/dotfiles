require('config.colorscheme')

require('mini.basics').setup({ mappings = { basic = false } })
require('mini.cmdline').setup({ autocorrect = { enabled = false } })
require('mini.completion').setup()
require('mini.cursorword').setup()
require('mini.icons').setup()
require('mini.jump').setup()
require('mini.notify').setup()
require('mini.pick').setup()
require('mini.snippets').setup()
require('mini.starter').setup({ header = "hi" })
require('mini.statusline').setup()
require('config.miniclue')
require('config.minihipatterns')
require('config.minisurround')

require('config.telescope')

require('gitsigns').setup({ current_line_blame = true })

require('config.oil')

require('inc_rename').setup()

require("config.treesitter")
require("render-markdown").setup({ latex = { enabled = false } })
require("nvim-ts-autotag").setup()

require('config.gitlinker')

require('neoterm').setup({ position = 'center', width = 0.85, height = 0.85 })

vim.cmd.helptags('ALL')
