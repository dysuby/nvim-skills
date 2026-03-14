-- lua/config/plugins/colorscheme.lua
-- 配色方案：Catppuccin mocha（最深的暗色版本，柔和的马卡龙色系）
-- 可选 flavour: latte（浅色）, frappe（中暗）, macchiato（暗）, mocha（最暗）

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,  -- 最高优先级，确保在其他插件之前加载
    opts = {
      flavour = "mocha",  -- 使用最深的暗色版本
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
