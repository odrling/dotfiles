(import-macros {: setup : map!} :macros)

(setup :yanky {})

(map! [n] :p "<Plug>(YankyPutAfter)")
(map! [n] :P "<Plug>(YankyPutBefore)")
(map! [n] :gp "<Plug>(YankyGPutAfter)")
(map! [n] :gP "<Plug>(YankyGPutBefore)")
(map! [n] :<C-n> "<Plug>(YankyCycleForward)")
(map! [n] :<C-p> "<Plug>(YankyCycleBackward)")
