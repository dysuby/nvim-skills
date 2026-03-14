-- lua/config/plugins/colorscheme.lua
-- 配色方案：Catppuccin Mocha（深色，柔和的马卡龙色调）
-- Catppuccin 是目前最受欢迎的现代 Neovim 主题之一

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,  -- 优先级最高，确保在其他插件之前加载
    opts = {
      flavour = "mocha",  -- 可选：latte（浅色）/ frappe / macchiato / mocha（最深）
      integrations = {
        -- 自动适配下面安装的插件，让配色保持一致
        neo_tree = true,
        telescope = { enabled = true },
        treesitter = true,
        cmp = true,
        gitsigns = true,
        which_key = true,
        bufferline = true,
        indent_blankline = { enabled = true },
        lualine = true,
        native_lsp = {
          enabled = true,
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
  },
}
