-- 1. 初始化 Mason
require("mason").setup()

-- 2. 获取 cmp 的补全能力 (让 gopls 知道我们要补全)
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- 3. 使用 handlers 自动配置所有 LSP
-- 这种写法比旧的 require('lspconfig').gopls.setup 更稳健
require("mason-lspconfig").setup({
    -- 确保安装 gopls
    ensure_installed = { "gopls" },

    -- handlers 会自动处理安装好的 server
    handlers = {
        -- (1) 默认处理器：如果没有特殊设置的 server，走这个逻辑
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
            })
        end,

        -- (2) gopls 专用处理器：在这里写 Go 的特殊配置
        ["gopls"] = function()
            require("lspconfig").gopls.setup({
                capabilities = capabilities,
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true, -- 提示未使用的参数
                        },
                        staticcheck = true,     -- 启用静态检查
                        gofumpt = true,         -- 更严格的格式化
                    },
                },
                -- 绑定快捷键 (仅在 LSP 启动时生效)
                on_attach = function(client, bufnr)
                    local opts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)    -- gd 跳转定义
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)          -- K 查看文档
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- 重命名变量
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)     -- 查看引用
                end,
            })
        end,
    }
})
