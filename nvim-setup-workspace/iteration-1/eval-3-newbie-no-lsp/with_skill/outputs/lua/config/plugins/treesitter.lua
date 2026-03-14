-- lua/config/plugins/treesitter.lua
-- 语法高亮：让代码变得五颜六色，并且真正理解代码结构
-- 不只是关键词匹配，而是解析完整的语法树，高亮更准确

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",  -- 安装/更新时自动编译解析器
    event = { "BufReadPost", "BufNewFile" },  -- 打开文件时才加载，节省启动时间
    opts = {
      -- 安装基础解析器（Lua 配置文件、Vim 脚本、Neovim 帮助文档）
      ensure_installed = { "lua", "vim", "vimdoc" },
      highlight = { enable = true },   -- 开启语法高亮
      indent = { enable = true },      -- 基于语法树的智能缩进
      auto_install = true,             -- 遇到新语言时自动安装对应解析器
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
