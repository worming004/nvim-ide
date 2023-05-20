local M = {
  "lvimuser/lsp-inlayhints.nvim",
  lazy = false,
  config = function()
    require("lsp-inlayhints").setup {}
  end,
}

return M
