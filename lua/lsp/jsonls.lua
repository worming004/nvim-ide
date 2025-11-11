local json_schemas = require('schemastore').json.schemas()

vim.lsp.config.jsonls = {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { '.git', 'package.json', 'tsconfig.json' },
  settings = {
    json = {
      schemas = json_schemas,
      validate = { enable = true },
    }
  },
}
