(import-macros {: exec : map! : defhydra : reqcall} :macros)

(local wm_hint "
 ^^^^^^^^^^^^     Size      ^^     Split
 ^^^^^^^^^^^^-------------  ^^---------------
 ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   _s_: horizontally
 _h_ ^ ^ _l_  _H_ ^ ^ _L_   _v_: vertically
 ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   _q_, _c_: close
 focus^^^^^^  window^^^^^^  _=_: equalize^
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   _o_: remain only
")

(defhydra wm_hydra
    {:name "Window Manager"
     :config {:invoke_on_body true
              :hint false
              :on_enter #(vim.notify "wm hydra activated")
              :on_exit  #(vim.notify "wm hydra activated")}
     :mode ["n"]}

    [[] "focus left" :h "<C-w>h"]
    [[] "focus down" :j "<C-w>j"]
    [[] "focus up"   :k "<C-w>k"]
    [[] "focus down" :l "<C-w>l"]

    [[] "resize left"  :H #(reqcall :smart-splits :resize_left 2)]
    [[] "resize down"  :J #(reqcall :smart-splits :resize_down 2)]
    [[] "resize up"    :K #(reqcall :smart-splits :resize_up 2)]
    [[] "resize right" :L #(reqcall :smart-splits :resize_right 2)]

    [[] "split horizontally" :s #(exec [[:split]])]
    [[] "split vertically"   :v #(exec [[:vsplit]])]

    [[] "remain only"        :o  "<C-w>o"]
    [[] "equalize"           "=" "<C-w>="]

    [[] "close"              :c #(exec [[:close]])]
    [[] "close"              :q #(exec [[:close]])]

    [[:exit :nowait] false   :<ESC>   nil])

(map! [n] "<leader>w" #(wm_hydra:activate))
