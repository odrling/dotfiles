(import-macros {: reqcall : augroup!} :macros)

(augroup! :packer-bootstrap
          [[User] PackerComplete (fn []
                                   (vim.cmd.packloadall {:bang true})
                                   (vim.defer_fn #(vim.cmd.augroup {1 :packer-bootstrap :bang true}) 15000))])

(reqcall :packer :sync)
