-- lua/config/plugins/lsp.lua
-- LSP（Language Server Protocol）：让 Neovim 真正"懂"你的代码
--
-- LSP 能做到：
--   · 自动补全：输入几个字母，给你提示
--   · 悬停文档：光标放在函数上，显示文档说明（按 K）
--   · 跳转定义：一键跳到函数定义的地方（按 gd）
--   · 错误提示：代码写错了，实时红线提示
--   · 重命名：一次改变量名，所有地方同步更新（<Space>rn）
--
-- 三个组件配合工作：
--   mason.nvim        → 帮你安装 language server（像 homebrew 一样）
--   mason-lspconfig   → 让 mason 和 lspconfig 无缝协作
--   nvim-lspconfig    → 配置各个 language server 的行为

return {
  -- ── Mason：LSP server 安装管理器 ──────────────────────────────
  {
    "williamboman/mason.nvim",
    cmd = "Mason",  -- 输入 :Mason 打开图形界面，可以手动安装/卸载 server
    opts = {
      ui = {
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- ── Mason-lspconfig：桥接层 ────────────────────────────────────
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- 自动安装以下 language server
      ensure_installed = {
        "pyright",  -- Python：提供类型检查、自动补全、跳转定义等
        "lua_ls",   -- Lua：用于编辑 Neovim 配置文件
      },
      automatic_installation = true,  -- 遇到未安装的自动安装
    },
  },

  -- ── nvim-lspconfig：配置 language server 的行为 ───────────────
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      -- 把 nvim-cmp 的补全能力告诉 LSP server，让补全菜单更丰富
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- ── 通用快捷键：每次 LSP 附加到 buffer 时都会设置 ────────
      local on_attach = function(_, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        map("gd",          vim.lsp.buf.definition,      "Go to definition")       -- 跳转到定义
        map("gr",          vim.lsp.buf.references,       "Find references")        -- 查找所有引用
        map("K",           vim.lsp.buf.hover,            "Hover documentation")    -- 显示悬停文档
        map("<leader>rn",  vim.lsp.buf.rename,           "Rename symbol")          -- 重命名变量/函数
        map("<leader>ca",  vim.lsp.buf.code_action,      "Code action")            -- 代码操作（快速修复等）
        map("[d",          vim.diagnostic.goto_prev,     "Previous diagnostic")    -- 跳到上一个错误/警告
        map("]d",          vim.diagnostic.goto_next,     "Next diagnostic")        -- 跳到下一个错误/警告
        map("<leader>d",   vim.diagnostic.open_float,    "Show diagnostic")        -- 在浮动窗口显示当前行诊断
      end

      -- ── 让 mason-lspconfig 自动配置所有已安装的 server ───────
      require("mason-lspconfig").setup_handlers({
        -- 默认处理函数：适用于所有 server
        function(server_name)
          lspconfig[server_name].setup({
            on_attach    = on_attach,
            capabilities = capabilities,
          })
        end,

        -- Python：pyright 特殊配置
        ["pyright"] = function()
          lspconfig.pyright.setup({
            on_attach    = on_attach,
            capabilities = capabilities,
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = "basic",  -- 类型检查强度：off / basic / strict
                  autoSearchPaths  = true,
                  useLibraryCodeForTypes = true,
                },
              },
            },
          })
        end,

        -- Lua：lua_ls 特殊配置（主要是让它认识 vim 全局变量）
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            on_attach    = on_attach,
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime  = { version = "LuaJIT" },
                workspace = {
                  checkThirdParty = false,
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                diagnostics = {
                  globals = { "vim" },  -- 让 lua_ls 知道 vim 是全局变量，不报错
                },
                telemetry = { enable = false },
              },
            },
          })
        end,
      })

      -- ── 诊断图标（错误、警告、提示的图标样式）────────────────
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",  -- 错误
            [vim.diagnostic.severity.WARN]  = " ",  -- 警告
            [vim.diagnostic.severity.HINT]  = "󰠠 ", -- 提示
            [vim.diagnostic.severity.INFO]  = " ",  -- 信息
          },
        },
        virtual_text = true,   -- 在行尾显示诊断文字
        update_in_insert = false,  -- insert 模式下不更新诊断（避免打字时闪烁）
        float = {
          border = "rounded",  -- 浮动窗口圆角边框
        },
      })
    end,
  },
}
