(import-macros {: setup : reqcall} :macros)

(macro config [name]
  (local configname (.. "config." name))
  `(require ,configname))

(setup :lazy 
  [
   {1 :udayvir-singh/tangerine.nvim
    :lazy false
    :priority 200
    :config #(config :tangerine)}

   ;; git
   {1 :lewis6991/gitsigns.nvim
    :dependencies [:nvim-lua/plenary.nvim]
    :opts {:current_line_blame true}}

   {1 :sindrets/diffview.nvim
    :dependencies :nvim-lua/plenary.nvim}

   ;; lsp
   {1 :neovim/nvim-lspconfig
    :dependencies [:nvim-lua/lsp-status.nvim
                   :jose-elias-alvarez/null-ls.nvim
                   :williamboman/mason.nvim
                   :williamboman/mason-lspconfig.nvim
                   :hrsh7th/cmp-nvim-lsp
                   ;; TODO:check :jayp0521/mason-null-ls.nvim
                   :WhoIsSethDaniel/mason-tool-installer.nvim
                   :b0o/schemastore.nvim
                   :folke/neodev.nvim
                   :hrsh7th/cmp-nvim-lsp]
    :config #(config :lsp)}

   {1 :hrsh7th/cmp-nvim-lsp
    :opts {}}

   {1 :smjonas/inc-rename.nvim
    :opts {}}

   {1 :hrsh7th/nvim-cmp
    :dependencies [:hrsh7th/cmp-path
                   :hrsh7th/cmp-buffer
                   :hrsh7th/cmp-cmdline
                   :kdheepak/cmp-latex-symbols
                   :petertriho/cmp-git 
                   :L3MON4D3/LuaSnip
                   :saadparwaiz1/cmp_luasnip
                   :rafamadriz/friendly-snippets]
    :config #(config :cmp)}

   {1 "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
    :config #(config :lsp_lines)}

   ;; Treesitter
   {1 :nvim-treesitter/nvim-treesitter
    :build #(reqcall :nvim-treesitter.install :update {:with_sync true})
    :config #(config :treesitter)}

   {1 :nvim-treesitter/playground
    :dependencies :nvim-treesitter/nvim-treesitter}
   {1 :nvim-treesitter/nvim-treesitter-refactor
    :dependencies :nvim-treesitter/nvim-treesitter}
   {1 :RRethy/nvim-treesitter-endwise
    :dependencies :nvim-treesitter/nvim-treesitter}
   {1 :RRethy/nvim-treesitter-endwise
    :dependencies :nvim-treesitter/nvim-treesitter}
   {1 :p00f/nvim-ts-rainbow
    :dependencies :nvim-treesitter/nvim-treesitter}
   {1 :windwp/nvim-ts-autotag
    :dependencies :nvim-treesitter/nvim-treesitter}
   {1 :JoosepAlviste/nvim-ts-context-commentstring
    :dependencies :nvim-treesitter/nvim-treesitter
    :config #(setup :ts_context_commentstring {:enable_autocmd false})}

   ;; Misc
   {1 :gpanders/nvim-parinfer
    :config #(config :parinfer)}

   {1 :rmagatti/auto-session
    :config #(config :auto-session)}

   {1 :folke/todo-comments.nvim
    :config #(config :todo-comments)}

   {1 :gaoDean/autolist.nvim
    :opts {}}

   {1 :AckslD/nvim-FeMaco.lua
    :config #(config :femaco)}

   :vim-scripts/ReplaceWithRegister

   {1 :mbbill/undotree
    :config #(config :undotree)}

   :godlygeek/tabular

   {1 :gbprod/yanky.nvim
    :config #(config :yanky)}

   {1 :chrisgrieser/nvim-spider
    :config #(config :spider)}

   :stevearc/profile.nvim

   {1 :t-troebst/perfanno.nvim
    :opts {}}

   ;; Interface
   {1 :goolord/alpha-nvim
    :dependencies [:kyazdani42/nvim-web-devicons]
    :config #(setup :alpha (. (require :alpha.themes.startify) :config))}

   {1 :projekt0n/github-nvim-theme
    :lazy false
    :priority 1000
    :name :github-theme
    :config (fn []
              (setup :github-theme {:groups {:all {:CursorLine  {:bg "#f8f8f8"}
                                                   :ColorColumn {:bg "#f8f8f8"}}}})
              (vim.cmd.colorscheme :github_light))}

   {1 :folke/noice.nvim
    :dependencies [:MunifTanjim/nui.nvim]
    :config #(config :noice)}

   {1 :nvim-lualine/lualine.nvim
    :config #(config :lualine)}

   ; {1 :lewis6991/satellite.nvim
   ;  :opts {}}

   :romainl/vim-cool
   {1 :melkster/modicator.nvim
    :opts {}}
   {1 :numtostr/FTerm.nvim
    :config #(config :fterm)}

   {1 :anuvyklack/windows.nvim
    :dependencies [:anuvyklack/middleclass
                   :anuvyklack/animation.nvim]
    :config #(config :windows)}
   {1 :projekt0n/circles.nvim
    :dependencies [:kyazdani42/nvim-web-devicons]
    :config #(config :circles)}
   {1 :nvim-telescope/telescope.nvim
    :dependencies [:nvim-lua/plenary.nvim
                   :nvim-telescope/telescope-fzf-native.nvim
                   :nvim-telescope/telescope-frecency.nvim
                   :kkharji/sqlite.lua]
    :config #(config :telescope)}

   {1 :nvim-telescope/telescope-fzf-native.nvim
    :build "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"}

   {1 :stevearc/dressing.nvim
    :config #(config :dressing)}

   {1 :levouh/tint.nvim
    :opts {:tint 45
           :tint_background_colors false}}

   {1 :anuvyklack/hydra.nvim
    :dependencies [:lewis6991/gitsigns.nvim
                   :numtostr/FTerm.nvim
                   :mrjones2014/smart-splits.nvim]
    :event :VeryLazy
    :config #(config :hydra)}

   {1 :ggandor/leap.nvim
    :config #(reqcall :leap :set_default_keymaps)}

   {1 :elihunter173/dirbuf.nvim
    :config #(config :dirbuf)}

   {1 :ahmedkhalf/project.nvim
    :name :project_nvim
    :opts {}}
   {1 :numToStr/Comment.nvim
    :config #(setup :Comment {:pre_hook (reqcall :ts_context_commentstring.integrations.comment_nvim :create_pre_hook)})
    :dependencies [:JoosepAlviste/nvim-ts-context-commentstring]}

   {1 :ruifm/gitlinker.nvim
    :config #(config :gitlinker)}

   {1 :NMAC427/guess-indent.nvim
    :opts {}}

   :tpope/vim-repeat
   :tpope/vim-surround
   :tpope/vim-abolish
   :tpope/vim-rsi

   :kenn7/vim-arsync

   {1 :glacambre/firenvim
    :build #((. vim.fn :firenvim#install) 0)
    :config #(config :firenvim)}

   {1 :NvChad/nvim-colorizer.lua
    :opts {:user_default_options {:names false}}}

   {1 :nacro90/numb.nvim
    :config #(setup :numb)}

   :LunarVim/bigfile.nvim
   {1 :vladdoster/remember.nvim
    :config #(require :remember)}])

