return {
  "Isrothy/neominimap.nvim",
  version = "v3.x.x",
  lazy = false,
  init = function()
    vim.opt.wrap = false
    vim.opt.sidescrolloff = 20
    vim.g.neominimap = {
      auto_enable = true,
    }
  end,
}
