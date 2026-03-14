-- lua/config/plugins/telescope.lua
-- Fuzzy finder: search files, text, buffers, git, and more

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Native sorter written in C — much faster than the Lua sorter
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      -- Only load if `make` is available
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  keys = {
    -- Find files by name
    { "<leader>ff", "<cmd>Telescope find_files<CR>",             desc = "Find files" },
    -- Search inside files (requires ripgrep: brew install ripgrep)
    { "<leader>fg", "<cmd>Telescope live_grep<CR>",              desc = "Live grep (search in files)" },
    -- List open buffers
    { "<leader>fb", "<cmd>Telescope buffers<CR>",                desc = "Find buffers" },
    -- Search Neovim help
    { "<leader>fh", "<cmd>Telescope help_tags<CR>",              desc = "Search help" },
    -- Search recently opened files
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>",               desc = "Recent files" },
    -- Search key mappings
    { "<leader>fk", "<cmd>Telescope keymaps<CR>",                desc = "Find keymaps" },
    -- Grep word under cursor
    { "<leader>fw", "<cmd>Telescope grep_string<CR>",            desc = "Find word under cursor" },
    -- Git: changed files
    { "<leader>gs", "<cmd>Telescope git_status<CR>",             desc = "Git status (changed files)" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        -- Show full path in results
        path_display = { "smart" },
        -- Default key bindings inside telescope
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,           -- Include hidden files
        },
      },
    })

    -- Load the native fzf sorter if available
    pcall(telescope.load_extension, "fzf")
  end,
}
