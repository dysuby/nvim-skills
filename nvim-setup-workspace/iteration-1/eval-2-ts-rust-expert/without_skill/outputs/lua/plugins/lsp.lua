-- lua/plugins/lsp.lua

return {
  -- Mason: tool installer
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        -- LSP servers
        "typescript-language-server",
        "rust-analyzer",
        "lua-language-server",
        -- Formatters / linters
        "prettierd",
        "eslint_d",
        "stylua",
        "taplo",            -- TOML formatter
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      -- Auto-install ensure_installed tools
      local mr = require("mason-registry")
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end)
    end,
  },

  -- mason-lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "ts_ls", "rust_analyzer", "lua_ls" },
      automatic_installation = true,
    },
  },

  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "folke/neodev.nvim", opts = {} },  -- lua dev for nvim config
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- ── on_attach: shared LSP keymaps ────────────────────────────────────
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        map("n", "gd",         vim.lsp.buf.definition,       "Go to definition")
        map("n", "gD",         vim.lsp.buf.declaration,      "Go to declaration")
        map("n", "gr",         vim.lsp.buf.references,       "References")
        map("n", "gI",         vim.lsp.buf.implementation,   "Implementation")
        map("n", "gy",         vim.lsp.buf.type_definition,  "Type definition")
        map("n", "K",          vim.lsp.buf.hover,            "Hover")
        map("n", "<C-k>",      vim.lsp.buf.signature_help,   "Signature help")
        map("n", "<leader>rn", vim.lsp.buf.rename,           "Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action,      "Code action")
        map("n", "<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, "Format")
        map("n", "[d", vim.diagnostic.goto_prev,  "Prev diagnostic")
        map("n", "]d", vim.diagnostic.goto_next,  "Next diagnostic")
        map("n", "<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
      end

      -- ── Diagnostics UI ────────────────────────────────────────────────────
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
        },
      })

      -- ── TypeScript (ts_ls) ─────────────────────────────────────────────────
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints        = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints         = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints       = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints        = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints         = true,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
          },
        },
      })

      -- ── Rust (rust_analyzer) ───────────────────────────────────────────────
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true, loadOutDirsFromCheck = true },
            checkOnSave = { command = "clippy" },
            procMacro = { enable = true },
            inlayHints = {
              bindingModeHints          = { enable = false },
              chainingHints             = { enable = true },
              closingBraceHints         = { enable = true, minLines = 25 },
              closureReturnTypeHints    = { enable = "never" },
              lifetimeElisionHints      = { enable = "never" },
              parameterHints            = { enable = true },
              typeHints                 = { enable = true },
            },
          },
        },
      })

      -- ── Lua ───────────────────────────────────────────────────────────────
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            completion = { callSnippet = "Replace" },
          },
        },
      })
    end,
  },

  -- Inlay hints toggle
  {
    "lvimuser/lsp-inlayhints.nvim",
    event = "LspAttach",
    opts = {},
    config = function(_, opts)
      require("lsp-inlayhints").setup(opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf)
        end,
      })
      vim.keymap.set("n", "<leader>lh", require("lsp-inlayhints").toggle,
        { desc = "Toggle inlay hints" })
    end,
  },

  -- Trouble: diagnostics list
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = { use_diagnostic_signs = true },
  },
}
