local M = {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local navbuddy = require "nvim-navbuddy"
    navbuddy.setup {
      window = {
        border = "double",
        position = "90%",
      },
      lsp = { auto_attach = true },
    }
  end,
  cmd = "Navbuddy"
}

return M
