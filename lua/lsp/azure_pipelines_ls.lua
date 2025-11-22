vim.lsp.config.azure_pipelines_ls = {
  cmd = { 'azure-pipelines-language-server', '--stdio' },
  filetypes = { 'azure-pipelines.yaml' },
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

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.yml", "*.yaml" },
  callback = function()
    local full_path = vim.fn.expand("%:p")
    if full_path:find("azure%-pipelines%.yml") or full_path:find("azure%-pipelines%.yaml") then
      vim.bo.filetype = "azure-pipelines.yaml"
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "azure-pipelines.yaml" },
  callback = function(data)
    local clients = vim.lsp.get_active_clients({ bufnr = data.buf })
    for _, client in pairs(clients) do
      if client.name == "yamlls" then
        vim.lsp.buf_detach_client(data.buf, client.id)
        vim.notify("Detached yamlls from buffer " .. data.buf)
      end
    end
  end
})
