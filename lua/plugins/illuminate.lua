return {
  "RRethy/vim-illuminate",
  configure = function()
    require('illuminate').configure({
      providers = {
        'lsp',
        'treesitter',
        'regex',
      },
      delay = 100,
    })
  end
}
