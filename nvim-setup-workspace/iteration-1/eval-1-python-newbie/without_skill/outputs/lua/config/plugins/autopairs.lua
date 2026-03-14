-- lua/config/plugins/autopairs.lua
-- Automatically insert closing brackets, quotes, parentheses, etc.

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp", -- Integrate with completion so <CR> works correctly
  },
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true,           -- Use Tree-sitter to be smarter about context
      ts_config = {
        -- Don't add pairs inside strings or comments in these languages
        lua = { "string" },
        python = { "string" },
        javascript = { "template_string" },
      },
      -- Don't pair when the next character is one of these
      fast_wrap = {
        map = "<M-e>",           -- Alt+e: wrap selected text in a pair
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    })

    -- Make autopairs work with nvim-cmp:
    -- When you press <CR> to confirm a completion, autopairs also runs
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
