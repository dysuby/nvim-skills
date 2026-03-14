-- lua/plugins/git.lua

return {
  -- Gitsigns: hunk indicators, blame, diff
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then return "]h" end
          gs.next_hunk()
        end, "Next hunk")
        map("n", "[h", function()
          if vim.wo.diff then return "[h" end
          gs.prev_hunk()
        end, "Prev hunk")

        -- Actions
        map({ "n", "v" }, "<leader>hs", gs.stage_hunk,        "Stage hunk")
        map({ "n", "v" }, "<leader>hr", gs.reset_hunk,        "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer,               "Stage buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk,            "Undo stage hunk")
        map("n", "<leader>hR", gs.reset_buffer,               "Reset buffer")
        map("n", "<leader>hp", gs.preview_hunk,               "Preview hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>gd", gs.diffthis,                   "Diff this")

        -- Text objects
        map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<CR>", "Select hunk")
      end,
    },
  },

  -- LazyGit: full TUI git client
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitCurrentFile", "LazyGitFilter" },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Diffview: side-by-side diffs and history
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<CR>",        desc = "Diffview open" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "File history" },
    },
    opts = {},
  },
}
