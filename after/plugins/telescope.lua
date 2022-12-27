-- Personnal
local builtin = require('telescope.builtin')
local opts = {}
vim.keymap.set('n', '<leader>fg', builtin.git_files, opts)
