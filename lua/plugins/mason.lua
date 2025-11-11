return {
  "mason-org/mason.nvim",
  lazy = false,
  command = ":Mason",
  build = ":MasonUpdate",
  version = "*",
  config = function()
    require("mason").setup({
      ui = {
        border = "none",
        icons = {
          package_installed = "◍",
          package_pending = "◍",
          package_uninstalled = "◍",
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 6,
    })
  end
}
