-- lua/config/plugins/indent-blankline.lua
-- 缩进参考线：在代码缩进处画一条竖线，帮你看清代码层级
-- 写 Python 的时候特别有用，因为 Python 靠缩进区分代码块

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main  = "ibl",  -- 新版 API 的入口模块名
    event = { "BufReadPost", "BufNewFile" },
    opts  = {
      indent = {
        char     = "│",  -- 缩进参考线的字符（需要 Nerd Font 或 Unicode 支持）
        tab_char = "│",
      },
      scope = {
        enabled    = true,  -- 高亮当前作用域的缩进线（需要 treesitter）
        show_start = true,  -- 在作用域开始处显示下划线
        show_end   = false, -- 不在作用域结束处显示（视觉上更干净）
      },
      -- 这些特殊文件类型不显示缩进线（避免干扰）
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
      },
    },
  },
}
