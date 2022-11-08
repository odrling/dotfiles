(import-macros {: map! : reqcall} :macros)

(map! [n] :<leader>q #(reqcall :Buffers :delete))
(map! [n] :<leader>Q #(reqcall :Buffers :only))
