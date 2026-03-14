-- lua/plugins/statusline.lua

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme                = "catppuccin",
        globalstatus         = true,
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
        disabled_filetypes   = { statusline = { "dashboard", "neo-tree" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          { "diff",        symbols = { added = " ", modified = " ", removed = " " } },
          { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
        },
        lualine_c = {
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        },
        lualine_x = {
          { -- LSP server name
            function()
              local clients = vim.lsp.get_active_clients({ bufnr = 0 })
              if #clients == 0 then return "" end
              local names = vim.tbl_map(function(c) return c.name end, clients)
              return " " .. table.concat(names, ", ")
            end,
            color = { fg = "#a6e3a1" },
          },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Bufferline: tab-style buffer list
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode              = "buffers",
        separator_style   = "slant",
        show_buffer_close_icons = true,
        show_close_icon   = false,
        diagnostics       = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = { error = " ", warning = " " }
          local ret = (diag.error and icons.error .. diag.error .. " " or "")
                   .. (diag.warning and icons.warning .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          { filetype = "neo-tree", text = "File Explorer", highlight = "Directory", text_align = "center" },
        },
      },
    },
  },
}
