local config = {}
config.settings = {
  cmd = { "ltex-ls" },
  filetypes = { "markdown", "text" },
  flags = { debounce_text_changes = 300 },
  settings = {
    ltex = {
      language = "fr"
    }
  }
}
return config
