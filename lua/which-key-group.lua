local wk = require "which-key"

wk.register {
  ["<leader>"] = {
    b = {
      name = "buffer",
    },
    c = {
      name = "copilot",
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
      g = {
        name = "git"
      }
    },
    k = {
      name = "kube"
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
      name = "navigation",
      h = {
        name = "harpoon",
      }
    },
    o = {
      name = "nvim-tree",
    },
    q = {
      name = "quick quit"
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
    },
    w = {
      name = "write"
    }
  },
}
