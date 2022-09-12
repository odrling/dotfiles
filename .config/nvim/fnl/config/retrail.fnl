(import-macros {: setup} :macros)

(setup :retrail {:trim {:blanklines true
                        :whitespace false}
                 :filetype {:strict false
                            :exclude [
                                       ""
                                       :alpha
                                       :diff
                                       :help
                                       :NeogitStatus
                                       :NeogitPopup
                                       :NeogitCommitMessage
                                       :TelescopePrompt
                                       :man
                                       :lspinfo
                                       :mason
                                       :WhichKey
                                       :checkhealth]}})
