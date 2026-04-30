-- lua/plugins/whichkey.lua
-- 作用：快捷键提示面板（像“菜单”一样）
-- 你的需求：
--   1) <leader> 仍然是 ","（不改你现有所有 <leader>xx 映射）
--   2) which-key 不要在按 "," 时自动弹出
--   3) 只有按 ",," 才弹出 which-key，并展示所有以 "," 开头的快捷键

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    -- UI/交互配置：这里只放 which-key 的配置字段
    wk.setup({
      preset = "modern",

      -- 这里给一个较大的延迟，避免你按单个 "," 时误弹
      -- 真正需要菜单你用 ",," 直接弹，不靠 delay
      delay = 800,

      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
      win = {
        border = "rounded",
        padding = { 1, 1, 1, 1 },
      },
      show_help = false,
      show_keys = true,
    })

    -- ========== 关键：让按键等待机制可用 ==========
    -- timeout/timeoutlen 属于 Vim 全局输入机制，不是 which-key 配置字段
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    -- ========== 关键：手动触发 which-key ==========
    -- ",,"：弹出以 "," 为前缀的所有映射（也就是你的 <leader> 体系）
    vim.keymap.set("n", ",,", function()
      wk.show(",")
    end, { noremap = true, silent = true, desc = "快捷键：打开菜单（which-key）" })

    -- ========== 分组标题（菜单里的分类） ==========
    wk.add({
      { "<leader>f", group = "+搜索" },     -- Telescope
      { "<leader>b", group = "+缓冲区" },   -- buffers
      { "<leader>l", group = "+LSP" },      -- LSP（你后面可以逐步归类到 ,l*）
      { "<leader>g", group = "+Git" },      -- gitsigns
      { "<leader>d", group = "+诊断" },     -- diagnostics
      { "<leader>t", group = "+文件树" },   -- nvim-tree（如果你后面愿意改成 ,t*）
      { "<leader>t", group = "+测试" },
      { "<leader>c", group = "+当前文件的位置" },
    })
  end,
}

