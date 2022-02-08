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

" Map jh to Esc
imap jh <Esc>

set wildmenu     " Using cool display menu on the top, the simplest way to try it would be with :color <Tab>:
set path=$PWD/** " Very useful for searches
set encoding=utf-8

" Copy then paste multiple times in Vim
xnoremap p pgvy

" Spell
map <leader>ss :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Navigation
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>

set smarttab " Insert tabs on the start of a line according to shiftwidth, not tabstop
syntax on    " I love colors, don't you?

" To remember the last line we were
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Colors of the Pmenu (used mainly for autocompletition)
highlight Pmenu ctermbg=black ctermfg=white

" Plugin manager
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'morhetz/gruvbox'
  Plug 'itchyny/lightline.vim'
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  if executable('go')
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  endif

  Plug 'prettier/vim-prettier', {'do': 'yarn install --frozen-lockfile --production', 'branch': 'release/0.x' }

  " just nvim
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'akinsho/bufferline.nvim'
  Plug 'lewis6991/gitsigns.nvim'
call plug#end()

if has('nvim')
  source ~/.vim/nvim-tree.nvim
  source ~/.vim/telescope.nvim
  source ~/.vim/bufferline.nvim
  source ~/.vim/gitsigns.nvim
  source ~/.vim/treesitter.nvim
endif


" Plugins configuration
source ~/.vim/gruvbox.vim
source ~/.vim/vim-gitgutter.vim
source ~/.vim/lightline.vim 
source ~/.vim/nerdtreee.vim
source ~/.vim/vim-go.vim
source ~/.vim/coc.vim
source ~/.vim/vim-prettier.vim
