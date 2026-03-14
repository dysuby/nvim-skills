-- lua/config/plugins/lualine.lua
-- Status line at the bottom of the screen
-- Shows: mode, git branch, filename, diagnostics, filetype, position

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "catppuccin",         -- Match the colorscheme
      globalstatus = true,          -- Single status line for all windows
      component_separators = { left = "", right = "" },
      section_separators   = { left = "", right = "" },
      disabled_filetypes = {
        statusline = { "NvimTree" }, -- Hide statusline in the file explorer
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        "diff",
        {
          "diagnostics",
          sources = { "nvim_lsp" },
          symbols = { error = " ", warn = " ", info = " ", hint = "󰠠 " },
        },
      },
      lualine_c = {
        {
          "filename",
          path = 1,   -- Show relative path (0 = filename only, 2 = full path)
          symbols = {
            modified = "●",
            readonly = "",
            unnamed  = "[No Name]",
          },
        },
      },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "nvim-tree", "lazy", "toggleterm", "quickfix" },
  },
}
