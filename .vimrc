"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " Required for vundle
filetype off                  " Required for vundle

" Start vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/AutoTag'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/tcomment_vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'Lokaltog/vim-powerline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-sleuth'
Plugin 'burke/matcher'

" End vundle
call vundle#end()            " Required for vundle
filetype plugin indent on    " Required for vundle

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

" Java specifics
autocmd BufNewFile,BufReadPre *.java setlocal textwidth=100
let java_highlight_all=1

" Searching
set incsearch                 " Incremental search
set ignorecase                " Search ignoring case
set hlsearch                  " Highlight the search
set showmatch                 " Show matching bracket
set diffopt=filler,iwhite     " Ignore all whitespace and sync
set autoindent
set tabstop=2
set softtabstop=2

" Vim splits
set splitbelow                " Open split to right / bottom
set splitright

" Search word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" File switching
nnoremap <LocalLeader><LocalLeader> <c-^>

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
inoremap jk <Esc>

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
nnoremap <LocalLeader>g :so ~/.vimrc<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore=*.class,*.o,*.info,*.swp
nnoremap <LocalLeader>d :CtrlPClearCache<CR>
set tags=tags;/
nnoremap <LocalLeader>. :CtrlPTag<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|class)$',
  \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Matcher
"""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('matcher')
  let g:ctrlp_match_func = { 'match': 'GoodMatch' }

  function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)
    let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
    if !( filereadable(cachefile) && a:items == readfile(cachefile) )
      call writefile(a:items, cachefile)
    endif
    if !filereadable(cachefile)
      return []
    endif

    let cmd = 'matcher --limit '.a:limit.' --manifest '.cachefile.' '
    if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
      let cmd = cmd.'--no-dotfiles '
    endif
    let cmd = cmd.a:str

    return split(system(cmd), "\n")
  endfunction
end

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

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor    " Use ag over grep
  let g:ctrlp_use_caching = 0             " CtrlP doesn't need to cache
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

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
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_min_num_identifier_candidate_chars = 3
let g:ycm_add_preview_to_completeopt = 0
set completeopt-=preview
