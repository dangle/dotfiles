" Use Homebrew version of python3
let g:python3_host_prog = '/home/linuxbrew/.linuxbrew/bin/python3'

"==============================================================================
" Plugins (vim-plug) 
"==============================================================================
call plug#begin(stdpath('data') . '/plugged')

" Sensible defaults
Plug 'tpope/vim-sensible'

" Status bar
Plug 'itchyny/lightline.vim'

" Enable toggling of quickfix and location lists
Plug 'Valloric/ListToggle'

" NERDTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

" NERDCommenter
Plug 'preservim/nerdcommenter'

" Multiple selection
Plug 'terryma/vim-multiple-cursors'

" Auto-paste mode when pasting
Plug 'ryanpcmcquen/fix-vim-pasting'

" Fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Language support
Plug 'vim-syntastic/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'Chiel92/vim-autoformat'

" Git
Plug 'tpope/vim-fugitive'

" Python
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'davidhalter/jedi-vim'

" Rust
Plug 'rust-lang/rust.vim'

" TypeScript
Plug 'Quramy/tsuquyomi'

" Svelte
Plug 'leafOfTree/vim-svelte-plugin'

" Markdown preview
Plug 'skanehira/preview-markdown.vim'

" Theme
Plug 'dylanaraps/wal.vim'

call plug#end()


"==============================================================================
" Theme
"==============================================================================
if !has('gui_running')
    set t_Co=256
endif

" Use colors for a dark background
set background=dark

" Highlight the current line
set cursorline

" Hide the current mode since it would duplicate lightline
set noshowmode

" Show line numbers
set number

colorscheme monokai

" Use a transparent background
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE

let g:lightline = { 'colorscheme': 'jellybeans' }

"==============================================================================
" File formats
"==============================================================================
if has('autocmd')
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    au BufRead,BufNewFile,BufEnter *polybar/config setf dosini
    au BufNewFile,BufRead /*.rasi setf css
endif


"==============================================================================
" Syntastic
"==============================================================================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

" Python
let g:syntastic_python_checkers = ['pylint', 'flake8', 'mypy', 'pep257']

"==============================================================================
" List Toggle
"==============================================================================
let g:lt_location_list_toggle_map = '<F2>'
let g:lt_quickfix_list_toggle_map = '<F3>'


"==============================================================================
" Better GUI integration
"==============================================================================

" Enable mouse support
if has('mouse')
    set mouse=a
endif

" Use the system clipboard as primary register
if has('clipboard')
    set clipboard=unnamedplus
endif


"==============================================================================
" NERDCommenter
"==============================================================================
map <C-_> <leader>c<space>
let g:NERDSpaceDelims = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDCommentEmptyLines = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'


"==============================================================================
" NERDTree
"==============================================================================
let g:NERDTreeWinPos = 'right'

" NERDTree mappings
map <silent> <leader>\ :NERDTreeToggle %<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}

" Close vi if NERDTree is only open buffer
if has('autocmd')
    au bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
endif


"==============================================================================
" Multiple selection
"==============================================================================
let g:multi_cursor_start_word_key = '<C-d>'
let g:multi_cursor_next_key = '<C-d>'


"==============================================================================
" Auto-format (<ctrl><shift>i)
"==============================================================================
noremap <C-S-i> :Autoformat<CR>


"==============================================================================
" Preview Markdown
"==============================================================================
let g:preview_markdown_vertical = 1
let g:preview_markdown_parser = 'glow'
let g:preview_markdown_auto_update = 1


"==============================================================================
" Git
"==============================================================================

" Blame
nnoremap <leader>b :Gblame<CR>


"==============================================================================
" Saving (<ctrl>s)
"==============================================================================
noremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>i


"==============================================================================
" Indentation
"==============================================================================
set linespace=4
set tabstop=4 shiftwidth=4 expandtab


"==============================================================================
" Tabs and Windows
"==============================================================================

" Disable word-wrap
set nowrap

" Allow file switching without saving
set hidden

" Map keys to clearing/hiding the search results
nnoremap <silent> <F4> :set hlsearch!<CR>

" More natural tab key mappings
noremap <silent> <C-t> :tabnew<CR>
noremap <M-1> 1gt
noremap <M-2> 2gt
noremap <M-3> 3gt
noremap <M-4> 4gt
noremap <M-5> 5gt
noremap <M-6> 6gt
noremap <M-7> 7gt
noremap <M-8> 8gt
noremap <M-9> 9gt
noremap <M-0> 10gt
noremap <M--> 11gt
noremap <M-=> 12gt
noremap <silent> <C-w> :windo bd<CR>

" Map window splitting keys
noremap <silent> <leader>; :new<CR>
noremap <silent> <leader>' :vnew<CR>

" Change window focus (<ctrl><arrow>)
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>
