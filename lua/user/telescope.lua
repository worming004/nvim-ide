local force_delete_buffer = function(prompt_bufnr)
  local action_state = require "telescope.actions.state"
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  current_picker:delete_selection(function(selection)
    local ok = pcall(vim.api.nvim_buf_delete, selection.bufnr, { force = true })
    return ok
  end)
end

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
        file_ignore_patterns = { ".git/", "node_modules", "bin", "obj" },
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
            ["<C-o>"] = actions.delete_buffer,
            ["<C-i>"] = force_delete_buffer
          }
        }
      },
      pickers = {
        keymaps = {
          show_plug = false
        }
      }
    }

    local telescope = require "telescope"
    telescope.setup(opts)
    telescope.load_extension("luasnip")
    telescope.load_extension('harpoon')
  end,
}

return M
