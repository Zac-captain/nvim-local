local M = {}

function M.setup()
  require("catppuccin").setup({
    flavour = "mocha", -- mocha(最深) / macchiato / frappe / latte(浅色)
    transparent_background = false,

    styles = {
      comments = {},
      keywords = { "bold" },
      functions = { "bold" },
      variables = {},
    },

    integrations = {
      cmp = true,
      gitsigns = true,
      neotree = true,
      treesitter = true,
      flash = true,
      illuminate = { enabled = true },
      which_key = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          warnings = { "undercurl" },
        },
      },
    },
  })

  vim.cmd.colorscheme("catppuccin")
end

return M
