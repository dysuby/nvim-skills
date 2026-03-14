-- lua/config/lazy.lua
-- 插件管理器 lazy.nvim 的引导代码
-- lazy.nvim 就像是 Neovim 的"应用商店"，帮你自动安装和更新插件

-- 第一步：检查 lazy.nvim 是否已经安装，没有就自动从 GitHub 克隆
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

-- 第二步：配置 lazy.nvim
-- spec 告诉 lazy 去 lua/config/plugins/ 目录下找所有插件配置文件
require("lazy").setup({
  spec = {
    { import = "config.plugins" },  -- 自动加载 lua/config/plugins/ 下所有文件
  },
  checker = { enabled = true },  -- 自动检查插件更新（启动时会提示）
  change_detection = {
    notify = false,  -- 配置文件改变时不弹出通知（避免干扰）
  },
})
