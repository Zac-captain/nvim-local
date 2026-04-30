-- lua/plugins/highlight.lua
-- 目的：在不换主题的情况下，把 Go 的语义高亮拉开层次
-- 原理：覆盖一些 Treesitter 的高亮组（@xxx）和 LSP 语义组，让关键结构更醒目
-- 注意：这是“主题补丁”，主题更新不受影响，维护成本低

-- local M = {}

-- function M.setup()
--   -- 每次 colorscheme 切换都重新应用（避免被主题覆盖）
--   vim.api.nvim_create_autocmd("ColorScheme", {
--     callback = function()
--       -- 关键字/类型/函数更突出
--       vim.api.nvim_set_hl(0, "@keyword", { bold = true })
--       vim.api.nvim_set_hl(0, "@keyword.function", { bold = true })
--       vim.api.nvim_set_hl(0, "@type", { bold = true })
--       vim.api.nvim_set_hl(0, "@type.builtin", { bold = true })
--       vim.api.nvim_set_hl(0, "@function", { bold = true })
--       vim.api.nvim_set_hl(0, "@method", { bold = true })
--
--       -- 字符串、数字更清晰
--       vim.api.nvim_set_hl(0, "@string", {})
--       vim.api.nvim_set_hl(0, "@number", { bold = true })
--
--       -- 注释更“退后”，代码更凸显（你有中文注释也会更舒服）
--       vim.api.nvim_set_hl(0, "@comment", { italic = true })
--     end,
--     desc = "Enhance Treesitter highlights for Go (theme patch)",
--   })
-- end
--
-- return M


-- lua/plugins/highlight.lua
return {
  "nvim-lua/plenary.nvim", -- 载体（telescope 也依赖它，基本你已装）
  name = "local-highlight",
  event = { "VimEnter", "ColorScheme" },
  config = function()
    local function apply()
      -- ✅ 更暗、更工程：用“粗体”表达结构，用“低饱和”表达区分

      -- 普通文本兜底
      vim.api.nvim_set_hl(0, "Normal", { fg = "#c8d3f5" })

      -- 函数：靠粗体，不靠刺眼亮蓝
      vim.api.nvim_set_hl(0, "Function", { fg = "#b4c2f0", bold = true })

      -- 关键字：降紫，仍然能一眼扫到 if/for/return
      vim.api.nvim_set_hl(0, "Keyword", { fg = "#a9a1e1", bold = true })

      -- 类型：不加粗，避免满屏“亮青”
      vim.api.nvim_set_hl(0, "Type", { fg = "#89b4fa", bold = false })

      -- 字符串：把绿压下来（原来太亮）
      vim.api.nvim_set_hl(0, "String", { fg = "#9bbf7a" })

      -- 注释：退后但可读
      vim.api.nvim_set_hl(0, "Comment", { fg = "#4f5675", italic = false })

      -- 常量/数字：不抢字符串
      vim.api.nvim_set_hl(0, "Number", { fg = "#e0af68" })
      vim.api.nvim_set_hl(0, "Boolean", { fg = "#e0af68" })
      vim.api.nvim_set_hl(0, "Constant", { fg = "#e0af68" })

      -- Diagnostics：错误是唯一允许“亮”的东西
      vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#f7768e", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#e0af68", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#7aa2f7" })
      vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#9bbf7a" })

      -- 下划线提示（轻量，不刺眼）
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#f7768e" })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#e0af68" })
    end

    apply()

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        apply()
      end,
    })
  end,
}

