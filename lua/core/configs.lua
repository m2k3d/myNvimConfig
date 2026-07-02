-- Line Numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Indent Settings
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Other
vim.opt.scrolloff = 8
vim.opt.wrap = true
vim.opt.termguicolors = true

-- Fillchars
vim.opt.fillchars = {
	vert = "│",
	fold = " ",
	eob = " ", -- suppress ~ at EndOfBuffer
	-- diff = "⣿", -- alternatives = ⣿ ░ - /
	msgsep = "‾",
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
}

-- BufferLine
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { silent = true })

vim.opt.termguicolors = true

vim.opt.linebreak = true
vim.opt.breakindent = true
