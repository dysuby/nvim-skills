-- lua/config/plugins/cmp.lua
-- 自动补全菜单：LSP 提供补全数据，nvim-cmp 负责显示漂亮的下拉菜单
--
-- 快捷键（insert 模式下）：
--   <C-Space>  → 手动触发补全
--   <CR>       → 确认选中
--   <Tab>      → 下一个选项 / 跳到下一个代码片段占位符
--   <S-Tab>    → 上一个选项 / 跳回上一个占位符
--   <C-u>      → 向上滚动文档
--   <C-d>      → 向下滚动文档

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",  -- 进入 insert 模式时才加载（懒加载）
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",          -- LSP 补全源（最重要的一个）
      "hrsh7th/cmp-buffer",            -- 当前 buffer 中出现的词语
      "hrsh7th/cmp-path",              -- 文件路径补全（输入路径时很有用）
      "L3MON4D3/LuaSnip",             -- 代码片段引擎
      "saadparwaiz1/cmp_luasnip",      -- LuaSnip → cmp 的桥接
      "rafamadriz/friendly-snippets",  -- 预置的常用代码片段（支持 Python、JS 等）
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      -- 加载 VS Code 风格的代码片段（friendly-snippets 提供的）
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        -- 代码片段展开方式
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- 窗口外观：圆角边框
        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- 快捷键映射
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),          -- 手动触发补全

          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 确认（select=true 自动选第一项）

          -- Tab：下一个选项，或者跳到下一个 snippet 占位符
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()  -- 如果都不满足，执行原本的 Tab 行为
            end
          end, { "i", "s" }),

          -- S-Tab：上一个选项，或者跳回上一个 snippet 占位符
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-u>"] = cmp.mapping.scroll_docs(-4),  -- 向上滚动文档预览
          ["<C-d>"] = cmp.mapping.scroll_docs(4),   -- 向下滚动文档预览
          ["<C-e>"] = cmp.mapping.abort(),           -- 关闭补全菜单
        }),

        -- 补全来源（优先级从上到下）
        sources = cmp.config.sources({
          { name = "nvim_lsp" },  -- LSP 补全（最高优先级）
          { name = "luasnip" },   -- 代码片段
          { name = "buffer" },    -- buffer 中出现的词语
          { name = "path" },      -- 文件路径
        }),

        -- 补全菜单的格式显示
        formatting = {
          format = function(entry, vim_item)
            -- 在补全项右侧显示来源标签，方便区分
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip  = "[Snippet]",
              buffer   = "[Buffer]",
              path     = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })
    end,
  },
}
