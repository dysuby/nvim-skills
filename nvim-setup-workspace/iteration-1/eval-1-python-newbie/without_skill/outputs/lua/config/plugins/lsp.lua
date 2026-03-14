-- lua/config/plugins/lsp.lua
-- Language Server Protocol setup
-- Provides: go-to-definition, hover docs, rename, diagnostics, etc.

return {
  -- mason.nvim: GUI for installing LSP servers, linters, formatters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Bridges mason.nvim with nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- These servers will be installed automatically
      ensure_installed = {
        "pyright",   -- Python LSP (type checking, completions, go-to-def)
        "ruff_lsp",  -- Python linter/formatter as LSP
        "lua_ls",    -- Lua LSP (useful for editing your own Neovim config)
      },
      automatic_installation = true,
    },
  },

  -- The actual LSP configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Nicer UI for LSP progress messages
      { "j-hui/fidget.nvim", opts = {} },
      -- Extra Lua types for Neovim API (great for editing your config)
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      -- neodev must be set up before lspconfig for Lua
      require("neodev").setup()

      local lspconfig = require("lspconfig")

      -- Capabilities: tell servers what features our completion plugin supports
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- nvim-cmp adds extra completion capabilities
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- ──────────────────────────────────────────────────────────
      -- Key mappings that only activate when an LSP is attached
      -- ──────────────────────────────────────────────────────────
      local on_attach = function(_, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        -- Navigation
        map("gd", vim.lsp.buf.definition,       "Go to definition")
        map("gD", vim.lsp.buf.declaration,      "Go to declaration")
        map("gr", vim.lsp.buf.references,       "Go to references")
        map("gi", vim.lsp.buf.implementation,   "Go to implementation")
        map("gt", vim.lsp.buf.type_definition,  "Go to type definition")

        -- Documentation
        map("K",  vim.lsp.buf.hover,            "Hover documentation")
        map("<C-k>", vim.lsp.buf.signature_help,"Signature help")

        -- Code actions
        map("<leader>rn", vim.lsp.buf.rename,         "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action,    "Code action")
        map("<leader>cf", vim.lsp.buf.format,         "Format file")

        -- Workspace
        map("<leader>wa", vim.lsp.buf.add_workspace_folder,    "Add workspace folder")
        map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
        map("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "List workspace folders")
      end

      -- ──────────────────────────────────────────────────────────
      -- Python: Pyright (type checking + completions)
      -- ──────────────────────────────────────────────────────────
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic", -- "off" | "basic" | "strict"
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })

      -- ──────────────────────────────────────────────────────────
      -- Python: Ruff (fast linter / formatter)
      -- ──────────────────────────────────────────────────────────
      lspconfig.ruff_lsp.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          -- Prefer Pyright for hover docs; Ruff handles linting/formatting
          client.server_capabilities.hoverProvider = false
        end,
      })

      -- ──────────────────────────────────────────────────────────
      -- Lua (for editing your Neovim config comfortably)
      -- ──────────────────────────────────────────────────────────
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      -- ──────────────────────────────────────────────────────────
      -- Diagnostic display settings
      -- ──────────────────────────────────────────────────────────
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●", -- Show a dot before inline diagnostic messages
        },
        signs = true,
        underline = true,
        update_in_insert = false, -- Don't show diagnostics while typing
        severity_sort = true,     -- Show errors before warnings
        float = {
          border = "rounded",
          source = "always",      -- Show which server issued the diagnostic
        },
      })

      -- Diagnostic signs in the gutter
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end,
  },
}
