-- lua/config/plugins/lualine.lua
-- 底部状态栏：显示当前模式、文件名、Git 分支、错误数量等信息

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },  -- 文件类型图标
    event = "VeryLazy",  -- 延迟加载，不影响启动速度
    opts = {
      options = {
        theme = "catppuccin",  -- 主题与 Catppuccin 配色方案保持一致
        component_separators = { left = "", right = "" },  -- 组件之间的分隔符
        section_separators   = { left = "", right = "" },  -- 区块之间的分隔符（斜线）
        globalstatus = true,  -- 使用单一全局状态栏（多窗口时只有一个状态栏）
      },
      sections = {
        -- 左侧第一区：当前模式（NORMAL / INSERT / VISUAL 等）
        lualine_a = { "mode" },
        -- 左侧第二区：Git 分支名、改动统计、诊断错误/警告数
        lualine_b = { "branch", "diff", "diagnostics" },
        -- 中间：文件路径（path=1 显示相对路径）
        lualine_c = { { "filename", path = 1 } },
        -- 右侧：编码格式、换行符类型、文件类型
        lualine_x = { "encoding", "fileformat", "filetype" },
        -- 右侧：当前位置百分比
        lualine_y = { "progress" },
        -- 最右侧：行号:列号
        lualine_z = { "location" },
      },
    },
  },
}
