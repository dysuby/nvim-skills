-- lua/plugins/editor.lua
-- Quality-of-life editor enhancements

return {
  -- Which-key: keymap discovery
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = { enabled = true } },
      defaults = {},
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        ["<leader>f"]  = { name = "+find" },
        ["<leader>g"]  = { name = "+git" },
        ["<leader>h"]  = { name = "+hunk" },
        ["<leader>l"]  = { name = "+lsp" },
        ["<leader>s"]  = { name = "+split" },
        ["<leader>t"]  = { name = "+terminal" },
        ["<leader>x"]  = { name = "+trouble" },
      })
    end,
  },

  -- Auto-pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      -- integrate with cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    version = "*",
    opts = {},
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Better escape from insert mode
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = { mapping = { "jk", "jj" } },
  },

  -- Highlight word under cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope  = { enabled = true },
    },
  },

  -- Mini modules (misc utilities)
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup({ n_lines = 500 })     -- better a/i text objects
      require("mini.bufremove").setup()                -- smarter buffer deletion
      require("mini.move").setup()                     -- move lines/blocks
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    keys = {
      { "<leader>lF", function() require("conform").format({ async = true, lsp_fallback = true }) end,
        desc = "Format (conform)" },
    },
    opts = {
      formatters_by_ft = {
        javascript  = { "prettierd", "prettier" },
        typescript  = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        json        = { "prettierd" },
        css         = { "prettierd" },
        html        = { "prettierd" },
        markdown    = { "prettierd" },
        rust        = { "rustfmt" },
        lua         = { "stylua" },
        toml        = { "taplo" },
      },
      format_on_save = {
        timeout_ms   = 500,
        lsp_fallback = true,
      },
    },
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        javascriptreact = { "eslint_d" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function() lint.try_lint() end,
      })
    end,
  },

  -- Flash: fast navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,       desc = "Remote Flash" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,       desc = "Toggle Flash Search" },
    },
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo" },
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Find todos" },
    },
  },

  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "hyper",
      config = {
        week_header = { enable = true },
        shortcut = {
          { desc = " Update",  group = "@property", action = "Lazy update",          key = "u" },
          { desc = " Files",   group = "Label",     action = "Telescope find_files",  key = "f" },
          { desc = " Config",  group = "Number",    action = "e $MYVIMRC",           key = "c" },
          { desc = " Quit",    group = "DiagnosticError", action = "qa",             key = "q" },
        },
      },
    },
  },
}
