-- lua/config/plugins/completion.lua
-- Autocompletion with nvim-cmp
-- Shows suggestions from LSP, buffer, path, and snippets

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Completion sources
    "hrsh7th/cmp-nvim-lsp",    -- LSP completions (primary source for Python)
    "hrsh7th/cmp-buffer",      -- Words from the current buffer
    "hrsh7th/cmp-path",        -- File system paths
    "hrsh7th/cmp-cmdline",     -- Command-line completions

    -- Snippet engine (required by nvim-cmp)
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      dependencies = {
        -- A large collection of pre-made snippets for many languages
        "rafamadriz/friendly-snippets",
      },
    },
    "saadparwaiz1/cmp_luasnip", -- Bridge between LuaSnip and nvim-cmp

    -- Adds icons to completion items (shows kind: Function, Class, etc.)
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Configure LuaSnip
    luasnip.config.setup({})

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- Completion window appearance
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      -- Key mappings for the completion menu
      mapping = cmp.mapping.preset.insert({
        -- Navigate completion items
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),

        -- Scroll the documentation window
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),

        -- Confirm selection
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Only confirm if explicitly selected
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),  -- Confirm (auto-select first)

        -- Trigger completion manually
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Close completion menu
        ["<C-e>"] = cmp.mapping.abort(),

        -- Tab: jump through snippet placeholders, or select next item
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Shift-Tab: jump backwards through snippet placeholders
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      -- Completion sources, in priority order
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 }, -- LSP (most important)
        { name = "luasnip",  priority = 750 },  -- Snippets
        { name = "buffer",   priority = 500 },  -- Words from current file
        { name = "path",     priority = 250 },  -- File paths
      }),

      -- How items are displayed in the completion menu
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",   -- Show icon + text label
          maxwidth = 50,
          ellipsis_char = "...",
          show_labelDetails = true,
        }),
      },
    })

    -- Command-line completions for "/" (search)
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })

    -- Command-line completions for ":" (ex commands and paths)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      }),
    })
  end,
}
