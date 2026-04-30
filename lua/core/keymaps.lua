-- lua/core/keymaps.lua
-- 全局快捷键配置
-- 插件专属快捷键放在对应插件文件中（flash.lua, gitsigns.lua, dap.lua 等）

vim.g.mapleader = ","
vim.g.maplocalleader = ","

local map = vim.keymap.set
local function o(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- ═══════════════ 基础操作 ═══════════════
map("n", "<leader>w", "<cmd>w<cr>", o("保存文件"))
map("n", "<leader>q", "<cmd>q<cr>", o("退出窗口"))
map("n", "<leader>h", "<cmd>nohlsearch<CR>", o("清除搜索高亮"))

-- ═══════════════ 窗口管理 ═══════════════
map("n", "<leader>sv", "<cmd>vsplit<cr>", o("垂直分屏"))
map("n", "<leader>sh", "<cmd>split<cr>", o("水平分屏"))
map("n", "<leader>sc", "<cmd>close<cr>", o("关闭当前窗口"))

-- ═══════════════ 编辑增强 ═══════════════
map("n", "J", "mzJ`z", o("合并行, 保持光标"))

-- ═══════════════ 文件树 (Neo-tree) ═══════════════
map("n", "<leader>n", "<cmd>Neotree toggle left<cr>", o("开关文件树"))
map("n", "<leader>cd", "<cmd>Neotree filesystem reveal left<cr>", o("定位当前文件"))

-- ═══════════════ 搜索 (Telescope) ═══════════════
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, o("查找文件"))
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, o("全文搜索"))
map("n", "<leader>fr", function() require("telescope.builtin").oldfiles() end, o("最近文件"))
map("n", "<leader>bb", function() require("telescope.builtin").buffers() end, o("已打开缓冲区"))

-- ═══════════════ LSP 导航 ═══════════════
map("n", "<leader>gd", vim.lsp.buf.definition, o("跳转到定义"))
map("n", "<leader>gr", function() require("telescope.builtin").lsp_references() end, o("查找引用"))
map("n", "<leader>gi", vim.lsp.buf.implementation, o("跳转到实现"))
map("n", "<leader>gt", vim.lsp.buf.type_definition, o("跳转到类型定义"))

-- ═══════════════ LSP 辅助 ═══════════════
map("n", "<leader>k", vim.lsp.buf.hover, o("悬浮文档"))
map("n", "<leader>rn", vim.lsp.buf.rename, o("重命名符号"))
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, o("Code Action"))

-- ═══════════════ 诊断跳转 ═══════════════
map("n", "]d", function() vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.WARN } }) end, o("下一个诊断"))
map("n", "[d", function() vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN } }) end, o("上一个诊断"))
map("n", "<leader>e", vim.diagnostic.open_float, o("查看诊断详情"))

-- ═══════════════ 引用跳转 (Illuminate) ═══════════════
map("n", "]r", function() require("illuminate").goto_next_reference(false) end, o("下一个同名引用"))
map("n", "[r", function() require("illuminate").goto_prev_reference(false) end, o("上一个同名引用"))

-- ═══════════════ 运行 ═══════════════
local run_cmds = {
  go     = "go run %",
  python = "python3 %",
  sh     = "bash %",
}

-- 通用浮动运行器
local function float_run(cmd, title)
  local max_w = math.floor(vim.o.columns * 0.8)
  local max_h = math.floor(vim.o.lines * 0.8)

  -- 先显示一个 "运行中..." 的浮动窗口
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = max_w,
    height = 3,
    col = math.floor((vim.o.columns - max_w) / 2),
    row = math.floor((vim.o.lines - 3) / 2),
    style = "minimal",
    border = "rounded",
    title = " " .. title .. " [Running...] ",
    title_pos = "center",
  })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "  Running..." })

  -- 收集输出
  local output = {}
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then table.insert(output, line) end
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then table.insert(output, line) end
        end
      end
    end,
    on_exit = function(_, code)
      vim.schedule(function()
        if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then return end

        -- 写入输出到 buffer
        if #output == 0 then output = { "(no output)" } end
        vim.bo[buf].modifiable = true
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
        vim.bo[buf].modifiable = false

        -- 收缩窗口适配内容
        local new_h = math.min(math.max(#output, 3), max_h)
        local status = code == 0 and "OK" or "FAIL:" .. code
        vim.api.nvim_win_set_config(win, {
          relative = "editor",
          width = max_w,
          height = new_h,
          col = math.floor((vim.o.columns - max_w) / 2),
          row = math.floor((vim.o.lines - new_h) / 2),
          title = " " .. title .. " [" .. status .. "] (q/Esc to close) ",
          title_pos = "center",
        })

        -- 光标到第一行
        vim.api.nvim_win_set_cursor(win, { 1, 0 })

        -- 绑定关闭快捷键
        local close = function() vim.api.nvim_win_close(win, true) end
        vim.api.nvim_buf_set_keymap(buf, "n", "q", "", { callback = close })
        vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "", { callback = close })
      end)
    end,
  })
end

map("n", "<leader>rr", function()
  local ft = vim.bo.filetype
  local cmd = run_cmds[ft]
  if not cmd then
    vim.notify("不支持运行 " .. ft .. " 文件", vim.log.levels.WARN)
    return
  end
  vim.cmd("w")
  cmd = cmd:gsub("%%", vim.fn.expand("%:p"))
  float_run(cmd, "Run: " .. ft)
end, o("运行当前文件"))

-- Java Maven：运行当前测试类
map("n", "<leader>jrr", function()
  local file = vim.fn.expand("%:t:r")
  local pom = vim.fs.find("pom.xml", { path = vim.fn.expand("%:p:h"), upward = true })[1]
  if not pom then
    vim.notify("找不到 pom.xml", vim.log.levels.WARN)
    return
  end
  local module_dir = vim.fs.dirname(pom)
  vim.cmd("w")
  float_run("cd " .. module_dir .. " && mvn test -Dtest=" .. file .. " -Dsurefire.useFile=false -Dmaven.test.redirectTestOutputToFile=false", "mvn test: " .. file)
end, o("Java: 运行测试类 (mvn)"))

