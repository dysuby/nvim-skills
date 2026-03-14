# nvim-setup skill

A Claude Code **Superpowers Skill** that guides users through setting up a complete Neovim development environment from scratch via an interactive conversation.

---

## What does this skill do?

The user just says "help me configure Neovim" and the skill takes over — acting as a knowledgeable guide who understands community best practices. It collects the user's preferences through a structured conversation, then generates a ready-to-use set of Lua config files for `~/.config/nvim/`.

The conversation runs in five phases:

1. **Detect experience level** — distinguishes newbies from experts and adjusts explanation depth throughout
2. **Environment check** — auto-runs `nvim --version`, `git --version`, and `uname` to detect OS and prerequisites without asking the user; also scans for an existing config and offers to add to it, start fresh, or show what's missing
3. **Module-by-module setup** — walks through 17 optional plugin modules one at a time, using interactive option buttons (single-select and multi-select) for every choice; skips already-configured modules when updating an existing setup
4. **Keybinding customization** — summarizes all keybindings, checks for conflicts against a session-wide registry and critical Neovim built-ins, and lets the user resolve any conflicts or change bindings before generating
5. **Generate config files** — outputs complete Lua files with installation instructions; never overwrites files the user chose to keep

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

## Interactive choices

All decisions are presented as clickable option buttons via `AskUserQuestion` — no typing required. Multi-select is used for bulk choices like language parsers and LSP servers.

---

## Re-entrant — safe to run on an existing config

When the skill detects an existing `~/.config/nvim/`, it offers three paths:

- **Add to / update** — checks each plugin file individually; prompts only for modules that aren't configured yet or the user wants to change
- **Start fresh** — proceeds as a new setup
- **Show what's missing** — compares the existing config against all available modules and suggests additions

Files the user chooses to keep are never overwritten.

---

## Keybinding conflict detection

A running registry tracks every keybinding assigned during the session. Before confirming any binding, the skill checks it against:

- Bindings already assigned earlier in the session (or found in the existing config)
- Critical Neovim built-ins (`h/j/k/l`, `dd`, `yy`, `u`, `<C-r>`, etc.) that are dangerous to shadow

If a conflict is found, the user is prompted to pick a different binding or consciously override.

---

## Language

Responds in **English by default**. Switches to Chinese automatically if the user writes in Chinese. Config file comments follow the same language.

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
```
