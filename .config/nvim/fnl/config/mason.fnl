(import-macros {: setup} :macros)

(setup :mason)
(setup :mason-lspconfig {:automatic_installation true})
(setup :mason-tool-installer {:auto_update true
                              :ensure_installed [:flake8
                                                 :isort
                                                 :stylua]})
