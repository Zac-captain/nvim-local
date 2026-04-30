-- lua/plugins/lualine.lua
-- 作用：状态栏（Statusline）
--   1) 当前模式（NORMAL/INSERT...）
--   2) Git 分支、diff（改了多少行）
--   3) LSP 诊断（error/warn/info/hint 计数）
--   4) 文件名、编码、文件类型、位置（行列/进度）

return {
  "nvim-lualine/lualine.nvim",
  -- 图标依赖：
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy", -- 启动后延迟加载，提升启动速度
  config = function()
    require("lualine").setup({
      options = {
        -- 主题：跟随你当前 colorscheme（tokyonight / monokai 等）
        theme = "auto",

        -- 分隔符（可按喜好改；你有 Nerd Font 所以显示没压力）
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },

        -- 让状态栏更干净
        icons_enabled = true,
        globalstatus = true, -- 一个状态栏贯穿所有窗口（更像 IDE）
        disabled_filetypes = { statusline = { "NvimTree", "lazy" } },
      },

      sections = {
        -- 左侧：模式
        lualine_a = { { "mode" } },

        -- 左中：Git 分支 + diff
        lualine_b = {
          { "branch" },
          {
            "diff",
            -- diff 依赖 git 仓库；不在 git 项目里就自动为空
            symbols = { added = "+", modified = "~", removed = "-" },
          },
        },

        -- 中间：文件名（含路径）
        lualine_c = {
          {
            "filename",
            path = 1, -- 0=仅文件名，1=相对路径，2=绝对路径
            shorting_target = 40,
            symbols = { modified = "●", readonly = "", unnamed = "[No Name]" },
          },
        },

        -- 右侧：LSP 诊断 + 文件信息 + 光标位置
        lualine_x = {
          {
            "diagnostics",
            -- 来源：Neovim 内置 diagnostic（LSP/linters 都走这个）
            sources = { "nvim_diagnostic" },
            symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
          },
          { "encoding" },  -- utf-8 等
          { "fileformat" },-- unix/dos
          { "filetype" },  -- go/lua/markdown
        },

        lualine_y = { { "progress" } },          -- 进度：%（在文件中的位置）
        lualine_z = { { "location" } },          -- 行列：line:col
      },

      inactive_sections = {
        -- 非活动窗口：简化显示，避免噪音
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}

