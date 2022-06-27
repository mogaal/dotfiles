lua <<EOF
require("toggleterm").setup{
	size = 20,
	open_mapping = [[<c-\>]],
  direction = "float",
	float_opts = {
		border = "curved",
		winblend = 3,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
EOF
