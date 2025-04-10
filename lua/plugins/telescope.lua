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
    },
    { "xiyaowong/telescope-emoji.nvim" },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
  },
  config = function()
    local actions = require('telescope.actions')
    local opts = {
      extensions = { live_grep_args = { auto_quoting = true } },
      defaults = {
        layout_config = {
          height = 0.90,
          width = 0.90,
        },
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { "node_modules/", "bin/", "obj/", "deps/" },
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
            ["<C-o>"] = actions.delete_buffer,
            ["<C-i>"] = force_delete_buffer
          }
        },
        dynamic_preview_title = true
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
    telescope.load_extension("emoji")
    telescope.load_extension("live_grep_args")
  end,
}

return M
