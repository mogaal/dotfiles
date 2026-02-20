-- Set space as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
      { out,                            "WarningMsg" },
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
  { 'numToStr/Comment.nvim', opts = {} },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>g", group = "git" },
        { "<leader>s", group = "search" },
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>u", group = "ui" },
        { "<leader>a", group = "Claude" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Move around easily
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua        = { 'stylua' },
        go         = { 'goimports', 'gofmt' },
        python     = { 'isort', 'black' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        terraform  = { 'terraform_fmt' },
        rust       = { 'rustfmt' },
      },
    },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format({ async = true, lsp_format = 'fallback' })
        end,
        mode = { 'n', 'v' },
        desc = 'Format buffer',
      },
    },
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      dashboard = {
        enabled = true,
        example = "files"
      },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
      { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
      { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
      -- find
      { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
      { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
      { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
      -- git
      { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
      { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
      { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
      { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
      { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
      { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
      { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
      { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
      { "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
      -- Grep
      { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
      { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
      { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
      { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
      { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
      { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
      { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
      { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
      { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
      { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
      { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
      { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
      { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
      { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
      { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
      { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
      { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
      { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
      { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
      { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
      { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
      -- LSP
      { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
      { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
      { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
      { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
      { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
      { "gai",             function() Snacks.picker.lsp_incoming_calls() end,                      desc = "C[a]lls Incoming" },
      { "gao",             function() Snacks.picker.lsp_outgoing_calls() end,                      desc = "C[a]lls Outgoing" },
      { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
      { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
      -- Other
      { "<leader>z",       function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
      { "<leader>Z",       function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
      { "<leader>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
      { "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
      { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
      { "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
      { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
      { "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
      { "<c-_>",           function() Snacks.terminal() end,                                       desc = "which_key_ignore" },
      { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",           mode = { "n", "t" } },
      { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",           mode = { "n", "t" } },
    }
  },

  -- AI assistant integration with Claude Code
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    opts = {
      open_in_current_tab = false, -- Don't create new tabs
    },
    keys = {
      { "<leader>a",  nil,                              desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
      {
        "<leader>aT",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file (tree)",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
  },

  -- Easily add, change, and delete surrounding characters (quotes, brackets, parentheses, etc.)
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- Bento-style layout manager for a clean and organized UI
  { "serhez/bento.nvim",     opts = {} },

  {
     "m4xshen/hardtime.nvim",
     lazy = false,
     dependencies = { "MunifTanjim/nui.nvim" },
     opts = {},
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lualine').setup {
        options = { theme = 'catppuccin' },
      }
    end
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

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate'
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
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    opts = {},
  },

  { "nvzone/volt", lazy = true },
  { "nvzone/menu", lazy = true }
})

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Make line numbers default
vim.opt.number = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- This increases my speed moving around
vim.opt.relativenumber = true

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Set highlight on search
vim.opt.hlsearch = false

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- NOTE: You should make sure your terminal supports this. Specially for bufferline
vim.opt.termguicolors = true

-- Keep cursor away from screen edges when scrolling
vim.opt.scrolloff = 8

-- Always show the sign column to prevent layout shifts from diagnostics
vim.opt.signcolumn = 'yes'

-- Faster which-key popup and key sequence timeout
vim.opt.timeoutlen = 300

-- Open splits in a more natural direction
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Replace a word with yanked text (replace text in one or more other locations)
--   See here: https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
vim.keymap.set('v', 'p', '"_dP', { desc = "Paste (in one or more other locations" })

-- Map jh to Esc
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

-- Same navigation from terminal mode (e.g. Claude Code window)
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = "Move to left window (terminal)" })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = "Move to right window (terminal)" })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = "Move to down window (terminal)" })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = "Move to up window (terminal)" })

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
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftwidth = 2     -- Shift 2 spaces when tab
vim.opt.tabstop = 2        -- 1 tab == 2 spaces
vim.opt.smartindent = true -- Autoindent new lines


-- Highlight on yank
vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 1000 })
  end
})

-- Remember the line when close
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 1 and mark[1] <= lcount then
      vim.cmd([[normal! g`"]])
    end
  end,
})

-----------------------------------------------------------
-- Configuration related to LSP
-----------------------------------------------------------

-- Diagnostics UI (set once)
vim.diagnostic.config({
  virtual_text = false, -- you already prefer float + navigation
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Global diagnostic navigation (not LSP-specific)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Diagnostics: prev" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Diagnostics: next" })

local servers = {
  terraformls = {},
  tflint = {},
  docker_compose_language_service = {},
  dockerls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = { globals = { 'vim' } },
    },
  },
  ts_ls = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
}

require('mason-lspconfig').setup({
  ensure_installed = vim.tbl_keys(servers),
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
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

------------------------
-- nvzone/menu plugin --
------------------------

-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open("default")
end, {})

-- mouse users
vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
  require('menu.utils').delete_old_menus()
  vim.cmd.exec '"normal! \\<RightMouse>"'
  require("menu").open("default", { mouse = true })
end, {})
