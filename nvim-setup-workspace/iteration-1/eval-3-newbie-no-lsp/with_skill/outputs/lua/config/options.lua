-- lua/config/options.lua
-- 基础 Neovim 设置

local opt = vim.opt

-- ── Leader 键 ──────────────────────────────────────────────────
-- 空格作为 leader 键，社区 90% 的现代配置都这么用，大拇指按起来最舒服
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ── 行号 ────────────────────────────────────────────────────────
opt.number = true
opt.relativenumber = true  -- 相对行号：一眼看出"要跳 5 行"，配合 5j 跳转效率高

-- ── 缩进 ────────────────────────────────────────────────────────
opt.tabstop = 2            -- Tab 显示为 2 个空格宽
opt.shiftwidth = 2         -- 缩进宽度
opt.expandtab = true       -- 把 Tab 转为空格
opt.autoindent = true
opt.smartindent = true

-- ── 搜索 ────────────────────────────────────────────────────────
opt.hlsearch = true        -- 高亮搜索结果
opt.incsearch = true       -- 边输入边搜索
opt.ignorecase = true      -- 搜索忽略大小写
opt.smartcase = true       -- 有大写字母时自动区分大小写

-- ── 外观 ────────────────────────────────────────────────────────
opt.termguicolors = true   -- 开启真彩色，让主题颜色更准确
opt.cursorline = true      -- 高亮当前行，方便找到光标位置
opt.scrolloff = 8          -- 滚动时保留 8 行上下文，避免光标顶到边缘（社区常见值）
opt.sidescrolloff = 8
opt.signcolumn = "yes"     -- 始终显示符号列，避免 gitsigns 图标出现时布局跳动
opt.wrap = false           -- 不自动换行

-- ── 文件 ────────────────────────────────────────────────────────
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.undofile = true        -- 持久化撤销历史，重启后也能 undo
opt.swapfile = false       -- 不创建 swap 文件
opt.backup = false

-- ── 体验 ────────────────────────────────────────────────────────
opt.mouse = "a"            -- 开启鼠标支持（点击、滚动都能用）
opt.clipboard = "unnamedplus"  -- 与系统剪贴板共享，省去 "+y 的麻烦
opt.splitright = true      -- 垂直分割在右侧
opt.splitbelow = true      -- 水平分割在下方
opt.updatetime = 250       -- 更快的响应速度（默认 4000 太慢），影响 gitsigns 速度
opt.timeoutlen = 500       -- 快捷键等待时间（which-key 弹出前的延迟）
