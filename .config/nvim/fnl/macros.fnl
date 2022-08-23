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
          :config (tset out :config `#(,nval))
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

(fn cfgcall [module func args]
  `((. (require ,module) ,func) ,args))

(fn setup [module args]
  `((. (require ,module) :setup) ,args))

{: has!
 : packer
 : use!
 : cfgcall
 : setup}
