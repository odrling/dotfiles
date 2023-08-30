(import-macros {: map! : reqcall} :macros)

(map! [nox] :w  #(reqcall :spider :motion :w))
(map! [nox] :e  #(reqcall :spider :motion :e))
(map! [nox] :b  #(reqcall :spider :motion :b))
(map! [nox] :ge #(reqcall :spider :motion :ge))
