-- options.lua

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.colorcolumn = "100"
opt.showmode = false          -- statusline handles this
opt.cmdheight = 1
opt.pumheight = 10

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Misc
opt.updatetime = 200
opt.timeoutlen = 300
opt.completeopt = { "menu", "menuone", "noselect" }
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.laststatus = 3           -- global statusline
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Folding (using treesitter via ufo or native)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.foldlevel = 99
