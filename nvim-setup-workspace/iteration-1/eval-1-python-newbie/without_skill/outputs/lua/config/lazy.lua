-- lua/config/lazy.lua
-- Bootstrap and configure lazy.nvim (plugin manager)

-- Set leader key BEFORE lazy loads plugins so mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================
-- Bootstrap lazy.nvim (auto-install if not present)
-- ============================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================
-- Load plugins
-- ============================================================
require("lazy").setup({
  -- Load each plugin spec from its own file under lua/config/plugins/
  { import = "config.plugins" },
}, {
  -- lazy.nvim options
  ui = {
    border = "rounded",
  },
  checker = {
    enabled = true,   -- Automatically check for plugin updates
    notify = false,   -- Don't notify on every startup
  },
  change_detection = {
    notify = false,
  },
})
