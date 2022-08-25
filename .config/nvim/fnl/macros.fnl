(local M {})

;; -------------------- ;;
;;        FENNEL        ;;
;; -------------------- ;;
(fn fennel []
  ; require fennel
  (var (ok out) (pcall require :tangerine.fennel))
  (if ok
    (set out (out.load))
    (set (ok out) (pcall require :fennel)))
  ; assert
  (assert-compile ok
    (.. "  hibiscus: module for \34fennel\34 not found.\n\n"
        "    * install fennel globally or install tangerine.nvim."))
  :return out)


;; -------------------- ;;
;;        UTILS         ;;
;; -------------------- ;;
(macro fun [name ...]
  "defines function 'name' and exports it to M."
  `(tset M ,(tostring name) (fn ,name ,...)))

(macro lmd [name args ...]
  "defines lambda function 'name' and exports it to M."
  (local asrt [])
  (each [_ arg (ipairs args)]
    (if (not= "?" (string.sub (tostring arg) 1 1))
        (table.insert asrt
          `(assert-compile (not= ,arg nil)
                           (.. "  " ,(tostring name) ": Missing required argument '" ,(tostring arg) "'.") ,arg))))
  `(tset M ,(tostring name)
           (fn ,name ,args (do ,(unpack asrt)) ,...)))

(lambda set- [name val]
  "sets variable 'name' to 'val' and returns its value."
  `(do (set ,name ,val)
       :return ,name))

(lambda tset- [tbl key val]
  "sets 'key' in 'tbl' to 'val' and returns its value."
  `(do (tset ,tbl ,key ,val)
       :return (. ,tbl ,key)))

(lambda dolist [lst]
  "unpacks 'lst' and wrap it within do block."
  `(do ,(unpack lst)))

(lambda parse-sym [xs]
  "parses symbol 'xs' converts it to string if not a variable."
  (if (or (in-scope? xs) (not (sym? xs)))
      (do xs)
      (tostring xs)))

(lambda parse-list [sx]
  "parses symbols present in sequence 'sx'."
  (if (sequence? sx)
      (vim.tbl_map parse-sym sx)
      (parse-sym sx)))

(lmd has! [feature]
  [vim.fn.has feature])


;; -------------------- ;;
;;       GENERAL        ;;
;; -------------------- ;;
(macro or= [x ...]
  "checks if 'x' is equal to any one of {...}"
  `(do
    (var out# false)
    (each [# v# (ipairs [,...])]
      (when (= ,x v#)
        (set out# true)
        (lua :break)))
    :return out#))


;; -------------------- ;;
;;       FSTRING        ;;
;; -------------------- ;;
(lmd ast [expr]
  "parses fennel 'expr' into ast."
  (local (ok out)
         (((. (fennel) :parser) expr "fstring")))
  :return out)

(lmd fstring [str]
  "wrapper around string.format, works like javascript's template literates."
  (local args [])
  (each [xs (str:gmatch "$([({][^$]+[})])")]
    (if (xs:find "^{")
        (table.insert args (sym (xs:match "^{(.+)}$")))
        (table.insert args (ast xs))))
  :return
  `(string.format ,(str:gsub "$[({][^$]+[})]" "%%s") ,(unpack args)))


;; -------------------- ;;
;;       CHECKING       ;;
;; -------------------- ;;
(lambda nil? [x]
  "checks if value of 'x' is nil."
  `(= nil ,x))

(lambda boolean? [x]
  "checks if 'x' is of boolean type."
  `(= :boolean (type ,x)))

(lambda string? [x]
  "checks if 'x' is of string type."
  `(= :string (type ,x)))

(lambda number? [x]
  "checks if 'x' is of number type."
  `(= :number (type ,x)))

(lambda odd? [x]
  "checks if 'x' is mathematically of odd parity ;}"
  `(and (= :number (type ,x)) (= 1 (% ,x 2))))

(lambda even? [x]
  "checks if 'x' is mathematically of even parity ;}"
  `(and (= :number (type ,x)) (= 0 (% ,x 2))))

(lambda fn? [x]
  "checks if 'x' is of function type."
  `(= :function (type ,x)))

(lambda table? [x]
  "checks if 'x' is of table type."
  `(= :table (type ,x)))

(lambda list? [tbl]
  "checks if 'tbl' is a valid list."
  `(vim.tbl_islist ,tbl))

(lambda empty? [tbl]
  "checks if 'tbl' is empty."
  `(and ,(table? tbl)
        (= 0 (length ,tbl))))


;; -------------------- ;;
;;        NUMBER        ;;
;; -------------------- ;;
(lmd inc [int]
  "increments 'int' by 1."
  `(+ ,int 1))

(lmd ++ [v]
  "increments variable 'v' by 1."
  (var v v)
  (set- v (+ v 1)))

(lmd dec [int]
  "decrements 'int' by 1."
  `(- ,int 1))

(lmd -- [v]
  "decrements variable 'v' by 1."
  (var v v)
  (set- v (dec v)))


