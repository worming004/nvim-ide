local config = {}
config.settings = {
  Lua = {
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { "vim" },
    },
  },
}

return config
