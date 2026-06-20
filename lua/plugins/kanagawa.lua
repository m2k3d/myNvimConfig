return {
  "rebelot/kanagawa.nvim",
  lazy = false,    -- ВАЖНО: тема должна загружаться сразу при старте
  priority = 997, -- ВАЖНО: максимальный приоритет, чтобы загрузилась первой
  config = function()
    require('kanagawa').setup({
      compile = false,
      undercurl = true,
      transparent = false,
      theme = "lotus",
    })
    -- Включаем тему прямо здесь, ПОСЛЕ того как плагин точно загружен!
--	vim.cmd("colorscheme kanagawa-lotus")
  end,
}
