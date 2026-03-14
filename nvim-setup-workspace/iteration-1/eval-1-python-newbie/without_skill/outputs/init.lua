-- init.lua
-- Entry point for Neovim configuration

-- Load core options first
require("config.options")

-- Load lazy.nvim plugin manager and all plugins
require("config.lazy")

-- Load keymaps after plugins are set up
require("config.keymaps")
