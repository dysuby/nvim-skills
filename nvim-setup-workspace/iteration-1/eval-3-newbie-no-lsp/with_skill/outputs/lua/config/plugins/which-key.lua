-- lua/config/plugins/which-key.lua
-- 快捷键提示：按下 leader 键（空格）后，会弹出一个窗口显示所有可用的快捷键
-- 对新手非常友好，不用担心忘记快捷键

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,               -- 按下 leader 后等 500ms 弹出提示
      icons = { mappings = true }, -- 显示图标
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      -- 注册分组标签，让提示窗口更有条理
      wk.add({
        { "<leader>f", group = "Find (Telescope)" },  -- 搜索相关
        { "<leader>h", group = "Git hunks" },         -- Git 改动操作
        { "<leader>b", group = "Buffer" },            -- Buffer 管理
      })
    end,
  },
}
