"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/bundle/')

" Plugins
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-slash'
Plug 'sickill/vim-pasta'
Plug 'svermeulen/vim-easyclip'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'rhysd/clever-f.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'phaazon/hop.nvim'
Plug 'junegunn/fzf.vim'

" Lanugage specific plugins
Plug 'cappyzawa/starlark.vim', { 'for': 'starlark' }

" Post installation hooks
Plug 'junegunn/fzf',      { 'dir': '~/.fzf', 'do': './install --all' }

" Command specific plugins
Plug 'machakann/vim-swap',        { 'on': ['<Plug>(swap-prev)', '<Plug>(swap-next)'] }
Plug 'tomtom/tcomment_vim',       { 'on': ['TComment'] }

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'ray-x/lsp_signature.nvim'

" Color Scheme
Plug 'sonph/onehalf', { 'rtp': 'vim/' }

" End plug
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color settings
set background=dark
colorscheme onehalfdark

" Local Leader
let maplocalleader=' '        " All my macros start with <Space>

" Display
set cc=+1
set ruler                     " Show the line number on the bar
set more                      " Use more prompt
set autoread                  " Watch for file changes
set number                    " Line numbers
set hidden
set noautowrite               " Don't automagically write on :next
set lazyredraw                " Don't redraw when don't have to
set showmode
set showcmd
set cursorline
set noswapfile
set synmaxcol=200

" Scrolling
set sidescrolloff=5           " Keep at least 5 lines left/right
set scrolloff=5               " Keep at least 5 lines above/below

" Clipboard
set clipboard=unnamed
set fileformats=unix
set ff=unix

" Filetypes
filetype on                   " Enable filetype
set wildmenu                  " Menu has tab completion
set laststatus=2
set list listchars=tab:\ \ ,trail:·
autocmd BufNewFile,BufRead * setlocal formatoptions+=t

" File specific line widths
autocmd BufNewFile,BufReadPre *.js,*.jsx setlocal textwidth=100
autocmd BufNewFile,BufReadPre *.java setlocal textwidth=100
autocmd BufNewFile,BufReadPre *.tex setlocal textwidth=80
autocmd BufNewFile,BufReadPre *.rb,*.rake setlocal textwidth=100

" Adding new filetypes
au BufNewFile,BufRead *.hql set filetype=hive.hql
au BufNewFile,BufRead *.tf set filetype=hcl

" Searching
set incsearch                 " Incremental search
set ignorecase                " Search ignoring case
set smartcase                 " Case sensitive for uppercase
set hlsearch                  " Highlight the search
set showmatch                 " Show matching bracket
set diffopt=filler,iwhite     " Ignore all whitespace and sync
set autoindent

" Vim splits
set splitbelow                " Open split to right / bottom
set splitright

" Misc settings
set mouse=a
set history=200
set backspace=indent,eol,start
set linebreak
set cmdheight=1               " Command line two lines high
set undolevels=1000           " 1000 undos
set updatecount=100           " Switch every 100 chars
set updatetime=250            " Update every 250ms
set complete=w,b,u,U,t,i,d    " Do lots of scanning on tab completion
set noerrorbells              " No error bells please
set virtualedit=onemore
set tags=./tags,tags;         " Find tags file
set tabstop=4

" Toggle relative numbering
set relativenumber
autocmd! InsertEnter,InsertLeave * set invrelativenumber

" Spelling
if v:version >= 700
   " Enable spell check for text files
   autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Useful commands and mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Kill any trailing whitespace on save (credit to FB)
let g:strip_whitespace = 1
function! <SID>StripTrailingWhitespaces()
  if exists('g:strip_whitespace')
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
  endif
endfunction

let g:kill_whitespace_blacklist = ["neosnippet"]
if index(g:kill_whitespace_blacklist, &ft) < 0
  au BufWritePre * :call <SID>StripTrailingWhitespaces()
endif

" Convert all tabs to spaces
nmap <LocalLeader>T :retab<cr>

" Close all quickfix windows
autocmd FileType qf nnoremap <buffer> q :q<CR>

" Unhighlight
nnoremap <LocalLeader>q :nohlsearch<CR>

" Sort lines
vmap <LocalLeader>S :sort<CR>

" Remove insert delay
if !has('gui_running')
  set timeoutlen=300
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=100
    au InsertLeave * set timeoutlen=300
  augroup END
