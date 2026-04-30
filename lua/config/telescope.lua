-- lua/plugins/telescope.lua
-- 作用：
--  1) 提供工程级文件/内容/符号搜索（Telescope）
--  2) 在 Telescope 弹窗里，使用你指定的按键习惯：
--     - Ctrl+J / Ctrl+K：上下选择候选项
--     - Ctrl+V：垂直分屏打开
--     - Ctrl+S：水平分屏打开（注意：某些终端会拦截 Ctrl+S，见下方备注）
--  3) 不“清空”Telescope 默认映射：只覆盖你关心的这几个键，其他保持默认

local M = {}

function M.setup()
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({
    defaults = {
      -- 提示符与选中标记（纯 UI，不影响功能）
      prompt_prefix = "🔍 ",
      selection_caret = "➤ ",

      -- 忽略无关目录：提升搜索质量与性能
      file_ignore_patterns = {
        "node_modules",
        ".git/",
        "dist",
        "vendor",
      },

      mappings = {
        -- i = insert mode（你在 Telescope 里输入时就是这个模式）
        i = {
          -- 退出（你按 Esc 立刻关掉弹窗）
          ["<Esc>"] = actions.close,

          -- 你指定的：上下选择
          -- 说明：这会覆盖 Telescope 默认的 <C-j>/<C-k> 行为为“选择上下项”
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          -- 你指定的：分屏打开
          -- Ctrl+V：垂直分屏
          ["<C-v>"] = actions.select_vertical,
        },

        -- n = normal mode（你在 Telescope 里按 Esc 进入 normal 后生效）
        -- 可选：也给 normal 模式配一份一致的体验
        n = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-v>"] = actions.select_vertical,
          ["<C-s>"] = actions.select_horizontal,
          ["q"] = actions.close, -- normal 模式下按 q 退出
        },
      },
    },
  })
end

return M

