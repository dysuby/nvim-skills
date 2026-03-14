# Config Templates

These are the base templates to assemble into the final config output.
Fill in the placeholders based on user choices collected during the interview.

---

## init.lua

```lua
-- ~/.config/nvim/init.lua
-- 入口文件：加载所有配置模块

require("config.options")   -- 基础设置
require("config.keymaps")   -- 全局快捷键
require("config.lazy")      -- 插件管理器 + 插件
```

---

## lua/config/options.lua

```lua
-- 基础 Neovim 设置

local opt = vim.opt

-- 行号
opt.number = true
opt.relativenumber = true  -- 相对行号，方便 vim 跳转

-- 缩进（根据用户选择：2 或 4 空格）
opt.tabstop = 2            -- Tab 显示为 2 个空格宽
opt.shiftwidth = 2         -- 缩进宽度
opt.expandtab = true       -- 把 Tab 转为空格
opt.autoindent = true
opt.smartindent = true

-- 搜索
opt.hlsearch = true        -- 高亮搜索结果
opt.incsearch = true       -- 边输入边搜索
opt.ignorecase = true      -- 搜索忽略大小写
opt.smartcase = true       -- 有大写时区分大小写

-- 外观
opt.termguicolors = true   -- 开启真彩色
opt.cursorline = true      -- 高亮当前行
opt.scrolloff = 8          -- 滚动时保留 8 行上下文
opt.sidescrolloff = 8
opt.signcolumn = "yes"     -- 始终显示符号列（LSP 错误图标用）
opt.wrap = false           -- 不自动换行

-- 文件
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.undofile = true        -- 持久化撤销历史
opt.swapfile = false       -- 不创建 swap 文件
opt.backup = false

-- 体验
opt.mouse = "a"            -- 开启鼠标支持
opt.clipboard = "unnamedplus"  -- 与系统剪贴板共享
opt.splitright = true      -- 垂直分割在右侧
opt.splitbelow = true      -- 水平分割在下方
opt.updatetime = 250       -- 更快的响应（LSP 诊断）
opt.timeoutlen = 500       -- 快捷键等待时间

-- 补全菜单
opt.completeopt = "menu,menuone,noselect"

-- Leader 键（根据用户选择）
vim.g.mapleader = " "
vim.g.maplocalleader = " "
```

---

## lua/config/keymaps.lua

See `references/keybindings.md` for the full set.

Always include the community best practices from the "Community Best Practices" section.
Add or remove individual mappings based on user customization requests.

```lua
-- lua/config/keymaps.lua
local map = vim.keymap.set

-- ── 社区最佳实践 ──────────────────────────────────────────────
-- jk 退出 insert mode（如果用户选择了的话）
-- map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- 保持选区在缩进后
map("v", "<", "<gv")
map("v", ">", ">gv")

-- 粘贴时不覆盖剪贴板（黑洞寄存器）
map("v", "p", '"_dP', { desc = "Paste without overwriting clipboard" })

-- ── 上下移动（跨折行）──────────────────────────────────────────
map("n", "j", "gj")
map("n", "k", "gk")

-- 移动选中行
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ── 搜索 ──────────────────────────────────────────────────────
-- 清除搜索高亮
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- ── 保存 / 退出 ────────────────────────────────────────────────
map("n", "<C-s>", "<cmd>w<CR>",         { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>",    { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>",     { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>",   { desc = "Force quit all" })

-- ── 窗口导航（社区标准：C-hjkl）──────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- 窗口大小调整
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Increase window height" })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Decrease window height" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- ── Buffer 导航（社区标准：Shift-h/l）─────────────────────────
map("n", "<S-l>", "<cmd>bnext<CR>",        { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>",    { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- ── 系统剪贴板 ────────────────────────────────────────────────
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- ── 用户自定义 ────────────────────────────────────────────────
-- [根据用户要求在此处添加]
```

---

## lua/config/lazy.lua

See `references/plugins.md` → "lazy.nvim Bootstrap" section.

---

## lua/config/plugins/ (one file per plugin)

Each plugin file is placed in `lua/config/plugins/` and automatically loaded by lazy.nvim
via the `{ import = "config.plugins" }` spec in `lazy.lua`.

Only generate files for plugins the user chose to install.
Reference the exact code from `references/plugins.md` for each plugin.

### Assembling the final output

When generating config files:

1. Start with `init.lua`, `options.lua`, `keymaps.lua`, `lazy.lua` (always)
2. Add one plugin file per chosen module
3. Replace all placeholder comments (e.g., `-- 根据用户选择填入`) with the actual values:
   - Language parsers they chose
   - Language servers they chose
   - Their keybinding choices
   - Their colorscheme and variant
4. If user is a newbie: keep the inline Chinese comments
5. If user is an expert: you can omit most comments or keep minimal ones

---

## Installation Instructions to Give the User

After generating all files, tell the user:

```
# 安装步骤

1. 创建目录结构：
   mkdir -p ~/.config/nvim/lua/config/plugins

2. 把 init.lua 放到 ~/.config/nvim/init.lua

3. 把 lua/ 目录里的文件对应放好

4. 打开 Neovim：
   nvim

   lazy.nvim 会自动安装，等安装完成（右上角进度条消失）

5. 重启 Neovim

6. 打开 :Mason 安装 LSP servers（如果你选了 LSP）

7. 如果图标显示乱码，确保你已安装 Nerd Font 并在终端里设置为该字体
```

---

## Nerd Font Installation Guide

macOS (with homebrew):
```bash
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

Manual: Download from https://www.nerdfonts.com/font-downloads
Then set in your terminal's font settings (iTerm2 / Kitty / Alacritty / etc.)

---

## Example: Minimal Config (newbie, just essentials)

For a user who chose: Catppuccin + Neo-tree + Telescope + Treesitter + LSP + cmp + lualine + autopairs + Comment:

```
~/.config/nvim/
├── init.lua
└── lua/
    └── config/
        ├── options.lua
        ├── keymaps.lua
        ├── lazy.lua
        └── plugins/
            ├── colorscheme.lua   (catppuccin, mocha)
            ├── neo-tree.lua
            ├── telescope.lua
            ├── treesitter.lua    (python + js parsers)
            ├── lsp.lua           (pyright + ts_ls)
            ├── cmp.lua
            ├── lualine.lua
            ├── autopairs.lua
            └── comment.lua
```
