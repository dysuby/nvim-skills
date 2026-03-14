-- lua/config/plugins/bufferline.lua
-- 顶部 buffer 标签栏：像浏览器标签页一样显示打开的文件
--
-- 常用快捷键：
--   <S-h>（Shift+h）  → 切换到上一个 buffer
--   <S-l>（Shift+l）  → 切换到下一个 buffer
--   <Space>bd         → 关闭当前 buffer
--   <Space>bo         → 关闭其他所有 buffer（只保留当前）
--   可以用鼠标直接点击标签切换！

return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
      { "<S-h>",       "<cmd>BufferLineCyclePrev<cr>",    desc = "Prev buffer" },
      { "<S-l>",       "<cmd>BufferLineCycleNext<cr>",    desc = "Next buffer" },
      { "<leader>bd",  "<cmd>bdelete<cr>",                desc = "Close buffer" },
      { "<leader>bo",  "<cmd>BufferLineCloseOthers<cr>",  desc = "Close other buffers" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",         -- 在标签上显示 LSP 错误/警告图标
        show_buffer_close_icons = true,   -- 显示每个 buffer 的关闭按钮
        show_close_icon = false,          -- 不显示右上角全局关闭按钮
        separator_style = "slant",        -- 分隔符样式：slant（斜线）/ slope / thick / thin
        always_show_bufferline = true,    -- 只有一个文件时也显示标签栏

        -- 配合 neo-tree：文件树打开时，标签栏往右偏移，不遮住文件树
        offsets = {
          {
            filetype  = "neo-tree",
            text      = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}
