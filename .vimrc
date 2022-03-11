call plug#begin()
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

syntax on
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

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
set colorcolumn=80

" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let mapleader = " "

nnoremap <leader>/ @="_i// <C-v><Esc>j"<CR>
nnoremap <leader>? @="_xxx<C-v><Esc>j"<CR>
nnoremap <leader>so :so%<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 25 <bar> let g:netrw_browse_split = 4<CR>
nnoremap <C-p> :Files<CR>

command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Wq        <line1>,<line2>wq<bang> <args>
