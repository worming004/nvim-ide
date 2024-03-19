local M = {}

M.servers = {
  "angularls",
  "ansiblels",
  "bashls",
  "bicep",
  "clangd",
  "cssls",
  "elixirls",
  "gopls",
  "helm_ls",
  "html",
  "jsonls",
  "lua_ls",
  "jdtls",
  "omnisharp",
  "powershell_es",
  "pyright",
  "rust_analyzer",
  "sqlls",
  "taplo",
  "terraformls",
  "tsserver",
  "yamlls",
  "zls",
}

M.execute_then_come_back_at_original_position = function(fn)
  local row, column = table.unpack(vim.api.nvim_win_get_cursor(0))
  fn()
  vim.api.nvim_win_set_cursor(0, { row, column })
end


M.check_command_exists = function(command, opts)
  local options = { warn = true }
  if opts then options = vim.tbl_extend('force', options, opts) end

  local executable = vim.fn.executable(command)
  if executable ~= 1 and options.warn then
    print('command ' .. command .. ' is not installed')
  end
  return executable == 1
end

M.redirect_user_to_file = function(fileName)
  vim.api.nvim_command('edit' .. fileName)
end

M.trim_newlines = function(str)
  return str:gsub("[\r\n]+$", "")
end

M.trim_whitespace = function(str)
  return str:gsub("^%s*(.-)%s*$", "%1")
end

M.is_null_or_empty = function(str)
  return str == nil or str == ''
end

return M
