-- lua/config/keymaps.lua
-- Key mappings for common actions
-- Leader key is set to Space (configured in lazy.lua before plugins load)

local map = vim.keymap.set

-- ============================================================
-- General Convenience
-- ============================================================

-- Clear search highlights with Escape
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Save file
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Quit
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- ============================================================
-- Window Navigation
-- ============================================================

-- Move between splits with Ctrl+hjkl (works in normal mode)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- ============================================================
-- Buffer Management
-- ============================================================

-- Navigate buffers
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- Close buffer
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- ============================================================
-- Indentation in Visual Mode
-- ============================================================

-- Stay in visual mode after indenting (very handy for Python)
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- ============================================================
-- Move Lines Up/Down
-- ============================================================

map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ============================================================
-- Diagnostics
-- ============================================================

map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })
