local M = {}

-- список тем: ключ = colorscheme, который вызывается через :colorscheme
M.themes = {
  "catppuccin-latte",
  "catppuccin-mocha",
  "github_dark",
  "gruvbox",
  "kanagawa-lotus",
  "kanagawa-dragon",
  "onedark",
}

local cache = vim.fn.stdpath("data") .. "/theme.txt"

local function save(name)
  local f = io.open(cache, "w")
  if f then f:write(name); f:close() end
end

local function load()
  local f = io.open(cache, "r")
  if not f then return M.themes[1] end
  local name = f:read("*l"); f:close()
  return name or M.themes[1]
end

function M.set(name)
  local ok = pcall(vim.cmd.colorscheme, name)
  if ok then save(name) else
    vim.notify("Нет темы: " .. name, vim.log.levels.WARN)
  end
end

-- применить сохранённую при старте
function M.apply()
  M.set(load())
end

-- меню выбора через telescope/vim.ui.select
function M.pick()
  vim.ui.select(M.themes, { prompt = "Тема:" }, function(choice)
    if choice then M.set(choice) end
  end)
end

return M
