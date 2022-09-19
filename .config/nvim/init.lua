-- :fennel:1663618382
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
local nvim_dir = vim.fn.stdpath("config")
do
  local augid_2_ = vim.api.nvim_create_augroup("fennel_init_lua", {clear = true})
  local function _3_()
    local status_37_auto, ret_38_auto = nil, nil
    local function _4_()
      return (require("tangerine.api.compile")).dir((nvim_dir .. "/initfnl"), nvim_dir)
    end
    local function _5_(e_39_auto)
      vim.notify(("tangerine.api.compile" .. "." .. "dir" .. " could not be called"), vim.log.levels.ERROR)
      return vim.notify(("tangerine.api.compile" .. "." .. "dir" .. ":\n" .. e_39_auto), vim.log.levels.TRACE)
    end
    status_37_auto, ret_38_auto = xpcall(_4_, _5_)
    if status_37_auto then
      return ret_38_auto
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd({"BufWritePost"}, {callback = _3_, group = augid_2_, nested = false, once = false, pattern = "init.fnl"})
end
do
  local status_40_auto, ret_41_auto = nil, nil
  local function _7_()
    return (require("tangerine")).setup({compiler = {hooks = {"onsave"}, verbose = false}, custom = {{(nvim_dir .. "/ftplugin"), (nvim_dir .. "/ftplugin")}}})
  end
  local function _8_(e_42_auto)
    vim.notify(("tangerine" .. ".setup could not be called"), vim.log.levels.ERROR)
    return vim.notify(("tangerine" .. ".setup:\n" .. e_42_auto), vim.log.levels.TRACE)
  end
  status_40_auto, ret_41_auto = xpcall(_7_, _8_)
  if status_40_auto then
  else
  end
end
local _10_
do
  local tbl_15_auto = {}
  local i_16_auto = #tbl_15_auto
  local function _13_(...)
    local status_37_auto, ret_38_auto = nil, nil
    local function _11_()
      return (require("tangerine.vim.hooks")).run()
    end
    local function _12_(e_39_auto)
      vim.notify(("tangerine.vim.hooks" .. "." .. "run" .. " could not be called"), vim.log.levels.ERROR)
      return vim.notify(("tangerine.vim.hooks" .. "." .. "run" .. ":\n" .. e_39_auto), vim.log.levels.TRACE)
    end
    status_37_auto, ret_38_auto = xpcall(_11_, _12_)
    if status_37_auto then
      return ret_38_auto
    else
      return nil
    end
  end
  for _, v in ipairs(_13_(...)) do
    local val_17_auto
    if (v == "config/packer.fnl") then
      val_17_auto = v
    else
      val_17_auto = nil
    end
    if (nil ~= val_17_auto) then
      i_16_auto = (i_16_auto + 1)
      do end (tbl_15_auto)[i_16_auto] = val_17_auto
    else
    end
  end
  _10_ = tbl_15_auto
end
_G.tangerine_recompiled_packer = (#_10_ > 0)
require("settings")
require("before")
return require("sync")