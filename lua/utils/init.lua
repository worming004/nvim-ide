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
  "jdtls",
  "omnisharp",
  "powershell_es",
  "pyright",
  "rust_analyzer",
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
  local options = {warn = true}
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

return M

