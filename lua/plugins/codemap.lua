return {
  "m2k3d/codemap",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  cmd = { "CodemapOpen", "CodemapToggle", "CodemapClose" },
  event = "VeryLazy", -- also load shortly after startup, so auto_open kicks in
  opts = {
    width = 20, -- sidebar width, column width
	update_events = { "BufEnter", "TextChanged", "TextChangedI" }, -- when to update the list
    debounce_ms = 300, -- delay before re-parsing after text editing
	auto_open = true, -- Open the sidebar automatically on startup.
	},
}
