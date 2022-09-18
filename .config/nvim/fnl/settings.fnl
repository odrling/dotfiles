(import-macros {: hl! : augroup! : set+ : set! : rem! : g! : exec : has! : map!} :macros)

; better :find
(set+ path "**")
(set! wildmenu)

(set! ignorecase) ; case insensitive search
(set! smartcase)  ; but case sensitive when uppercase present

(set! scrolljump 1)
(set! scrolloff 5)

(set! splitright)
(set! splitbelow)
(set! autowrite) ; automatically write a file when leaving a modified buffer
(set! hidden) ; allow buffer switching without saving

; no swapfile/backup
(set! nobackup)
(set! noswapfile)
(set! nowritebackup)

; default tabs/space
(set! shiftwidth 4)
(set! tabstop 4)
(set! expandtab)  ; tabs are spaces

; With a map leader it's possible to do extra key combinations
; like <leader>w saves the current file
(g! mapleader ",")

; Oh well
(map! [n] "<leader>;" "A;<ESC>")

; => Moving around, tabs, windows and buffers

; Smart way to move between windows
(map! [n] :<C-j> :<C-W>j)
(map! [n] :<C-k> :<C-W>k)
(map! [n] :<C-h> :<C-W>h)
(map! [n] :<C-l> :<C-W>l)

(map! [n] :<leader>k ":bnext<cr>")
(map! [n] :<leader>j ":bprevious<cr>")

; Useful mappings for managing tabs
;map <leader>tn :tabnew<cr>
;map <leader>to :tabonly<cr>
;map <leader>tc :tabclose<cr>
;map <leader>tm :tabmove
;map <leader>t<leader> :tabnext<cr>

; Switch CWD to the directory of the open buffer
(map! [n] :<leader>cd ":cd %:p:h<cr>:pwd<cr>")

; Let remember.nvim deal with it
(g! leave_my_cursor_position_alone "")

; => Status line
; Always show the status line
(set! laststatus 3)

; Format the status line
;set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

; => Editing mappings
; Remap VIM 0 to first non-blank character
(map! [n] :0 :^)
(map! [n :noremap] :H :^)
(map! [n :noremap] :L :$)

; Move a line of text using ALT+[jk] or Command+[jk] on mac
(map! [n] :<M-j> "mz:m+<cr>`z")
(map! [n] :<M-k> "mz:m-2<cr>`z")
(map! [v] :<M-j> ":m'>+<cr>`<my`>mzgv`yo`z")
(map! [v] :<M-k> ":m'<-2<cr>`>my`<mzgv`yo`z")

(when (or (vim.fn.has :mac) (vim.fn.has :macunix))
    (map! [nv] :<D-j> :<M-j>)
    (map! [nv] :<D-k> :<M-k>))

; => Spell checking
; Pressing ,ss will toggle and untoggle spell checking
(map! [n] :<leader>ss ":setlocal spell!<cr>")

; Shortcuts using <leader>
(map! [n] :<leader>sn "]s")
(map! [n] :<leader>sp "[s")
(map! [n] :<leader>sa :zg)
(map! [n] :<leader>s? :z=)

; set python interpreter path
(g! python3_host_prog :python3)

; Remove the Windows ^M - when the encodings gets messed up
(map! [n] :<Leader>m "mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm")

; turn off highlighting
(map! [n] :<leader>h "<cmd>noh<CR>")

; copy line to clipboard
(map! [n :noremap] :<C-c> "\"+yy")
(map! [v :noremap] :<C-c> "\"+y")

; file completion
(map! [i] :<C-f> :<C-x><C-f>)

; tag completion
(map! [i] "<C-]>" "<C-x><C-]>")

; create line above
(map! [i] :<S-Enter> :<Esc>O)

; run commands
(map! [n] :<leader>x :<cmd>.!sh<cr>)

; User Interface
(set! number)
(set! relativenumber)


; Height of the command bar
(set! cmdheight 1)

; always show sign column
(set! signcolumn :yes)
; sign column matches background
(hl! :SignColumn {})

; don't redraw while executing macros
(set! lazyredraw)

(set! mouse :nv)
(set! mousehide)
(set! nomodeline)

(set! list)
(set! listchars "tab:│\\x20,nbsp: ,trail:~,extends:>,space:\x20")
(set! showcmd)
(set! ruler)
(set! showmode)
(set! showmatch)
(set! matchtime 5)
(set! report 0)
(set! linespace 0)
(set! pumheight 20)

; How many tenths of a second to blink when matching brackets
(set! mat 2)

(set! filetype "on")

; wrap long lines
(set! wrap)
(set! linebreak)
(set! breakindent)  ; keep indentation when wrapping

; disable wrapping the input
(set! textwidth 0)
(set! wrapmargin 0)
(rem! formatoptions :t)

; GUI settings
(set! guifont "monospace:h12")

; use true colors
(set! termguicolors)
(set! background :light)

(set! cursorline)
(set! cursorlineopt "number,screenline")

(set! shell "/bin/sh")

; autoreload changed files
(set! updatetime 300)
(set! autoread)
(augroup! :autoread-hold [[CursorHold] * :checktime])
