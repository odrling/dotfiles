local miniclue = require('mini.clue')
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },

        -- movements
        { mode = 'n', keys = 'm' },
        { mode = 'x', keys = 'm' },
        { mode = 'o', keys = 'm' },
        { mode = 'n', keys = 'M' },
        { mode = 'x', keys = 'M' },
        { mode = 'o', keys = 'M' },
    },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        { mode = 'n', keys = '<Leader>g',  desc = "Git+" },
        { mode = 'n', keys = '<Leader>ga', postkeys = '<Leader>g' },
        { mode = 'n', keys = '<Leader>gb', postkeys = '<Leader>g' },
        { mode = 'n', keys = '<Leader>gd', postkeys = '<Leader>g' },
        { mode = 'n', keys = '<Leader>gj', postkeys = '<Leader>g' },
        { mode = 'n', keys = '<Leader>gk', postkeys = '<Leader>g' },
        { mode = 'n', keys = '<Leader>gn', postkeys = '<Leader>g' },
        { mode = 'n', keys = '<Leader>gp', postkeys = '<Leader>g' },
        { mode = 'n', keys = '<Leader>gr', postkeys = '<Leader>g' },
        { mode = 'n', keys = '<Leader>gs', postkeys = '<Leader>g' },
    },

    window = {
        delay = 100,
        config = {
            width = 45,
        }
    }
})
