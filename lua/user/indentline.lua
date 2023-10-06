local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl"
  event = "BufReadPre",
}

M.opts = {
  char = "▏",
  use_treesitter = true,
  buftype_exclude = { "terminal", "nofile" },
  filetype_exclude = {
    "help",
    "packer",
    "NvimTree",
  },
}

return M
