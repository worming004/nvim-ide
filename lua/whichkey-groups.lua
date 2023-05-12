local wk = require "which-key"

wk.register {
  ["<leader>"] = {
    c = {
      name = "comment",
    },
    d = {
      name = "dap",
    },
    e = {
      name = "edit",
    },
    f = {
      name = "telescope / search",
    },
    g = {
      name = "git",
    },
    n = {
      name = "navigation"
    },
    o = {
      name = "nvim-tree",
    },
    t = {
      name = "test",
    },
    u = {
      name = "utils",
      n = {
        name = "notify",
      },
    },
    v = {
      name = "view",
      w = {
        name = "workspace",
      }
    }
  },
}
