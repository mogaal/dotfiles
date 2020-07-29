set sw=2
set et
set mouse=a
set number

set showcmd        " Show (partial) command in status line.
set showmatch      " Show matching brackets.
set autowrite      " Automatically save before commands like :next and :make
set hidden         " Hide buffers when they are abandoned
set autoread       " reload file if changed outside vim
set cursorline     " highlight the line with the cursor

" Set the <leader> key
let mapleader = ","

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

" Using cool display menu on the top, the simplest way to try it would be with :color <Tab>:
set wildmenu

" Very useful for searches
set path=$PWD/**

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

" use colors, cursorline and return/enter key
let NERDTreeHijackNetrw = 0
let NERDChristmasTree = 1
let NERDTreeHighlightCursorline = 1

" Plugin: NERDTree - keys to toggle NERDTree
nnoremap <leader>d :NERDTreeToggle<CR>

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""
" vim-gitgutter "
"""""""""""""""""

" Making the diff markers appears quicker (default is 4 seconds)
set updatetime=100

""""""""""
" vim-go "
""""""""""

filetype plugin indent on 
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" Automatically handle the imports and format
let g:go_fmt_command = "goimports"
