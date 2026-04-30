-- lua/plugins/go_highlight.lua
-- 目的：在不破坏 TokyoNight Storm 气质的前提下
--      强化 Go 的“工程语义可读性”

-- local M = {}
--
-- function M.setup()
--   -- ========== Treesitter 语义层 ==========
--   local set = vim.api.nvim_set_hl
--
--   -- 类型 / struct / interface
--   set(0, "@type.go",              { fg = "#7aa2f7", bold = true })
--   set(0, "@type.definition.go",   { fg = "#7aa2f7", bold = true })
--
--   -- struct 字段
--   set(0, "@field.go",             { fg = "#c0caf5" })
--
--   -- 函数定义
--   set(0, "@function.definition.go", { fg = "#7dcfff", bold = true })
--
--   -- 函数调用
--   set(0, "@function.call.go",     { fg = "#73daca" })
--
--   -- 方法调用 obj.Method()
--   set(0, "@method.call.go",       { fg = "#73daca" })
--
--   -- 参数
--   set(0, "@parameter.go",         { fg = "#e0af68" })
--
--   -- 常量 / 枚举感
--   set(0, "@constant.go",          { fg = "#ff9e64", bold = true })
--
--   -- 注释里的 TODO / FIXME
--   set(0, "@comment.todo",         { fg = "#ff9e64", bold = true })
-- end
--
-- return M
-- lua/plugins/go_highlight.lua
return {
  "nvim-lua/plenary.nvim",
  name = "local-go-highlight",
  ft = "go",
  config = function()
    local function apply_go()
      -- Go 控制流：只用粗体（不再额外上色太亮）
      vim.api.nvim_set_hl(0, "Statement", { bold = true })
      vim.api.nvim_set_hl(0, "Conditional", { bold = true })
      vim.api.nvim_set_hl(0, "Repeat", { bold = true })

      -- struct/interface/type：轻蓝，不抢戏
      vim.api.nvim_set_hl(0, "Structure", { fg = "#89b4fa", bold = false })
      vim.api.nvim_set_hl(0, "Typedef", { fg = "#89b4fa", bold = false })

      -- err：工程关键点，给一颗红钉子
      vim.api.nvim_set_hl(0, "GoErr", { fg = "#f7768e", bold = true })
    end

    apply_go()

    -- 仅在 go buffer 对 err 做词边界高亮
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      pattern = "*.go",
      callback = function()
        apply_go()
        pcall(vim.fn.matchdelete, vim.b._go_err_match_id or -1)
        vim.b._go_err_match_id = vim.fn.matchadd("GoErr", [[\<err\>]])
      end,
    })

    -- 切主题后重打（避免被 colorscheme 冲掉）
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = apply_go,
    })
  end,
}

