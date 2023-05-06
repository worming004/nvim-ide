local schemas     = require('schemastore').yaml.schemas()
local kschemas    = { kubernetes = "*.yaml" }
local allSchemas = vim.tbl_deep_extend("force", kschemas, schemas)

local config      = {
  settings = {
    yaml = {
      schemas = allSchemas,
      validate = { enable = true },
    }
  }
}
return config
