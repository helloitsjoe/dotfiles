call plug#begin()
  Plug 'machakann/vim-highlightedyank'
  Plug 'neovimhaskell/haskell-vim'
  Plug 'helloitsjoe/quantum.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-commentary'
  Plug 'dense-analysis/ale'
  Plug 'preservim/nerdtree'
  Plug 'rust-lang/rust.vim'
  Plug 'github/copilot.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'junegunn/fzf.vim'
  Plug 'evanleck/vim-svelte', {'branch': 'main'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  " Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

let $FZF_DEFAULT_OPTS='--reverse'

let g:fzf_history_dir = '~/.local/share/fzf-history'

colorscheme iceberg

" Transparent background
" hi Normal guibg=NONE ctermbg=NONE

syntax on
filetype plugin indent on

set termguicolors
set background=dark
set wildignore=node_modules/**,dist/**,coverage/**
set completeopt-=preview " Hide Omnicomplete preview window at top of screen
set foldmethod=syntax
set nofoldenable
set re=0 " Use new syntax highlighting engine because TS is slow

set omnifunc=ale#completion#OmniFunc

set wildmode=longest,list,full " Show file list when tabbing in shell commands, e.g. :!mv ./<tab>
set wildmenu

" Add filename and lint status to the statusline
let padding = ' | '
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
set hidden " Keep Explore window from splitting vertically
set visualbell t_vb=
set colorcolumn=80
set signcolumn=yes
set updatetime=50
set backspace=indent,eol,start

highlight ALEError ctermbg=none ctermfg=red cterm=underline gui=undercurl
highlight ALEWarning ctermbg=none ctermfg=yellow cterm=underline gui=undercurl

highlight HighlightedyankRegion cterm=reverse gui=reverse
let g:highlightedyank_highlight_duration = 50
let g:yats_host_keyword = 1

" https://gist.github.com/romainl/6e4c15dfc4885cb4bd64688a71aa7063#risky-business
augroup group
  autocmd!
augroup END

" Don't add comment under a comment. This needs to be an autocmd: https://vi.stackexchange.com/a/9367
autocmd group FileType * set formatoptions-=cro
autocmd group BufEnter *.md set conceallevel=0

autocmd group BufEnter *.go iabbr forr for _,X := range k {<CR>}<Esc>kfXs
autocmd group BufEnter *.go iabbr pr fmt.Println("")<Esc>F"i
autocmd group BufEnter *.rs iabbr pr println!("{:?}",);<Esc>F)i
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr cl console.log('');<C-c>F'i
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr cll console.log('');<C-c>F'i
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr modex module.exports = {};<C-c>F{a
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr impp import { } from '';<C-c>F{a
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr reqq const { } = require('');<C-c>F{a
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr expp expect().toBe();<C-c>2F)i
autocmd group BufEnter *.test.{js,ts,jsx,tsx,mjs} iabbr itt it('', () => {<CR>});<C-c>kf'a
autocmd group BufEnter *.test.{js,ts,jsx,tsx,mjs} iabbr testt test('', () => {<CR>});<C-c>kf'a
autocmd group BufEnter *.test.{js,ts,jsx,tsx,mjs} iabbr dess describe('', () => {<CR>});<C-c>kf'a
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr imr import React from 'react';
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr func function() {<CR><CR>}<C-c>kk0f(i
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr todo // TODO:
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr /** /**<CR> *<CR>*/<C-c>kA
autocmd group BufEnter *.{js,ts,jsx,tsx,mjs} iabbr /*/ /* */<C-c>hhi
autocmd group BufEnter *.{js,jsx} iabbr impt import PropTypes from 'prop-types';
autocmd group BufEnter *.html iabbr htmll <html><CR><head><CR><title></title><CR></head><CR><body><CR></body><CR></html><Esc>/title<CR>wa

" Bar cursor in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

let g:rustfmt_autosave = 1

" Go syntax highlighting
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_operators = 1

"==== ALE ====

" Adds total lint warnings/errors to the statusbar
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf('⚠️  %d 🔴 %d', all_non_errors, all_errors)
endfunction

let g:ale_linter_aliases = {'svelte': ['css', 'javascript', 'typescript', 'html']}
let g:ale_linters = { 'javascript': ['tsserver', 'eslint'], 'typescript': ['tsserver', 'eslint'], 'javascriptreact': ['tsserver', 'eslint'], 'typescriptreact': ['tsserver', 'eslint'], 'sh': ['shellcheck'], 'python': ['jedils', 'pylint', 'flake8', 'black', 'mypy'], 'rust': ['analyzer', 'cargo'], 'svelte': ['tsserver', 'eslint'] }
let g:ale_fixers = { 'javascript': ['prettier'], 'typescript': ['prettier'], 'javascriptreact': ['prettier'], 'typescriptreact': ['prettier'], 'json': ['prettier'], 'markdown': ['prettier'], 'python': ['black'], 'html': ['prettier'], 'svelte': ['prettier'] }
let g:ale_deno_executable = ''

let g:ale_sign_error = 'X'
let g:ale_sign_warning = '*'
let g:ale_echo_msg_error_str = 'Errors'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_statusline_format = ['%d errors', '%d warnings', 'OK']
let g:ale_fix_on_save = 1
let g:ale_rust_cargo_use_clippy = 1
let g:ale_python_black_options='--line-length=79'

let g:ale_completion_enabled = 1
let g:ale_save_hidden = 1 " Save hidden buffers (experimenting)

let g:ale_completion_delay = 10
let g:ale_lint_delay = 10

let g:ale_floating_preview = 1 " Lint info in floating window
let g:ale_cursor_detail = 1
let g:ale_floating_window_border = []
let g:ale_go_golangci_lint_package = 1 " Workaround for Go linting, see https://github.com/golangci/golangci-lint/issues/536

let g:svelte_preprocessors = ['typescript']

let mapleader = " "

" Find and replace in quick fix list:
" `e` flag is 'no error if pattern not found'
" `update` saves (only writes if changes were made)
" Can also use `bufdo` do find/replace in open buffers
" :cdo %s/pattern/replace/ge | update

" Paste from clipboard - native ctrl-p is very slow sometimes
" https://stackoverflow.com/questions/18258561/pasting-a-huge-amount-of-text-into-vim-is-slow
inoremap <C-v> <c-c>"+p
map <C-c> "+y " Copy visual selection to clipboard

nnoremap ; :

" Window nav
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Find next/previous lint errors
nnoremap <leader>ln :ALENextWrap<CR>
nnoremap <leader>lp :ALEPreviousWrap<CR>
nnoremap <leader>D :ALEGoToDefinition<CR>
nnoremap <leader>ty :ALEHover<CR>
" Toggle completion so it doesn't get in the way of copilot
nnoremap <leader>au :let g:ale_completion_enabled = !g:ale_completion_enabled<CR>
nnoremap <leader>R :ALERename<CR>
" nnoremap <leader>F :ALEFindReferences<CR>
nnoremap <leader>cpe :Copilot enable<CR>
nnoremap <leader>cpd :Copilot disable<CR>

" React useState
nnoremap <C-s> <Esc>diwi []<Esc>Pa, <Esc>pbvUiset<Esc>A = useState();<Esc>F)i

