local M = {
  {
    "williamboman/mason-lspconfig.nvim",
    event = "BufReadPre",
    lazy = false,
    dependencies = { "neovim/nvim-lspconfig" },
  },
}

return M
