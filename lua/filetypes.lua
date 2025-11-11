local filetypes = {
  pattern = {
    ['.*%.razor'] = 'razor',
    [".*/hypr/.*%.conf"] = "hyprlang",
    [".*/playbooks/.*%.yml"] = "yaml.ansible"
  }
}

vim.filetype.add(filetypes)
