-- lua/plugins/format.lua
-- 格式化配置：
-- 目标：保存时自动执行 gofumpt + goimports。
-- 为什么选 conform：它专注格式化，配置简单，问题定位也比“全家桶式”的方案更清楚。

local M = {}

function M.setup()
  require("conform").setup({
    -- 保存自动格式化
    format_on_save = {
      timeout_ms = 1500,  -- 防止卡住编辑器
      lsp_fallback = true -- 如果没有外部 formatter，就退回 LSP 的 formatting
    },

    -- 不同文件类型用不同 formatter
    formatters_by_ft = {
      go = { "gofumpt", "goimports" },
      -- 解释：gofumpt 管风格，goimports 管 import（排序/删除未用/自动添加）
    },
  })

  -- 你也可以手动触发格式化
  vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_fallback = true })
  end, { desc = "手动格式化当前文件" })
end

return M

