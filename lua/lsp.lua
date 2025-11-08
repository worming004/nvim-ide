local capabilities = vim.lsp.protocol.make_client_capabilities()
-- not sure what this is doing
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities = cmp_nvim_lsp.default_capabilities(capabilities)


-- https://www.reddit.com/r/neovim/comments/y9qv1w/autoformatting_on_save_with_vimlspbufformat_and/
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local custom_on_attach = function(client, buffer_number)
  -- autoformat
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = buffer_number }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = buffer_number,
      callback = function()
        if vim.g.autoformat then
          vim.lsp.buf.format()
        else
          vim.notify("Autoformat deactivated")
        end
      end,
    })
  end
end

for _, server_file_name in pairs(require("utils").servers) do
  vim.lsp.enable(server_name)
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
