local wk = require "which-key"

wk.register {
  ["<leader>"] = {
    u = {
      name = "utils",
      n = {
        name = "notify",
      },
    },
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
      g = "git"
    },
    g = {
      name = "git",
    },
    o = {
      name = "nvim-tree",
    },
    t = {
      name = "test",
    },
    v = {
      name = "view",
      w = {
        name = "workspace",
      }
    }
  },
}
