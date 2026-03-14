-- lua/config/plugins/gitsigns.lua
-- Git integration: shows changed lines in the gutter, blame, hunk navigation

return {
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

    -- Show git blame inline at end of line (toggle with <leader>gb)
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
    },

    -- Key mappings (set up inside on_attach so they are buffer-local)
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "Git: " .. desc })
      end

      -- Navigation between hunks (changed sections)
      map("n", "]h", gs.next_hunk, "Next hunk")
      map("n", "[h", gs.prev_hunk, "Previous hunk")

      -- Staging
      map("n", "<leader>hs", gs.stage_hunk,        "Stage hunk")
      map("n", "<leader>hr", gs.reset_hunk,        "Reset hunk")
      map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage selected hunk")
      map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset selected hunk")
      map("n", "<leader>hS", gs.stage_buffer,      "Stage buffer")
      map("n", "<leader>hR", gs.reset_buffer,      "Reset buffer")

      -- Previewing
      map("n", "<leader>hp", gs.preview_hunk,      "Preview hunk")

      -- Blame
      map("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, "Blame line (full)")
      map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle inline blame")

      -- Diff
      map("n", "<leader>hd", gs.diffthis,          "Diff this file")

      -- Text object: select a hunk (e.g., vih to select the current change)
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
    end,
  },
}