" Move lines up and down
nnoremap <C-n> :m .+1<CR>==
nnoremap <C-m> :m .-2<CR>==
vnoremap <C-n> :m '>+1<CR>gv=gv
vnoremap <C-m> :m '<-2<CR>gv=gv

inoremap <C-l> <Esc>yi'f'a, <Esc>p " In insert mode, paste the variable from its label
inoremap <C-]> {<CR>}<Esc>O " Open brackets
inoremap <C-f> () => {<CR><CR>});<C-c>2k$F)i " Function

cnoremap <C-k> \(.*\) " One-eyed Kirby for find/replace

" Auto-wrap tags (replaces default register with previously cut content)
inoremap <C-t> <Esc>ciw<<Esc>pa></<Esc>pa><Esc>F<:let @"=@0<CR>i

inoremap jk <Esc> " jk -> esc
" vim-commentary
nmap <C-/> gcc
vmap <C-/> gcgv

" source vimrc
nnoremap <leader>so :so ~/.vimrc<CR>
" search for word under cursor across file
nnoremap <leader>S :%s/<C-r><C-w>//g<C-f>hhi<C-c>
" open current file in Chrome (e.g. preview markdown or html)
nnoremap <leader>ch :!open -a "Google Chrome" %<CR>

" Open explorer in a side panel (not needed with NerdTree
" nnoremap <leader>e :wincmd v<bar> :wincmd H<bar> :Ex <bar> :vertical resize 25 <bar> let g:netrw_browse_split = 4<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>re :NERDTreeFind<CR>
" Copy relative file path to clipboard
noremap <leader>yf :let @*=expand("%")<cr>:echo "Copied file to clipboard"<cr>

