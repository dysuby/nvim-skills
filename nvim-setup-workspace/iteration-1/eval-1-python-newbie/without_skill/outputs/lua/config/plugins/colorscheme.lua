-- lua/config/plugins/colorscheme.lua
-- Theme: Catppuccin Mocha (a popular, well-maintained dark theme)

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Load before other plugins so colors apply correctly
  opts = {
    flavour = "mocha", -- Options: latte, frappe, macchiato, mocha (darkest)
    background = {
      dark = "mocha",
    },
    integrations = {
      nvimtree = true,
      treesitter = true,
      mason = true,
      which_key = true,
      gitsigns = true,
      telescope = { enabled = true },
      cmp = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
