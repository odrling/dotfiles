local function on_exit_meson_format(code, signal)
    vim.notify("meson format stopped (code " .. code .. ")")
    vim.schedule(vim.cmd.edit)
end

local function run_meson_format()
    vim.cmd.write()
    local file = vim.fn.expand("%:p")
    vim.uv.spawn("meson", { args = { "format", "-i", file } }, on_exit_meson_format)
end

local function create_command()
    vim.api.nvim_buf_create_user_command(0, "MesonFormat", run_meson_format, {})
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>f', '<CMD>MesonFormat<CR>', { desc = "Format Meson file" })
end

create_command()
