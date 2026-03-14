-- lua/config/plugins/which-key.lua
-- Shows available keybindings in a popup when you start typing a sequence
-- Essential for newbies: press <Space> and wait to see all leader mappings

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    plugins = {
      marks = true,      -- Show marks when you press `
      registers = true,  -- Show register contents when you press "
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    window = {
      border = "rounded",
      padding = { 2, 2, 2, 2 },
    },
    layout = {
      height = { min = 4, max = 25 },
      width  = { min = 20, max = 50 },
      spacing = 3,
      align = "center",
    },
    -- Group labels for leader key sequences
    groups = {
      { "<leader>f",  group = "Find (Telescope)" },
      { "<leader>g",  group = "Git" },
      { "<leader>h",  group = "Git hunks" },
      { "<leader>b",  group = "Buffers" },
      { "<leader>c",  group = "Code (LSP)" },
      { "<leader>r",  group = "Rename" },
      { "<leader>t",  group = "Terminal" },
      { "<leader>w",  group = "Workspace / Save" },
      { "<leader>d",  group = "Diagnostics" },
    },
  },
}
