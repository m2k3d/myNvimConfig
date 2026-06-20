-- Bufferrs
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- Insert
vim.keymap.set("i", "jj", "<Esc>")

-- Navigation
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- SplitScreen
vim.keymap.set("n", "|", ":vsplit<CR>")
vim.keymap.set("n", "\\", ":split<CR>")

-- NeoTreeKeyMapping
vim.keymap.set("n", "<c-b>", ":Neotree left reveal toggle<CR>")

-- Diagnostics
-- Открыть плавающее окно с описанием ошибки
vim.keymap.set("n", "gl", vim.diagnostic.open_float)

-- Переход к следующей/предыдущей ошибке (опционально)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

-- Теперь вместо списка внизу будет открываться окно Telescope
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go to Definition" })
