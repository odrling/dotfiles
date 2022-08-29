local pack = "packer"

local function bootstrap (url)
	local name = url:gsub(".*/", "")
	local path = vim.fn.stdpath [[data]] .. "/site/pack/".. pack .. "/start/" .. name

	if vim.fn.isdirectory(path) == 0 then
		_G[name .. "_bootstrap"] = true
		print(name .. ": installing in data dir...")

		vim.fn.system {"git", "clone", "--depth", "1", url, path}

		vim.cmd [[redraw]]
		print(name .. ": finished installing")
	end
end

bootstrap "https://github.com/udayvir-singh/tangerine.nvim"
bootstrap "https://github.com/lewis6991/impatient.nvim"
bootstrap "https://github.com/wbthomason/packer.nvim"

local hooks
if _G["tangerine.nvim_bootstrap"] then
	hooks = {"oninit", "onsave"}
else
	hooks = {"onsave"}
end

-- require "impatient"
require "tangerine".setup {
	compiler = {
		verbose = false,
		hooks = hooks
	}
}