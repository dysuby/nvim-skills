-- lua/config/options.lua

local opt = vim.opt

-- Leader key (Space — community standard)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation (2 spaces — TS/JS standard)
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.termguicolors = true
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.wrap = false

-- Files
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- Experience
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true
opt.updatetime = 250
opt.timeoutlen = 500

-- Completion
opt.completeopt = "menu,menuone,noselect"
