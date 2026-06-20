return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            vim.lsp.config('gopls', {
                settings = {
                    gopls = {
                        semanticTokens = true,
                    },
                },
            })

            vim.lsp.enable('lua_ls')
            vim.lsp.enable('gopls')

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    }
}
