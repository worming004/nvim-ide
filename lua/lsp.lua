local capabilities = vim.lsp.protocol.make_client_capabilities()
-- not sure what this is doing
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities = cmp_nvim_lsp.default_capabilities(capabilities)


-- local servers = {
--   "angularls",
--   "ansiblels",
--   "bashls",
--   "bicep",
--   "clangd",
--   "cssls",
--   -- "elixirls",
--   "expert",
--   "gopls",
--   "helm_ls",
--   "html",
--   "jsonls",
--   "lua_ls",
--   "jdtls",
--   "ltex",
--   "omnisharp",
--   "powershell_es",
--   "pyright",
--   "regal",
--   "rust_analyzer",
--   "sqlls",
--   -- "systemd-language-server", -- waiting for https://github.com/williamboman/mason-lspconfig.nvim/pull/499
--   "taplo",
--   "terraformls",
--   "ts_ls",
--   "yamlls",
--   "zls",
-- }


-- https://www.reddit.com/r/neovim/comments/y9qv1w/autoformatting_on_save_with_vimlspbufformat_and/
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local servers = {
  "ansiblels",
  "expert",
  "gopls",
  "jsonls",
  "ltex",
  "lua_ls",
  "omnisharp",
  "pyright",
  "sqlls",
  "taplo",
  "yamlls",
}


for _, server_file_name in pairs(servers) do
  require("lsp." .. server_file_name)
  vim.lsp.enable(server_file_name)
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
