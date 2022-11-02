(import-macros {: setup : map!} :macros)

(setup :bufferline {:options {:show_buffer_close_icons false
                              :show_close_icon false
                              :show_buffer_icons false
                              :separator_style :thin
                              :diagnostics :nvim_lsp}})
