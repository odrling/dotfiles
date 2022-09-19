-- :fennel:1663560130
local pack = "packer"
local function bootstrap(url)
  _G.assert((nil ~= url), "Missing argument url on initfnl/init.fnl:4")
  local name = url:gsub(".*/", "")
  local path = (vim.fn.stdpath("data") .. "/site/pack/" .. pack .. "/start/" .. name)
  if (vim.fn.isdirectory(path) == 0) then
    _G.config_bootstraping = true
    print((name .. ": installing in data dir..."))
    vim.fn.system({"git", "clone", "--depth", "1", url, path})
    vim.cmd.redraw()
    print((name .. ": finished installing"))
    return vim.cmd.packadd(name)
  else
    return nil
  end
end
bootstrap("https://github.com/udayvir-singh/tangerine.nvim")
bootstrap("https://github.com/lewis6991/impatient.nvim")
bootstrap("https://github.com/wbthomason/packer.nvim")
bootstrap("https://github.com/rcarriga/nvim-notify")
bootstrap("https://github.com/projekt0n/github-nvim-theme")
require("impatient")
vim.o.loadplugins = false
local nvim_dir = vim.fn.stdpath("config")
local status_40_auto, ret_41_auto = nil, nil
local function _2_()
  local function _3_()
    if _G.config_bootstraping then
      return "oninit"
    else
      return nil
    end
  end
  return (require("tangerine")).setup({compiler = {hooks = {"onsave", _3_()}, verbose = false}, custom = {{(nvim_dir .. "/ftplugin"), (nvim_dir .. "/ftplugin")}, {(nvim_dir .. "/initfnl"), nvim_dir}}})
end
local function _4_(e_42_auto)
  vim.notify(("tangerine" .. ".setup could not be called"), vim.log.levels.ERROR)
  return vim.notify(("tangerine" .. ".setup:\n" .. e_42_auto), vim.log.levels.TRACE)
end
status_40_auto, ret_41_auto = xpcall(_2_, _4_)
if status_40_auto then
  return ret_41_auto
else
  return nil
end