call plug#begin()
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

syntax on
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

filetype plugin indent on
set number
set tabstop=2
set shiftwidth=2
set smartindent
set relativenumber
set scrolloff=8
set expandtab
set nohlsearch
set ignorecase
set smartcase
set laststatus=2
set incsearch
set cursorline
set cursorcolumn
set noerrorbells
set visualbell t_vb=
set colorcolumn=80
set signcolumn=yes
set updatetime=100 " Update GitGutter every 100ms

autocmd BufEnter *.js iabbr cl console.log('');<C-c>hhi
autocmd BufEnter *.js iabbr cll console.log('', f);<C-c>hhhhhi


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
nnoremap <leader>e :wincmd v<bar> :Ex <bar> :vertical resize 25 <bar> let g:netrw_browse_split = 4<CR>
:nnoremap <leader>w <C-w>
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>f :Rg<CR>


command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading --color=always --smart-case -g '!{*.lock,*-lock.json}' ".shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:40%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Wq        <line1>,<line2>wq<bang> <args>
