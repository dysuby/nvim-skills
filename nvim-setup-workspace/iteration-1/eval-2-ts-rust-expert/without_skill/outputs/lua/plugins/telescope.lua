-- lua/plugins/telescope.lua

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function() return vim.fn.executable("make") == 1 end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions   = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix   = "  ",
          selection_caret = " ",
          path_display    = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical   = { mirror = false },
            width      = 0.87,
            height     = 0.80,
          },
          mappings = {
            i = {
              ["<C-j>"]   = actions.move_selection_next,
              ["<C-k>"]   = actions.move_selection_previous,
              ["<C-q>"]   = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Esc>"]   = actions.close,
              ["<C-u>"]   = false,
              ["<C-d>"]   = false,
            },
          },
          file_ignore_patterns = { "node_modules", ".git/", "target/", "dist/" },
        },
        pickers = {
          find_files = { hidden = true },
          live_grep  = { additional_args = { "--hidden" } },
        },
        extensions = {
          fzf = {
            fuzzy                   = true,
            override_generic_sorter = true,
            override_file_sorter    = true,
            case_mode               = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
  },
}
