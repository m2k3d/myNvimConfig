# Установка конфига на новом ПК (treesitter / tree-sitter)

Шпаргалка про самую больную часть — nvim-treesitter на ветке `main` + Neovim 0.12.
Если поставить конфиг «как есть» на чистый ПК, вылезут ровно те же ошибки, что были
при первой настройке. Здесь — как их сразу избежать.

## TL;DR — порядок действий на новом ПК

1. Поставить **Neovim** (проверялось на 0.12.x).
2. Поставить **C-компилятор** (нужен для сборки парсеров). У меня — LLVM/clang:
   ```
   winget install LLVM.LLVM
   ```
3. Поставить **tree-sitter CLI** (ветка `main` собирает парсеры только через него):
   ```
   winget install tree-sitter.tree-sitter-cli
   ```
4. **ВАЖНО: перелогиниться в Windows** (или перезагрузиться) после установки tree-sitter —
   см. раздел «Грабли №1». Без этого nvim не увидит `tree-sitter`.
5. Открыть **новый** терминал, проверить: `tree-sitter --version` → должно ответить.
6. Запустить nvim из этого терминала. lazy сам поставит плагины; парсеры go/cpp соберутся.
7. Проверить: открыть `.go` (подсветка есть) и нажать `K` на символе (hover без ошибок).

---

## Почему конфиг treesitter выглядит именно так

Файл: `lua/plugins/treesitter.lua`. Ключевые решения:

### 1. `branch = 'main'`, а не `master`
`master` — замороженная legacy-ветка. Её shim совместимости (`all = false`) **не работает
на Neovim 0.11+/0.12**: там убрали старый режим, и падает
`attempt to call method 'range' (a nil value)` (ловилось на `K`/hover).
Для Neovim 0.11+ поддерживается только ветка `main`.

### 2. На `main` нет `ensure_installed` / `highlight.enable`
Другой API. Поэтому:
- парсеры ставим явно: `require('nvim-treesitter').install({ 'go', 'cpp' })`;
- подсветку включаем сами автокомандой `FileType` → `pcall(vim.treesitter.start, buf)`.

### 3. НЕ ставим через nvim-treesitter языки, которые Neovim везёт сам
Neovim 0.12 уже поставляет согласованные пары «парсер + query» для:
`c, lua, markdown, markdown_inline, query, vim, vimdoc`
- парсеры: `C:\Program Files\Neovim\lib\nvim\parser\*.dll`
- queries: `C:\Program Files\Neovim\share\nvim\runtime\queries\*`

Если продублировать их через nvim-treesitter, его `parser\*.so` встаёт раньше в
`runtimepath` и **перекрывает** встроенный парсер, а query остаётся встроенный (новее) →
`Query error ... Invalid field name "operator"` (старый парсер vs новый query).

Поэтому в `install({...})` оставлены только `go` и `cpp` — то, чего в Neovim нет.
`cpp` при сборке тянет `c` как build-зависимость; это ок — свежая грамматика C новее
встроенного query, «missing field» не будет.

---

## Грабли №1 — winget ставит tree-sitter, но его «не видно»

Симптом:
```
Error during "tree-sitter build": ENOENT: no such file or directory (cmd): 'tree-sitter'
```
хотя `winget list` показывает, что пакет установлен.

Причина: winget кладёт бинарь в папку пакета
```
%LOCALAPPDATA%\Microsoft\WinGet\Packages\tree-sitter.tree-sitter-cli_Microsoft.Winget.Source_8wekyb3d8bbwe\tree-sitter.exe
```
и должен создать shim в `%LOCALAPPDATA%\Microsoft\WinGet\Links` + добавить его в PATH.
Без **Developer Mode**/админа симлинк не создаётся. Плюс уже запущенные процессы
(терминал, nvim, Explorer) **не перечитывают PATH на лету** — донашивают старый.

Что делать:
1. Убедиться, что папка пакета есть в PATH (обычно winget её уже прописал в User Path).
   Проверка в PowerShell:
   ```powershell
   [Environment]::GetEnvironmentVariable('Path','User') -split ';' | Select-String tree-sitter
   ```
   Если пусто — добавить руками:
   ```powershell
   $dir = "$env:LOCALAPPDATA\Microsoft\WinGet\Packages\tree-sitter.tree-sitter-cli_Microsoft.Winget.Source_8wekyb3d8bbwe"
   $p = [Environment]::GetEnvironmentVariable('Path','User')
   [Environment]::SetEnvironmentVariable('Path', ($p.TrimEnd(';') + ';' + $dir), 'User')
   ```
   (папка без номера версии — переживает `winget upgrade`.)
2. **Перелогиниться в Windows** (или перезагрузиться), затем открыть **новый** терминал.
3. Проверить `tree-sitter --version` и запускать nvim только из этого нового терминала.

Альтернатива winget, если возни много: `npm install -g tree-sitter-cli`
(node уже стоит) — кладёт бинарь в каталог, который сразу на PATH.

---

## Если парсер всё-таки конфликтует (Invalid field name ...)

Значит какой-то `nvim-treesitter/parser/<lang>.so` перекрыл встроенный в Neovim и
рассинхронился с его query. Лечение — удалить дублирующий парсер, взять встроенный:
```
del "%LOCALAPPDATA%\nvim-data\lazy\nvim-treesitter\parser\<lang>.so"
```
и убрать `<lang>` из списка `install({...})` в `lua/plugins/treesitter.lua`.
Так уже сделано для `lua`, `markdown`, `markdown_inline`.

---

## Полезные команды в nvim

| Команда                 | Что делает                          |
|-------------------------|-------------------------------------|
| `:Lazy sync`            | Установить/обновить плагины          |
| `:TSUpdate`             | Обновить установленные парсеры        |
| `:TSInstall <lang>`     | Поставить парсер вручную              |
| `:checkhealth vim.treesitter` | Диагностика treesitter          |
| `:Lazy`                 | Меню менеджера плагинов               |

---

## Прочее (не про treesitter)

- Миникарта — плагин `m2k3d/codemap` (спек `lua/plugins/codemap.lua`), команды
  `:CodemapOpen` / `:CodemapClose` / `:CodemapToggle`. `<leader>tw` тогглит wrap
  и вместе с ним codemap (см. `lua/core/mappings.lua`).
- Старый `neominimap.nvim` больше не используется. Если остался в `lazy/` — `:Lazy clean`.
