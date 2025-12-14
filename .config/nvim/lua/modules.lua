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
require('mini.surround').setup()
require('config.miniclue')
require('config.minihipatterns')

require('config.telescope')

require('gitsigns').setup({ current_line_blame = true })

require('oil').setup({ view_options = { show_hidden = true } })

require("config.treesitter")
require("render-markdown").setup({ latex = { enabled = false } })

require('config.gitlinker')
