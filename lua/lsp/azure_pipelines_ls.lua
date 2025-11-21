vim.lsp.config.azure_pipelines_ls = {
  cmd = { 'node', '/home/sclmth/git/lsp/azure-pipelines-language-server/language-server/out/server.js', '--stdio' },
  filetypes = { 'azure-pipeline.yaml', 'yaml', 'yml' },
  root_markers = { ".git", vim.uv.cwd() },
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
          "*.yaml",
          "*.yml"
        },
      },
    },
  },
}
