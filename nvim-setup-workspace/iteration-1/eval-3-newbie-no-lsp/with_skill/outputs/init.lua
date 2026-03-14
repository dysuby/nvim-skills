-- ~/.config/nvim/init.lua
-- 入口文件：加载所有配置模块

require("config.options")   -- 基础设置
require("config.keymaps")   -- 全局快捷键
require("config.lazy")      -- 插件管理器 + 插件
