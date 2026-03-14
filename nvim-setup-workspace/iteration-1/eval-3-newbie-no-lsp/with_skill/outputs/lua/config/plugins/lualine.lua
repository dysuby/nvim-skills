-- lua/config/plugins/lualine.lua
-- 底部状态栏：显示当前模式、文件名、Git 分支等信息
-- theme = "auto" 会自动匹配 Catppuccin 的颜色，保持风格统一

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",  -- 延迟加载，不影响启动速度
    opts = {
      options = {
        theme = "auto",  -- 自动匹配当前配色方案（catppuccin）
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },                         -- 当前模式（NORMAL / INSERT 等）
        lualine_b = { "branch", "diff", "diagnostics" },-- Git 分支、修改统计
        lualine_c = { { "filename", path = 1 } },       -- 文件名（path = 1 显示相对路径）
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },                     -- 文件进度百分比
        lualine_z = { "location" },                     -- 行号:列号
      },
    },
  },
}
