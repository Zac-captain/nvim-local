-- lua/core/autocmds.lua
-- 自动命令集中管理：避免散落在各文件里找不到。

local aug = vim.api.nvim_create_augroup("ZacNvimCore", { clear = true })

-- 高亮复制：提升“我到底复制了什么”的可见性
vim.api.nvim_create_autocmd("TextYankPost", {
  group = aug,
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
  desc = "复制后短暂高亮",
})

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.schedule(function()
      -- 空启动时（alpha 页面）不打开 neo-tree
      if vim.bo.filetype == "alpha" then return end
      vim.cmd("Neotree filesystem reveal left")
    end)
  end,
})

