-- lua/plugins/neo-tree.lua

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      popup_border_style   = "rounded",
      enable_git_status    = true,
      enable_diagnostics   = true,
      default_component_configs = {
        indent = {
          indent_size   = 2,
          with_markers  = true,
          with_expanders = true,
        },
        icon = {
          folder_closed = "",
          folder_open   = "",
          folder_empty  = "󰜌",
        },
        git_status = {
          symbols = {
            added     = "✚",
            modified  = "",
            deleted   = "✖",
            renamed   = "󰁕",
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          },
        },
      },
      window = {
        position = "left",
        width     = 35,
        mappings  = {
          ["<space>"] = "none",   -- avoid conflict with leader
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
      filesystem = {
        filtered_items = {
          visible        = false,
          hide_dotfiles  = false,
          hide_gitignored = true,
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
    },
  },
}
