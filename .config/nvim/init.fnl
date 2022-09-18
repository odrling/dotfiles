(import-macros {: augroup!} :macros)

(require :settings)
(require :before)
(require :sync)

(vim.schedule #(require :config.packer))
(vim.cmd.luafile _G.packer_compile_path)
