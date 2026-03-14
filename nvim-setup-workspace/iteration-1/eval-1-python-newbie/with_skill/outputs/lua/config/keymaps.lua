-- lua/config/keymaps.lua
-- 全局快捷键设置
-- 注意：插件相关的快捷键在各自的插件文件里定义

local map = vim.keymap.set

-- ── 社区经典技巧：jk 退出 insert mode ─────────────────────────
-- Esc 键离手太远，jk 是 Vim 社区流传很久的习惯
-- （在英文正常打字中，j 后面紧跟 k 几乎不会出现，所以很安全）
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- ── 上下移动（支持跨折行）──────────────────────────────────────
-- gj/gk 在视觉行（折行后的行）上移动，比 j/k 更直觉
map("n", "j", "gj")
map("n", "k", "gk")

-- ── 缩进后保持选区 ────────────────────────────────────────────
-- 默认 Vim 缩进后会丢失选区，这两行让你可以连续缩进多次
map("v", "<", "<gv")
map("v", ">", ">gv")

-- 移动选中行（Alt+j/k 上下移动整块选区）
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ── 搜索 ──────────────────────────────────────────────────────
-- 按 Esc 清除搜索高亮（不用 :noh 那么麻烦）
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- ── 保存 / 退出 ────────────────────────────────────────────────
map("n", "<C-s>", "<cmd>w<CR>",       { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>",  { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>",   { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force quit all" })

-- ── 窗口导航（社区标准：C-hjkl）──────────────────────────────
-- 默认的 <C-w>h 需要两次按键，这里简化成 <C-h>
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- 窗口大小调整（方向键调整窗口尺寸）
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Increase window height" })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Decrease window height" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- ── Buffer 导航（社区标准：Shift-h/l）─────────────────────────
-- H/L 在原版 Vim 是跳到屏幕顶/底，但现代配置通常把它们重映射为 buffer 切换
map("n", "<S-l>", "<cmd>bnext<CR>",        { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>",    { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- ── 剪贴板 ────────────────────────────────────────────────────
-- 粘贴时不覆盖剪贴板：默认 Vim 粘贴覆盖选区后，剪贴板会变成被删除的内容
-- '_dP 先把选区扔到黑洞寄存器（_），再从默认寄存器粘贴（P）
map("v", "p", '"_dP', { desc = "Paste without overwriting clipboard" })

-- 显式复制/粘贴到系统剪贴板（虽然 clipboard=unnamedplus 已经打通，但这两个是备用）
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
