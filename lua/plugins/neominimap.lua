return {
	"Isrothy/neominimap.nvim",
	version = "v3.x.x",
	lazy = false,
	keys = {
		{ "<leader>nm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle minimap" },
		{ "<leader>nf", "<cmd>Neominimap Focus<cr>", desc = "Focus minimap" },
	},
	init = function()
		vim.g.neominimap = {
			auto_enable = true,
			layout = "float",
			float = {
				minimap_width = 20,
				window_border = "none",
			},
			click = { enabled = true, auto_switch_focus = false },
			exclude_filetypes = { "help", "alpha", "lazy", "mason", "neo-tree" },
			diagnostic = { enabled = true, mode = "line" },
			git = { enabled = true, mode = "sign" },
			search = { enabled = true, mode = "line" },
			treesitter = { enabled = true },
		}
	end,
}
