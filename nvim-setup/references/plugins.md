# Plugin Reference

Each section covers one plugin group: what it does, the lazy.nvim spec, and default config.

---

## lazy.nvim Bootstrap

Always included. Put in `lua/config/lazy.lua`.

```lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit...", "ErrorMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "config.plugins" },
  },
  checker = { enabled = true },  -- 自动检查插件更新
})
```

---

## Colorscheme

### Catppuccin
```lua
-- lua/config/plugins/colorscheme.lua
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte (light), frappe, macchiato, mocha (darkest)
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
```
Variants: `latte` (light), `frappe` (medium dark), `macchiato` (dark), `mocha` (darkest)

### Tokyo Night
```lua
return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "night", -- storm, night, day, moon
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
```

### Gruvbox
```lua
return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      contrast = "hard", -- soft, medium, hard
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.o.background = "dark" -- or "light"
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}
```

### Dracula
```lua
return {
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("dracula")
    end,
  },
}
```

### Rose Pine
```lua
return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      variant = "main", -- main, moon, dawn (light)
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd.colorscheme("rose-pine")
    end,
  },
}
```

---

## File Explorer — neo-tree.nvim

```lua
-- lua/config/plugins/neo-tree.lua
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_default",
      },
      window = {
        width = 30,
      },
    },
  },
}
```

---

## Fuzzy Finder — Telescope.nvim

```lua
-- lua/config/plugins/telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",    desc = "Recent files" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },
}
```

---

## Syntax Highlighting — nvim-treesitter

```lua
-- lua/config/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- 根据用户选择填入语言列表
      ensure_installed = { "lua", "vim", "vimdoc", "query" },
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
    end,
  },
}
```

Common language parsers: `lua`, `python`, `javascript`, `typescript`, `tsx`, `rust`, `go`,
`c`, `cpp`, `java`, `html`, `css`, `json`, `yaml`, `toml`, `markdown`, `bash`, `dockerfile`

---

## LSP Stack

Three components work together:

### mason.nvim — LSP Server Manager
```lua
-- lua/config/plugins/lsp.lua
return {
  -- Mason: 安装和管理 LSP servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Mason-lspconfig: 让 mason 和 lspconfig 协作
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- 根据用户选择的语言填入
      ensure_installed = {},
      automatic_installation = true,
    },
  },

  -- nvim-lspconfig: 配置 LSP servers 的行为
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 通用 on_attach：设置 LSP 相关快捷键
      local on_attach = function(_, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition,       "Go to definition")
        map("gr", vim.lsp.buf.references,        "Find references")
        map("K",  vim.lsp.buf.hover,             "Hover documentation")
        map("<leader>rn", vim.lsp.buf.rename,    "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("[d", vim.diagnostic.goto_prev,      "Previous diagnostic")
        map("]d", vim.diagnostic.goto_next,      "Next diagnostic")
        map("<leader>d", vim.diagnostic.open_float, "Show diagnostic")
      end

      -- 根据用户选择配置各个 language server
      -- 示例，实际根据用户选择填入：
      -- lspconfig.lua_ls.setup({ on_attach = on_attach, capabilities = capabilities })
      -- lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
      })

      -- 诊断图标
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰠠 ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
        },
      })
    end,
  },
}
```

Common LSP server names:
- `lua_ls` — Lua
- `pyright` — Python
- `ts_ls` — TypeScript/JavaScript
- `rust_analyzer` — Rust
- `gopls` — Go
- `clangd` — C/C++
- `html`, `cssls`, `jsonls` — Web
- `bashls` — Bash
- `dockerls` — Dockerfile

---

## Autocompletion — nvim-cmp

```lua
-- lua/config/plugins/cmp.lua
return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",    -- LSP 补全源
      "hrsh7th/cmp-buffer",      -- 当前 buffer 词语补全
      "hrsh7th/cmp-path",        -- 文件路径补全
      "L3MON4D3/LuaSnip",        -- 代码片段引擎
      "saadparwaiz1/cmp_luasnip",-- LuaSnip 补全源
      "rafamadriz/friendly-snippets", -- 常用代码片段集合
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip  = "[Snippet]",
              buffer   = "[Buffer]",
              path     = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })
    end,
  },
}
```

---

## Status Line — lualine.nvim

```lua
-- lua/config/plugins/lualine.lua
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        -- theme 自动匹配配色方案，如 "catppuccin", "tokyonight", "gruvbox"
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
}
```

---

## Git Integration

