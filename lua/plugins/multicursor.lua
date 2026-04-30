return {
  {
    "mg979/vim-visual-multi",
    event = "BufEnter",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"]         = "<C-n>",  -- 选中当前词，再按选下一个
        ["Find Subword Under"] = "<C-n>",  -- 可视模式也用 Ctrl+n
        ["Select All"]         = "<C-S-l>", -- 选中所有匹配
        ["Skip Region"]        = "<C-k>",  -- 跳过当前，选下一个
        ["Remove Region"]      = "<C-p>",  -- 取消当前选中
      }
    end,
  },
}
