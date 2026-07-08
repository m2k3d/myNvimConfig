return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    -- Массив с путями к вашим папкам (можно добавлять и удалять элементы)
    local my_directories = {
      "/home/matthew/.config/nvim"
      -- Добавьте сюда любые другие пути
    }

    local buttons = {}
    for i, path in ipairs(my_directories) do
      -- Заменяем тильду на полный путь для корректной работы cd
      local expanded_path = vim.fn.expand(path)
      local shortcut = tostring(i)
      
      -- Создание кнопки: меняет рабочую директорию и открывает её в Neovim
      local btn = dashboard.button(
        shortcut, 
        "📁 " .. path, 
        "<cmd>cd " .. expanded_path .. " | edit . <CR>"
      )
      table.insert(buttons, btn)
    end

    -- Интеграция динамических кнопок в главное меню
    dashboard.section.buttons.val = buttons

    -- Настройка внешнего вида (опционально)
dashboard.section.header.val = vim.split([==[
yo!
]==], "\n", { trimempty = true })

    alpha.setup(dashboard.config)
  end
}