### gitsigns.nvim
```lua
-- lua/config/plugins/gitsigns.lua
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "󰍵" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "│" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end
        map("n", "<leader>hs", gs.stage_hunk,         "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk,         "Reset hunk")
        map("n", "<leader>hp", gs.preview_hunk,       "Preview hunk")
        map("n", "<leader>hb", gs.blame_line,         "Blame line")
        map("n", "<leader>hd", gs.diffthis,           "Diff this")
      end,
    },
  },
}
```

### vim-fugitive (optional, for experts)
```lua
{
  "tpope/vim-fugitive",
  cmd = { "Git", "G" },
  keys = {
    { "<leader>gs", "<cmd>Git<cr>",    desc = "Git status" },
    { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
    { "<leader>gp", "<cmd>Git push<cr>",   desc = "Git push" },
  },
},
```

---

## Terminal — toggleterm.nvim

```lua
-- lua/config/plugins/toggleterm.lua
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
    opts = {
      size = 20,
      open_mapping = [[<C-\>]],
      direction = "horizontal", -- horizontal, vertical, float, tab
      float_opts = {
        border = "curved",
      },
    },
  },
}
```

---

## Which-key — which-key.nvim

```lua
-- lua/config/plugins/which-key.lua
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500, -- 按下 leader 后 500ms 弹出提示
      icons = { mappings = true },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      -- 注册 leader 分组标签
      wk.add({
        { "<leader>f", group = "Find (Telescope)" },
        { "<leader>h", group = "Git hunks" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
      })
    end,
  },
}
```

---

## Auto Pairs — nvim-autopairs

```lua
-- lua/config/plugins/autopairs.lua
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,  -- 使用 treesitter 来智能判断
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      -- 与 cmp 集成：确认补全时自动加括号
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
```

---

## Comment — Comment.nvim

```lua
-- lua/config/plugins/comment.lua
return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
}
```

Keybindings (built-in, no config needed):
- `gcc` — toggle comment on current line
- `gc{motion}` — toggle comment on motion (e.g. `gc3j` = comment 3 lines down)
- `gcb` — block comment
- Visual mode: `gc` — comment selection

---

## Buffer Tabs — bufferline.nvim

```lua
-- lua/config/plugins/bufferline.lua
return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<leader>bd", "<cmd>bdelete<cr>",         desc = "Close buffer" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",           -- 在标签上显示 LSP 错误图标
        show_buffer_close_icons = true,
        show_close_icon = false,
        separator_style = "slant",          -- slant, slope, thick, thin
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}
```

---

## Indent Lines — indent-blankline.nvim

```lua
-- lua/config/plugins/indent-blankline.lua
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",         -- 缩进参考线字符
        tab_char = "│",
      },
      scope = {
        enabled = true,     -- 高亮当前作用域的缩进线（需要 treesitter）
        show_start = true,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help", "dashboard", "neo-tree", "Trouble", "lazy", "mason",
        },
      },
    },
  },
}
```

---

## Noice.nvim — UI Overhaul

```lua
-- lua/config/plugins/noice.lua
return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",   -- 通知弹窗
    },
    opts = {
      lsp = {
        -- 覆盖 LSP 文档渲染，使用 Treesitter 高亮
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,         -- 搜索栏在底部（更传统）
        command_palette = true,       -- 命令行在中间浮动
        long_message_to_split = true, -- 长消息自动打开 split
        inc_rename = false,
        lsp_doc_border = true,        -- LSP 文档加边框
      },
    },
  },
  -- nvim-notify 单独配置（可选）
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      render = "wrapped-compact",
      stages = "fade",
    },
  },
}
```

---

## Surround — nvim-surround

```lua
-- lua/config/plugins/surround.lua
return {
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    config = true,   -- 使用默认配置即可，不需要额外设置
  },
}
```

Built-in keybindings (no config needed):

| Key                     | Action                                      | Example                          |
|-------------------------|---------------------------------------------|----------------------------------|
| `ys{motion}{char}`      | Add surround                                | `ysiw"` → surround word with `"` |
| `cs{old}{new}`          | Change surround                             | `cs"'` → change `"` to `'`      |
| `ds{char}`              | Delete surround                             | `ds(` → remove `()`             |
| `S{char}` (visual)      | Surround selection                          | Select + `S"` → add `"`          |

Examples:
- `ysiw(` → wrap word in `(word)`
- `yss"` → wrap whole line in `"line"`
- `cs"'` → change `"hello"` to `'hello'`
- `dst` → delete surrounding HTML tag
