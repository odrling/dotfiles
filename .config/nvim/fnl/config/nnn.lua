vim.api.nvim_set_keymap("n", "<C-n>", "<CMD>NnnPicker<CR>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-n>", "<CMD>NnnPicker<CR>", { noremap = true })

require("nnn").setup {
    replace_netrw = "picker"
}
