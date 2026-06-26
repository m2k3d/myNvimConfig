-- Basic Config
require("core.configs")
require("core.mappings")
require("core.lazy")
require("neovide")
require("core.theme").apply()
vim.keymap.set("n", "<leader>th", require("core.theme").pick, { desc = "Сменить тему" })

