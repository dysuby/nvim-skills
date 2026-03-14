-- lua/config/keymaps.lua
local map = vim.keymap.set

-- Better up/down (wrapped lines)
map("n", "j", "gj")
map("n", "k", "gk")

-- Keep selection after indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move selected lines
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Paste without clobbering clipboard
map("v", "p", '"_dP', { desc = "Paste without overwriting clipboard" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Save / quit
map("n", "<C-s>", "<cmd>w<CR>",        { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>",   { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>",    { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>",  { desc = "Force quit all" })

-- Window navigation (C-hjkl — community standard)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window resize
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Increase window height" })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Decrease window height" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer navigation (Shift-h/l — community standard)
map("n", "<S-l>", "<cmd>bnext<CR>",        { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>",    { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- System clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
