-- lua/config/plugins/comment.lua
-- 快速注释/取消注释代码
--
-- 常用快捷键：
--   gcc         → 注释/取消注释当前行
--   gc{motion}  → 注释一段范围，比如 gc3j 注释往下 3 行
--   gcb         → 块注释（/* ... */）
--   Visual 模式下选中后 gc → 注释选中的内容
--
-- 对 Python 自动用 #，对 Lua 自动用 --，对 HTML 用 <!-- -->

return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- 这个插件帮助 Comment.nvim 在 JSX/TSX 等混合语言文件里
      -- 选择正确的注释符号（对纯 Python 来说不是必须，但有备无患）
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- 先初始化 ts-context-commentstring（关闭自动命令模式，由 Comment.nvim 调用）
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })

      require("Comment").setup({
        -- 让 Comment.nvim 通过 treesitter 判断当前位置应该用什么注释符号
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
}
