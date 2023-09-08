local schemas        = require('schemastore').yaml.schemas()
-- local kschemas   = { kubernetes = "*.yaml" }
local github_schemas = { ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*" }
local all_schemas    = schemas
-- local allSchemas = vim.tbl_deep_extend("force", kschemas, schemas)
all_schemas          = vim.tbl_deep_extend("force", all_schemas, github_schemas)

local ado_org        = os.getenv("ADO_ORG_NAME")
if ado_org ~= nil and ado_org ~= "" then
  all_schemas = vim.tbl_deep_extend("force", all_schemas,
    { ["https://dev.azure.com/{organization}/_apis/distributedtask/yamlschema?api-version=5.1"] = "*azure*.y*" })
end

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
