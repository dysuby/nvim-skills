-- lua/config/plugins/nvim-tree.lua
-- File explorer (like VS Code's sidebar)

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- File icons (requires a Nerd Font)
  },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>",   desc = "Toggle file explorer" },
    { "<leader>fe", "<cmd>NvimTreeFocus<CR>",   desc = "Focus file explorer" },
  },
  config = function()
    -- Disable netrw (Neovim's built-in file browser) so nvim-tree takes over
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      view = {
        width = 35,
        side = "left",
      },
      renderer = {
        group_empty = true,        -- Collapse single-child directories
        highlight_git = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,          -- Show hidden files (like .env, .gitignore)
      },
      git = {
        enable = true,
        ignore = false,            -- Show git-ignored files (greyed out)
      },
      actions = {
        open_file = {
          quit_on_open = false,    -- Keep explorer open after opening a file
          window_picker = {
            enable = true,
          },
        },
      },
    })
  end,
}
