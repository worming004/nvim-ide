local filetypes = {
  pattern = {
    ['.*.razor'] = 'razor',
    [".*/hypr/.*%.conf"] = "hyprlang"
  }
}

vim.filetype.add(filetypes)
