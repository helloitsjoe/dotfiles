call plug#begin()
" Plug 'gruvbox-community/gruvbox'
  Plug 'helloitsjoe/quantum.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'sheerun/vim-polyglot'
  Plug 'dense-analysis/ale'
  Plug 'preservim/nerdtree'
  Plug 'rust-lang/rust.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'nicwest/vim-http'
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'sheerun/vim-go'
call plug#end()

let $FZF_DEFAULT_OPTS='--reverse'

syntax on
set termguicolors
set background=dark
set wildignore=node_modules/**,dist/**,coverage/**

" let g:gruvbox_contrast_dark = 'hard'
" let g:gruvbox_colors = { 'bg0': ['#111111', 0] }

colorscheme quantum

filetype plugin indent on

let padding = ' | '

" Show file list when tabbing in shell commands, e.g. :!mv ./<tab>
set wildmode=longest,list,full
set wildmenu

" Don't add comment under a comment
set formatoptions-=cro

" Add filename and lint status to the statusline
set statusline=%f " %t for just filename
set statusline+=%{padding}
set statusline+=col:\ %c
set statusline+=%{padding}
set statusline+=%{LinterStatus()}

" Don't add a comment to the line below a comment
set formatoptions-=cro

set path+=**
set suffixesadd+=.js

set number
set tabstop=2
set shiftwidth=2
set smartindent
set relativenumber
set scrolloff=8
set expandtab
set hlsearch
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

" cl' will expand to a console log with the cursor in place
autocmd BufEnter *.{js,ts,jsx,tsx} iabbr cl console.log(');<C-c>F'i
" autocmd BufEnter *.{js,ts} iabbr cll <Esc>bdwiconsole.log('<Esc>pi:', <Esc>pi);<C-c>
" autocmd BufEnter *.{js,ts,jsx,tsx} iabbr cll console.log(', );<C-c>F'i
autocmd BufEnter *.{js,ts,jsx,tsx} iabbr modex module.exports = {<CR>};<C-c>kA
autocmd BufEnter *.{js,ts,jsx,tsx} iabbr imn import { X } from ';<C-c>F'i
autocmd BufEnter *.{js,ts} iabbr reqn const { X } = require(');<C-c>F'i
autocmd BufEnter *.test.{js,ts} iabbr it( it(', () => {<CR>});<C-c>kf'i
autocmd BufEnter *.test.{js,ts} iabbr test( test(', () => {<CR>});<C-c>kf'i
autocmd BufEnter *.test.{js,ts} iabbr desc( describe(', () => {<CR>});<C-c>kf'i
autocmd BufEnter *.{js,ts,jsx,tsx} iabbr imr import React from 'react';
autocmd BufEnter *.{js,ts} iabbr impt import PropTypes from 'prop-types';

" In insert mode, paste the variable from its label
" specifically for cl' abbrev
inoremap <C-l> <Esc>yi'f)i, <Esc>p

" console log the selected text with label
vnoremap <leader>cll yoconsole.log('<Esc>pa', <Esc>pa);<Esc>
nnoremap <leader>cll yiwoconsole.log('<Esc>pa', <Esc>pa);<Esc>

inoremap <C-t> <Esc>ciw<<Esc>pa></<Esc>pa><Esc>F<i

" Make jkl; global marks
nnoremap mj mJ
nnoremap 'j 'J
nnoremap `j `J
nnoremap mk mK
nnoremap 'k 'K
nnoremap `k `K
nnoremap ml mL
nnoremap 'l 'L
nnoremap `l `L
nnoremap m; m:
nnoremap '; ':
nnoremap `; `:

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Make netrw use current selected directory as you navigate
let g:netrw_keepdir=0
let g:netrw_banner=0
let g:netrw_liststyle = 3
let g:netrw_localrmdir='rm -r'

let g:rustfmt_autosave = 1

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

" ALE (linting and prettier)
let g:ale_linters = { 'javascript': ['tsserver'], 'typescript': ['tsserver'] }
let g:ale_fixers = { 'javascript': ['prettier'], 'typescript': ['prettier'], 'typescriptreact': ['prettier'], 'json': ['prettier'], 'markdown': ['prettier'] }
let g:ale_deno_executable = ''

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_echo_msg_error_str = 'Errors'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_statusline_format = ['%d errors', '%d warnings', 'OK']
let g:ale_fix_on_save = 1

" Are these worth it?
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 10

" Lint info in floating window
let g:ale_floating_preview = 1
let g:ale_cursor_detail = 1
let g:ale_floating_window_border = []

let NERDTreeShowHidden = 1

let mapleader = " "

" vim-commentary
nmap <C-_> gcc
vmap <C-_> gcgv

" source vimrc
nnoremap <leader>so :so%<CR>
nnoremap <leader>sv :so ~/.vimrc<CR>

" Open explorer in a side panel (not needed with NerdTree
" nnoremap <leader>e :wincmd v<bar> :wincmd H<bar> :Ex <bar> :vertical resize 25 <bar> let g:netrw_browse_split = 4<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>re :NERDTreeFind<CR>
" Copy relative file path to clipboard
noremap <leader>yf :let @*=expand("%")<cr>:echo "Copied file to clipboard"<cr>
nnoremap <leader>wf :wincmd f<CR>
nnoremap <leader>wt :vertical terminal <CR><C-w>x<C-w>l

" Quickfix list
nnoremap <leader>co :copen<CR>
nnoremap <leader>cl :cclose<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprev<CR>
nnoremap <leader>z :tab split<CR>
" Repeat last command line command
nnoremap <leader>@ :!<Up><CR>

" Window nav
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Split vertically and focus on right pane
nnoremap <leader>wv <C-w>v<C-w>l
" Fuzzy file finder
nnoremap <C-p> :GFiles<CR>
" Fuzzy text search
nnoremap <leader>f :Rg<CR>
" Search the word under the cursor
nnoremap <leader>F :Rg <C-R><C-W><CR>
" Visual block
nnoremap <leader>v <C-v>
" Delete curly block including lines
nnoremap <leader>d{ va{Vd
nnoremap <leader>b :ls<CR>:buffer<space>

" Fugitive - some of these might be overkill as mappings
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>glo :Git log --oneline<CR>
nnoremap <leader>gd :Gvdiff!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" Find next/previous lint errors
nnoremap <leader>ln :ALENextWrap<CR>
nnoremap <leader>lp :ALEPreviousWrap<CR>
nnoremap <leader>D :ALEGoToDefinition<CR>
nnoremap <C-w>d :ALEGoToDefinition<CR>

" Make Y act like C and D
nnoremap Y y$

" Visual maps
xnoremap A $A
xnoremap p pgvy

" Select all
nnoremap <leader>ggg ggVG

" Swap relative/absolute numbers
nnoremap <leader>rn :set relativenumber!<CR>

" Git push
nnoremap <leader>gp :! git add . && git commit -m '' && git push<C-f>4ba
nnoremap <leader>vim <C-w>v<C-w>l:e ~/.vimrc<CR>

" Tab autocomplete, navigate with j/k
inoremap <tab> <C-n>
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("k"))

" Visual mode indent repeat
vnoremap > >gv
vnoremap < <gv

:nnoremap <leader>w <C-w>

" Search across files
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --hidden --line-number --no-heading --color=always --smart-case -g '!{.git,*.lock,*-lock.json}' ".shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:40%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

"" Focus right pane in netrw instead of new netrw pane
"augroup netrw_mapping
"  autocmd!
"  autocmd filetype netrw call NetrwMapping()
"augroup END

"function! NetrwMapping()
"  nnoremap <buffer> <c-l> :wincmd l<cr>
"endfunction

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
" autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Wq        <line1>,<line2>wq<bang> <args>
command! -bar -bang Q quit<bang>
