return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    heading = {
      enabled = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      width = "full",
    },
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
    },
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰄵 " },
    },
    code = {
      enabled = true,
      style = "full",
      width = "block",
      border = "thick",
      left_pad = 2,
      right_pad = 2,
    },
    dash = {
      enabled = true,
      icon = "─",
      width = "full",
    },
    pipe_table = {
      enabled = true,
      style = "full",
      border = { "┌", "┬", "┐", "├", "┼", "┤", "└", "┴", "┘", "│", "─" },
    },
    link = {
      enabled = true,
      hyperlink = "󰌹 ",
    },
    sign = {
      enabled = true,
    },
  },
}
