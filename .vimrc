"""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color settings
colorscheme kolor
set t_Co=256
syntax on
set bg=dark

" Local Leader
let maplocalleader=','        " All my macros start with ,

" Display
set cc=+1
set textwidth=100
set ruler                     " Show the line number on the bar
set more                      " Use more prompt
set autoread                  " Watch for file changes
set number                    " Line numbers
set hidden
set noautowrite               " Don't automagically write on :next
set lazyredraw                " Don't redraw when don't have to
set showmode
set showcmd
set nocompatible              " Vim, not vi

" Scrolling
set sidescrolloff=5           " Keep at least 5 lines left/right
set scrolloff=5               " Keep at least 5 lines above/below

" Tab settings
set smarttab
set autoindent                " Auto/smart indent
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

" Clipboard
set clipboard=unnamed
set fileformats=unix
set ff=unix

" Filetypes
filetype on                   " Enable filetype
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins
set wildmenu                  " Menu has tab completion
set laststatus=2
set list listchars=tab:\ \ ,trail:·
autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd BufNewFile,BufRead * setlocal formatoptions+=t

"  Searching
set incsearch                 " Incremental search
set ignorecase                " Search ignoring case
set hlsearch                  " Highlight the search
set showmatch                 " Show matching bracket
set diffopt=filler,iwhite     " Ignore all whitespace and sync

" Misc settings
set history=200
set backspace=indent,eol,start
set linebreak
set cmdheight=1               " Command line two lines high
set undolevels=1000           " 1000 undos
set updatecount=100           " Switch every 100 chars
set complete=.,w,b,u,U,t,i,d  " Do lots of scanning on tab completion
set ttyfast                   " We have a fast terminal
set noerrorbells              " No error bells please
set virtualedit=onemore

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Useful commands and mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Unhighlight
nmap <LocalLeader>q :nohlsearch<CR>

" Spelling
if v:version >= 700
   " Enable spell check for text files
   autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en
endif

" Remove insert delay
if !has('gui_running')
    set ttimeoutlen=40
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=100
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" Exiting insert mode
imap jk <Esc>

" Search word under cursor
nnoremap <LocalLeader>s *

" Update buffer
nnoremap <LocalLeader>r :checktime<CR>

" Toggle list mode
nmap <LocalLeader>tl :set list!<cr>

" Toggle paste mode
nmap <LocalLeader>pp :set paste!<cr>

" Move single lines
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" :(
:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q

" Source vimrc
nnoremap <LocalLeader>v :so ~/.vimrc<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pathogen
"""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore=*.class,*.o,*.info,*.swp
nnoremap <LocalLeader>d :CtrlPClearCache<CR>
set tags=tags;/
nnoremap <LocalLeader>. :CtrlPTag<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy Motion
"""""""""""""""""""""""""""""""""""""""""""""""""""""
map <LocalLeader> <Plug>(easymotion-prefix)

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" TComment
"""""""""""""""""""""""""""""""""""""""""""""""""""""
map <LocalLeader>c :TComment<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ag
"""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <LocalLeader>a :Ag!<Space>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""
au Filetype go nnoremap <LocalLeader>v :vsp <CR>:exe "GoDef"<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <LocalLeader>m :NERDTreeFind<CR>
let g:NERDTreeWinSize = 50

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" DelimitMate
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:delimitMate_expand_cr = 2

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_min_num_identifier_candidate_chars = 4
nnoremap <LocalLeader>f :YcmCompleter GoToDefinitionElseDeclaration<CR>
