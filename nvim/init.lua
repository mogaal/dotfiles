-- Set comma as the leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Here is where we install the plugins.
require('lazy').setup({
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',               opts = {} },

  { 'folke/which-key.nvim',                opts = {} },

  -- Add indentation guides even on blank lines
  { 'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {} },

  -- Highlighting other uses of the word under the cursor
  -- default <a-n> and <a-p> to move between references
  { 'RRethy/vim-illuminate' },

  -- Move around easily
  {
    'ggandor/leap.nvim',
    enabled = true,
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },
  
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      require("claude-code").setup({
        keymaps = {
          toggle = {
            normal = "<C-,>",        -- Toggle Claude Code in normal mode
            terminal = "<C-,>",      -- Toggle Claude Code in terminal mode
            variants = {
              continue = "<leader>cc", -- Open Claude Code and continue previous session
              verbose = "<leader>cv",  -- Open Claude Code with verbose output
            },
          },
          window_navigation = false, -- Disabled (using custom window navigation at lines 327-331)
          scrolling = true,          -- Enable scrolling keymaps (<C-f/b>) for page up/down
        }
      })
     end
  },

  {
      "kylechui/nvim-surround",
      version = "^3.0.0",
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({})
      end
  },

  {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({})
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
  },

  { "serhez/bento.nvim", opts = {} },

  -- {
  --    "m4xshen/hardtime.nvim",
  --    lazy = false,
  --    dependencies = { "MunifTanjim/nui.nvim" },
  --    opts = {},
  -- },

  -- Terminal, used for lazygit
  { 'akinsho/toggleterm.nvim', version = "*" },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lualine').setup {
        options = { theme = 'everforest' },
      }
    end
  },

  -- Dashboard (start screen)
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VimEnter",
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { "<leader>t", "<cmd>NvimTreeToggle<CR>", desc = "nvim-tree (file explorer)" },
    },
    opts = {},
  },

  -- Git labels
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }
    end
  },

  -- LSP Configuration & Plugins
  {
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
          { "mason-org/mason.nvim", opts = {} },
          "neovim/nvim-lspconfig",
      },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    },
  },

  -- buferline
  {
    'akinsho/bufferline.nvim',
    lazy = false,
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
        }
      }
    end,
    keys = {
      { "<leader>bs", ":BufferLinePick<cr>",      desc = "Select buffer (from bufferline)" },
      { "<leader>bc", ":BufferLinePickClose<cr>", desc = "Close buffer (from bufferline)" },
      { "<leader>bp", ":BufferLineTogglePin<cr>", desc = "Pin a buffer (from bufferline)" },
    }
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    version = '*',
    keys = {
      { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>",      desc = "Find files" },
      { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep() <cr>",      desc = "Grep files" },
      { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>",         desc = "Buffers" },
      { "<leader>fh", "<cmd>lua require('telescope.builtin').command_history()<cr>", desc = "Command History" },
      { "<leader>fc", "<cmd>lua require('telescope.builtin').commands()<cr>",        desc = "Available commands" },
      { "<leader>fs", "<cmd>lua require('telescope.builtin').spell_suggest()<cr>",   desc = "Spelling suggest" },
      {
        "<leader>/",
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
        desc = "Spelling suggest"
      },
    },
    config = function()
      require('telescope').setup {
        defaults = {}
      }
    end
  },

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  -- Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require('catppuccin').setup {}
      vim.cmd.colorscheme 'catppuccin'
    end
  },

  {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {},
  },

  { "nvzone/volt" , lazy = true },
  { "nvzone/menu" , lazy = true }
})

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- This increases my speed moving around
vim.o.relativenumber = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Set highlight on search
vim.o.hlsearch = false

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- NOTE: You should make sure your terminal supports this. Specially for bufferline
vim.o.termguicolors = true

-- Replace a word with yanked text (replace text in one or more other locations)
--   See here: https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
vim.keymap.set('v', 'p', '"_dP', { desc = "Paste (in one or more other locations" })

-- Map jh to Esc
-- imap jh <Esc>
vim.keymap.set('i', 'jh', '<Esc>', { desc = "Map jh to <Esc>" })

-- Reload configuration without restart nvim
vim.keymap.set('n', '<leader>r', ':so %<CR>', { desc = "Reload configuration" })

-- Close all windows and exit
vim.keymap.set('n', '<leader>q', ':qa!<CR>', { desc = "Close all windows and exit" })

