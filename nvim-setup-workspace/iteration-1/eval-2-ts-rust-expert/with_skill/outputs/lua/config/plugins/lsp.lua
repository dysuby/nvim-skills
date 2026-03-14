-- lua/config/plugins/lsp.lua
return {
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

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "ts_ls",
        "rust_analyzer",
        "lua_ls",
      },
      automatic_installation = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end
        map("gd",          vim.lsp.buf.definition,      "Go to definition")
        map("gr",          vim.lsp.buf.references,       "Find references")
        map("K",           vim.lsp.buf.hover,            "Hover documentation")
        map("<leader>rn",  vim.lsp.buf.rename,           "Rename symbol")
        map("<leader>ca",  vim.lsp.buf.code_action,      "Code action")
        map("[d",          vim.diagnostic.goto_prev,     "Previous diagnostic")
        map("]d",          vim.diagnostic.goto_next,     "Next diagnostic")
        map("<leader>d",   vim.diagnostic.open_float,    "Show diagnostic")
      end

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
      })

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
