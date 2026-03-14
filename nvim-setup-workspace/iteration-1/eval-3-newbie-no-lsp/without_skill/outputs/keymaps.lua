-- keymaps.lua
-- Key mappings

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ─── General ─────────────────────────────────────────────────

-- Save file
map("n", "<C-s>", ":w<CR>", vim.tbl_extend("force", opts, { desc = "Save file" }))

-- Quit
map("n", "<leader>q", ":q<CR>", vim.tbl_extend("force", opts, { desc = "Quit" }))

-- Clear search highlight
map("n", "<Esc>", ":nohlsearch<CR>", vim.tbl_extend("force", opts, { desc = "Clear search highlight" }))

-- ─── Window navigation ───────────────────────────────────────

map("n", "<C-h>", "<C-w>h", vim.tbl_extend("force", opts, { desc = "Move to left window" }))
map("n", "<C-j>", "<C-w>j", vim.tbl_extend("force", opts, { desc = "Move to lower window" }))
map("n", "<C-k>", "<C-w>k", vim.tbl_extend("force", opts, { desc = "Move to upper window" }))
map("n", "<C-l>", "<C-w>l", vim.tbl_extend("force", opts, { desc = "Move to right window" }))

-- ─── Telescope (fuzzy search) ────────────────────────────────

-- <C-p> to find files (as requested)
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", vim.tbl_extend("force", opts, { desc = "Find files" }))

-- Live grep (search inside files)
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", vim.tbl_extend("force", opts, { desc = "Live grep" }))

-- Recent files
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", vim.tbl_extend("force", opts, { desc = "Recent files" }))

-- Search open buffers
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", vim.tbl_extend("force", opts, { desc = "Buffers" }))

-- ─── File tree (Neo-tree) ────────────────────────────────────

-- Toggle file tree
map("n", "<leader>e", ":Neotree toggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle file tree" }))
