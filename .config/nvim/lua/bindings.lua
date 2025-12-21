local builtin = require('telescope.builtin')

local function nmap(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs, { desc = desc })
end

local function nxmap(lhs, rhs, desc)
    vim.keymap.set({ 'n', 'x' }, lhs, rhs, { desc = desc })
end

local function nxomap(lhs, rhs, desc)
    vim.keymap.set({ 'n', 'x', 'o' }, lhs, rhs, { desc = desc })
end

local function xomap(lhs, rhs, desc)
    vim.keymap.set({ 'x', 'o' }, lhs, rhs, { desc = desc })
end

nmap('<leader><leader>', builtin.find_files, 'Find files')
nmap('<leader>s', builtin.live_grep, 'Live grep')
nmap('<leader>b', builtin.buffers, 'Find buffers')
nmap('<leader>h', builtin.help_tags, 'Search help tags')
nmap('<leader>r', builtin.lsp_references, 'Search LSP references')
nmap('<leader>n', vim.cmd.noh, 'Stop highlighting')

nmap('<C-t>', require('neoterm').open, 'Open terminal')
vim.keymap.set('t', '<C-t>', require('neoterm').close, { desc = 'Close terminal' })

local function format_buf()
    vim.lsp.buf.format({ async = true })
end

nmap("<leader>d", vim.lsp.buf.definition, "LSP Go to definition")
nmap("gd", vim.lsp.buf.definition, "LSP Go to definition")
nmap("gf", format_buf, "LSP format buffer")
nmap("<leader>f", format_buf, "LSP format buffer")
nmap("<leader>a", vim.lsp.buf.code_action, "LSP code actions")

local function oil_cwd()
    vim.cmd.Oil(vim.fn.fnameescape(vim.fn.getcwd()))
end

nmap("<leader>e", vim.cmd.Oil, "File explorer (parent directory)")
nmap("<leader>E", oil_cwd, "File explorer (working directory)")

nmap(
    "<leader>y",
    function() require('gitlinker').get_buf_range_url('n') end,
    "Copy permalink"
)

-- window movement
nmap("<C-j>", "<C-W>j")
nmap("<C-k>", "<C-W>k")
nmap("<C-h>", "<C-W>h")
nmap("<C-l>", "<C-W>l")

nxmap('gy', '"+y', "Copy to system clipboard")
nxmap('<C-c>', '"+y', "Copy to system clipboard")

nmap("<leader>n", "<CMD>bnext<CR>", "Next buffer")
nmap("<leader>p", "<CMD>bprevious<CR>", "Previous buffer")

nmap("<leader>ga", "<CMD>Gitsigns stage_buffer<CR>", "stage hunk")
nmap("<leader>gs", "<CMD>Gitsigns stage_hunk<CR>", "stage hunk")
nmap("<leader>gr", "<CMD>Gitsigns reset_hunk<CR>", "reset hunk")
nmap("<leader>gv", "<CMD>Gitsigns preview_hunk<CR>", "preview hunk")
nmap("<leader>gb", "<CMD>Gitsigns blame<CR>", "blame")
nmap("<leader>gn", "<CMD>Gitsigns next_hunk<CR>", "next hunk")
nmap("<leader>gp", "<CMD>Gitsigns prev_hunk<CR>", "previous hunk")

nmap("<leader>gd", function()
    local gitsigns = require('gitsigns')
    gitsigns.toggle_linehl()
    gitsigns.toggle_word_diff()
    gitsigns.toggle_deleted()
end, "Toggle inline diff")

-- treesitter bindings
local select = require('nvim-treesitter-textobjects.select')
local move = require('nvim-treesitter-textobjects.move')

xomap(
    "af",
    function()
        select.select_textobject("@function.outer", "textobjects")
    end,
    "select outer function"
)
xomap(
    "if",
    function()
        select.select_textobject("@function.inner", "textobjects")
    end,
    "select inner function"
)
xomap(
    "ac",
    function()
        select.select_textobject("@class.outer", "textobjects")
    end,
    "select outer class"
)
xomap(
    "ic",
    function()
        select.select_textobject("@class.inner", "textobjects")
    end,
    "select inner class"
)

xomap(
    "as",
    function()
        select.select_textobject("@local.scope", "locals")
    end,
    "select scope"
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
    nxomap(
        'm' .. key,
        function()
            move.goto_next_start(definition.query, definition.query_lib)
        end,
        "go to next " .. definition.name .. " start"
    )
    nxomap(
        'M' .. key,
        function()
            move.goto_next_end(definition.query, definition.query_lib)
        end,
        "go to next " .. definition.name .. " end"
    )
    nxomap(
        'm' .. key:upper(),
        function()
            move.goto_previous_start(definition.query, definition.query_lib)
        end,
        "go to previous " .. definition.name .. " start"
    )
    nxomap(
        'M' .. key:upper(),
        function()
            move.goto_previous_end(definition.query, definition.query_lib)
        end,
        "go to previous " .. definition.name .. " end"
    )
end

nmap('md',
    function()
        vim.diagnostic.jump({ count = 1, float = true })
    end,
    "go to next diagnostic"
)
nmap('mD',
    function()
        vim.diagnostic.jump({ count = -1, float = true })
    end,
    "go to previous diagnostic"
)

nmap('mp', '}', "go to next paragraph")
nmap('mP', '{', "go to previous paragraph")
