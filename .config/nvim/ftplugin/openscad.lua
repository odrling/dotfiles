local function on_exit_openscad(code, signal)
    vim.notify("openscad stopped (code " .. code .. ")")
end

local function run_openscad()
    local file = vim.fn.expand("%:p")
    vim.uv.spawn("openscad", { args = { file } }, on_exit_openscad)
end

local function create_command()
    vim.api.nvim_buf_create_user_command(0, "Openscad", run_openscad, {})
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>o', '<CMD>Openscad<CR>', { desc = "Open in Openscad" })
end

create_command()
