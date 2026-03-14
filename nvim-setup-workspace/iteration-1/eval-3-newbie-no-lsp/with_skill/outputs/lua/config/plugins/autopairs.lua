-- lua/config/plugins/autopairs.lua
-- 自动括号配对：输入 ( 自动补全 )，输入 { 自动补全 }，输入 [ 自动补全 ]
-- 还支持引号配对：输入 " 自动补全 "，输入 ' 自动补全 '

return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",  -- 只在进入 Insert 模式时加载
    opts = {
      check_ts = true,  -- 使用 treesitter 来更智能地判断是否需要补全括号
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      -- 注意：这个配置不需要与 cmp 集成，因为我们没有安装 nvim-cmp
    end,
  },
}
