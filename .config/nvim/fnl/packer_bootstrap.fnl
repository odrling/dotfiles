(import-macros {: reqcall : augroup!} :macros)

(set _G.bootstraping_packer true)
(fn load_all_packages_once []
  (when _G.bootstraping_packer
    (vim.cmd.packloadall {:bang true})
    (set _G.bootstraping_packer false)))

(augroup! :packer-bootstrap
          [[User] PackerComplete 'load_all_packages_once])

(reqcall :packer :sync)
