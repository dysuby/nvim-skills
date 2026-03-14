# nvim-setup skill

A Claude Code **Superpowers Skill** that guides users through setting up a complete Neovim development environment from scratch via an interactive conversation.

---

## What does this skill do?

The user just says "help me configure Neovim" and the skill takes over — acting as a knowledgeable guide who understands community best practices. It collects the user's preferences through a structured conversation, then generates a ready-to-use set of Lua config files for `~/.config/nvim/`.

The conversation runs in five phases:

1. **Detect experience level** — distinguishes newbies from experts and adjusts explanation depth throughout
2. **Environment check** — confirms OS, Neovim version, and Nerd Font installation
3. **Module-by-module setup** — walks through 17 optional plugin modules one at a time
4. **Keybinding customization** — summarizes all keybindings and lets the user change any of them
5. **Generate config files** — outputs complete Lua files with installation instructions

---

## Supported modules

| Module | Plugin | Description |
|--------|--------|-------------|
| Base config | — | Leader key, relative line numbers, indentation, clipboard — community best practices. **Always included.** |
| Plugin manager | lazy.nvim | Auto-bootstrap. **Always included.** |
| Colorscheme | catppuccin / Tokyo Night / Gruvbox / Dracula / Rose Pine | Dark and light variants supported |
| File explorer | neo-tree.nvim | VS Code-style sidebar file browser |
| Fuzzy finder | Telescope.nvim | Search files, content, buffers, and help tags |
| Syntax highlighting | nvim-treesitter | Language-specific parsers, all major languages supported |
| LSP | mason + nvim-lspconfig + mason-lspconfig | Autocompletion, go-to-definition, hover docs, diagnostics |
| Autocompletion | nvim-cmp + LuaSnip | Dropdown menu + snippets with multiple completion sources |
| Status line | lualine.nvim | Displays mode, branch, diagnostics, and file info |
| Git integration | gitsigns.nvim / vim-fugitive | Line-level diff indicators + full Git commands |
| Terminal | toggleterm.nvim | Open a terminal without leaving Neovim |
| Keybinding hints | which-key.nvim | Shows available keybindings after pressing leader |
| Auto pairs | nvim-autopairs | Automatically closes `(`, `{`, `[`, etc. |
| Comments | Comment.nvim | `gcc` to comment line, `gc{motion}` for ranges |
| Buffer tabs | bufferline.nvim | Top-of-screen tab bar with LSP diagnostic icons |
| Indent guides | indent-blankline.nvim | Visual indentation guides for nested code |
| UI overhaul | noice.nvim | Floating command line + notification popups (expert-recommended) |
| Surround | nvim-surround | `ys`/`cs`/`ds` to add/change/delete surrounding characters |

---

## Two conversation styles

**Newbie mode**: explains each module before asking — what it is, why it's useful, with analogies. Goes slow, one step at a time.

**Expert mode**: lists plugin name + one-line summary. Quick yes/no. No unnecessary explanation.

---

## Supported LSP servers

| Language | Server |
|----------|--------|
| Lua | `lua_ls` |
| Python | `pyright` |
| TypeScript / JavaScript | `ts_ls` |
| Rust | `rust_analyzer` |
| Go | `gopls` |
| C / C++ | `clangd` |
| HTML / CSS / JSON | `html` / `cssls` / `jsonls` |
| Bash | `bashls` |
| Dockerfile | `dockerls` |

---

## Generated file structure

```
~/.config/nvim/
├── init.lua
└── lua/
    └── config/
        ├── options.lua
        ├── keymaps.lua
        ├── lazy.lua
        └── plugins/
            ├── colorscheme.lua
            ├── neo-tree.lua
            ├── telescope.lua
            ├── treesitter.lua
            ├── lsp.lua
            ├── cmp.lua
            └── ...  (only modules the user chose)
```

Only files for chosen modules are generated. Newbie configs include inline explanatory comments; expert configs omit them by default.

---

## Installation

This skill is distributed as a **Claude Code plugin**. You need [Claude Code](https://claude.ai/code) and the [Superpowers plugin](https://github.com/anthropics/claude-plugins-official) installed first.

### From GitHub (recommended)

Add this repository as a marketplace and install the plugin:

```bash
claude plugin marketplace add github:YOUR_USERNAME/nvim-setup-skill
claude plugin install nvim-setup
```

### Local installation

Clone the repo and point Claude Code at it directly:

```bash
git clone https://github.com/YOUR_USERNAME/nvim-setup-skill
claude plugin marketplace add ./nvim-setup-skill
claude plugin install nvim-setup
```

### Verify installation

```bash
claude plugin list
```

You should see `nvim-setup` in the list. The skill is immediately available in any Claude Code session — no restart needed.

---

## Usage

Just talk to Claude Code naturally:

```
Help me configure Neovim from scratch, I mainly write Python
```

```
Set up neovim for me, I'm an expert, TypeScript + Rust on macOS
```

The skill auto-detects the intent and starts the guided flow.

---

## Repository structure

```
nvim-setup/
├── SKILL.md                  # Skill definition
└── references/
    ├── plugins.md            # lazy.nvim specs for all plugins
    ├── keybindings.md        # Keybinding defaults and community best practices
    └── config-template.md    # Templates for init.lua / options.lua / keymaps.lua

nvim-setup-workspace/
└── iteration-1/              # Eval run outputs
    ├── eval-1-python-newbie/
    ├── eval-2-ts-rust-expert/
    └── eval-3-newbie-no-lsp/
```
