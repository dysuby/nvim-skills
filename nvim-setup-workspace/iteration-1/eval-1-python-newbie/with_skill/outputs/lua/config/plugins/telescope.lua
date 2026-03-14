-- lua/config/plugins/telescope.lua
-- 全局搜索神器：搜文件名、文件内容、历史记录等
-- 类似 VS Code 的 Ctrl+P，但功能更强大

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- fzf 原生扩展：大幅提升搜索速度（需要 make 构建，首次安装会编译）
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find files" },           -- 搜文件名
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Live grep" },            -- 搜文件内容
      { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Buffers" },              -- 切换已打开的文件
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Help tags" },            -- 搜帮助文档
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",    desc = "Recent files" },         -- 最近打开的文件
      { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" }, -- 在当前文件内搜索
    },
    opts = {
      defaults = {
        prompt_prefix = " ",   -- 搜索框前缀图标（需要 Nerd Font）
        selection_caret = " ", -- 选中项的箭头图标
        -- 搜索时忽略这些目录（提升性能）
        file_ignore_patterns = { "node_modules", ".git/", "__pycache__", "*.pyc", ".venv" },
        layout_config = {
          horizontal = {
            preview_width = 0.55,  -- 预览窗口占 55% 宽度
          },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")  -- 加载 fzf 加速扩展
    end,
  },
}
