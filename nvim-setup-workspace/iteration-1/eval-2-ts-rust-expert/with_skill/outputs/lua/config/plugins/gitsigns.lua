-- lua/config/plugins/gitsigns.lua
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "󰍵" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "│" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end
        map("n", "<leader>hs", gs.stage_hunk,   "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk,   "Reset hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", gs.blame_line,   "Blame line")
        map("n", "<leader>hd", gs.diffthis,     "Diff this")
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>",        desc = "Git status" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<cr>",   desc = "Git push" },
    },
  },
}