;; -------------------- ;;
;;        STRING        ;;
;; -------------------- ;;
(lmd append [v str]
  "appends 'str' to variable 'v'."
  (var v v)
  (set- v (list `.. v str)))

(lmd tappend [tbl key str]
  "appends 'str' to 'key' of table 'tbl'."
  (tset- tbl key `(.. (or (. ,tbl ,key) "") ,str)))

(lmd prepend [v str]
  "prepends 'str' to variable 'v'."
  (var v v)
  (set- v (list `.. str v)))

(lmd tprepend [tbl key str]
  "prepends 'str' to 'key' of table 'tbl'."
  (tset- tbl key `(.. ,str (or (. ,tbl ,key) ""))))


;; -------------------- ;;
;;        TABLE         ;;
;; -------------------- ;;
(lmd merge-list [list1 list2]
  "merges all values of 'list1' and 'list2' together."
  `(let [out# []]
     (each [# v# (ipairs ,list1)]
           (table.insert out# v#))
     (each [# v# (ipairs ,list2)]
           (table.insert out# v#))
     :return out#))

(lmd merge [tbl1 tbl2]
  "merges 'tbl2' onto 'tbl1', correctly appending lists."
  `(if (and ,(list? tbl1) ,(list? tbl2))
       ,(merge-list tbl1 tbl2)
       :else
       (vim.tbl_deep_extend "force" ,tbl1 ,tbl2)))

(lmd merge! [v tbl]
  "merges 'tbl' onto variable 'v'."
  (var v v)
  (set- v (M.merge v tbl)))


;; -------------------- ;;
;;     PRETTY PRINT     ;;
;; -------------------- ;;
(fun dump [...]
  "pretty prints {...} into human readable form."
  `(let [out# []]
     (if (?. _G.tangerine :api :serialize)
         (table.insert out# [(_G.tangerine.api.serialize ,...)])
         (each [# v# (ipairs [,...])]
           (table.insert out# [(vim.inspect v#)])))
     (vim.api.nvim_echo out# false [])))



;; -------------------- ;;
;;       HELPERS        ;;
;; -------------------- ;;
(lambda func? [x]
  "checks if 'x' is function definition."
  (let [ref (?. x 1 1)]
    (or= ref :fn :hashfn :lambda :partial)))

(lambda quote? [x]
  "checks if 'x' is quoted value."
  (let [ref (?. x 1 1)]
    (= ref :quote)))

(lambda parse-cmd [xs ...]
  "parses command 'xs', wrapping it in function if quoted."
  (if (quote? xs)
      (let [ref (. xs 2)]
        (if (list? ref) `(fn [] ,ref) ref))
      :else xs))


