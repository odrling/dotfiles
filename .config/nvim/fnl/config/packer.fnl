(import-macros {: augroup! : exec : color! : packer : use! : reqcall : map!} :macros)

(augroup! :packer
          [[BufWritePost] packer.fnl "silent! FnlCompileBuffer"]
          [[BufWritePost] packer.fnl "PackerCompile"])

(packer
  (use! :udayvir-singh/tangerine.nvim)
  (use! :lewis6991/impatient.nvim)
  (use! :nathom/filetype.nvim)

  ; git
  (use! :TimUntersberger/neogit
        :requires :nvim-lua/plenary.nvim
        :module :config.neogit)

  (use! :akinsho/git-conflict.nvim
        :setup (git-conflict {}))

  (use! :lewis6991/gitsigns.nvim
        :requires :nvim-lua/plenary.nvim
        :setup (gitsigns {:current_line_blame true}))
  (use! :sindrets/diffview.nvim
        :requires :nvim-lua/plenary.nvim
        :module :config.diffview)

  ; lsp
  (use! :neovim/nvim-lspconfig
        :requires [
                   :ray-x/lsp_signature.nvim
                   :L3MON4D3/LuaSnip
                   :nvim-lua/lsp-status.nvim
                   :jose-elias-alvarez/null-ls.nvim
                   :williamboman/mason.nvim
                   :williamboman/mason-lspconfig.nvim
                   :hrsh7th/nvim-cmp
                   :saadparwaiz1/cmp_luasnip
                   :hrsh7th/cmp-nvim-lsp
                   :tami5/lspsaga.nvim
                   :hrsh7th/cmp-path
                   :hrsh7th/cmp-buffer
                   :hrsh7th/cmp-cmdline
                   :ray-x/cmp-treesitter
                   :kdheepak/cmp-latex-symbols
                   :hrsh7th/cmp-emoji
                   :petertriho/cmp-git
                   :b0o/schemastore.nvim
                   :windwp/nvim-autopairs
                   :Olical/conjure
                   :PaterJason/cmp-conjure]
        :module :config.lsp)
  (use! :windwp/nvim-autopairs
        :setup (nvim-autopairs {}))

  ; Treesitter
  (use! :nvim-treesitter/nvim-treesitter
        :run #(reqcall :nvim-treesitter.install :update {:with_sync true})
        :requires [
                   "nvim-treesitter/playground"
                   "RRethy/nvim-treesitter-endwise"
                   "windwp/nvim-ts-autotag"
                   "JoosepAlviste/nvim-ts-context-commentstring"
                   "yioneko/nvim-yati"
                   "nvim-treesitter/nvim-treesitter-textobjects"]
        :module :config.treesitter)

  (use! :Gelio/dim.lua
        :branch :fix-hl_ns-breaking-change
        :requires [
                    :nvim-treesitter/nvim-treesitter
                    :neovim/nvim-lspconfig]
        :setup (dim {}))

  (use! :gpanders/nvim-parinfer)
  (use! :Olical/conjure)

  (use! :mickael-menu/zk-nvim
        :module :config.zk)

  ; Interface
  (use! :projekt0n/github-nvim-theme
        :config #(color! github_light))
  (use! :numtostr/FTerm.nvim
        :module :config/fterm)
  (use! :folke/which-key.nvim
        :setup (which-key {}))
  (use! :mvllow/modes.nvim
        :setup (modes {:opacity 0.15}))
  (use! :lukas-reineke/indent-blankline.nvim
        :module :config.indent_blankline)
  (use! :nvim-lualine/lualine.nvim
        :module :config.lualine)
  (use! :projekt0n/circles.nvim
        :requires :kyazdani42/nvim-web-devicons
        :module :config.circles)
  (use! :nvim-telescope/telescope.nvim
        :requires [ :nvim-lua/plenary.nvim
                    :natecraddock/telescope-zf-native.nvim
                    :nvim-telescope/telescope-ui-select.nvim]
        :module :config.telescope)
  (use! :akinsho/bufferline.nvim
        :module :config.bufferline)
  (use! :famiu/bufdelete.nvim
        :config #(map! [n] :<leader>q #(reqcall :bufdelete :bufdelete [0 true])))
  (use! :ggandor/leap.nvim
        :config #(reqcall :leap :set_default_keymaps))
  (use! :antoinemadec/FixCursorHold.nvim)
  (use! :elihunter173/dirbuf.nvim
        :module :config.dirbuf)
  (use! :luukvbaal/stabilize.nvim
        :setup (stabilize {}))
  (use! :ahmedkhalf/project.nvim
        :setup (project_nvim {}))
  (use! :numToStr/Comment.nvim
        :setup (Comment {}))
  (use! :tpope/vim-repeat)
  (use! :tpope/vim-surround)
  (use! :tpope/vim-sleuth)
  (use! :kenn7/vim-arsync
        :config #(map! [n] :<leader>p :<cmd>ARsyncUp<cr>))
  (use! :zakharykaplan/nvim-retrail
        :setup (retrail {:trim {:blanklines true
                                :whitespace false}}))
  (use! :vladdoster/remember.nvim
        :module :remember))
