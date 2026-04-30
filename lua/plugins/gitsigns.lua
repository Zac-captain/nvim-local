-- lua/plugins/gitsigns.lua
-- 作用：在编辑区行号旁边显示 Git 变更（新增/修改/删除）
-- 你会得到：
--   1) 行号旁边的标记（改没改一眼看出）
--   2) 查看某一行的 blame（是谁改的）
--   3) 预览当前 hunk（这一段 diff）
--   4) 快速 stage/reset 当前 hunk（不离开编辑器）
-- 为什么要装：
--   写 Go 项目时，边写边看 diff 是最高频动作之一，比来回切 git 工具快得多

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- 打开文件时加载（不拖慢启动）
  config = function()
  local gs = require("gitsigns")

  gs.setup({
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    current_line_blame = false,
    preview_config = { border = "rounded", style = "minimal", relative = "cursor", row = 0, col = 1 },
    update_debounce = 120,

    -- 关键：在这里绑定快捷键（插件加载完成后才会执行，避免 nil）
    on_attach = function(bufnr)
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- hunk 跳转
      map("n", "]h", gs.next_hunk, vim.tbl_extend("force", opts, { desc = "Git：下一个变更块" }))
      map("n", "[h", gs.prev_hunk, vim.tbl_extend("force", opts, { desc = "Git：上一个变更块" }))

      -- hunk 操作
      map("n", "<leader>gp", gs.preview_hunk, vim.tbl_extend("force", opts, { desc = "Git：预览当前变更块" }))
      map("n", "<leader>gs", gs.stage_hunk,   vim.tbl_extend("force", opts, { desc = "Git：暂存当前变更块" }))
      map("n", "<leader>gS", gs.stage_buffer, vim.tbl_extend("force", opts, { desc = "Git：暂存整个文件" }))
      map("n", "<leader>gR", gs.reset_hunk,   vim.tbl_extend("force", opts, { desc = "Git：撤销当前变更块" }))
      map("n", "<leader>gu", gs.undo_stage_hunk, vim.tbl_extend("force", opts, { desc = "Git：撤销暂存变更块" }))

      -- blame
      map("n", "<leader>gb", gs.blame_line, vim.tbl_extend("force", opts, { desc = "Git：查看当前行作者" }))
      map("n", "<leader>gB", gs.toggle_current_line_blame,
        vim.tbl_extend("force", opts, { desc = "Git：切换行尾作者信息" }))
    end,
  })
end

}