;; -------------------- ;;
;;       GENERAL        ;;
;; -------------------- ;;
(lmd concat [lst sep]
  "smartly concats all strings in 'lst' with 'sep'."
  (var out [])
  (var idx 1)
  (each [i v (ipairs lst)]
    ; ignore separator at end
    (local sep (if (< i (# lst)) sep ""))
    ; concat string
    (if (string? v)
        (tappend out idx (.. v sep))
        :else
        (do (tset out (++ idx) `(.. ,v ,sep))
            (++ idx))))
  :return
  (if (= idx 1)
      (unpack out)
      (list `.. (unpack out))))

(lmd exec [cmds]
  "wraps [cmd] chunks in 'cmds' within vim.cmd block."
  (local out [])
  (each [_ cmd (ipairs cmds)]
        (table.insert out `(vim.cmd ,(concat cmd " "))))
  (table.insert out true)
  :return
  (dolist out))


;; -------------------- ;;
;;       MAPPINGS       ;;
;; -------------------- ;;
(lambda parse-map-args [args]
  "parses map 'args' into (modes opts) chunk."
  (let [modes []
        opts  {:silent true}]
    ; parse modes
    (each [mode (string.gmatch (tostring (table.remove args 1)) ".")]
      (table.insert modes mode))
    ; parse options
    (each [_ key (ipairs args)]
      (match key
        :verbose (tset opts :silent false)
        [k v]    (tset opts k v)
        _        (tset opts key true)))
    :return
    (values modes opts)))

(lmd map! [args lhs rhs ?desc]
  "defines vim keymap for modes in 'args'."
  (assert-compile (. args 1)
    "map: missing required argument 'mode'." args)
  (local (modes opts) (parse-map-args args))
  (set opts.desc ?desc)
  :return
  `(vim.keymap.set ,modes ,lhs ,(parse-cmd rhs) ,opts))


;; -------------------- ;;
;;       AUTOCMDS       ;;
;; -------------------- ;;
(lambda parse-callback [cmd]
  "parses cmd into valid (name callback) chunk for opts in lua api."
  (if (or (func? cmd) (quote? cmd))
      (values :callback (parse-cmd cmd))
      (values :command  (do cmd))))

(lambda autocmd [id [events pattern cmd]]
  "defines autocmd for group of 'id'."
  ; parse events
  (local opts {:once false :nested false})
  (each [i e (ipairs events)]
    (when (or= e :once :nested)
      (tset opts e true)
      (table.remove events i)))
  (local events (parse-list events))
  (assert-compile (empty? events)) "events must contain at least one element" events
  ; parse patterns
  (local pattern
    (if (sequence? pattern) (parse-list pattern) (parse-sym pattern)))
  ; parse callback
  (local (name val) (parse-callback cmd))
  :return
  `(vim.api.nvim_create_autocmd ,events {:once ,opts.once :nested ,opts.nested :group ,id :pattern ,pattern ,name ,val}))

(lmd augroup! [name ...]
  "defines augroup with 'name' and {...} containing [[groups] pat cmd] chunks."
  (assert-compile
    (string? name)
    (.. "  augroup: invalid name " (view name)) name)
  ; define augroup
  (local id  (gensym :augid))
  (local out [])
  (table.insert out `(local ,id (vim.api.nvim_create_augroup ,name {:clear true})))
  ; define autocmds
  (each [_ au (ipairs [...])]
    (assert-compile
      (sequence? au)
      (.. "  augroup: autocmds expected to be a sequence, got " (view au)) au)
    (table.insert out (autocmd id au)))
  :return
  (dolist out))


;; -------------------- ;;
;;       COMMANDS       ;;
;; -------------------- ;;
(lambda parse-command-args [args]
  "converts list of 'args' into table of valid command-opts."
  (assert-compile
    (even? (# args))
    "  command: expected even number of values in args." args)
  (local out {:force true})
  (each [idx val (ipairs args)]
    (if (odd? idx)
        (tset out val (. args (inc idx)))))
  :return out)

(lmd command! [args lhs rhs]
  "defines a user command from 'lhs' and 'rhs'."
  `(vim.api.nvim_create_user_command ,lhs ,(parse-cmd rhs) ,(parse-command-args args)))


;; -------------------- ;;
;;       OPTIONS        ;;
;; -------------------- ;;
(lmd set! [name ?val]
  "sets vim option 'name', optionally taking 'val'."
  (local name (parse-sym name))
  (if (not= nil ?val)
      `(tset vim.opt ,name ,?val)
      (string? name)
      (if (= :no (string.sub name 1 2))
          `(tset vim.opt ,(string.sub name 3) false)
          `(tset vim.opt ,name true))
      ; else compute at runtime
      `(if (= :no (string.sub ,name 1 2))
           (tset vim.opt (string.sub ,name 3) false)
           (tset vim.opt ,name true))))

(lmd set+ [name val]
  "appends 'val' to vim option 'name'."
  `(: (. vim.opt ,(parse-sym name)) :append ,val))

(lmd set^ [name val]
  "prepends 'val' to vim option 'name'."
  `(: (. vim.opt ,(parse-sym name)) :prepend ,val))

(lmd rem! [name val]
  "removes 'val' from vim option 'name'."
  `(: (. vim.opt ,(parse-sym name)) :remove ,val))

(lmd color! [name]
  "sets vim colorscheme to 'name'."
  `(vim.cmd (.. "colorscheme " ,(parse-sym name))))


;; -------------------- ;;
;;      VARIABLES       ;;
;; -------------------- ;;
(lmd g! [name val]
  "sets global variable 'name' to 'val'."
  `(tset vim.g ,(parse-sym name) ,val))

(lmd b! [name val]
  "sets buffer scoped variable 'name' to 'val'."
  `(tset vim.b ,(parse-sym name) ,val))


(lmd packer [...]
  "syntactic sugar over packer's startup function."
  (local packer `(require :packer))
  `((. ,packer :startup)
    (lambda [(unquote (sym :use))]
      (use :wbthomason/packer.nvim)
      (do ,...)
      (if (. _G :packer.nvim_bootstrap)
          ((. ,packer :sync))))))

(lambda parse-conf [name opts]
  "parses 'name' and list of 'opts' into valid packer.use args."
  (local out [name])
  (each [idx val (ipairs opts)]
    (local nval (. opts (+ idx 1)))
    (if (odd? idx)
        (match val
          :module (tset out :config `#(require ,nval))
          :setup  (let [(mod conf) (unpack nval)]
                    (tset out :config `#((. (require ,mod) :setup) ,conf)))
          :config (tset out :config `(fn [] ,nval))
          _       (tset out val nval))))
  :return out)


(lambda M.use! [name ...]
  "syntactic sugar over packer's use function."
  (assert-compile
    (string? name)
    (.. "  packer-use: invalid name " (view name)) name)
  (assert-compile
    (even? (# [...]))
    (.. "  packer-use: error in :" name ", opts must contain even number of key-value pairs."))
  :return
  `(use ,(parse-conf name [...])))

(fun cfgcall [module func args]
  `((. (require ,module) ,func) ,args))

(fun setup [module args]
  `((. (require ,module) :setup) ,args))

:return M
