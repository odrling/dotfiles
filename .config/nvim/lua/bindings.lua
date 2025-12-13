local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>s', builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = 'Search help tags' })
vim.keymap.set('n', '<leader>n', vim.cmd.noh, { desc = 'Stop highlighting' })

function format_buf()
    vim.lsp.buf.format({ async = true })
end

vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
vim.keymap.set("n", "gf", format_buf, { desc = "LSP: format buffer" })
vim.keymap.set("n", "<leader>f", format_buf, { desc = "LSP: format buffer" })
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "LSP: code actions" })

function oil_cwd()
    vim.cmd.Oil(vim.fn.fnameescape(vim.fn.getcwd()))
end

vim.keymap.set("n", "<leader>e", vim.cmd.Oil, { desc = "File explorer (parent directory)" })
vim.keymap.set("n", "<leader>E", oil_cwd, { desc = "File explorer (working directory)" })

-- window movement
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")

vim.keymap.set("n", "<leader>n", "<CMD>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>p", "<CMD>bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<leader>ga", "<CMD>Gitsigns stage_buffer<CR>", { desc = "Git: stage hunk" })
vim.keymap.set("n", "<leader>gs", "<CMD>Gitsigns stage_hunk<CR>", { desc = "Git: stage hunk" })
vim.keymap.set("n", "<leader>gr", "<CMD>Gitsigns reset_hunk<CR>", { desc = "Git: reset hunk" })
vim.keymap.set("n", "<leader>gv", "<CMD>Gitsigns preview_hunk<CR>", { desc = "Git: preview hunk" })
vim.keymap.set("n", "<leader>gb", "<CMD>Gitsigns blame<CR>", { desc = "Git: blame" })
vim.keymap.set("n", "<leader>gn", "<CMD>Gitsigns next_hunk<CR>", { desc = "Git: preview hunk" })
vim.keymap.set("n", "<leader>gj", "<CMD>Gitsigns next_hunk<CR>", { desc = "Git: preview hunk" })
vim.keymap.set("n", "<leader>gp", "<CMD>Gitsigns prev_hunk<CR>", { desc = "Git: preview hunk" })
vim.keymap.set("n", "<leader>gk", "<CMD>Gitsigns prev_hunk<CR>", { desc = "Git: preview hunk" })
vim.keymap.set("n", "<leader>gw", "<CMD>Gitsigns toggle_word_diff<CR>", { desc = "Git: word diff" })
