-- 自动补全括号/引号（写 Go/JSON/YAML 都很爽）
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true, -- 结合 treesitter，避免在字符串里乱补
      fast_wrap = {},  -- 先不启用花哨 wrap，保持稳定
    })
  end,
}
