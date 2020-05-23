"-------------------------------- GENERAL --------------------------------
syntax on

set autoindent
filetype plugin on
filetype plugin indent on

set hidden

set nobackup
set nowritebackup
set noswapfile
set nowrap

set encoding=UTF-8
set mouse=a

set history=1000
set undolevels=1000

set incsearch
set hlsearch

set number
set relativenumber
set ignorecase
set smartcase

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set lazyredraw

set visualbell
set noerrorbells

"-------------------------------- KEY BINDING --------------------------------
" Navigations
noremap <C-h> <C-W>h
noremap <C-j> <C-w>j
noremap <C-k> <C-W>k
noremap <C-l> <C-w>l

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

" Windows Alter
vnoremap <C-c> "+y
vnoremap <C-x> "+x
noremap <C-v> "+gP
noremap <C-a> ggVG
