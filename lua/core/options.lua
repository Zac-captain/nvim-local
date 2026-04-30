-- lua/core/options.lua
-- 这里放 Neovim 的基础行为配置：不依赖任何插件。

local opt = vim.opt

-- 行号
opt.number = true          -- 显示行号
opt.relativenumber = true  -- 相对行号：配合跳转更快

-- 缩进
opt.expandtab = true       -- Tab 转空格（Go 真实格式由 gofmt/gofumpt 控制）
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- 搜索
opt.ignorecase = true      -- 默认忽略大小写
opt.smartcase = true       -- 搜索里有大写时自动区分大小写
opt.incsearch = true

-- UI
opt.termguicolors = true   -- 24-bit 色彩
opt.cursorline = true      -- 高亮当前行
opt.signcolumn = "yes"     -- 左侧标记栏常驻，避免诊断标记出现时文本抖动


-- 性能/体验
opt.updatetime = 200       -- 更快触发 CursorHold 等事件（对诊断提示更灵敏）
opt.timeoutlen = 400       -- leader 组合键等待时间（你用 , 作为 leader，很顺手）



-- 使用系统剪贴板作为默认寄存器
vim.opt.clipboard = "unnamed,unnamedplus"




-- TokyoNight 有时候终端的 termguicolors 没开会糊
vim.opt.termguicolors = true

