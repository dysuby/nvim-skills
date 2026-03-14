-- lua/config/plugins/autopairs.lua
-- 自动配对括号：输入 ( 自动补全 )，输入 { 自动补全 }，输入 " 自动补全 "
-- 省去手动输入右括号的麻烦，写代码更流畅

return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",  -- 进入 insert 模式时加载
    opts = {
      check_ts = true,  -- 使用 treesitter 智能判断（比如字符串内不自动配对）
    },
    config = function(_, opts)
      local autopairs = require("nvim-autopairs")
      autopairs.setup(opts)

      -- 与 nvim-cmp 集成：当你从补全菜单选择函数时，自动在后面加括号
      -- 比如选择 print，会自动变成 print()，光标在括号内
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp           = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
