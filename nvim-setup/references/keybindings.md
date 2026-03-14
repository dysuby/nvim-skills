# Keybinding Reference

## Community Best Practices

These are conventions that the Neovim community has broadly converged on. Share these with
users proactively — explain *why* each one exists, not just what it does.

### Space as Leader Key
```lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "
```
Why: Space is the most accessible key on any keyboard (thumb reach), and in normal mode it
only moves the cursor right — not critical. The vast majority of popular configs
(LazyVim, AstroNvim, NvChad, kickstart.nvim) all default to Space.

### `jk` to Exit Insert Mode
```lua
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
```
Why: `<Esc>` is far from the home row. `jk` is a near-impossible sequence to type accidentally
in English text, making it safe and ergonomic. Classic Vim community trick passed down for decades.
Alternative: some prefer `kj` or `<C-c>` (though `<C-c>` skips some autocmds).

### `<leader><leader>` to Find Recent Files
```lua
{ "<leader><leader>", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" }
```
Why: Double-tapping Space is one of the fastest possible keystrokes. Recent files is one of
the most frequent actions. LazyVim uses this convention.

### `<leader>/` for Buffer Search
```lua
{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" }
```
Why: `/` is already the Vim search key — combining it with leader makes a "fuzzy /" that
gives you a live, interactive version of the same idea.

### `]` / `[` for Next/Prev Navigation
A community-wide convention: use `]x` for "next X" and `[x` for "previous X".
```
]d / [d    → next/prev diagnostic
]h / [h    → next/prev git hunk
]b / [b    → next/prev buffer
]q / [q    → next/prev quickfix item
```
Why: Consistent, memorable, mnemonic. Borrowed from tpope/vim-unimpaired and now universal.

### `<C-hjkl>` for Window Navigation
```lua
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
```
Why: The default `<C-w>h` requires two keystrokes. Everyone remaps this. Universal in
modern configs. Also works with tmux-navigator if they use tmux.

### `<S-h>` / `<S-l>` for Buffer Switching
```lua
map("n", "<S-h>", "<cmd>bprevious<cr>")
map("n", "<S-l>", "<cmd>bnext<cr>")
```
Why: `H` and `L` move to screen top/bottom in vanilla Vim — useful but rarely needed.
Most modern configs repurpose them for buffer navigation.

### Visual Mode Indent Keep Selection
```lua
map("v", "<", "<gv")
map("v", ">", ">gv")
```
Why: In stock Vim, indenting in visual mode drops the selection. This re-selects after
indenting, letting you indent multiple times without reselecting. Everyone wants this.

### Don't Clobber Clipboard on Paste
```lua
map("v", "p", '"_dP')
```
Why: In Vim, pasting over a selection replaces your clipboard with the deleted text.
This mapping uses the black-hole register so your clipboard stays intact after pasting.

### `<leader>` Namespace Conventions
The community has loosely standardized these `<leader>` prefixes:
```
<leader>f  → Find / Telescope
<leader>g  → Git
<leader>l  → LSP (or <leader>c for Code)
<leader>b  → Buffer
<leader>w  → Window / Workspace
<leader>t  → Terminal / Tab
<leader>u  → UI toggles (noice, etc.)
<leader>x  → Diagnostics / Quickfix (LazyVim convention)
```

---

## Leader Key

The leader key is a prefix key that unlocks a whole namespace of custom shortcuts.
Most people use `<Space>` (spacebar) as their leader.

- **Space** — recommended, easy to reach with thumb, very common in modern configs
- **Comma (,)** — classic choice, used by many experienced Vim users
- **Backslash** — the Vim default, but rarely used in modern configs

Set in `options.lua`:
```lua
vim.g.mapleader = " "      -- Space
vim.g.maplocalleader = " "
```

## Notation Guide (for newbies)

| Notation     | Meaning                         |
|--------------|---------------------------------|
| `<leader>`   | Your leader key (usually Space) |
| `<C-x>`      | Ctrl + x                        |
| `<S-x>`      | Shift + x                       |
| `<A-x>`      | Alt + x                         |
| `<CR>`       | Enter key                       |
| `<Esc>`      | Escape key                      |
| `<Tab>`      | Tab key                         |
| `g`          | Literal letter g (prefix)       |

