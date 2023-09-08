local schemas = require('schemastore').yaml.schemas()

vim.tbl_deep_extend("force", schemas, { kubernetes = "*.y*l" })
local config = {
  filetypes = { 'yaml', 'yml' },
  settings = {
    yaml = {
      schemas = all_schemas,
      validate = true,
      completion = true,
    }
  }
}
return config
