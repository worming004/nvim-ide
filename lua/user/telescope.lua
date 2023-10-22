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
    local telescope = require "telescope"
    telescope.load_extension "luasnip"
  end,
}

M.opts = {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },
  },
  mappings = {
    i = {
      -- ["<C-h>"] = "which_key",
      -- ["<C-p>"] = require('telescope.actions').delete_buffer
    }
  }
}

return M
