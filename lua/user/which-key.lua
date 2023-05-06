local M = {
  "folke/which-key.nvim",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 1000
    require("which-key").setup {}
  end,
  lazy = false -- search better
}

return M
