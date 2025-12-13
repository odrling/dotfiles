local treesitter = require('nvim-treesitter')
treesitter.setup({
    install_dir = vim.fn.stdpath('data') .. '/treesitter'
})

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

local hl_languages = {}
for _, lang in ipairs(hl_languages) do
    vim.api.nvim_create_autocmd('FileType', {
        pattern = { lang },
        callback = function() vim.treesitter.start() end,
    })
end
