" tnoremap <C-A-n> <cmd>NnnExplorer<CR>
" nnoremap <C-A-n> <cmd>NnnExplorer %:p:h<CR>
tnoremap <C-n> <cmd>NnnPicker<CR>
nnoremap <C-n> <cmd>NnnPicker<CR>

lua << EOF
require("nnn").setup {
    replace_netrw = "picker"
}
EOF
