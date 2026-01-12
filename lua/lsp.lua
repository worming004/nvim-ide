local manual_config_servers = {
  "ansiblels",
  "azure_pipelines_ls",
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
  -- "angularls",
  "bashls",
  "clangd",
  "cssls",
  "helm_ls",
  "html",
  "jdtls",
  "just",
  "ltex",
  -- "powershell_es",
  "regal",
  "ruff",
  "rust_analyzer",
  "systemd_lsp",
  -- "terraformls",
  "templ",
  "tofu_ls",
  "ts_ls",
  "ty",
  "zls",
}

for _, server in pairs(manual_config_servers) do
  local file_path = vim.fn.stdpath('config') .. "/lua/lsp/" .. server .. ".lua"
  if vim.loop.fs_stat(file_path) then
    require("lsp." .. server)
  end
  vim.lsp.enable(server)
end

for _, server in pairs(nvim_lspconfig_servers) do
  -- if lsp-overrides dir have lua file with same name, require file
  if vim.loop.fs_stat(vim.fn.stdpath('config') .. "/lua/lsp-overrides/" .. server .. ".lua") then
    local config = require("lsp-overrides." .. server)
    vim.lsp.config(server, config)
  end
  vim.lsp.enable(server)
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
