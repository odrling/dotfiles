(import-macros {: augroup! : exec : color! : packer : use! : reqcall : map! : g! : setup} :macros)

(packer
  (use! :udayvir-singh/tangerine.nvim)
  (use! :lewis6991/impatient.nvim)

  ; git
  (use! :tpope/vim-fugitive)

  (use! :akinsho/git-conflict.nvim
        :config #(setup :git-conflict {}))

  (use! :lewis6991/gitsigns.nvim
        :event :BufReadPost
        :requires :nvim-lua/plenary.nvim
        :config #(setup :gitsigns {:current_line_blame true}))

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
        :after :cmp-nvim-lsp
        :module :config.lsp)

  (use! :hrsh7th/cmp-nvim-lsp
        :config #(setup :cmp_nvim_lsp))

  (use! :smjonas/inc-rename.nvim
        :config #(setup :inc_rename {:input_buffer_type :dressing}))

  (use! :hrsh7th/nvim-cmp
        :requires [:hrsh7th/cmp-path
                   {1 :hrsh7th/cmp-buffer :after :nvim-cmp}
                   {1 :hrsh7th/cmp-cmdline :after :nvim-cmp}
                   {1 :kdheepak/cmp-latex-symbols :after :nvim-cmp}
                   {1 :petertriho/cmp-git 
                    :after :nvim-cmp
                    :config #(setup :cmp_git)}
                   :L3MON4D3/LuaSnip
                   {1 :saadparwaiz1/cmp_luasnip :after :nvim-cmp}
                   :rafamadriz/friendly-snippets
                   :windwp/nvim-autopairs]
        :event [:InsertEnter :CmdlineEnter]
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
        :requires [{1 :nvim-treesitter/playground :after :nvim-treesitter}
                   {1 :nvim-treesitter/nvim-treesitter-refactor :after :nvim-treesitter}
                   {1 :RRethy/nvim-treesitter-endwise :after :nvim-treesitter}
                   {1 :nvim-treesitter/nvim-treesitter-refactor :after :nvim-treesitter}
                   {1 :p00f/nvim-ts-rainbow :after :nvim-treesitter}
                   {1 :windwp/nvim-ts-autotag :after :nvim-treesitter}
                   {1 :JoosepAlviste/nvim-ts-context-commentstring :after :nvim-treesitter}
                   {1 :nvim-treesitter/nvim-treesitter-textobjects :after :nvim-treesitter}]
        :module :config.treesitter)

  (use! :Kasama/nvim-custom-diagnostic-highlight
        :event :LspAttach
        :config #(setup :nvim-custom-diagnostic-highlight {}))

  ;; Misc
  (use! :gpanders/nvim-parinfer
        :module :config.parinfer)

  (use! :sheerun/vim-polyglot
        :event :BufReadPost
        :setup #(g! polyglot_disabled [:autoindent :sensible]))

  (use! :mickael-menu/zk-nvim
        :module :config.zk)

  (use! :rmagatti/auto-session
        :module :config.auto-session)

  (use! :rmagatti/session-lens
        :after [:telescope.nvim
                :auto-session])

  (use! :folke/todo-comments.nvim
        :module :config.todo-comments)

  (use! :gaoDean/autolist.nvim
        :config #(setup :autolist {}))

  (use! :AckslD/nvim-FeMaco.lua
        :module :config.femaco)

  (use! :vim-scripts/ReplaceWithRegister)

  (use! :mbbill/undotree
        :module :config.undotree)

  (use! :kevinhwang91/nvim-hlslens
        :module :config.hlslens)

  ; Interface
  (use! :projekt0n/github-nvim-theme)
  (use! :joeytwiddle/sexy_scroller.vim
        :module :config.sexy_scroller)
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
                   :rcarriga/nvim-notify
                   :nvim-telescope/telescope-frecency.nvim
                   :kkharji/sqlite.lua]
        :module :config.telescope)
  (use! :stevearc/dressing.nvim
        :module :config.dressing)
  (use! :rcarriga/nvim-notify)
  (use! :anuvyklack/hydra.nvim
        :event :VimEnter
        :module :config.hydra
        :requires [:lewis6991/gitsigns.nvim
                   :akinsho/git-conflict.nvim
                   :tpope/vim-fugitive
                   :mrjones2014/smart-splits.nvim])
  (use! :romgrk/barbar.nvim
        :requires :kyazdani42/nvim-web-devicons
        :module :config.barbar)
  (use! :ggandor/leap.nvim
        :config #(reqcall :leap :set_default_keymaps))
  (use! :jinh0/eyeliner.nvim
        :module :config.eyeliner)
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
        :config #(setup :colorizer {:user_default_options {:names false}}))
  (use! :vladdoster/remember.nvim
        :module :remember))
