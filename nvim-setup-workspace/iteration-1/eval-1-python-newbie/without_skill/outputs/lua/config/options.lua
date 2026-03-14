-- lua/config/options.lua
-- Core Neovim options for a comfortable editing experience

local opt = vim.opt

-- ============================================================
-- General
-- ============================================================
opt.mouse = "a"               -- Enable mouse support
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.undofile = true           -- Persistent undo history
opt.confirm = true            -- Ask to save instead of erroring

-- ============================================================
-- UI
-- ============================================================
opt.number = true         -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers (great for navigation)
opt.signcolumn = "yes"    -- Always show the sign column (for git, diagnostics)
opt.cursorline = true     -- Highlight the current line
opt.termguicolors = true  -- Enable 24-bit RGB colors
opt.showmode = false      -- Don't show --INSERT-- etc. (statusline handles this)
opt.scrolloff = 8         -- Keep 8 lines above/below cursor when scrolling
opt.sidescrolloff = 8     -- Keep 8 columns left/right of cursor
opt.wrap = false          -- Don't wrap long lines
opt.splitbelow = true     -- Horizontal splits go below
opt.splitright = true     -- Vertical splits go to the right

-- ============================================================
-- Indentation (Python-friendly defaults)
-- ============================================================
opt.expandtab = true  -- Use spaces instead of tabs
opt.tabstop = 4       -- A tab is 4 spaces wide (PEP 8)
opt.shiftwidth = 4    -- Indent by 4 spaces
opt.softtabstop = 4   -- Backspace removes 4 spaces at once
opt.smartindent = true -- Auto-indent new lines smartly

-- ============================================================
-- Search
-- ============================================================
opt.ignorecase = true -- Case-insensitive search...
opt.smartcase = true  -- ...unless the query contains uppercase
opt.hlsearch = true   -- Highlight search results
opt.incsearch = true  -- Show matches as you type

-- ============================================================
-- Performance
-- ============================================================
opt.updatetime = 200  -- Faster completion and diagnostics (default is 4000ms)
opt.timeoutlen = 300  -- How long to wait for a key sequence (ms)

-- ============================================================
-- Completion
-- ============================================================
opt.completeopt = { "menuone", "noselect" } -- Completion menu behavior
