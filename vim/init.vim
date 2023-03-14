"""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color settings
set termguicolors

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
set wildmenu                  " Menu has tab completion
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
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

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

" Close all quickfix windows
autocmd FileType qf nnoremap <buffer> q :q<CR>

" Remove insert delay
if !has('gui_running')
  set timeoutlen=300
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=100
    au InsertLeave * set timeoutlen=300
  augroup END
endif

" Open location list
nmap <LocalLeader>l :lopen<CR>

" Reload files on focus
au FocusGained * if &autoread | silent checktime | endif

" Neovim workaround for C-h
if has('nvim')
  nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
endif

" Source vimrc
nnoremap <LocalLeader>t :so ~/.config/nvim/init.vim<CR>

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
" TComment
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tcomment_mapleader1 = ''
let g:tcomment_mapleader2 = ''
let g:tcomment_mapleader_comment_anyway = ''

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use ripgrep for code searching
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --hidden --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

" Open windows in splits
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
\ }

" Appearance
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_nvim_statusline = 0

""""""""""""""""""""""""""""""""""""
" Fugitive
""""""""""""""""""""""""""""""""""""
" easy close
autocmd FileType fugitive,fugitiveblame nmap <buffer> q gq
autocmd FileType fugitive,fugitiveblame nmap <buffer> <C-n> )
autocmd FileType fugitive,fugitiveblame nmap <buffer> <C-p> (

let g:fugitive_github_domains = ['github.com']

""""""""""""""""""""""""""""""""""""
" VimPasta
""""""""""""""""""""""""""""""""""""
let g:pasta_disabled_filetypes = ["coffee", "markdown", "yaml", "slim", "nerdtree"]


""""""""""""""""""""""""""""""""""""
" Clever-F
""""""""""""""""""""""""""""""""""""
let g:clever_f_across_no_line = 1
let g:clever_f_fix_key_direction = 1

""""""""""""""""""""""""""""""""""""
" Lua
""""""""""""""""""""""""""""""""""""
lua require('init')
