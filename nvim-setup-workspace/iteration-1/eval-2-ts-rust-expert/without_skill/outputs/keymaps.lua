-- keymaps.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- ── General ─────────────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Quit all" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<CR>")
map("n", "<C-Down>", "<cmd>resize -2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<CR>==")
map("n", "<A-k>", "<cmd>m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Indent and stay in visual
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Paste without overwriting register
map("v", "p", '"_dP')

-- ── Telescope ────────────────────────────────────────────────────────────────
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>",   { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",    { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>",      { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>",    { desc = "Help tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>",     { desc = "Recent files" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
map("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>",  { desc = "Diagnostics" })
map("n", "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Search buffer" })

-- ── File explorer (neo-tree) ──────────────────────────────────────────────────
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Explorer" })
map("n", "<leader>o", "<cmd>Neotree focus<CR>",  { desc = "Focus explorer" })

-- ── LSP (set in on_attach, but global fallbacks) ──────────────────────────────
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>",     { desc = "Location list" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>",      { desc = "Quickfix" })

-- ── Git (Gitsigns / Fugitive / Lazygit) ──────────────────────────────────────
map("n", "<leader>gg", "<cmd>LazyGit<CR>",           { desc = "LazyGit" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { desc = "Diff this" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Blame line" })

-- ── Terminal (toggleterm) ─────────────────────────────────────────────────────
map("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>",      { desc = "Float terminal" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Horizontal terminal" })
map("t", "<Esc><Esc>", "<C-\\><C-n>",                              { desc = "Exit terminal mode" })

-- ── Splits ───────────────────────────────────────────────────────────────────
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>sh", "<cmd>split<CR>",  { desc = "Horizontal split" })
