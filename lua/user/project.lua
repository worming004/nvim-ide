local M = {
  "ahmedkhalf/project.nvim",

  config = function()
    local project = require "project_nvim"
    project.setup {
      manual_mode = false,

      -- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
      detection_methods = { "pattern" },

      -- patterns used to detect root dir, when **"pattern"** is in detection_methods
      patterns = { ".git", "Makefile", "package.json" },

      show_hidden = true,
      silent_chdir = false,
      exclude_dirs = {},
      datapath = vim.fn.stdpath "data",
    }
  end,
}

return M
