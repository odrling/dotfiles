require('telescope').setup({
    defaults = {
        layout_strategy = "vertical",
        generic_sorter = require('mini.fuzzy').get_telescope_sorter,
    }
})
