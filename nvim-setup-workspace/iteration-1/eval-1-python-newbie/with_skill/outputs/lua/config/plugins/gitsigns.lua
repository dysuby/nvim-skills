-- lua/config/plugins/gitsigns.lua
-- Git 变更标记：在行号旁边显示彩色竖线
--   绿色竖线 → 新增的行
--   橙色竖线 → 修改过的行
--   红色符号 → 删除的行
--
-- 常用快捷键：
--   <Space>hs → 暂存当前 hunk（像 git add 一部分）
--   <Space>hr → 撤销当前 hunk 的修改
--   <Space>hp → 预览当前 hunk 的改动
--   <Space>hb → 显示当前行的 git blame（谁、什么时候改的）
--   <Space>hd → 查看当前文件与 HEAD 的 diff

return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },  -- 打开文件时加载
    opts = {
      -- 各种 git 状态的符号样式
      signs = {
        add          = { text = "│" },   -- 新增行
        change       = { text = "│" },   -- 修改行
        delete       = { text = "󰍵" },   -- 删除行（下方）
        topdelete    = { text = "‾" },   -- 删除行（上方）
        changedelete = { text = "~" },   -- 修改后删除
        untracked    = { text = "│" },   -- 未追踪的新文件
      },
      -- 每次 gitsigns 附加到 buffer 时设置快捷键
      on_attach = function(bufnr)
        local gs  = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- hunk 操作（hunk = 一段连续的改动）
        map("n", "<leader>hs", gs.stage_hunk,   "Git: Stage hunk")    -- 暂存这段改动
        map("n", "<leader>hr", gs.reset_hunk,   "Git: Reset hunk")    -- 撤销这段改动
        map("n", "<leader>hp", gs.preview_hunk, "Git: Preview hunk")  -- 预览这段改动
        map("n", "<leader>hb", gs.blame_line,   "Git: Blame line")    -- 查看这行的 blame
        map("n", "<leader>hd", gs.diffthis,     "Git: Diff this")     -- 对比当前文件与 HEAD

        -- 跳转到上/下一个 hunk
        map("n", "]h", function() gs.next_hunk() end, "Git: Next hunk")
        map("n", "[h", function() gs.prev_hunk() end, "Git: Prev hunk")
      end,
    },
  },
}
