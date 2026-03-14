-- lua/config/options.lua
-- 基础 Neovim 设置

local opt = vim.opt

-- Leader 键：空格键（社区 90% 的现代配置都用空格，大拇指按起来最舒服）
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ── 行号 ───────────────────────────────────────────────────────
-- number：显示绝对行号；relativenumber：显示相对行号
-- 相对行号让你一眼看出"我要跳 5 行"，配合 5j 跳转，效率高很多
opt.number = true
opt.relativenumber = true

-- ── 缩进 ───────────────────────────────────────────────────────
-- Python 社区标准是 4 空格（PEP 8），但 Lua/JS 等用 2 空格
-- 这里设置默认 2 空格，Python 文件可以用 LSP/EditorConfig 按项目覆盖
opt.tabstop = 2            -- Tab 显示为 2 个空格宽
opt.shiftwidth = 2         -- 缩进宽度
opt.expandtab = true       -- 把 Tab 转为空格（不插入真正的 Tab 字符）
opt.autoindent = true      -- 自动缩进
opt.smartindent = true     -- 智能缩进（对大多数语言有效）

-- ── 搜索 ───────────────────────────────────────────────────────
opt.hlsearch = true        -- 高亮所有搜索结果
opt.incsearch = true       -- 边输入边实时搜索
opt.ignorecase = true      -- 搜索忽略大小写
opt.smartcase = true       -- 输入大写字母时区分大小写

-- ── 外观 ───────────────────────────────────────────────────────
opt.termguicolors = true   -- 开启真彩色（让主题颜色显示正确）
opt.cursorline = true      -- 高亮当前光标所在行
opt.scrolloff = 8          -- 滚动时保留 8 行上下文，光标不会顶到边缘（社区常见值）
opt.sidescrolloff = 8      -- 水平滚动时保留 8 列
opt.signcolumn = "yes"     -- 始终显示符号列（LSP 错误图标、Git 标记用）
opt.wrap = false           -- 不自动折行，长行需要水平滚动
opt.showmode = false       -- 不在底部显示模式（lualine 会显示）

-- ── 文件 ───────────────────────────────────────────────────────
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.undofile = true        -- 持久化撤销历史（关闭文件后仍可撤销）
opt.swapfile = false       -- 不创建 swap 文件（避免 .swp 垃圾文件）
opt.backup = false         -- 不创建备份文件

-- ── 体验 ───────────────────────────────────────────────────────
opt.mouse = "a"            -- 开启鼠标支持（可以用鼠标点击定位）
opt.clipboard = "unnamedplus"  -- 与系统剪贴板共享，省去 "+y 的麻烦
opt.splitright = true      -- 垂直分割新窗口在右侧
opt.splitbelow = true      -- 水平分割新窗口在下方
opt.updatetime = 250       -- 更快的响应（默认 4000ms 太慢，影响 LSP 诊断速度）
opt.timeoutlen = 500       -- 快捷键序列等待时间（ms）

-- ── 补全菜单 ───────────────────────────────────────────────────
opt.completeopt = "menu,menuone,noselect"  -- 补全菜单行为（配合 nvim-cmp 使用）
