require('telescope').setup({
    pickers = {
        -- show hidden files
        hidden = true,
    },
    defaults = {
        layout_strategy = "vertical",
        generic_sorter = require('mini.fuzzy').get_telescope_sorter,
    }
})
