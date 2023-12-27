local M = {
  "folke/which-key.nvim",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 700
    require("which-key").setup {}
  end,
  event = "VeryLazy",
}

return M
