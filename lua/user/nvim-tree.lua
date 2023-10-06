local M = {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
}

local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mapping
  api.config.mappings.default_on_attach(bufnr)
  -- custom
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Parent")
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Edit File")
  vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
end

M.opts = {
  on_attach = on_attach,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 50,
    side = "left",
  },
}

return M
