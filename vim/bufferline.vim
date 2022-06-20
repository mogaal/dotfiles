set termguicolors

lua << EOF
require("bufferline").setup{
   options = {
      mode = "tabs",
      offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center"}},
      show_tab_indicators = true
   }
}
EOF
