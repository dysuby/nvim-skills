# Neovim 新手配置对话记录

## 用户请求

**用户：** 我想配置 Neovim，我是新手。我不想要 LSP，太复杂了。我只要文件树、好看的颜色和模糊搜索就好。把 find files 的快捷键改成 Ctrl+P。

---

## 助手回应

好的，完全理解！我帮你搭建一个干净、简单的 Neovim 配置，没有 LSP，只包含你需要的三样东西：

- **文件树** — 用 Neo-tree，可以在侧边栏浏览文件
- **好看的颜色** — 用 Catppuccin（Mocha 深色主题），非常流行
- **模糊搜索** — 用 Telescope，按 `Ctrl+P` 搜索文件

使用 **lazy.nvim** 作为插件管理器，用 **Lua** 编写配置。

---

## 生成的文件结构

把所有文件放到 `~/.config/nvim/` 目录下：

```
~/.config/nvim/
├── init.lua          ← 入口文件
├── lua/
│   ├── options.lua   ← 基础编辑器设置
│   ├── keymaps.lua   ← 快捷键
│   └── lazy-setup.lua ← 插件配置（内容同 lazy.lua）
```

> **注意：** 本次输出为平铺文件（非嵌套目录），使用时请按上方结构手动放置。`init.lua` 中 `require("lazy-setup")` 对应 `lua/lazy-setup.lua`，其余同理。

---

## 文件说明

### `init.lua`
Neovim 的入口，按顺序加载其他模块。

### `options.lua`
基础编辑器设置，包括：
- 显示行号（绝对 + 相对）
- 缩进用 2 个空格
- 搜索忽略大小写
- 开启真彩色
- 鼠标支持
- 系统剪贴板

### `keymaps.lua`
所有快捷键：

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+P` | **搜索文件**（Telescope find files）|
| `<Space>fg` | 在文件内容中搜索（live grep）|
| `<Space>fr` | 最近打开的文件 |
| `<Space>fb` | 搜索已打开的 buffer |
| `<Space>e` | 打开/关闭文件树 |
| `Ctrl+S` | 保存文件 |
| `<Space>q` | 退出 |
| `Ctrl+H/J/K/L` | 在窗口之间移动 |

### `lazy.lua`（即 `lazy-setup.lua`）
插件管理器配置，包含以下插件：

| 插件 | 用途 |
|------|------|
| `catppuccin/nvim` | 颜色主题（Mocha 深色）|
| `nvim-neo-tree/neo-tree.nvim` | 文件树侧边栏 |
| `nvim-telescope/telescope.nvim` | 模糊搜索 |
| `nvim-lualine/lualine.nvim` | 状态栏 |
| `nvim-treesitter/nvim-treesitter` | 语法高亮 |

---

## 安装步骤

1. **备份旧配置（如果有）：**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. **创建配置目录：**
   ```bash
   mkdir -p ~/.config/nvim/lua
   ```

3. **复制文件：**
   ```bash
   # 复制入口文件
   cp init.lua ~/.config/nvim/init.lua

   # 复制其他 Lua 文件到 lua/ 子目录
   cp options.lua ~/.config/nvim/lua/options.lua
   cp keymaps.lua ~/.config/nvim/lua/keymaps.lua
   cp lazy.lua    ~/.config/nvim/lua/lazy-setup.lua
   ```

4. **打开 Neovim：**
   ```bash
   nvim
   ```
   首次启动时，lazy.nvim 会自动下载并安装所有插件，稍等片刻即可。

5. **安装 Treesitter 语法解析器（可选，首次启动后执行）：**
   ```
   :TSUpdate
   ```

---

## 使用技巧

- 按 `Ctrl+P` 搜索项目中的文件，输入文件名关键词即可
- 按 `<Space>e` 打开左侧文件树，方向键或 `j/k` 移动，回车打开文件
- Telescope 搜索框内：`Ctrl+J/K` 上下移动结果，`Esc` 关闭
- 按 `<Space>` 查看可用的快捷键（需要 which-key，本配置未安装，可后续添加）

---

## 后续可以添加的功能（当你准备好了）

- `folke/which-key.nvim` — 显示快捷键提示
- `lewis6991/gitsigns.nvim` — Git 变更标记
- `windwp/nvim-autopairs` — 自动补全括号
- LSP（当你不再觉得复杂的时候）— `neovim/nvim-lspconfig` + `mason.nvim`
