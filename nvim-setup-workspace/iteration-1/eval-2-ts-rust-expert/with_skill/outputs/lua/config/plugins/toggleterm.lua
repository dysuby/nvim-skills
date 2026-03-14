-- lua/config/plugins/toggleterm.lua
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
    opts = {
      size = 20,
      open_mapping = [[<C-\>]],
      direction = "horizontal",
      float_opts = {
        border = "curved",
      },
    },
  },
}
