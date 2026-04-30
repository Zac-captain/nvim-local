-- lua/plugins/cmp.lua
-- 自动补全配置：
-- 目标：LSP 补全 + 片段补全 + 最小学习成本的按键（Tab/Shift-Tab/Enter）。

local M = {}

function M.setup()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  require("luasnip.loaders.from_vscode").lazy_load()

  cmp.setup({
    snippet = {
      expand = function(args)
        -- LuaSnip 负责“把片段展开成代码”
        luasnip.lsp_expand(args.body)
      end,
    },

    mapping = cmp.mapping.preset.insert({
      -- Ctrl+Space：手动触发补全（不想自动弹窗时很有用）
      ["<C-Space>"] = cmp.mapping.complete(),

      -- Enter：确认补全；select=true 表示默认选中第一项（更像 IDE）
      ["<CR>"] = cmp.mapping.confirm({ select = true }),

      -- Tab：优先选择下一项；其次跳片段；最后才是真正的 Tab
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),

      -- Shift+Tab：反向操作
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),

    sources = {
      { name = "nvim_lsp" }, -- LSP 补全来源（gopls）
      { name = "luasnip" },  -- 片段补全来源
    },
  })
end

return M

