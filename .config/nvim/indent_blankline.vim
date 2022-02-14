highlight IndentBlanklineIndent1 guibg=#eeeeee gui=nocombine
highlight IndentBlanklineIndent2 guibg=#e4e4e4 gui=nocombine

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
