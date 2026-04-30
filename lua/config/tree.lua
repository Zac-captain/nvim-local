-- lua/plugins/tree.lua
-- 作用：
--  提供一个稳定、可控的工程目录树
--  不抢键位，不搞花活

local M = {}

function M.setup()
  require("nvim-tree").setup({
    view = {
      width = 30,
      side = "left",
    },
    renderer = {
      highlight_git = true,
      icons = {
        show = {
          git = true,
          folder = true,
          file = true,
        },
      },
    },
    filters = {
      dotfiles = false,
    },
    git = {
      enable = true,
      ignore = false,
    },
  })
end

return M

