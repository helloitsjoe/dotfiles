call plug#begin()
  Plug 'helloitsjoe/quantum.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-commentary'
  Plug 'dense-analysis/ale'
  Plug 'preservim/nerdtree'
  Plug 'rust-lang/rust.vim'
  Plug 'markonm/traces.vim'
  Plug 'wellle/context.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'nicwest/vim-http'
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'sheerun/vim-go'
call plug#end()

let $FZF_DEFAULT_OPTS='--reverse'

let g:fzf_history_dir = '~/.local/share/fzf-history'

" Local .viminfo per project for global marks
" Remember to gitignore!
set viminfo+=n.viminfo

syntax on
set termguicolors
set background=dark
set wildignore=node_modules/**,dist/**,coverage/**
" Hide Omnicomplete preview window
set completeopt-=preview
set foldmethod=indent
set nofoldenable

colorscheme quantum
" Transparent background
hi Normal guibg=NONE ctermbg=NONE

filetype plugin indent on

" Show file list when tabbing in shell commands, e.g. :!mv ./<tab>
set wildmode=longest,list,full
set wildmenu

let padding = ' | '

" Add filename and lint status to the statusline
set statusline=%f " %t for just filename
set statusline+=%{padding}
set statusline+=col:\ %c
set statusline+=%{padding}
set statusline+=%{LinterStatus()}

set path+=**
set suffixesadd+=.js

set number
set tabstop=2
set shiftwidth=2
set smartindent
set relativenumber
set scrolloff=5
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

" https://gist.github.com/romainl/6e4c15dfc4885cb4bd64688a71aa7063#risky-business
augroup group
  autocmd!
augroup END

" Don't add comment under a comment. This needs to be an autocmd: https://vi.stackexchange.com/a/9367
autocmd group FileType * set formatoptions-=cro
autocmd group BufEnter *.md set conceallevel=0

" cl' or cll' will expand to a console log with the cursor in place
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr cl console.log(');<C-c>F'i
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr cll console.log(');<C-c>F'i
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr modex module.exports = {<CR>};<C-c>kA
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr imn import { X } from ';<C-c>F'i
autocmd group BufEnter *.test.{js,ts,jsx,tsx,mjs} iabbr it( it(', () => {<CR>});<C-c>kf'i
autocmd group BufEnter *.test.{js,ts,jsx,tsx,mjs} iabbr test( test(', () => {<CR>});<C-c>kf'i
autocmd group BufEnter *.test.{js,ts,jsx,tsx,mjs} iabbr desc( describe(', () => {<CR>});<C-c>kf'i
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr imr import React from 'react';
autocmd group BufEnter *.{js,jsx} iabbr impt import PropTypes from 'prop-types';
autocmd group BufEnter *.html iabbr html <html><CR><head><CR><title></title><CR></head><CR><body><CR></body><CR></html><Esc>/title<CR>wa
autocmd group BufEnter *.go iabbr forr for _,X := range k {<CR>}<Esc>kfXs
autocmd group BufEnter *.go iabbr fmtp fmt.Println("")<Esc>F"i
autocmd group BufEnter *.rs iabbr pr println!("{:?}",);<Esc>F)i

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd group BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" This is nice in theory but ends up messing with <C-w>l when in NERDTree.
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
" autocmd group BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Make netrw use current selected directory as you navigate
" let g:netrw_keepdir=0
" let g:netrw_banner=0
" let g:netrw_liststyle = 3
" let g:netrw_localrmdir='rm -r'

let g:rustfmt_autosave = 1

" Adds total lint warnings/errors to the statusbar
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf(
  \   '⚠️  %d 🔴 %d',
  \   all_non_errors,
  \   all_errors
  \)
endfunction

" ALE (linting and prettier)
let g:ale_linters = { 'javascript': ['tsserver', 'eslint'], 'typescript': ['tsserver', 'eslint'],  'javascriptreact': ['tsserver', 'eslint'], 'typescriptreact': ['tsserver', 'eslint'], 'sh': ['shellcheck'] }
let g:ale_fixers = { 'javascript': ['prettier'], 'typescript': ['prettier'], 'typescriptreact': ['prettier'], 'json': ['prettier'], 'markdown': ['prettier'], 'html': ['prettier'] }
let g:ale_deno_executable = ''

let g:ale_sign_error = '🔴'
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
let NERDTreeMapMenu = 'n'

let mapleader = " "

" React useState
nnoremap <C-s> <Esc>diwi []<Esc>Pa, <Esc>pbvUiset<Esc>A = useState();<Esc>F)i
inoremap <C-s> <Esc>diwi []<Esc>Pa, <Esc>pbvUiset<Esc>A = useState();<Esc>F)i

" In insert mode, paste the variable from its label
" specifically for cl' abbrev
inoremap <C-l> <Esc>yi'f'a, <Esc>p

" Open brackets
inoremap <C-]> {<CR>}<Esc>O

" nnoremap <leader>cll yiwoconsole.log('<Esc>pa', <Esc>pa);<Esc>

" Auto-wrap tags ("t register)
inoremap <C-t> <Esc>"tciw<<Esc>"tpa></<Esc>"tpa><Esc>F<i<CR><Esc>O

" jk -> esc
inoremap jk <Esc>

" Make home row global marks
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
nnoremap mf mF
nnoremap 'f 'F
nnoremap `f `F
nnoremap md mD
nnoremap 'd 'D
nnoremap `d `D
nnoremap ms mS
nnoremap 's 'S
nnoremap `s `S
nnoremap ma mA
nnoremap 'a 'A
nnoremap `a `A

" vim-commentary
nmap <C-_> gcc
vmap <C-_> gcgv

" source vimrc
nnoremap <leader>so :so ~/.vimrc<CR>
nnoremap <leader>sv :so ~/.vimrc<CR>

" search across file
nnoremap <leader>s :%s/
" search for word under cursor across file
nnoremap <leader>S :%s/<C-r><C-w>//g<C-f>hi<C-c>

" open current file in Chrome (e.g. preview markdown or html)
nnoremap <leader>ch :!open -a "Google Chrome" %<CR>

" Open explorer in a side panel (not needed with NerdTree
" nnoremap <leader>e :wincmd v<bar> :wincmd H<bar> :Ex <bar> :vertical resize 25 <bar> let g:netrw_browse_split = 4<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>re :NERDTreeFind<CR>
" Copy relative file path to clipboard
noremap <leader>yf :let @*=expand("%")<cr>:echo "Copied file to clipboard"<cr>
" Probably delete this, seems like gf does the trick
" nnoremap <leader>wf :wincmd f<CR>

" Quickfix list
nnoremap <leader>co :copen<CR>
nnoremap <leader>cl :cclose<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprev<CR>
" Zoom into current tab, :q to close
nnoremap <leader>z :tab split<CR>
" Repeat last command line command
nnoremap <leader>@ :!<Up>
nnoremap ; :

" Window nav
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Split vertically and focus on right pane
nnoremap <leader>wv <C-w>v<C-w>l
" Fuzzy file finder, exclude .yarn cache
nnoremap <C-p> :GFiles ':!:.yarn/cache'<CR>
" Fuzzy text search
nnoremap <leader>f :Rg<CR>
" Search the word under the cursor
nnoremap <leader>F :Rg <C-R><C-W><CR>
" List buffers
nnoremap <leader>b :ls<CR>:b

nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" Fugitive - some of these might be overkill as mappings
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gs :Git<CR> <C-w>10_
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>glo :Git log --oneline<CR>
" Pickaxe
nnoremap <leader>glp :Git log -p -S ''<C-f>ba
nnoremap <leader>gd :Gvdiff!<CR>
nnoremap <leader>ga :Git add .<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" fzf :History command to open recently opend files
nnoremap <leader>hi :History<CR>

" Turn off current highlight selection
nnoremap <leader>no :noh<CR>

" Find and replace in quick fix list:
" `e` flag is 'no error if pattern not found'
" `update` saves (only writes if changes were made)
" Can also use `bufdo` do find/replace in open buffers
" :cdo %s/pattern/replace/ge | update

" Find next/previous lint errors
nnoremap <leader>ln :ALENextWrap<CR>
nnoremap <leader>lp :ALEPreviousWrap<CR>
nnoremap <leader>D :ALEGoToDefinition<CR>

" Make Y act like C and D
nnoremap Y y$

" Visual maps
xnoremap A $A
xnoremap p pgvy
" Visual mode indent repeat
vnoremap > >gv
vnoremap < <gv

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


command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Wq        <line1>,<line2>wq<bang> <args>
command! -bar -bang Q quit<bang>
