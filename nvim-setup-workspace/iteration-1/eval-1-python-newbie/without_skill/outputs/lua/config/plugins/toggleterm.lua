-- lua/config/plugins/toggleterm.lua
-- Integrated terminal: open a terminal inside Neovim without leaving

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    -- Toggle the floating terminal with Ctrl+\
    { "<C-\\>", "<cmd>ToggleTerm direction=float<CR>",   desc = "Toggle floating terminal", mode = { "n", "t" } },
    -- Toggle a bottom terminal
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle horizontal terminal" },
    -- Toggle a side terminal
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>",   desc = "Toggle vertical terminal" },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15          -- Height for horizontal split
      elseif term.direction == "vertical" then
        return math.floor(vim.o.columns * 0.4) -- 40% width for vertical split
      end
    end,
    open_mapping = [[<C-\>]],
    hide_numbers = true,   -- Hide line numbers in terminal
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = "float",   -- Default: open as a floating window
    close_on_exit = true,  -- Auto-close terminal when process exits
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
    },
  },
}
