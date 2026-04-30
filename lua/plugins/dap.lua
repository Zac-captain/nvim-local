return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "调试：切换断点" },
      { "<leader>dc", function() require("dap").continue() end, desc = "调试：启动/继续" },
      { "<leader>di", function() require("dap").step_into() end, desc = "调试：步入" },
      { "<leader>do", function() require("dap").step_over() end, desc = "调试：步过" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "调试：步出" },
      { "<leader>dr", function() require("dap").restart() end, desc = "调试：重启" },
      { "<leader>dq", function() require("dap").terminate() end, desc = "调试：终止" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "调试：切换 UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "调试：查看变量值", mode = { "n", "v" } },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- dap-go: 自动配置 delve
      require("dap-go").setup()

      -- dap-ui
      dapui.setup()

      -- 启动/结束调试时自动打开/关闭 UI
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },
}