" Quickfix list
nnoremap <leader>co :copen<CR>
nnoremap <leader>cl :cclose<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprev<CR>

nnoremap <leader>@ :!<Up> " Repeat last command line command

" Fuzzy file finder, exclude .yarn cache
nnoremap <C-p> :GFiles ':!:.yarn/cache'<CR>
" Fuzzy text search
nnoremap <leader>f :Rg<CR>
" Search the word under the cursor
nnoremap <leader>F :Rg <C-R><C-W><CR>
" List buffers
nnoremap <leader>b :ls<CR>:b

" re-center cursor after scrolling
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" Fugitive
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gs :Git<CR> <C-w>10_
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>glo :Git log --oneline<CR>
nnoremap <leader>gdd :Gvdiff!<CR>
nnoremap <leader>ga :Git add .<CR>
nnoremap <leader>gdh :diffget //2<CR>
nnoremap <leader>gdl :diffget //3<CR>
" Pickaxe
nnoremap <leader>gpx :Git log -p -S ''<C-f>ba

" fzf :History command to open recently opend files
nnoremap <leader>hi :History<CR>
" Turn off current highlight selection
nnoremap <leader>no :noh<CR>

" Spell check
nnoremap <leader>spp :set spell spelllang=en_us<CR>
nnoremap <leader>spx :set nospell<CR>

" Make Y act like C and D
nnoremap Y y$
xnoremap A $A
xnoremap p pgvy " Re-yank selection after pasting
" Visual mode indent repeat
vnoremap > >gv
vnoremap < <gv

" Swap relative/absolute numbers
nnoremap <leader>rn :set relativenumber!<CR>
" Open vimrc in vertical split
nnoremap <leader>vim <C-w>v<C-w>l:e ~/.vimrc<CR>

inoremap <tab> <C-n> " Tab autocomplete, navigate with j/k
" inoremap <silent><expr> <tab> pumvisible() ? "\<C-n>" : "\<tab>"
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("k"))

:nnoremap <leader>w <C-w>

" Open another file in diff view
command! -nargs=1 -complete=file Diffwith :vs <args> <Bar> windo diffthis

let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['right:50%:<70(down:40%)', 'ctrl-p']

" Search across files
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --hidden --line-number --no-heading --color=always --smart-case -g '!{.git,*.lock,*-lock.json}' ".shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:40%')
  \           : fzf#vim#with_preview('right:50%:<70(down:40%)', 'ctrl-p'),
  \   <bang>0)

let NERDTreeShowHidden = 1

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd group BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
" This is nice in theory but ends up messing with <C-w>l when in NERDTree?
" autocmd group BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Syntax highlighting: get the identifier for the symbol under the cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nnoremap gm :call SynStack()<CR>

command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Wq        <line1>,<line2>wq<bang> <args>
command! -bar -bang Q quit<bang>

" gof = git open file, open the current file in GitHub UI
noremap <silent> <leader>gof :<c-u>call OpenInGitHub()<cr>
" goc = git open commit, when on a commit hash, e.g. in Fugitive git blame
noremap <silent> <leader>goc yiw:q<CR> :<c-u>call OpenInGitHub('<c-r>"')<cr>

function! OpenInGitHub(...)
  let commit_hash = get(a:, 1, '')
  let file_dir = expand('%:h')
  let git_root = system('cd ' . file_dir . '; git rev-parse --show-toplevel | tr -d "\n"')
  let file_path = substitute(expand('%:p'), git_root . '/', '', '')
  let branch = system('git symbolic-ref --short -q HEAD | tr -d "\n"')
  let git_remote = system('cd ' . file_dir . '; git remote get-url origin')
  let repo_path = matchlist(git_remote, ':\(.*\)\.')[1]
  let url = 'https://github.com/' . repo_path
  if commit_hash != ''
    let url .= '/commit/' . commit_hash
  else
    let url .= '/blob/main/' . file_path
  endif
  call system('open ' . url)
endfunction
