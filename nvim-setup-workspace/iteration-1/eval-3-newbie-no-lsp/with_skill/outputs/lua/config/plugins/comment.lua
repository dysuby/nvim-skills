-- lua/config/plugins/comment.lua
-- 快速注释/取消注释代码
-- 内置快捷键（不需要额外配置）：
--   gcc  → 注释/取消注释当前行
--   gc3j → 注释当前行和下面 3 行（gc + 移动命令）
--   gcb  → 块注释
--   gc   → Visual 模式下注释选中内容

return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- ts-context-commentstring 让注释符号根据语言自动切换
      -- 比如在 Vue 文件的 HTML 部分用 <!-- -->，在 JS 部分用 //
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
}
