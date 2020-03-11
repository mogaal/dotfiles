set sw=2
set et
set mouse=a
set number

set showcmd        " Show (partial) command in status line.
set showmatch      " Show matching brackets.
set autowrite      " Automatically save before commands like :next and :make
set hidden         " Hide buffers when they are abandoned

" Search related stuff
set incsearch      " Searching starts after you enter the string.
set hlsearch       " Turns on search highlighting
set ignorecase
set smartcase      " Do smart case matching

" Use 2-spaces instead of tabs
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Mas nunca archivos de backup, adios `.swp` files!
set nobackup
set noswapfile

set encoding=utf-8

" Insert tabs on the start of a line according to shiftwidth, not tabstop
set smarttab

" Always colors
syntax on

" To remember the last line we were
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"""""""""""""""""
" lightline.vim "
"""""""""""""""""

" More info in https://github.com/itchyny/lightline.vim#introduction
set laststatus=2

" lightline is already showing the mode
set noshowmode

""""""""""""
" NERDTREE "
""""""""""""

" Mapping NERD_Tree toggle command to F2
map <C-n> :NERDTreeToggle<CR>
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""
" vim-gitgutter "
"""""""""""""""""

" Making the diff markers appears quicker (default is 4 seconds)
set updatetime=100
