-- lua/config/plugins/comment.lua
-- Easy code commenting with gcc (line) and gbc (block)

return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- Helps Comment.nvim figure out the right comment syntax inside JSX/TSX
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- nvim-ts-context-commentstring integration (required setup)
    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })

    require("Comment").setup({
      -- Integration with nvim-ts-context-commentstring
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

      -- Default key bindings (these are Comment.nvim's built-in defaults):
      --
      --   Normal mode:
      --     gcc   → toggle comment on current line
      --     gbc   → toggle block comment on current line
      --     gcO   → add comment above
      --     gco   → add comment below
      --     gcA   → add comment at end of line
      --
      --   Visual mode:
      --     gc    → toggle line comments on selection
      --     gb    → toggle block comments on selection
      --
      -- No customization needed — the defaults are great.
    })
  end,
}
