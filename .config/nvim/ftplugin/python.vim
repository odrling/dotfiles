" let b:ale_linters = ['pyre', 'flake8']
let b:ale_fixers = ['isort', 'remove_trailing_lines', 'trim_whitespace']

map <leader>o :ALEFix autoimport<CR>
