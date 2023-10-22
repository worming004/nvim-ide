local M = {
  "nvim-telescope/telescope.nvim",
  event = "Bufenter",
  cmd = { "Telescope" },
  dependencies = {
    {
      "benfowler/telescope-luasnip.nvim",
    },
    {
      "nvim-lua/plenary.nvim",
      branch = "master"
    }
  },
  config = function()
    local actions = require('telescope.actions')
    local opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules" },
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
            ["<C-o>"] = actions.delete_buffer
          }
        }
      },
    }

    local telescope = require "telescope"
    telescope.setup(opts)
    telescope.load_extension "luasnip"
  end,

}


return M
