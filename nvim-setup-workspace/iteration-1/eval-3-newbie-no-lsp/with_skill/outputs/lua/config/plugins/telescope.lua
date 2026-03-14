-- lua/config/plugins/telescope.lua
-- 模糊搜索神器：搜文件名、文件内容、最近打开的文件
-- 类似 VS Code 的 Ctrl+P，但功能更强大

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- fzf-native 用 C 编写，让搜索速度更快
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      -- 注意：find files 改为 Ctrl+P，更贴近 VS Code 习惯
      { "<C-p>",      "<cmd>Telescope find_files<cr>",  desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",    desc = "Recent files" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",   -- 搜索框前缀图标（需要 Nerd Font）
        selection_caret = " ", -- 选中项的图标
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")  -- 加载 fzf 扩展以提升搜索速度
    end,
  },
}
