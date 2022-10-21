(import-macros {: map! : setup} :macros)

(setup :syntax-tree-surfer)

(map! [n] "vx" "<cmd>STSSelectCurrentNode<cr>")
(map! [n] "vn" "<cmd>STSSelectCurrentNode<cr>")

(map! [n] "<A-S-j>" "<cmd>STSSwapCurrentNodeNextNormal<cr>")
(map! [n] "<A-S-k>" "<cmd>STSSwapCurrentNodePrevNormal<cr>")
(map! [n] "<A-j>" "<cmd>STSSwapDownNormal<cr>")
(map! [n] "<A-k>" "<cmd>STSSwapUpNormal<cr>")

(map! [x] "J" "<cmd>STSSelectNextSiblingNode<cr>")
(map! [x] "K" "<cmd>STSSelectPrevSiblingNode<cr>")
(map! [x] "H" "<cmd>STSSelectParentNode<cr>")
(map! [x] "L" "<cmd>STSSelectChildNode<cr>")

(map! [x] "<A-j>" "<cmd>STSSwapNextVisual<cr>")
(map! [x] "<A-k>" "<cmd>STSSwapPrevVisual<cr>")