endif

" Exiting insert mode
inoremap jk <Esc>

" Search word under cursor
nmap <LocalLeader>s *

" Update buffer
nnoremap <LocalLeader>r :checktime<CR>

" Open location list
nmap <LocalLeader>l :lopen<CR>

" Intelligently jump over wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

vnoremap <expr> j v:count ? 'j' : 'gj'
vnoremap <expr> k v:count ? 'k' : 'gk'

" :(
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev WQ wq
cnoreabbrev Wq wq
cnoreabbrev wQ wq

" Avoid ex mode
nnoremap Q <nop>

" Reload files on focus
au FocusGained * if &autoread | silent checktime | endif

" Easily move to start/end of line
nnoremap H ^
vnoremap H ^
onoremap H ^
nnoremap L $
vnoremap L $
onoremap L $

" Easier to run commands
nnoremap ; :
vnoremap ; :

" Neovim workaround for C-h
if has('nvim')
  nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
endif

" Source vimrc
nnoremap <LocalLeader>t :so ~/.config/nvim/init.vim<CR>

" File switching
nnoremap <LocalLeader><LocalLeader> <c-^>

" Copy file path
nnoremap <LocalLeader>u :let @+=expand('%')<CR>

" Evenly size all splits
nnoremap <silent> <C-q> <C-w>=

" Run a macro on all visually selected lines
" https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db#.3dcn9prw6
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hop
"""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <LocalLeader>w :HopWord<CR>
nmap <LocalLeader>b :HopWord<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" TComment
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tcomment_mapleader1 = ''
let g:tcomment_mapleader2 = ''
let g:tcomment_mapleader_comment_anyway = ''
map <LocalLeader>c :TComment<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <C-p> :FZF -m<CR>
nmap <LocalLeader>a :Rg<Space>

" Use ripgrep for code searching
command! -bang -nargs=* Rg call fzf#vim#grep('rg --hidden --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

" Search for word under cursor
nmap S :Rg <C-R><C-W><CR>

" Open windows in splits
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
\ }

" Appearance
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_nvim_statusline = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" netrw needed for fugitive
let g:nvim_tree_disable_netrw = 0
let g:nvim_tree_disable_window_picker = 1

nnoremap <LocalLeader>f :NvimTreeFindFile<CR>

""""""""""""""""""""""""""""""""""""
" Easy Align
""""""""""""""""""""""""""""""""""""
vmap <LocalLeader>v <Plug>(EasyAlign)

" Define custome configurations
if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['_'] = { 'pattern': '-', 'ignore_groups': ['String'] }
let g:easy_align_delimiters[':'] = { 'pattern': ':' }
let g:easy_align_delimiters['\'] = { 'pattern': '\\' }

""""""""""""""""""""""""""""""""""""
" Easy Clip
""""""""""""""""""""""""""""""""""""
xmap d <Plug>MoveMotionXPlug
xmap x <Plug>MoveMotionXPlug
nmap dd <Plug>MoveMotionLinePlug

""""""""""""""""""""""""""""""""""""
" Fugitive
""""""""""""""""""""""""""""""""""""
nmap <silent> <LocalLeader>gs :Git<CR>gg<C-n>
nmap <silent> <LocalLeader>gd :Git diff<CR>
nmap <silent> <LocalLeader>gb :Git blame<CR>
nmap <silent> <LocalLeader>gr :GBrowse<CR>
vmap <silent> <LocalLeader>gr :GBrowse<CR>

" easy close
autocmd FileType fugitive,fugitiveblame nmap <buffer> q gq

let g:fugitive_github_domains = ['github.com']

""""""""""""""""""""""""""""""""""""
" VimPasta
""""""""""""""""""""""""""""""""""""
let g:pasta_disabled_filetypes = ["coffee", "markdown", "yaml", "slim", "nerdtree"]

""""""""""""""""""""""""""""""""""""
" Vim Swap
""""""""""""""""""""""""""""""""""""
nmap gh <Plug>(swap-prev)
nmap gl <Plug>(swap-next)

""""""""""""""""""""""""""""""""""""
" Clever-F
""""""""""""""""""""""""""""""""""""
let g:clever_f_across_no_line = 1
let g:clever_f_fix_key_direction = 1

""""""""""""""""""""""""""""""""""""
" Lua
""""""""""""""""""""""""""""""""""""
lua require('init')
