call plug#begin()
  Plug 'airblade/vim-gitgutter'
  Plug 'dense-analysis/ale'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'sheerun/vim-polyglot'
" Plug 'gruvbox-community/gruvbox'
  Plug 'helloitsjoe/quantum.vim'
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

syntax on
set termguicolors
set background=dark
set wildignore=node_modules/**,dist/**,coverage/**

" let g:gruvbox_contrast_dark = 'hard'
" let g:gruvbox_colors = { 'bg0': ['#111111', 0] }

colorscheme quantum

filetype plugin indent on

let padding = ' | '

" Add filename and lint status to the statusline
set statusline=%t
set statusline+=%{padding}
set statusline+=%{LinterStatus()}

set path+=**
set suffixesadd+=.js

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
set noerrorbells
" Keep Explore window from splitting vertically
set hidden
set visualbell t_vb=
set colorcolumn=80
set signcolumn=yes
set updatetime=500
set backspace=indent,eol,start
" set cursorline
" set cursorcolumn

" Copy visual selection to clipboard
map <C-c> "+y

" Copy relative file path to clipboard
noremap <Leader>yf :let @*=expand("%")<cr>:echo "Copied file to clipboard"<cr>

" cl' will expand to a console log with the cursor in place
autocmd BufEnter *.js iabbr cl console.log(');<C-c>F'i
autocmd BufEnter *.js iabbr cll console.log(', );<C-c>F'i
autocmd BufEnter *.js iabbr modex module.exports = {<CR><Tab><CR>};<C-c>ki
autocmd BufEnter *.js iabbr im import { X } from ';<C-c>F'i
autocmd BufEnter *.js iabbr req const { X } = require('');<C-c>F'i
autocmd BufEnter *.js iabbr it it(', () => {<CR><Tab><CR>});<C-c>2kf'i
autocmd BufEnter *.js iabbr test test(', () => {<CR><Tab><CR>});<C-c>2kf'i
autocmd BufEnter *.js iabbr desc describe(', () => {<CR><Tab><CR>});<C-c>2kf'i
autocmd BufEnter *.js iabbr imr import React from 'react';
autocmd BufEnter *.js iabbr impt import PropTypes from 'prop-types';

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" ALE (linting and prettier)
let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_fixers = { 'javascript': ['prettier'] }

" Adds total lint warnings/errors to the statusbar
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
    \   '⚠️  %d ❌ %d',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_echo_msg_error_str = 'Errors'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_statusline_format = ['%d errors', '%d warnings', 'OK']
let g:ale_fix_on_save = 1

let g:netrw_liststyle = 3

let mapleader = " "

nnoremap <leader>/ @="_i// <C-v><Esc>j"<CR>
nnoremap <leader>? @="_xxx<C-v><Esc>j"<CR>
nnoremap <leader>so :so%<CR>
nnoremap <leader>e :wincmd v<bar> :Ex <bar> :vertical resize 25 <bar> let g:netrw_browse_split = 4<CR>
nnoremap <leader>wf :vertical wincmd f<CR>
xnoremap A $A
:nnoremap <leader>w <C-w>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprev<CR>
nnoremap <leader>gb :term git blame %<CR>
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <leader>wv <C-w>v<C-w>l
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>f :Rg<CR>
xnoremap p pgvy
nnoremap vv <C-w>v<C-w>l
nnoremap <leader>v <C-v>

" Search across files
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --hidden --line-number --no-heading --color=always --smart-case -g '!{.git,*.lock,*-lock.json}' ".shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:40%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Wq        <line1>,<line2>wq<bang> <args>
command! -bar -bang Q quit<bang>
