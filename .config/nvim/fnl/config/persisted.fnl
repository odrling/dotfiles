(import-macros {: setup : reqcall : augroup!} :macros)

(let [config {:use_git_branch true}]
  ;; allow forcing autosave in other directories with env var
  (when (not vim.env.NVIM_AUTOSAVE_SESSION)
    (set config.allow_dirs ["~/git/"]))

  (setup :persisted config))

(reqcall :telescope :load_extension :persisted)

(augroup! :persisted-autoload
          [[VimEnter] * #(reqcall :persisted :load)])
