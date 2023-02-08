-- :fennel:1675817331
local pack = "tangerine"
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
    vim.cmd.packadd(name)
    return true
  else
    return false
  end
end
local BOOTSTRAP = (vim.env.BOOTSTRAP_NEOVIM ~= nil)
do
  local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
    BOOTSTRAP = true
  else
  end
  do end (vim.opt.rtp):prepend(lazypath)
end
if BOOTSTRAP then
  local status_40_auto, ret_41_auto = nil, nil
  local function _3_()
    local function _4_()
      do
        local status_40_auto0, ret_41_auto0 = nil, nil
        local function _5_()
          return (require("tangerine")).setup({compiler = {hooks = {"onsave", "oninit"}, verbose = false}})
        end
        local function _6_(e_42_auto)
          vim.notify(("tangerine" .. ".setup could not be called"), vim.log.levels.ERROR)
          return vim.notify(("tangerine" .. ".setup:\n" .. e_42_auto), vim.log.levels.TRACE)
        end
        status_40_auto0, ret_41_auto0 = xpcall(_5_, _6_)
        if status_40_auto0 then
        else
        end
      end
      return vim.cmd.quitall({bang = true})
    end
    return (require("lazy")).setup({{priority = 200, config = _4_, lazy = false, "udayvir-singh/tangerine.nvim"}})
  end
  local function _8_(e_42_auto)
    vim.notify(("lazy" .. ".setup could not be called"), vim.log.levels.ERROR)
    return vim.notify(("lazy" .. ".setup:\n" .. e_42_auto), vim.log.levels.TRACE)
  end
  status_40_auto, ret_41_auto = xpcall(_3_, _8_)
  if status_40_auto then
  else
  end
else
end
require("settings")
require("before")
require("sync")
return require("profiling")