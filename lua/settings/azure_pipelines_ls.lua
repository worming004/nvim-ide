local config = {
  filetypes = { 'yaml', 'yml' },
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
          "*azure*.y*l",
          "Azure-Pipelines/**/*.y*l",
          "Pipelines/*.y*l",
        },
      },
      validate = true,
      completion = true,
    }
  }
}
return config
