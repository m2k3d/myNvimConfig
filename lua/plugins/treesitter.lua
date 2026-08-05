return {
	{
		'nvim-treesitter/nvim-treesitter',
		branch = 'main',     -- ветка для Neovim 0.11+/nightly (master заморожена и несовместима с 0.12)
		lazy = false,
		build = ':TSUpdate', -- компилирует/обновляет парсеры
		config = function()
			-- На main нет ensure_installed/auto_install — парсеры ставим явно.
			-- lua/markdown/markdown_inline/c НЕ ставим: их парсеры И queries уже
			-- везёт сам Neovim (lib/nvim/parser + runtime/queries) согласованной парой.
			-- Дублировать их через nvim-treesitter — гарантированный рассинхрон
			-- «старый парсер vs новый query». Ставим только то, чего в Neovim нет.
			require('nvim-treesitter').install({ 'go', 'cpp' })

			-- На main нет highlight.enable — подсветку включаем вручную по FileType.
			-- pcall прячет ошибку для буферов, у которых парсера нет.
			vim.api.nvim_create_autocmd('FileType', {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end,
	},
}
