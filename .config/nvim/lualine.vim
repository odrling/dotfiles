lua << EOF

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'zenwritten',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
  }
}

EOF
