(import-macros {: setup} :macros)

(setup :lualine {:options {:icons_enabled false
                           :component_separators {:left "│" :right "│"}
                           :section_separators {:left "" :right ""}}
                 :sections {:lualine_a [:mode]
                            :lualine_b [:branch
                                        :diff 
                                        :diagnostics 
                                        {1 :macro
                                         :fmt #(let [reg (vim.fn.reg_recording)]
                                                 (when (~= reg "")
                                                   (.. "Recording @" reg)))}]
                            :lualine_c [:filename]
                            :lualine_x [:encoding :fileformat :filetype]
                            :lualine_y [:progress :location]
                            :lualine_z [:hostname]}})
