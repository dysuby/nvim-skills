-- init.lua
-- Entry point: load options, keymaps, then bootstrap lazy.nvim

require("options")
require("keymaps")
require("lazy-bootstrap")   -- maps to lua/lazy-bootstrap.lua
