require('mini.surround').setup({
    custom_surroundings = {
        ['k'] = {
            input = { '%["().-()"%]' },
            output = { left = '["', right = '"]' },
        },
    }
})
