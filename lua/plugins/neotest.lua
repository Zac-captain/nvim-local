-- lua/plugins/neotest.lua
-- 作用：Neovim 里的“测试 IDE 层”（以 Go 为主）
-- 目标：在多包 Go 项目里也“跑得对、跑得顺”
--
-- 常见 Go 项目结构：
--   demo/        (root 包可能没测试)
--     go.mod
--     logic/     (测试在子包)
--       *_test.go
--
-- 我们提供四种常用粒度（并且保证不被 “No tests found” 卡住）：
--   1) nearest：跑光标最近的测试（解析失败 -> fallback 到当前包）
--   2) file：跑当前文件（解析失败 -> fallback 到当前包）
--   3) package：跑当前包（最稳，强烈推荐）
--   4) all：跑整个项目（go test ./...）
--
-- 关键策略：
--   - 不“一刀切”固定 cwd（你明确说不要）
--   - 但在按键层面为“nearest/file”提供可靠 fallback（不再被 No tests found 破坏体验）
--   - package/all 走明确语义：package = cd 当前目录 && go test .
--                all     = cd go.mod 根目录 && go test ./...

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",           -- 工具函数库
    "nvim-treesitter/nvim-treesitter", -- neotest 内部会用到解析能力
    "nvim-neotest/nvim-nio",           -- neotest 新依赖（0.11 常见）
    "nvim-neotest/neotest-go",         -- Go adapter：跑 go test
  },

  -- 懒加载：按键触发才加载（启动快、也避免 require 找不到）
  keys = {
    -- =========================
    -- 测试：运行（Run）
    -- =========================

    -- nearest：优先跑“光标最近的测试”
    -- 如果 neotest/go adapter 解析失败（外部 test 包 logic_test / 复杂 table-driven 等场景常见）
    -- 则 fallback 到“当前包”，保证你永远能跑起来
    {
      "<leader>tn",
      function()
        local nt = require("neotest")
        local file = vim.api.nvim_buf_get_name(0)
        if file == "" then return end
        local dir = vim.fs.dirname(file)

        -- 先尝试 nearest
        local ok = pcall(function() nt.run.run() end)
        if not ok then
          -- fallback：当前包（最稳）
          nt.run.run({ cwd = dir })
        end
      end,
      desc = "测试：运行最近（nearest，不行则跑当前包）",
    },

    -- file：跑当前文件
    -- 若 adapter 无法识别到该文件的 tests（仍可能出现 No tests found）
    -- 则 fallback 到“当前包”
    {
      "<leader>tf",
      function()
        local nt = require("neotest")
        local file = vim.api.nvim_buf_get_name(0)
        if file == "" then return end
        local dir = vim.fs.dirname(file)

        local ok = pcall(function()
          nt.run.run(vim.fn.expand("%"))
        end)
        if not ok then
          nt.run.run({ cwd = dir })
        end
      end,
      desc = "测试：运行当前文件（不行则跑当前包）",
    },

    -- package：跑当前包（多包项目最推荐、最稳）
    -- 等价：cd 当前文件目录 && go test .
    {
      "<leader>tp",
      function()
        local file = vim.api.nvim_buf_get_name(0)
        if file == "" then return end
        local dir = vim.fs.dirname(file)
        require("neotest").run.run({ cwd = dir })
      end,
      desc = "测试：运行当前包（package）",
    },

    -- all：跑整个项目（go test ./...）
    -- 这里我们只在这个按键里“临时定位 go.mod 根目录”，不影响其他按键/其他项目
    {
      "<leader>tA",
      function()
        local file = vim.api.nvim_buf_get_name(0)
        local start = (file ~= "" and vim.fs.dirname(file)) or vim.loop.cwd()
        local gomod = vim.fs.find("go.mod", { path = start, upward = true })[1]
        local root = gomod and vim.fs.dirname(gomod) or vim.loop.cwd()

        -- cd root && go test ./...
        -- 注：extra_args 是 neotest-go 支持的传参方式之一；如果你这边版本不吃 extra_args，
        -- 我们再换成 adapter 的 args / 或者用 vim.system 兜底（但那属于“第二方案”，先不动）。
        require("neotest").run.run({ cwd = root, extra_args = { "./..." } })
      end,
      desc = "测试：运行整个项目（go test ./...）",
    },

    -- stop：停止运行
    {
      "<leader>ts",
      function() require("neotest").run.stop() end,
      desc = "测试：停止运行",
    },

    -- rerun last：修一下再重跑（很常用）
    {
      "<leader>tr",
      function() require("neotest").run.run_last() end,
      desc = "测试：重跑上一次",
    },

    -- =========================
    -- 测试：查看结果 / UI（View）
    -- =========================

    -- output：打开当前用例输出（聚焦进入）
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true, auto_close = false })
      end,
      desc = "测试：打开输出（当前用例）",
    },

    -- output panel：全局输出面板（toggle）
    {
      "<leader>tO",
      function() require("neotest").output_panel.toggle() end,
      desc = "测试：切换输出面板（全局）",
    },

    -- summary：测试树（toggle）
    {
      "<leader>tt",
      function() require("neotest").summary.toggle() end,
      desc = "测试：切换测试树（summary）",
    },

    -- jump：跳到失败的测试
    {
      "<leader>tj",
      function() require("neotest").jump.next({ status = "failed" }) end,
      desc = "测试：跳到下一个失败",
    },
    {
      "<leader>tJ",
      function() require("neotest").jump.prev({ status = "failed" }) end,
      desc = "测试：跳到上一个失败",
    },

    -- attach：附加到运行（可选）
    {
      "<leader>ta",
      function() require("neotest").run.attach() end,
      desc = "测试：附加到运行（attach）",
    },
  },

  config = function()
    local neotest = require("neotest")

    neotest.setup({
      -- ========== 适配器 ==========
      adapters = {
        require("neotest-go")({
          -- 说明：neotest-go 负责把 neotest 的“运行请求”翻译成 go test 命令

          experimental = {
            -- 作用：table-driven 测试在 summary 里展示更友好（子用例更清晰）
            test_table = true,
          },

          -- 想排除 go test 缓存干扰时打开（调试阶段推荐）
          -- args = { "-count=1" },

          -- 不强制 cwd：按键里按需传 {cwd=...}，避免“一刀切”
        }),
      },

      -- ========== UI 行为 ==========
      status = { enabled = true },                    -- summary 显示状态
      output = { enabled = true, open_on_run = false }, -- 跑完不自动弹 output，避免打断你写代码

      -- quickfix：先关着（你要“失败自动进 quickfix”时再开）
      quickfix = {
        enabled = false,
        open = false,
      },

      -- ========== 日志（排错用） ==========
      -- 你要追 “为什么 adapter 识别不到 tests” 时，临时改成 INFO 或 DEBUG
      log_level = vim.log.levels.WARN,
    })
  end,
}

