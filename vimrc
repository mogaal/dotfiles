""""""""""""""""""""
" General settings "
""""""""""""""""""""

set sw=2
set et
set mouse=a
set number
set relativenumber " It is increasing my speed moving around

set showcmd        " Show (partial) command in status line.
set showmatch      " Show matching brackets.
set autowrite      " Automatically save before commands like :next and :make
set hidden         " Hide buffers when they are abandoned
set autoread       " reload file if changed outside vim
set cursorline     " highlight the line with the cursor

let mapleader = "," " Set the <leader> key

" Blink cursor on error instead of beeping (grr)
set visualbell

" Fast saving
nmap <leader>w :w!<cr>

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

set nobackup   " Bye bye `.swp` files!
set noswapfile 

set wildmenu     " Using cool display menu on the top, the simplest way to try it would be with :color <Tab>:
set path=$PWD/** " Very useful for searches
set encoding=utf-8

" Spell
map <leader>ss :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

set smarttab " Insert tabs on the start of a line according to shiftwidth, not tabstop
syntax on    " I love colors, don't you?

" To remember the last line we were
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Colors of the Pmenu (used mainly for autocompletition)
highlight Pmenu ctermbg=black ctermfg=white

" Plugins configuration
source ~/.vim/gruvbox.vim
source ~/.vim/ctrlp.vim
source ~/.vim/vim-gitgutter.vim
source ~/.vim/lightline.vim 
source ~/.vim/nerdtreee.vim
source ~/.vim/vim-go.vim
source ~/.vim/coc.vim
source ~/.vim/vim-prettier.vim
