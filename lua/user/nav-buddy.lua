local M = {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
    "numToStr/Comment.nvim",
    "nvim-telescope/telescope.nvim",
  },

  cmd = "Navbuddy",
}

function M.config()
  local navbuddy = require "nvim-navbuddy"
  navbuddy.setup {
    window = {
      border = "double",
      position = "90%",
    },
    lsp = { auto_attach = true },
  }
end

return M
