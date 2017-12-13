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

" Mapping NERD_Tree toggle command to F2
"map <F2> :NERDTreeToggle<CR>

"call pathogen#infect()
"call pathogen#helptags()

syntax on

filetype plugin on
filetype indent plugin on

:let g:session_autosave = 'no'
:let g:session_autoload = 'no'

" Vim airline
set laststatus=2
:let g:airline#extensions#tabline#enabled = 1
" Avoid print the status bar as well as the command bar
:let g:bufferline_echo = 0
" You have to configure powerline fonts
:let g:airline_powerline_fonts = 1
" Set default theme
:let g:airline_theme='simple'

" To remember the last line we were
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
