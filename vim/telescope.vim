lua << EOF
require('telescope').setup{
   defaults = {}
}
EOF

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').command_history()<cr>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').spell_suggest()<cr>
