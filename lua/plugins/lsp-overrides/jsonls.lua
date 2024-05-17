local config = {}
config.settings = {
  json = {
    schemas = require('schemastore').json.schemas(),
    validate = { enable = true },
  }
}
return config
