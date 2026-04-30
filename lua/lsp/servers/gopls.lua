-- lua/lsp/servers/gopls.lua
-- Neovim 0.11+ 推荐方式：vim.lsp.config / vim.lsp.enable
-- 目的：不再依赖 nvim-lspconfig 的 require("lspconfig").gopls.setup()

local M = {}

function M.setup(opts)
  -- 1) 注册 gopls 配置（命名必须是 "gopls"）
  vim.lsp.config("gopls", {
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,

    settings = {
      gopls = {
        gofumpt = true,

        analyses = {
          unusedparams = true,
          unusedwrite = true,
          nilness = true,
          shadow = true,
        },

        staticcheck = true,

        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  })

  -- 2) 启用该 server（Neovim 会在匹配到文件类型时自动启动）
  vim.lsp.enable("gopls")
end

return M

