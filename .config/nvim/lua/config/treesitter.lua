local treesitter = require('nvim-treesitter')
treesitter.setup({
    install_dir = vim.fn.stdpath('data') .. '/treesitter'
})
require("nvim-treesitter-textobjects").setup()

local languages = {
    'rust',
    'c',
    'cpp',
    'python',
    'zig',
    'bash',
    'lua',
    'markdown',
    'markdown_inline',
    'yaml',
    'html',
}
treesitter.install(languages)

local hl_languages = {
    'markdown',
}

for _, lang in ipairs(hl_languages) do
    vim.api.nvim_create_autocmd('FileType', {
        pattern = { lang },
        callback = function() vim.treesitter.start() end,
    })
end
