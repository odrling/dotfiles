(import-macros {: odd? : even? : string? : append} :hibiscus.core)

(lambda has! [feature]
  [vim.fn.has feature])

;; packer
(lambda bootstrap []
  "installs packer in data dir if not already installed."
  (let [url  "https://github.com/wbthomason/packer.nvim"
        path (.. (vim.fn.stdpath :data) "/site/pack/packer/start/packer.nvim")]
    `(when (= 0 (vim.fn.isdirectory ,path))
       (print "packer.nvim: installing in data dir...")
       (tset _G :packer_bootstrap
             (vim.fn.system [:git :clone "--depth" "1" ,url ,path]))
       (vim.cmd :redraw)
       (vim.cmd "packadd packer.nvim")
       (print "packer.nvim: installed"))))

(lambda packer [...]
  "syntactic sugar over packer's startup function."
  (bootstrap)
  (local packer `(require :packer))
  `((. ,packer :startup)
    (lambda [(unquote (sym :use))]
      (use :wbthomason/packer.nvim)
      (do ,...)
      (if _G.packer_bootstrap
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


(lambda use! [name ...]
  "syntactic sugar over packer's use function."
  (assert-compile
    (string? name)
    (.. "  packer-use: invalid name " (view name)) name)
  (assert-compile
    (even? (# [...]))
    (.. "  packer-use: error in :" name ", opts must contain even number of key-value pairs."))
  :return
  `(use ,(parse-conf name [...])))

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

(lambda map! [args lhs rhs ?desc]
  "defines vim keymap for modes in 'args'."
  (assert-compile (. args 1)
    "map: missing required argument 'mode'." args)
  (local (modes opts) (parse-map-args args))
  (set opts.desc ?desc)
  :return
  `(vim.keymap.set ,modes ,lhs ,(parse-cmd rhs) ,opts))

(fn cfgcall [module func args]
  `((. (require ,module) ,func) ,args))

(fn setup [module args]
  `((. (require ,module) :setup) ,args))

{: has!
 : packer
 : use!
 : cfgcall
 : setup
 : map!}
