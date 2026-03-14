-- lua/config/plugins/treesitter.lua
-- Syntax highlighting and code understanding via Tree-sitter

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- Auto-update parsers when plugin updates
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- Extra text objects (select inside function, class, etc.)
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Languages to install parsers for
      ensure_installed = {
        "python",
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "json",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        "html",
        "css",
        "javascript",
        "typescript",
        "regex",
        "dockerfile",
        "gitignore",
      },

      -- Install parsers synchronously (only on first run)
      sync_install = false,

      -- Automatically install missing parsers when entering a buffer
      auto_install = true,

      highlight = {
        enable = true,
        -- Disable for very large files to keep Neovim fast
        disable = function(_, buf)
          local max_filesize = 1024 * 1024 -- 1 MB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        -- Use treesitter highlighting + Neovim's built-in regex (belt-and-suspenders)
        additional_vim_regex_highlighting = false,
      },

      -- Smarter indentation
      indent = {
        enable = true,
      },

      -- Text objects (e.g., select/move to next function or class)
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to the next text object
          keymaps = {
            ["af"] = "@function.outer", -- Around function
            ["if"] = "@function.inner", -- Inside function
            ["ac"] = "@class.outer",    -- Around class
            ["ic"] = "@class.inner",    -- Inside class
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
        },
      },
    })
  end,
}
