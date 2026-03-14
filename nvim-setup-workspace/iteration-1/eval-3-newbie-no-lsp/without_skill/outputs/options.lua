-- options.lua
-- General Neovim settings

local opt = vim.opt

-- Line numbers
opt.number = true           -- Show absolute line numbers
opt.relativenumber = true   -- Show relative line numbers

-- Indentation
opt.tabstop = 2             -- Number of spaces a tab counts for
opt.shiftwidth = 2          -- Number of spaces for each indentation
opt.expandtab = true        -- Use spaces instead of tabs
opt.smartindent = true      -- Auto indent new lines

-- Search
opt.ignorecase = true       -- Ignore case when searching
opt.smartcase = true        -- Override ignorecase if search has uppercase

-- Appearance
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.cursorline = true       -- Highlight the current line
opt.signcolumn = "yes"      -- Always show the sign column
opt.wrap = false            -- Disable line wrap

-- Behavior
opt.mouse = "a"             -- Enable mouse support
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.splitright = true       -- Vertical splits open to the right
opt.splitbelow = true       -- Horizontal splits open below

-- Performance
opt.updatetime = 250        -- Faster completion
opt.timeoutlen = 300        -- Time to wait for mapped sequence

-- Backup / swap (disable for cleaner workflow)
opt.swapfile = false
opt.backup = false
opt.undofile = true         -- Persistent undo history
