(import-macros {: augroup! : exec : color! : packer : use! : reqcall : map! : g! : setup} :macros)

(augroup! :packer
          [[BufWritePost] packer.fnl (fn []
                                       (reqcall :tangerine.api.compile :buffer)
                                       (exec [[:source (.. (vim.fn.stdpath :config) "/lua/config/packer.lua")]])
                                       (reqcall :packer :compile))])

(packer
  (use! :udayvir-singh/tangerine.nvim)
  (use! :lewis6991/impatient.nvim)

  ; git
  (use! :TimUntersberger/neogit
        :requires :nvim-lua/plenary.nvim
        :module :config.neogit)

  (use! :akinsho/git-conflict.nvim
        :config #(setup :git-conflict {}))

  (use! :lewis6991/gitsigns.nvim
        :requires :nvim-lua/plenary.nvim
        :config #(setup :gitsigns {:current_line_blame true}))
  (use! :sindrets/diffview.nvim
        :requires :nvim-lua/plenary.nvim
        :module :config.diffview)

  ; lsp
  (use! :neovim/nvim-lspconfig
        :requires [
                   :ray-x/lsp_signature.nvim
                   :nvim-lua/lsp-status.nvim
                   :jose-elias-alvarez/null-ls.nvim
                   :williamboman/mason.nvim
                   :williamboman/mason-lspconfig.nvim
                   :L3MON4D3/LuaSnip
                   :saadparwaiz1/cmp_luasnip
                   :rafamadriz/friendly-snippets
                   ;; TODO:check :jayp0521/mason-null-ls.nvim
                   :WhoIsSethDaniel/mason-tool-installer.nvim
                   :hrsh7th/nvim-cmp
                   :hrsh7th/cmp-nvim-lsp
                   :kkharji/lspsaga.nvim
                   "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
                   :hrsh7th/cmp-path
                   :hrsh7th/cmp-buffer
                   :hrsh7th/cmp-cmdline
                   :ray-x/cmp-treesitter
                   :kdheepak/cmp-latex-symbols
                   :hrsh7th/cmp-emoji
                   :petertriho/cmp-git
                   :b0o/schemastore.nvim
                   :windwp/nvim-autopairs
                   :folke/lua-dev.nvim
                   :smjonas/inc-rename.nvim]
        :module :config.lsp)
  (use! :windwp/nvim-autopairs
        :config #(setup :nvim-autopairs {}))

  ; Treesitter
  (use! :nvim-treesitter/nvim-treesitter
        :run #(reqcall :nvim-treesitter.install :update {:with_sync true})
        :requires [
                   :nvim-treesitter/playground
                   :nvim-treesitter/nvim-treesitter-refactor
                   :p00f/nvim-ts-rainbow
                   :RRethy/nvim-treesitter-endwise
                   :windwp/nvim-ts-autotag
                   :JoosepAlviste/nvim-ts-context-commentstring
                   :yioneko/nvim-yati
                   :nvim-treesitter/nvim-treesitter-textobjects]
        :module :config.treesitter)
  (use! :nvim-treesitter/nvim-treesitter-refactor
        :after :nvim-treesitter)
  (use! :p00f/nvim-ts-rainbow
        :after :nvim-treesitter)
  (use! :windwp/nvim-ts-autotag
        :after :nvim-treesitter)
  (use! :yioneko/nvim-yati
        :after :nvim-treesitter)
  (use! :JoosepAlviste/nvim-ts-context-commentstring
        :after :nvim-treesitter)
  (use! :nvim-treesitter/nvim-treesitter-textobjects
        :after :nvim-treesitter)

  (use! :narutoxy/dim.lua
        :requires [
                    :nvim-treesitter/nvim-treesitter
                    :neovim/nvim-lspconfig]
        :config #(setup :dim {}))

  (use! :gpanders/nvim-parinfer
        :module :config.parinfer)

  (use! :sheerun/vim-polyglot)

  (use! :mickael-menu/zk-nvim
        :module :config.zk)

  (use! :rmagatti/auto-session
        :requires :rmagatti/session-lens
        :module :config.auto-session)
  (use! :rmagatti/session-lens
        :after :telescope.nvim)

  (use! :folke/todo-comments.nvim
        :module :config.todo-comments)

  (use! :gaoDean/autolist.nvim
        :config #(setup :autolist {}))

  ; Interface
  (use! :projekt0n/github-nvim-theme)
  (use! :numtostr/FTerm.nvim
        :module :config/fterm)
  (use! :folke/which-key.nvim
        :config #(setup :which-key))
  (use! :nvim-lualine/lualine.nvim
        :module :config.lualine)
  (use! :projekt0n/circles.nvim
        :requires :kyazdani42/nvim-web-devicons
        :module :config.circles)
  (use! :nvim-telescope/telescope.nvim
        :requires [:nvim-lua/plenary.nvim
                   :natecraddock/telescope-zf-native.nvim
                   :rcarriga/nvim-notify]
        :module :config.telescope)
  (use! :stevearc/dressing.nvim
        :module :config.dressing)
  (use! :rcarriga/nvim-notify)
  (use! :anuvyklack/hydra.nvim
        :module :config.hydra
        :requires [
                   :lewis6991/gitsigns.nvim
                   :akinsho/git-conflict.nvim
                   :TimUntersberger/neogit
                   :mrjones2014/smart-splits.nvim])
  (use! :romgrk/barbar.nvim
        :requires :kyazdani42/nvim-web-devicons
        :module :config.barbar)
  (use! :goolord/alpha-nvim
        :requires [:kyazdani42/nvim-web-devicons]
        :config #(setup :alpha (. (require :alpha.themes.startify) :config)))
  (use! :ggandor/leap.nvim
        :config #(reqcall :leap :set_default_keymaps))
  (use! :jinh0/eyeliner.nvim
        :module :config.eyeliner)
  (use! :antoinemadec/FixCursorHold.nvim)
  (use! :elihunter173/dirbuf.nvim
        :module :config.dirbuf)
  (use! :luukvbaal/stabilize.nvim
        :config #(setup :stabilize {}))
  (use! :ahmedkhalf/project.nvim
        :config #(setup :project_nvim {}))
  (use! :numToStr/Comment.nvim
        :config #(setup :Comment {}))
  (use! :ruifm/gitlinker.nvim
        :module :config.gitlinker)
  (use! :tpope/vim-repeat)
  (use! :tpope/vim-surround)
  (use! :tpope/vim-sleuth)
  (use! :tpope/vim-abolish)
  (use! :kenn7/vim-arsync)
  (use! :zakharykaplan/nvim-retrail
        :module :config.retrail)
  (use! :glacambre/firenvim
        :run #((. vim.fn :firenvim#install) 0)
        :module :config.firenvim)
  (use! :NvChad/nvim-colorizer.lua
        :config #(setup :colorizer))
  (use! :vladdoster/remember.nvim
        :module :remember))
