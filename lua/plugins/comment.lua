-- 快速注释/反注释（gcc / gc）
return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  config = function()
    require("Comment").setup()
  end,
}
