-- lua/config/plugins/which-key.lua
-- 快捷键提示弹窗：当你按下 leader 键（空格）后，
-- 等 500ms 会弹出一个窗口，显示所有可用的快捷键
-- 对新手非常友好——不需要记住所有快捷键，看提示就行！

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",  -- 延迟加载
    opts = {
      delay = 500,  -- 按下 leader 后等 500ms 弹出提示（可以调小让它更快）
      icons = {
        mappings = true,   -- 显示图标
        keys = {
          Space = "󱁐 ",
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- 注册 leader 分组标签，让提示菜单更清晰
      -- 比如按下 <Space>f 会看到 "Find (Telescope)" 的分组标题
      wk.add({
        { "<leader>f",  group = "Find (Telescope)" },  -- Telescope 搜索
        { "<leader>h",  group = "Git hunks" },          -- Git hunk 操作
        { "<leader>g",  group = "Git" },                -- Git 相关
        { "<leader>b",  group = "Buffer" },             -- Buffer 操作
        { "<leader>w",  group = "Window" },             -- 窗口操作
        { "<leader>l",  group = "LSP" },                -- LSP 相关
      })
    end,
  },
}
