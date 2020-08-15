"set completeopt-=preview                                                        "Disable preview window for autocompletion
set pumheight=15                                                                "Maximum number of entries in autocomplete popup

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

let g:coc_global_extensions = [
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-sql',
      \ 'coc-db',
      \ 'coc-yaml',
      \ 'coc-spell-checker',
      \ ]

" Taken from https://github.com/kristijanhusak/neovim-config/blob/master/nvim/partials/coc.vim 
set wildignore=*.o,*.obj,*~                                                     " Stuff to ignore when tab completing
set wildignore+=*.git*
set wildignore+=*.meteor*
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*mypy_cache*
set wildignore+=*__pycache__*
set wildignore+=*cache*
set wildignore+=*logs*
set wildignore+=*node_modules*
set wildignore+=**/node_modules/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
