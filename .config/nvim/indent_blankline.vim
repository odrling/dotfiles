highlight IndentBlanklineIndent1 guibg=#ffffff gui=nocombine
highlight IndentBlanklineIndent2 guibg=#f8f8f8 gui=nocombine

lua << EOF
require("indent_blankline").setup {
    char = "",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    show_trailing_blankline_indent = false,
    show_current_context = true,
    show_current_context_start = true,
}
EOF
