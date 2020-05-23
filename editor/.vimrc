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

" Navigations
no <C-h> <C-W>h
no <C-j> <C-w>j
no <C-k> <C-W>k
no <C-l> <C-w>l

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==