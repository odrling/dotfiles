require('telescope').setup({
    pickers = {
        find_files = {
            -- show hidden files
            hidden = true,
        }
    },
    defaults = {
        layout_strategy = "vertical",
        generic_sorter = require('mini.fuzzy').get_telescope_sorter,
    }
})
