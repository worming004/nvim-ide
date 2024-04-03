local lang = "fr"
local config = {}
config = {
  cmd = { "ltex-ls" },
  filetypes = { "markdown", "text" },
  flags = { debounce_text_changes = 300 },
  settings = {
    ltex = {
      language = lang
    }
  },
  extra_on_attach = function(client, bufnr)
    require("ltex_extra").setup {
      init_check = true,
      load_langs = { lang, "en-US" },
      path = vim.fn.expand('~') .. '/.local/share/ltex',
    }
  end,
}
return config
