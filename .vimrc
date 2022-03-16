call plug#begin()
  Plug 'airblade/vim-gitgutter'
  Plug 'dense-analysis/ale'
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

syntax on
let g:gruvbox_contrast_dark = 'hard'

set termguicolors
set background=dark

colorscheme quantum

filetype plugin indent on

let padding = ' | '

" Add filename and lint status to the statusline
set statusline=%t
set statusline+=%{padding}
set statusline+=%{LinterStatus()}

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
autocmd BufEnter *.js iabbr cl console.log(');<C-c>2hi
autocmd BufEnter *.js iabbr cll console.log(', f);<C-c>5hi

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" ALE (linting and prettier)
let g:ale_linters = {
\  'javascript': ['eslint'],
\}
let g:ale_fixers = {
\  'javascript': ['prettier'],
\}

" Adds total lint warnings/errors to the statusbar
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
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
xnoremap p pgvy

" Search across files
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading --color=always --smart-case -g '!{*.lock,*-lock.json}' ".shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:40%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Wq        <line1>,<line2>wq<bang> <args>
