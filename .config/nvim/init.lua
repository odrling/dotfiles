local pack = "packer"

local function bootstrap (url)
	local name = url:gsub(".*/", "")
	local path = vim.fn.stdpath [[data]] .. "/site/pack/".. pack .. "/start/" .. name

	if vim.fn.isdirectory(path) == 0 then
		_G["config_bootstraping"] = true
		print(name .. ": installing in data dir...")

		vim.fn.system {"git", "clone", "--depth", "1", url, path}

		vim.cmd.redraw()
		print(name .. ": finished installing")
		vim.cmd.packadd(name)
	end
end

bootstrap "https://github.com/udayvir-singh/tangerine.nvim"
bootstrap "https://github.com/lewis6991/impatient.nvim"
bootstrap "https://github.com/wbthomason/packer.nvim"
bootstrap "https://github.com/rcarriga/nvim-notify"
bootstrap "https://github.com/projekt0n/github-nvim-theme"

require "impatient"

local hooks

if _G["config_bootstraping"] then
	vim.o.loadplugins = false
	hooks = {"onsave", "oninit"}
else
	hooks = {"onsave"}
end

local nvim_dir = vim.fn.stdpath [[config]]

require "tangerine".setup {
	compiler = {
		verbose = false,
		hooks = hooks
	},
	custom = {
		{nvim_dir .. "/fnlftplugin", nvim_dir .. "/ftplugin"}
	}
}
