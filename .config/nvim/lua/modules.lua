require('config.colorscheme')

require('mini.basics').setup()
require('mini.icons').setup()
require('config.miniclue')
require('mini.surround').setup()
require('mini.statusline').setup()
require('mini.notify').setup()
require('mini.cursorword').setup()
require('config.minihipatterns')
require('config.telescope')
require('mini.starter').setup({ header = "hi" })
require('mini.pick').setup()
require('config.minipairs')
require('mini.snippets').setup()
require('mini.completion').setup()
require('mini.cmdline').setup()
require('mini.jump').setup()

require('gitsigns').setup({ current_line_blame = true })

require('oil').setup({ view_options = { show_hidden = true } })

require("lsp_lines").setup()

require("config.treesitter")
require("render-markdown").setup({ latex = { enabled = false } })

require('config.gitlinker')
