local M = {}

function M.setup_mason()
  require("mason").setup()

  local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

  require("mason-lspconfig").setup({
    ensure_installed = { "gopls" },
    automatic_installation = true,
  })
end

function M.setup_servers()
  vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gosum", "gowork" },
    settings = {
      gopls = {
        analyses = {
          unusedparams = false,
          fieldalignment = false,
          nilness = true,
          unusedwrite = true,
          useany = false,
          modernize = false,
          any = false,
        },
        hints = {
          assignVariableTypes = false,
          compositeLiteralFields = false,
          compositeLiteralTypes = false,
          constantValues = false,
          functionTypeParameters = false,
          parameterNames = false,
          rangeVariableTypes = false,
        },
        staticcheck = false,
        usePlaceholders = false,
        completeUnimported = true,
      },
    },
  })

  vim.lsp.enable("gopls")

  vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = { border = "rounded" },
  })
end

return M
