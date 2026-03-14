-- lua/config/keymaps.lua
-- 全局快捷键配置（不依赖插件的通用快捷键）

local map = vim.keymap.set

-- ── Insert Mode ───────────────────────────────────────────────
-- jk 退出 insert mode：Esc 离手太远，jk 是 Vim 社区流传很久的习惯
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- ── 上下移动（跨折行）─────────────────────────────────────────
-- 当行被 wrap 折成多行时，gj/gk 按视觉行移动而不是逻辑行
map("n", "j", "gj")
map("n", "k", "gk")

-- ── 缩进后保持选区 ─────────────────────────────────────────────
-- 默认缩进后会取消选区，这样可以连续缩进多次
map("v", "<", "<gv")
map("v", ">", ">gv")

-- ── 移动选中行 ─────────────────────────────────────────────────
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ── 粘贴时不覆盖剪贴板 ────────────────────────────────────────
-- 默认粘贴会把被替换的内容存入剪贴板，这里用黑洞寄存器避免这个问题
map("v", "p", '"_dP', { desc = "Paste without overwriting clipboard" })

-- ── 搜索 ──────────────────────────────────────────────────────
-- Esc 清除搜索高亮
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- ── 保存 / 退出 ────────────────────────────────────────────────
map("n", "<C-s>", "<cmd>w<CR>",         { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>",    { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>",     { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>",   { desc = "Force quit all" })

-- ── 窗口导航（社区标准：C-hjkl）──────────────────────────────
-- 比默认的 <C-w>h 少按一个键，每个现代配置都会加这个
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- ── 窗口大小调整 ───────────────────────────────────────────────
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Increase window height" })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Decrease window height" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- ── Buffer 导航（社区标准：Shift-h/l）─────────────────────────
-- H 和 L 在 Vim 里移动屏幕顶部/底部，但很少用到，拿来做 buffer 切换更实用
map("n", "<S-l>", "<cmd>bnext<CR>",        { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>",    { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- ── 系统剪贴板 ────────────────────────────────────────────────
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
