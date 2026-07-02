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
            -- Форматирование при сохранении делает conform.nvim (goimports включает gofmt)
        end
    }
}
