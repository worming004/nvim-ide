local capabilities = vim.lsp.protocol.make_client_capabilities()

local manual_config_servers = {
  "ansiblels",
  "bicep",
  "expert",
  "gopls",
  "jsonls",
  "lua_ls",
  "omnisharp",
  "sqlls",
  "taplo",
  "yamlls",
}

local nvim_lspconfig_servers = {
  "angularls",
  "bashls",
  "clangd",
  "cssls",
  "helm_ls",
  "html",
  "jdtls",
  "ltex",
  "powershell_es",
  "pyright",
  "regal",
  "rust_analyzer",
  "systemd_ls",
  "terraformls",
  "ts_ls",
  "zls",
}

for _, server_file_name in pairs(manual_config_servers) do
  local file_path = vim.fn.stdpath('config') .. "/lua/lsp/" .. server_file_name .. ".lua"
  if vim.loop.fs_stat(file_path) then
    require("lsp." .. server_file_name)
  end
  vim.lsp.enable(server_file_name)
end

for _, server in pairs(nvim_lspconfig_servers) do
  require("lspconfig")[server].setup {
  }
end

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "💡" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  signs = {
    active = signs,
  },
  update_in_insert = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
  },
  virtual_text = true,
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {})
