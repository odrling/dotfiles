local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>s', builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = 'Search help tags' })
vim.keymap.set('n', '<leader>n', vim.cmd.noh, { desc = 'Stop highlighting' })

function format_buf()
    vim.lsp.buf.format({ async = true })
end

vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, { desc = "LSP Go to definition" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Go to definition" })
vim.keymap.set("n", "gf", format_buf, { desc = "LSP format buffer" })
vim.keymap.set("n", "<leader>f", format_buf, { desc = "LSP format buffer" })
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "LSP code actions" })

function oil_cwd()
    vim.cmd.Oil(vim.fn.fnameescape(vim.fn.getcwd()))
end

vim.keymap.set("n", "<leader>e", vim.cmd.Oil, { desc = "File explorer (parent directory)" })
vim.keymap.set("n", "<leader>E", oil_cwd, { desc = "File explorer (working directory)" })

vim.keymap.set(
    "n", "<leader>y",
    function() require('gitlinker').get_buf_range_url('n') end,
    { desc = "Copy permalink" }
)

-- window movement
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")

vim.keymap.set({ 'n', 'x' }, 'gy', '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ 'n', 'x' }, '<C-c>', '"+y', { desc = "Copy to system clipboard" })

vim.keymap.set("n", "<leader>n", "<CMD>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>p", "<CMD>bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<leader>ga", "<CMD>Gitsigns stage_buffer<CR>", { desc = "stage hunk" })
vim.keymap.set("n", "<leader>gs", "<CMD>Gitsigns stage_hunk<CR>", { desc = "stage hunk" })
vim.keymap.set("n", "<leader>gr", "<CMD>Gitsigns reset_hunk<CR>", { desc = "reset hunk" })
vim.keymap.set("n", "<leader>gv", "<CMD>Gitsigns preview_hunk<CR>", { desc = "preview hunk" })
vim.keymap.set("n", "<leader>gb", "<CMD>Gitsigns blame<CR>", { desc = "blame" })
vim.keymap.set("n", "<leader>gn", "<CMD>Gitsigns next_hunk<CR>", { desc = "next hunk" })
vim.keymap.set("n", "<leader>gp", "<CMD>Gitsigns prev_hunk<CR>", { desc = "previous hunk" })
vim.keymap.set("n", "<leader>gd", function()
    local gitsigns = require('gitsigns')
    gitsigns.toggle_linehl()
    gitsigns.toggle_word_diff()
    gitsigns.toggle_deleted()
end, { desc = "inline diff" })

-- treesitter bindings
local select = require('nvim-treesitter-textobjects.select')
local move = require('nvim-treesitter-textobjects.move')

vim.keymap.set(
    { "x", "o" }, "af",
    function()
        select.select_textobject("@function.outer", "textobjects")
    end,
    { desc = "select outer function" }
)
vim.keymap.set(
    { "x", "o" }, "if",
    function()
        select.select_textobject("@function.inner", "textobjects")
    end,
    { desc = "select inner function" }
)
vim.keymap.set(
    { "x", "o" }, "ac",
    function()
        select.select_textobject("@class.outer", "textobjects")
    end,
    { desc = "select outer class" }
)
vim.keymap.set(
    { "x", "o" }, "ic",
    function()
        select.select_textobject("@class.inner", "textobjects")
    end,
    { desc = "select inner class" }
)

vim.keymap.set(
    { "x", "o" }, "as",
    function()
        select.select_textobject("@local.scope", "locals")
    end,
    { desc = "select scope" }
)

local objects = {
    f = {
        name = "function",
        query = "@function.outer",
        query_lib = "textobjects",
    },
    c = {
        name = "class",
        query = "@class.outer",
        query_lib = "textobjects",
    },
    l = {
        name = "loop",
        query = { "@loop.inner", "@loop.outer" },
        query_lib = "textobjects",
    },
    s = {
        name = "scope",
        query = "@local.scope",
        query_lib = "locals",
    },
}

for key, definition in pairs(objects) do
    vim.keymap.set(
        { 'n', 'x', 'o' }, 'm' .. key,
        function()
            move.goto_next_start(definition.query, definition.query_lib)
        end,
        { desc = "go to next " .. definition.name .. " start" }
    )
    vim.keymap.set(
        { 'n', 'x', 'o' }, 'M' .. key,
        function()
            move.goto_next_end(definition.query, definition.query_lib)
        end,
        { desc = "go to next " .. definition.name .. " end" }
    )
    vim.keymap.set(
        { 'n', 'x', 'o' }, 'm' .. key:upper(),
        function()
            move.goto_previous_start(definition.query, definition.query_lib)
        end,
        { desc = "go to previous " .. definition.name .. " start" }
    )
    vim.keymap.set(
        { 'n', 'x', 'o' }, 'M' .. key:upper(),
        function()
            move.goto_previous_end(definition.query, definition.query_lib)
        end,
        { desc = "go to previous " .. definition.name .. " end" }
    )
end

vim.keymap.set(
    'n', 'md',
    function()
        vim.diagnostic.jump({ count = 1, float = true })
    end,
    { desc = "go to next diagnostic" }
)
vim.keymap.set(
    'n', 'mD',
    function()
        vim.diagnostic.jump({ count = -1, float = true })
    end,
    { desc = "go to previous diagnostic" }
)

vim.keymap.set('n', 'mp', '}', { desc = "go to next paragraph" })
vim.keymap.set('n', 'mP', '{', { desc = "go to previous paragraph" })
