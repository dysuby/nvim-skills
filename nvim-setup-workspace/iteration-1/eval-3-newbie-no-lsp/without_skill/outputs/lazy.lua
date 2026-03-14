-- lazy.lua  (referenced as "lazy-setup" in init.lua)
-- Bootstrap and configure lazy.nvim plugin manager

-- ── Bootstrap lazy.nvim ──────────────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ── Plugin list ──────────────────────────────────────────────────────────────
require("lazy").setup({

  -- ── Colorscheme ────────────────────────────────────────────────────────────
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,   -- Load before other plugins
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",   -- latte | frappe | macchiato | mocha
        transparent_background = false,
        term_colors = true,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- ── File tree (Neo-tree) ───────────────────────────────────────────────────
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",  -- File icons
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          width = 30,
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = {
            enabled = true,
          },
        },
      })
    end,
  },

  -- ── Telescope (fuzzy finder) ───────────────────────────────────────────────
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Optional but much faster sorter (requires make / gcc)
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions   = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<Esc>"] = actions.close,
            },
          },
          -- Show hidden files (dotfiles) in search results
          file_ignore_patterns = { "node_modules", ".git/" },
        },
        pickers = {
          find_files = {
            hidden = true,   -- Include hidden files
          },
        },
      })

      -- Load fzf extension if available
      pcall(telescope.load_extension, "fzf")
    end,
  },

  -- ── Status line (lualine) ──────────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          globalstatus = true,
        },
      })
    end,
  },

  -- ── Syntax highlighting (Treesitter) ──────────────────────────────────────
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Install parsers for common languages automatically
        ensure_installed = {
          "lua", "vim", "vimdoc",
          "javascript", "typescript", "python",
          "html", "css", "json", "markdown",
        },
        highlight = { enable = true },
        indent    = { enable = true },
      })
    end,
  },

}, {
  -- lazy.nvim options
  ui = {
    border = "rounded",
  },
})
