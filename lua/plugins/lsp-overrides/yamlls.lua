local schemas = require('schemastore').yaml.schemas()

vim.tbl_deep_extend("force", schemas, { kubernetes = "*.y*l" })
local config = {
  filetypes = { 'yaml', 'yml' },
  settings = {
    yaml = {
      format = {
        enable = true,
      },
      schemas = schemas,
      schemaStore = {
        enable = true,
      },
      validate = true,
      completion = true,

    }
  }
}
return config
