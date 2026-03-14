-- lua/config/lazy.lua
-- 插件管理器 lazy.nvim 的启动引导代码
-- 第一次打开 Neovim 时会自动从 GitHub 下载 lazy.nvim，然后安装你选择的插件

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit...", "ErrorMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- 自动加载 lua/config/plugins/ 目录下的所有插件文件
    { import = "config.plugins" },
  },
  checker = { enabled = true },  -- 自动检查插件更新，有更新时右下角会提示
})
