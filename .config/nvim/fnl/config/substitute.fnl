(import-macros {: map!} :macros)

(local substitute (require :substitute))
(substitute.setup {})

(map! [n] "s" 'substitute.operator)
(map! [n] "ss" 'substitute.line)
(map! [n] "S" 'substitute.eol)
