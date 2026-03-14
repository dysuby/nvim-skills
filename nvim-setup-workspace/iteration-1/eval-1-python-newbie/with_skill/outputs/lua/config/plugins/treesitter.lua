-- lua/config/plugins/treesitter.lua
-- 语法高亮和代码结构理解
-- Treesitter 不只是关键词匹配，它真正"解析"代码的语法树，让高亮更准确

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",  -- 安装/更新时自动更新语言解析器
    event = { "BufReadPost", "BufNewFile" },  -- 打开文件时才加载（懒加载）
    opts = {
      -- 自动安装以下语言的语法解析器
      ensure_installed = {
        "python",    -- 主要语言：Python
        "markdown",  -- Markdown 文档
        "lua",       -- Neovim 配置语言（必装）
        "vim",       -- Vim 脚本
        "vimdoc",    -- Vim 帮助文档格式
        "query",     -- Treesitter 查询语言（调试用）
        "bash",      -- Shell 脚本
        "json",      -- JSON 配置文件
        "yaml",      -- YAML 配置文件
        "toml",      -- TOML 配置文件（Python pyproject.toml 等）
      },
      highlight = {
        enable = true,   -- 开启语法高亮
      },
      indent = {
        enable = true,   -- 基于语法树的智能缩进
      },
      auto_install = true,  -- 遇到新语言文件时自动安装对应解析器
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