-- Navigation with Ctrl
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', { desc = "Move to left window" })
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', { desc = "Move to right window" })
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', { desc = "Move to down window" })
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', { desc = "Move to up window" })

-- Spelling
vim.keymap.set('n', '<leader>ss', ':setlocal spell!<cr>', { desc = "Enable spelling" })
vim.keymap.set('n', '<leader>sn', ']s', { desc = "Next word" })
vim.keymap.set('n', '<leader>sp', '[s', { desc = "Previous word" })
vim.keymap.set('n', '<leader>sa', 'zg', { desc = "Move down" })
vim.keymap.set('n', '<leader>s?', 'z=', { desc = "Suggestion?" })

-- Moving lines around
--   either Alt-j/Alt-k or Shift-J/K
vim.keymap.set('x', 'J', ":move '>+1<CR>gv-gv", { desc = "Move line down (Select-mode)" })
vim.keymap.set('x', 'K', ":move '<-2<CR>gv-gv", { desc = "Move line up (Select-mode)" })
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv", { desc = "Move line down (Select-mode)" })
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv", { desc = "Move line up (Select-mode)" })
--   visual-mode (NOT WORKING I DUNNO WHY)
-- vim.keymap.set('v', 'J', ":m .+1<CR>==", { desc = "Move line down (Visual-mode)" })
-- vim.keymap.set('v', 'K', ":m .-2<CR>==", { desc = "Move line up (Visual-mode)" })

-- Fast saving
vim.keymap.set('n', '<leader>w', ':w!<cr>', { desc = "Fast saving" })

-- Tabs & indent
vim.o.expandtab = true   -- Use spaces instead of tabs
vim.o.shiftwidth = 2     -- Shift 2 spaces when tab
vim.o.tabstop = 2        -- 1 tab == 2 spaces
vim.o.smartindent = true -- Autoindent new lines


-- Highlight on yank
vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
  end
})

-- Remember the line when close
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*" },
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.api.nvim_exec("normal! g'\"", false)
    end
  end
})


-----------------------------------------------------------
-- toggleterm
-----------------------------------------------------------

require("toggleterm").setup {
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

local Terminal = require('toggleterm.terminal').Terminal

-- Lazygit
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

-- nnn
local nnn = Terminal:new({ cmd = "nnn", hidden = true })

function _nnn_toggle()
  nnn:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>n", "<cmd>lua _nnn_toggle()<CR>", { noremap = true, silent = true })

-----------------------------------------------------------
-- nvim-tree
-----------------------------------------------------------

-- When nvim-tree is the only window opened, automatically close it.
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})

-----------------------------------------------------------
-- Treesitter
-----------------------------------------------------------

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vim' },
  auto_install = true,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
}

-----------------------------------------------------------
-- Configuration related to LSP
-----------------------------------------------------------

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

local servers = {
  terraformls = {},
  tflint = {},
  docker_compose_language_service = {},
  dockerls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  ts_ls = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
}

-- Setup Mason-LSPConfig integration
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('mason-lspconfig').setup({
  ensure_installed = vim.tbl_keys(servers),
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = capabilities,
        settings = servers[server_name],
      })
    end,
  },
})

local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open("default")
end, {})

-- mouse users + nvimtree users!
vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
  require('menu.utils').delete_old_menus()

  vim.cmd.exec '"normal! \\<RightMouse>"'

  -- clicked buf
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

  require("menu").open(options, { mouse = true })
end, {})

-----------------------------------------------------------
-- alpha-vim
-----------------------------------------------------------

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
  "                                                     ",
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                     ",
}

-- Set menu
dashboard.section.buttons.val = {
  dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
  dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
  dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
  dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
}

-- Set footer
--   NOTE: This is currently a feature in my fork of alpha-nvim (opened PR #21, will update snippet if added to main)
--   To see test this yourself, add the function as a dependecy in packer and uncomment the footer lines
--   ```init.lua
--   return require('packer').startup(function()
--       use 'wbthomason/packer.nvim'
--       use {
--           'goolord/alpha-nvim', branch = 'feature/startify-fortune',
--           requires = {'BlakeJC94/alpha-nvim-fortune'},
--           config = function() require("config.alpha") end
--       }
--   end)
--   ```
-- local fortune = require("alpha.fortune")
-- dashboard.section.footer.val = fortune()

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
