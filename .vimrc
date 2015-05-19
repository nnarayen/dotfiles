set t_Co=256
autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e
colorscheme kolor
let java_highlight_all=1
set cc=+1
set textwidth=80
syntax on
set bg=dark
set ruler                     " show the line number on the bar
set more                      " use more prompt
set autoread                  " watch for file changes
set number                    " line numbers
set hidden
set noautowrite               " don't automagically write on :next
set lazyredraw                " don't redraw when don't have to
set showmode
set showcmd
set nocompatible              " vim, not vi
set smarttab
set autoindent 		          " auto/smart indent
set shiftwidth=2
set tabstop=4
set softtabstop=4
set expandtab
set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set history=200
set backspace=indent,eol,start
set linebreak
set cmdheight=2               " command line two lines high
set undolevels=1000           " 1000 undos
set updatecount=100           " switch every 100 chars
set complete=.,w,b,u,U,t,i,d  " do lots of scanning on tab completion
set ttyfast                   " we have a fast terminal
set noerrorbells              " No error bells please
set clipboard=unnamed
set fileformats=unix
set ff=unix
filetype on                   " Enable filetype 
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins
set wildmenu                  " menu has tab completion
let maplocalleader=','        " all my macros start with ,
set laststatus=2
set list listchars=tab:\ \ ,trail:·

"  searching
set incsearch                 " incremental search
nmap \q :nohlsearch<CR>
set ignorecase                " search ignoring case
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set diffopt=filler,iwhite     " ignore all whitespace and sync

" spelling
if v:version >= 700
   " Enable spell check for text files
   autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en
endif

" mappings
" toggle list mode
nmap <LocalLeader>tl :set list!<cr>
" toggle paste mode
nmap <LocalLeader>pp :set paste!<cr>

" pathogen
execute pathogen#infect()

" tab autocomplete
function! Tab_Or_Complete()
   if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
   else
    return "\<Tab>"
   endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
set dictionary="/usr/dict/words"

nmap j gj
nmap k gk
vmap j gj
vmap k gk
autocmd BufNewFile,BufRead * setlocal formatoptions+=t
set virtualedit=onemore

" control P
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore=*.class,*.o,*.info,*.swp
nnoremap <LocalLeader>d :CtrlPClearCache<CR>

" easy-motion
map <LocalLeader> <Plug>(easymotion-prefix)

" ctags
set tags=tags;/
nnoremap <LocalLeader>. :CtrlPTag<CR>

" NERDComment
map ,c :TComment<cr>

" Syntastic
nnoremap <LocalLeader>s :SyntasticToggleMode<CR>

" Ag
nnoremap <LocalLeader>a :Ag!<Space>

" Remove insert delay
if !has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=100
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" exiting insert mode
imap jk <Esc>

" update buffer after switching branches
nnoremap <LocalLeader>r :checktime<CR>
