-- lua/config/plugins/bufferline.lua
return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>",      desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>",      desc = "Next buffer" },
      { "<leader>bd", "<cmd>bdelete<cr>",             desc = "Close buffer" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = true,
        show_close_icon = false,
        separator_style = "slant",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}
