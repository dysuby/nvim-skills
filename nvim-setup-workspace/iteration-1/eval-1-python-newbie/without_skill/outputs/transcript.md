# Neovim Setup Transcript — Python Newbie on macOS

## Simulated Interaction

**User:** 我从来没用过 Neovim，但是想学，帮我从零开始配置一个好用的开发环境，我主要写 Python。

**Assistant:** Great! I'll set up a complete, beginner-friendly Neovim configuration for Python development on macOS. Here's what I'm going to include and why.

---

## Design Decisions

### Plugin Manager: lazy.nvim
lazy.nvim is the modern standard. It loads plugins on demand (lazy loading), so Neovim starts fast even with many plugins installed. It also has a clean UI for browsing and updating plugins.

### Leader Key: Space
Space is the easiest leader key for beginners — it's large, always in the same place, and doesn't conflict with any Vim defaults.

### Theme: Catppuccin Mocha
Catppuccin Mocha is a popular dark theme with excellent support across almost every plugin ecosystem (LSP, Telescope, nvim-tree, Lualine, etc.). It's visually easy on the eyes and has good contrast.

---

## Plugins Included

| Plugin | Purpose |
|---|---|
| `catppuccin/nvim` | Dark colorscheme (Mocha variant) |
| `nvim-tree/nvim-tree.lua` | File explorer sidebar (like VS Code) |
| `nvim-telescope/telescope.nvim` | Fuzzy finder for files, text, buffers |
| `nvim-treesitter/nvim-treesitter` | Syntax highlighting + text objects |
| `neovim/nvim-lspconfig` | LSP client configuration |
| `williamboman/mason.nvim` | GUI installer for LSP servers/tools |
| `williamboman/mason-lspconfig.nvim` | Bridges Mason with lspconfig |
| `j-hui/fidget.nvim` | LSP progress indicator |
| `folke/neodev.nvim` | Lua types for Neovim API |
| `hrsh7th/nvim-cmp` | Autocompletion engine |
| `L3MON4D3/LuaSnip` | Snippet engine |
| `rafamadriz/friendly-snippets` | Pre-made snippet library |
| `onsails/lspkind.nvim` | Icons in completion menu |
| `nvim-lualine/lualine.nvim` | Status line at the bottom |
| `lewis6991/gitsigns.nvim` | Git gutter signs + hunk actions |
| `akinsho/toggleterm.nvim` | Integrated terminal |
| `windwp/nvim-autopairs` | Auto-close brackets, quotes, etc. |
| `numToStr/Comment.nvim` | Toggle code comments easily |
| `folke/which-key.nvim` | Shows available keybindings on demand |

### LSP Servers (auto-installed by Mason)
- **pyright** — Full Python LSP: type checking, go-to-definition, completions, hover docs
- **ruff_lsp** — Python linter and formatter (very fast, PEP 8 aware)
- **lua_ls** — Lua LSP (useful for editing your own Neovim config)

---

## File Structure Generated

```
nvim/                          ← goes in ~/.config/nvim/
├── init.lua                   ← entry point
└── lua/
    └── config/
        ├── options.lua        ← vim settings (tabs, line numbers, etc.)
        ├── keymaps.lua        ← key bindings
        ├── lazy.lua           ← plugin manager bootstrap
        └── plugins/           ← one file per plugin
            ├── colorscheme.lua
            ├── nvim-tree.lua
            ├── telescope.lua
            ├── treesitter.lua
            ├── lsp.lua
            ├── completion.lua
            ├── lualine.lua
            ├── gitsigns.lua
            ├── toggleterm.lua
            ├── autopairs.lua
            ├── comment.lua
            └── which-key.lua
```

---

## Installation Instructions

### Prerequisites (macOS)

```bash
# 1. Install Homebrew if you don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install Neovim (version 0.9+ required)
brew install neovim

# 3. Install a Nerd Font (for icons in nvim-tree and lualine)
brew install --cask font-jetbrains-mono-nerd-font
# Then set your terminal font to "JetBrainsMono Nerd Font"

# 4. Install ripgrep (for Telescope live grep)
brew install ripgrep

# 5. Install Node.js (required by some LSP servers)
brew install node

# 6. Install Python (if not already present)
brew install python
```

### Deploy the Config

```bash
# Back up any existing config first
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# Copy this config into place
cp -r /path/to/this/output ~/.config/nvim
```

### First Launch

```bash
nvim
```

On first launch, lazy.nvim will automatically:
1. Install itself
2. Install all listed plugins
3. Mason will install pyright, ruff_lsp, and lua_ls

This takes about 1–2 minutes. After that, open any `.py` file and you'll have full LSP features.

---

## Key Bindings Reference (Most Important for Beginners)

> **Tip:** Press `<Space>` and wait 300ms to see all available commands via which-key.

### Navigation
| Key | Action |
|---|---|
| `<Space>ff` | Find files |
| `<Space>fg` | Search text in all files |
| `<Space>fb` | Switch between open files (buffers) |
| `<Space>fr` | Recently opened files |
| `<Space>e` | Toggle file explorer |
| `<Ctrl-h/j/k/l>` | Move between open panels |
| `<Shift-h>` / `<Shift-l>` | Previous / Next buffer |

### LSP (when editing Python)
| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | Find all references |
| `K` | Show hover documentation |
| `<Space>rn` | Rename symbol |
| `<Space>ca` | Code actions (quick fixes) |
| `<Space>cf` | Format file (via ruff) |
| `[d` / `]d` | Jump to previous/next error |
| `<Space>e` | Show error details |

### Terminal
| Key | Action |
|---|---|
| `<Ctrl-\>` | Toggle floating terminal |
| `<Space>th` | Open terminal at bottom |

### Git
| Key | Action |
|---|---|
| `<Space>gs` | Git status (changed files) |
| `]h` / `[h` | Next/previous changed section |
| `<Space>hp` | Preview change |
| `<Space>hs` | Stage change |
| `<Space>gb` | Show git blame for current line |

### Comments
| Key | Action |
|---|---|
| `gcc` | Toggle comment on current line |
| `gc` (visual) | Toggle comment on selection |

### Completion (while typing)
| Key | Action |
|---|---|
| `<Ctrl-Space>` | Open completion menu |
| `<Ctrl-n>` / `<Ctrl-p>` | Navigate items |
| `<Tab>` | Accept item / jump through snippet |
| `<CR>` (Enter) | Confirm selected item |
| `<Ctrl-e>` | Close completion menu |

---

## Notes for Newbies

- **Modal editing**: Neovim has modes. Press `i` to type (Insert mode), press `Esc` to stop typing (Normal mode). Most commands work in Normal mode.
- **Undo/Redo**: `u` to undo, `<Ctrl-r>` to redo.
- **Saving**: `<Space>w` saves the file.
- **Quitting**: `<Space>q` quits. If you have unsaved changes, it will ask you.
- **Help**: `:help <topic>` opens Neovim's built-in manual. Try `:help` alone to start.
- **Run `nvim --version`** to confirm Neovim 0.9+ is installed before starting.
