local wk = require "which-key"

wk.register {
  ["<leader>"] = {
    b = {
      name = "buffer",
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
    l = {
      name = "lsp",
      l = {
        name = "admin"
      },
      g = {
        name = "go to"
      }
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
