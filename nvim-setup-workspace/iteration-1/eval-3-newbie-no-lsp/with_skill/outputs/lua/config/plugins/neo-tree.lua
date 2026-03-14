-- lua/config/plugins/neo-tree.lua
-- 文件树：就像 VS Code 左边的文件树，可以浏览、打开、创建文件
-- 按 <leader>e（即空格 + e）切换显示/隐藏

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",       -- 通用工具库，很多插件都依赖它
      "nvim-tree/nvim-web-devicons", -- 文件图标（需要 Nerd Font）
      "MunifTanjim/nui.nvim",        -- UI 组件库
    },
    cmd = "Neotree",  -- 只在使用 Neotree 命令时加载，节省启动时间
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },      -- 打开文件时自动定位到文件树中的位置
        hijack_netrw_behavior = "open_default",        -- 替换 Neovim 默认的文件浏览器
      },
      window = {
        width = 30,  -- 文件树宽度（字符数）
      },
    },
  },
}
