(import-macros {: exec : map! : defhydra : reqcall} :macros)

(local lsp_hint " _J_: next diagnostic _L_: toggle diagnostics _K_: prev diagnostic _F_: format code  _q_: quit")

(defhydra lsp_hydra
    {:name "LSP"
     :hint lsp_hint
     :config {:color :pink
              :invoke_on_body true
              :hint {:type :cmdline}
              :on_key #(print lsp_hint)}
     :mode ["n" "x"]}

    [[] "next diagnostic"    :J #(vim.diagnostic.goto_next {:float false})]
    [[] "prev diagnostic"    :K #(vim.diagnostic.goto_prev {:float false})]
    [[] "format code"        :F #(vim.lsp.buf.format {:async true})]
    [[] "toggle diagnostics" :L #(reqcall :lsp_lines :toggle)]

    [[:exit :nowait] "exit"            :q       nil]
    [[:exit :nowait] false             :<ESC>   nil])

:return lsp_hydra
