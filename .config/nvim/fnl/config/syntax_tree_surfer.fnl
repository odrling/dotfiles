(import-macros {: map! : setup} :macros)

(setup :syntax-tree-surfer)

(map! [n] "vx" "<cmd>STSSelectCurrentNode<cr>")
(map! [n] "vn" "<cmd>STSSelectCurrentNode<cr>")

(map! [n] "<C-j>" "<cmd>STSSwapCurrentNodeNextNormal<cr>")
(map! [n] "<C-k>" "<cmd>STSSwapCurrentNodePrevNormal<cr>")
(map! [n] "<C-S-j>" "<cmd>STSSwapDownNormal<cr>")
(map! [n] "<C-S-k>" "<cmd>STSSwapUpNormal<cr>")

(map! [x] "J" "<cmd>STSSelectNextSiblingNode<cr>")
(map! [x] "K" "<cmd>STSSelectPrevSiblingNode<cr>")
(map! [x] "H" "<cmd>STSSelectParentNode<cr>")
(map! [x] "L" "<cmd>STSSelectChildNode<cr>")

(map! [x] "<C-S-j>" "<cmd>STSSwapNextVisual<cr>")
(map! [x] "<C-S-k>" "<cmd>STSSwapPrevVisual<cr>")
