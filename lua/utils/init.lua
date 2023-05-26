local M = {}

M.servers = {
  "angularls",
  "ansiblels",
  "bashls",
  "bicep",
  "cssls",
  "elixirls",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "omnisharp",
  "powershell_es",
  "pyright",
  "rust_analyzer",
  "terraformls",
  "tsserver",
  "yamlls",
}

M.execute_then_come_back_at_original_position = function(fn)
  local row, column = table.unpack(vim.api.nvim_win_get_cursor(0))
  fn()
  vim.api.nvim_win_set_cursor(0, { row, column })
end
return M
