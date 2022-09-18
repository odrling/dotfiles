(import-macros {: augroup! : exec : color! : packer : use! : reqcall : map! : g! : setup} :macros)

(packer
  (use! :udayvir-singh/tangerine.nvim)
  (use! :lewis6991/impatient.nvim)

  ; git
  (use! :TimUntersberger/neogit
        :requires :nvim-lua/plenary.nvim
        :module :config.neogit)

  (use! :akinsho/git-conflict.nvim
        :event :BufReadPost
        :config #(setup :git-conflict {}))

  (use! :lewis6991/gitsigns.nvim
        :event :BufReadPost
        :requires :nvim-lua/plenary.nvim
        :config #(setup :gitsigns {:current_line_blame true}))

  (use! :sindrets/diffview.nvim
        :requires :nvim-lua/plenary.nvim
        :module :config.diffview)

  ; lsp
  (use! :neovim/nvim-lspconfig
        :requires [:nvim-lua/lsp-status.nvim
                   :jose-elias-alvarez/null-ls.nvim
                   :williamboman/mason.nvim
                   :williamboman/mason-lspconfig.nvim
                   :hrsh7th/cmp-nvim-lsp
                   ;; TODO:check :jayp0521/mason-null-ls.nvim
                   :WhoIsSethDaniel/mason-tool-installer.nvim
                   :b0o/schemastore.nvim
                   :folke/lua-dev.nvim]
        :event :BufReadPost
        :module :config.lsp)

  (use! :smjonas/inc-rename.nvim
        :config #(setup :inc_rename {:input_buffer_type :dressing}))

  (use! :hrsh7th/nvim-cmp
        :requires [:hrsh7th/cmp-nvim-lsp
                   :hrsh7th/cmp-path
                   :hrsh7th/cmp-buffer
                   :hrsh7th/cmp-cmdline
                   :kdheepak/cmp-latex-symbols
                   :petertriho/cmp-git
                   :L3MON4D3/LuaSnip
                   :saadparwaiz1/cmp_luasnip
                   :rafamadriz/friendly-snippets
                   :windwp/nvim-autopairs]
        :module :config.cmp)

  (use! :ray-x/lsp_signature.nvim
        :module :config.lsp_signature)

  (use! :windwp/nvim-autopairs
        :config #(setup :nvim-autopairs {}))

  (use! "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
        :module :config.lsp_lines)

  ; Treesitter
  (use! :nvim-treesitter/nvim-treesitter
        :run #(reqcall :nvim-treesitter.install :update {:with_sync true})
        :requires [:nvim-treesitter/playground
                   :nvim-treesitter/nvim-treesitter-refactor
                   :RRethy/nvim-treesitter-endwise]
        :module :config.treesitter)
  (use! :nvim-treesitter/nvim-treesitter-refactor
        :after :nvim-treesitter)
  (use! :p00f/nvim-ts-rainbow
        :after :nvim-treesitter)
  (use! :windwp/nvim-ts-autotag
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

  (use! :sheerun/vim-polyglot
        :event :BufReadPost
        :setup #(g! polyglot_disabled [:autoindent :sensible]))

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

  (use! :AckslD/nvim-FeMaco.lua
        :module :config.femaco)

  (use! :vim-scripts/ReplaceWithRegister)

  ; Interface
  (use! :projekt0n/github-nvim-theme)
  (use! :joeytwiddle/sexy_scroller.vim)
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
  (use! :glacambre/firenvim
        :run #((. vim.fn :firenvim#install) 0)
        :module :config.firenvim)
  (use! :NvChad/nvim-colorizer.lua
        :config #(setup :colorizer))
  (use! :vladdoster/remember.nvim
        :module :remember))
