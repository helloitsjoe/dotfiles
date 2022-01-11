syntax on
colorscheme oldhope

set number

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set relativenumber
set scrolloff=8
set expandtab
set hlsearch
set incsearch
set cursorline
set cursorcolumn

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let mapleader = " "

nnoremap <leader>/ @="_i// <C-v><Esc>j"<CR>
nnoremap <leader>? @="_xxx<C-v><Esc>j"<CR>
nnoremap <leader>so :so %<CR>

command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Wq        <line1>,<line2>wq<bang> <args>
