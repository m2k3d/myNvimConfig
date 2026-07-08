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
vim.keymap.set("n", [[\\]], ":split<CR>")

-- NeoTreeKeyMapping
vim.keymap.set("n", "<c-b>", ":Neotree left reveal toggle<CR>")

-- Diagnostics
-- Открыть плавающее окно с описанием ошибки
vim.keymap.set("n", "gl", vim.diagnostic.open_float)

-- Переход к следующей/предыдущей ошибке (опционально)
-- opts.float у vim.diagnostic.jump() устарел в 0.12 (удалят в 0.14) — используем on_jump
local function diag_jump(count)
  vim.diagnostic.jump({
    count = count,
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
    end,
  })
end
vim.keymap.set("n", "[d", function() diag_jump(-1) end)
vim.keymap.set("n", "]d", function() diag_jump(1) end)

-- Теперь вместо списка внизу будет открываться окно Telescope
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go to Definition" })

vim.keymap.set("n", "<leader>tw", function()
  vim.wo.wrap = not vim.wo.wrap
  if vim.wo.wrap then
    vim.cmd("Neominimap WinDisable")
  else
    vim.cmd("Neominimap WinEnable")
  end
end, { desc = "Toggle wrap + minimap" })
