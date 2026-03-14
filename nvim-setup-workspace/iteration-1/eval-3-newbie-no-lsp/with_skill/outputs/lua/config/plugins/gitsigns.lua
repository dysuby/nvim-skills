-- lua/config/plugins/gitsigns.lua
-- Git 集成：在行号旁边显示彩色竖线，表示 Git 改动状态
-- 绿色竖线 = 新增行，橙色竖线 = 修改行，红色符号 = 删除行

return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "│" },   -- 新增行
        change       = { text = "│" },   -- 修改行
        delete       = { text = "󰍵" },   -- 删除行
        topdelete    = { text = "‾" },   -- 删除（顶部）
        changedelete = { text = "~" },   -- 修改后删除
        untracked    = { text = "│" },   -- 未追踪的新文件
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end
        -- Git hunk 操作（hunk = 一段连续的改动）
        map("n", "<leader>hs", gs.stage_hunk,   "Stage hunk")    -- 暂存这段改动
        map("n", "<leader>hr", gs.reset_hunk,   "Reset hunk")    -- 撤销这段改动
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")  -- 预览改动内容
        map("n", "<leader>hb", gs.blame_line,   "Blame line")    -- 查看这行最后由谁修改
        map("n", "<leader>hd", gs.diffthis,     "Diff this")     -- 对比当前文件的改动
      end,
    },
  },
}
