# Neovim Setup — Expert User Transcript

## User

帮我 setup neovim，我是老手，用过 vim 多年。我主要写 TypeScript 和 Rust，macOS。给我推荐一个现代化的配置。

---

## Assistant

好的，直接上现代化配置。基于 **lazy.nvim** 插件管理器，使用纯 Lua，针对 TypeScript + Rust 开发优化。

### 文件结构

```
~/.config/nvim/
├── init.lua
├── lazy-bootstrap.lua
├── options.lua
├── keymaps.lua
└── lua/
    └── plugins/
        ├── colorscheme.lua   # Catppuccin Mocha
        ├── treesitter.lua    # Syntax + text objects
        ├── lsp.lua           # ts_ls, rust_analyzer, lua_ls + Mason
        ├── completion.lua    # nvim-cmp + LuaSnip
        ├── telescope.lua     # Fuzzy finder
        ├── neo-tree.lua      # File explorer
        ├── git.lua           # Gitsigns + LazyGit + Diffview
        ├── statusline.lua    # Lualine + Bufferline
        ├── terminal.lua      # Toggleterm
        └── editor.lua        # Which-key, autopairs, flash, conform, lint…
```

### 安装步骤

```bash
# 备份已有配置
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true

# 把生成的文件放到正确位置
cp -r <output_dir>/* ~/.config/nvim/

# 依赖（macOS）
brew install neovim ripgrep fd lazygit node rust-analyzer
npm install -g typescript typescript-language-server prettierd eslint_d

# 启动 nvim，lazy.nvim 会自动安装所有插件
nvim
# 等插件安装完成后：:TSUpdate 确保 treesitter parsers 最新
```

---

### 核心插件一览

| 类别 | 插件 |
|------|------|
| 插件管理 | `lazy.nvim` |
| 主题 | `catppuccin/nvim` (Mocha) |
| Treesitter | `nvim-treesitter` + textobjects |
| LSP | `nvim-lspconfig` + `mason.nvim` |
| TS | `ts_ls` (typescript-language-server) |
| Rust | `rust_analyzer` via mason |
| 补全 | `nvim-cmp` + `LuaSnip` + `lspkind` |
| Fuzzy finder | `telescope.nvim` + fzf-native |
| 文件树 | `neo-tree.nvim` |
| Git | `gitsigns` + `lazygit.nvim` + `diffview` |
| 状态栏 | `lualine` + `bufferline` |
| 终端 | `toggleterm.nvim` |
| 格式化 | `conform.nvim` (prettierd/rustfmt/stylua) |
| Lint | `nvim-lint` (eslint_d) |
| 导航 | `flash.nvim` |
| 其他 | which-key, autopairs, surround, illuminate, indent-blankline, mini.nvim, todo-comments |

---

### 主要 Leader 键映射 (`<Space>`)

#### 文件 / 搜索
| 键 | 功能 |
|----|------|
| `<leader>ff` | 查找文件 |
| `<leader>fg` | Live Grep |
| `<leader>fb` | 切换 Buffer |
| `<leader>fr` | 最近文件 |
| `<leader>fs` | Document Symbols |
| `<leader>/`  | 当前文件搜索 |

#### LSP
| 键 | 功能 |
|----|------|
| `gd` | Go to Definition |
| `gr` | References |
| `K`  | Hover Doc |
| `<leader>rn` | Rename |
| `<leader>ca` | Code Action |
| `<leader>lf` | Format (LSP) |
| `<leader>lF` | Format (conform) |
| `<leader>lh` | Toggle Inlay Hints |
| `[d` / `]d`  | Prev/Next Diagnostic |

#### Git
| 键 | 功能 |
|----|------|
| `<leader>gg` | LazyGit |
| `<leader>gv` | Diffview |
| `<leader>gb` | Blame line |
| `]h` / `[h`  | Next/Prev hunk |
| `<leader>hs` | Stage hunk |

#### 终端
| 键 | 功能 |
|----|------|
| `<leader>tt` | 浮动终端 |
| `<leader>th` | 水平终端 |
| `<C-\>`       | 切换终端 |
| `<Esc><Esc>`  | 退出终端模式 |

#### 导航
| 键 | 功能 |
|----|------|
| `s` | Flash jump |
| `S` | Flash treesitter |
| `<leader>e` | 文件树 toggle |

---

### TypeScript 特别说明

- `ts_ls` 启用了完整的 inlay hints（参数名、变量类型、返回值类型）
- `prettierd` + `eslint_d` 守护进程模式，格式化/lint 速度快
- 保存时自动用 `conform.nvim` 格式化

### Rust 特别说明

- `rust_analyzer` 启用 `clippy` 作为 check command
- 启用 proc macro 支持
- inlay hints 包含 chaining hints 和 parameter hints
- 保存时自动 `rustfmt`

---

### 注意事项

1. 需要 Neovim **0.10+**（`brew install neovim` 默认安装最新稳定版）
2. 需要支持真彩色的终端（iTerm2、Alacritty、Kitty、WezTerm 均可）
3. 安装 [Nerd Font](https://www.nerdfonts.com/) 才能正确显示图标（推荐 `JetBrainsMono Nerd Font`）
4. `telescope-fzf-native` 需要 `make` + C 编译器（macOS 装了 Xcode Command Line Tools 即可）
5. 首次启动会自动安装插件，需要等待几分钟
