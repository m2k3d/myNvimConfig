return {
	{
		'nvim-treesitter/nvim-treesitter',
		branch = 'master',   -- ADD THIS: Pins the plugin to the legacy branch
		build = ':TSUpdate', -- ADD THIS: Keeps your parsers up to date automatically
		config = function()
			require('nvim-treesitter.configs').setup({
				 ensure_installed = {"go", "lua", "cpp", "markdown", "markdown_inline"},
				 auto_install = true,
				 highlight = {
					 enable = true
				 }
			})
		end
	}
}