## Mode Prefixes

Keymaps are mode-specific:
- `n` — Normal mode (default when navigating)
- `i` — Insert mode (when typing)
- `v` — Visual mode (when selecting)
- `x` — Visual mode only (not select mode)
- `t` — Terminal mode

---

## Base Keymaps (options.lua / keymaps.lua)

These are always included regardless of plugins chosen:

```lua
-- lua/config/keymaps.lua
local map = vim.keymap.set

-- 更好的上下移动（跨折行）
map("n", "j", "gj")
map("n", "k", "gk")

-- 保持选区在缩进后
map("v", "<", "<gv")
map("v", ">", ">gv")

-- 移动选中行
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- 清除搜索高亮
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 更快的保存
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })

-- 更快的退出
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force quit all" })

-- 窗口导航（分割窗口之间移动）
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- 窗口大小调整
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Increase window height" })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Decrease window height" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer 导航
map("n", "<S-l>", "<cmd>bnext<CR>",     { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- 粘贴时不覆盖剪贴板
map("v", "p", '"_dP', { desc = "Paste without overwriting clipboard" })

-- 系统剪贴板
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
```

---

## Plugin Keybinding Defaults

### Neo-tree
| Key          | Action               |
|--------------|----------------------|
| `<leader>e`  | Toggle file explorer |

### Telescope
| Key           | Action         |
|---------------|----------------|
| `<leader>ff`  | Find files     |
| `<leader>fg`  | Live grep      |
| `<leader>fb`  | Open buffers   |
| `<leader>fh`  | Help tags      |
| `<leader>fr`  | Recent files   |

### LSP
| Key             | Action                 |
|-----------------|------------------------|
| `gd`            | Go to definition       |
| `gr`            | Find references        |
| `K`             | Hover documentation    |
| `<leader>rn`    | Rename symbol          |
| `<leader>ca`    | Code actions           |
| `[d`            | Previous diagnostic    |
| `]d`            | Next diagnostic        |
| `<leader>d`     | Show diagnostic float  |

### Gitsigns
| Key           | Action           |
|---------------|------------------|
| `<leader>hs`  | Stage hunk       |
| `<leader>hr`  | Reset hunk       |
| `<leader>hp`  | Preview hunk     |
| `<leader>hb`  | Blame line       |
| `<leader>hd`  | Diff this        |

### Toggleterm
| Key       | Action            |
|-----------|-------------------|
| `<C-\>`   | Toggle terminal   |

### nvim-cmp (Insert mode)
| Key          | Action                    |
|--------------|---------------------------|
| `<C-Space>`  | Trigger completion        |
| `<CR>`       | Confirm selection         |
| `<Tab>`      | Next item / jump snippet  |
| `<S-Tab>`    | Prev item / jump back     |
| `<C-u>`      | Scroll docs up            |
| `<C-d>`      | Scroll docs down          |

### Comment.nvim (Normal mode)
| Key    | Action                      |
|--------|-----------------------------|
| `gcc`  | Toggle line comment         |
| `gcb`  | Toggle block comment        |
| `gc`   | Comment motion (e.g. `gc3j`)|

---

## Customization Template

When a user wants to change a keybinding, use this pattern:

```lua
-- Replace <leader>ff with <C-p> for Telescope find files
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
```

For plugin-managed keybindings (using the `keys` table in lazy.nvim spec), update the
`keys` table directly instead:

```lua
keys = {
  { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },  -- changed from <leader>ff
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
},
```

---

## Common User Requests

| User says                           | Change to make                              |
|-------------------------------------|---------------------------------------------|
| "用 Ctrl+P 搜索文件"                 | Replace `<leader>ff` with `<C-p>`          |
| "用 Ctrl+/ 注释"                    | Add `gcc` → `<C-/>`                        |
| "逗号作为 leader"                   | Change `vim.g.mapleader = ","`              |
| "用 jk 退出 insert mode"            | Add `map("i", "jk", "<Esc>")`              |
| "Ctrl+S 保存"                       | Already included in base keymaps            |
| "打开终端用 F4"                     | Change toggleterm key to `<F4>`             |
