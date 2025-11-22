local yaml_schemas = require('schemastore').yaml.schemas()

vim.lsp.config.yamlls = {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.ansible' },
  root_markers = { ".git", vim.uv.cwd() },
  settings = {
    -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
    redhat = { telemetry = { enabled = false } },
    yaml = {
      format = {
        enable = true,
      },
      schemas = yaml_schemas,
      schemaStore = {
        enable = true,
      },
      validate = true,
      completion = true,
    }
  },
}
