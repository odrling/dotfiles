(import-macros {: exec : map! : defhydra : reqcall} :macros)

(local lsp_hint " _J_: next diagnostic _K_: prev diagnostic _F_: format code  _q_: quit")

(defhydra lsp_hydra
    {:name "LSP"
     :hint lsp_hint
     :config {:color :pink
              :invoke_on_body true
              :hint {:type :cmdline}}
     :mode ["n" "x"]}

    [[] "next diagnostic"    :J #(vim.diagnostic.goto_next {:float true})]
    [[] "prev diagnostic"    :K #(vim.diagnostic.goto_prev {:float true})]
    [[] "format code"        :F #(vim.lsp.buf.format {:async true})]

    [[:exit :nowait] "exit"            :q       nil]
    [[:exit :nowait] false             :<ESC>   nil])

:return lsp_hydra
