return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()
		require("dap-go").setup()

		dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
		dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end

		vim.keymap.set("n", "<F5>", dap.continue)
		vim.keymap.set("n", "<F10>", dap.step_over)
		vim.keymap.set("n", "<F11>", dap.step_into)
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
	end,
}
