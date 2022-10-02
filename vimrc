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

nmap <leader>w :w!<cr>   " Fast saving

" Adding some LUA
lua <<EOF
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
EOF

" To remember the last line we were
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Plugin manager
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-commentary'

  " just nvim
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'

  " Telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'akinsho/bufferline.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'towolf/vim-helm'

  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'

  " nvim-cmp
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  " For vsnip users.
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'onsails/lspkind.nvim'

  Plug 'catppuccin/nvim', {'as': 'catppuccin'}

  Plug 'akinsho/toggleterm.nvim'
  Plug 'google/vim-jsonnet'

  " diffView requires Telescope
  Plug 'sindrets/diffview.nvim'
call plug#end()

if has('nvim')
  source ~/.vim/nvim-tree.nvim
  source ~/.vim/telescope.vim
  source ~/.vim/bufferline.vim
  source ~/.vim/gitsigns.nvim
  source ~/.vim/treesitter.nvim
  source ~/.vim/nvim-lspconfig.vim
  source ~/.vim/nvim-cmp.vim
  source ~/.vim/toggleterm.vim
endif


" Plugins configuration
source ~/.vim/lightline.vim 

" let g:catppuccin_flavour = "macchiato" " latte, frappe, macchiato, mocha
let g:catppuccin_flavour = "mocha" " latte, frappe, macchiato, mocha

lua << EOF
require("catppuccin").setup()
EOF


set smarttab " Insert tabs on the start of a line according to shiftwidth, not tabstop
syntax on    " I love colors, don't you?
colorscheme catppuccin
