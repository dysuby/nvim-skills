-- lua/config/plugins/neo-tree.lua
-- 文件树浏览器：就像 VS Code 左边的文件树
-- 按 <Space>e 可以打开/关闭

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",        -- 工具函数库（很多插件都依赖它）
      "nvim-tree/nvim-web-devicons",  -- 文件图标（需要 Nerd Font）
      "MunifTanjim/nui.nvim",         -- UI 组件库
    },
    cmd = "Neotree",  -- 只在执行 :Neotree 命令时加载（懒加载，加快启动速度）
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },  -- 自动展开并定位当前编辑的文件
        hijack_netrw_behavior = "open_default",    -- 替代默认的文件浏览器 netrw
        filtered_items = {
          visible = true,      -- 显示隐藏文件（可见但变暗）
          hide_dotfiles = false,  -- 不隐藏 .开头的文件（比如 .gitignore）
          hide_gitignored = false,
        },
      },
      window = {
        width = 30,  -- 文件树宽度（列数）
        mappings = {
          ["<space>"] = "none",  -- 避免与 leader 键冲突
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,   -- 显示折叠/展开箭头
        },
        git_status = {
          symbols = {
            added     = "✚",
            modified  = "",
            deleted   = "✖",
            renamed   = "󰁕",
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          },
        },
      },
    },
  },
}
