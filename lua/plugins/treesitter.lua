return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  priority = 1000,
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "go", "lua", "vim", "vimdoc", "markdown", "markdown_inline" },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
