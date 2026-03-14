-- lua/config/plugins/toggleterm.lua
-- 在 Neovim 内部打开终端，不用切换窗口
-- 按 <C-\>（Ctrl + 反斜杠）打开/关闭终端

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
    opts = {
      size = 15,                    -- 终端窗口高度（horizontal 方向）
      open_mapping = [[<C-\>]],     -- 打开/关闭快捷键
      direction = "horizontal",     -- 终端方向：horizontal / vertical / float / tab
      shade_terminals = true,       -- 终端背景略微变暗，与编辑区有区分
      shading_factor = 2,           -- 变暗程度
      close_on_exit = true,         -- 进程退出后自动关闭终端窗口
      float_opts = {
        border = "curved",          -- float 模式下的圆角边框
        width  = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
      },
      -- 在终端模式下，用 <Esc><Esc> 回到 normal 模式
      -- （单个 Esc 在 terminal 里有其他用途，比如取消操作）
      on_create = function(term)
        vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {
          buffer = term.bufnr,
          desc   = "Exit terminal mode",
        })
      end,
    },
  },
}
