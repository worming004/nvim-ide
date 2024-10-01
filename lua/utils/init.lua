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
  "ltex",
  "omnisharp",
  "powershell_es",
  "pyright",
  "rust_analyzer",
  "sqlls",
  "taplo",
  "terraformls",
  "ts_ls",
  "yamlls",
  "zls",
}

local function check_command_exists(command, opts)
  local options = { warn = true }
  if opts then options = vim.tbl_extend('force', options, opts) end

  local executable = vim.fn.executable(command)
  if executable ~= 1 and options.warn then
    print('command ' .. command .. ' is not installed')
  end
  return executable == 1
end

M.execute_then_come_back_at_original_position = function(fn)
  local row, column = unpack(vim.api.nvim_win_get_cursor(0))
  fn()
  vim.api.nvim_win_set_cursor(0, { row, column })
end


M.check_command_exists = check_command_exists

local function ensure_is_installed(command, install)
  local exists = check_command_exists(command, { warn = false })
  if exists ~= 1 then
    install()
  end
  return exists
end

M.ensure_gotests_is_installed = function()
  ensure_is_installed("gotests",
    function() vim.fn.system { 'go', 'install', 'github.com/cweill/gotests/gotests@latest' } end)
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

--- Return true if current win is nvim-tree
M.is_last_win_is_nvimtree = function()
  local all_windows = vim.api.nvim_list_wins()
  local non_relative_wins = {}
  for _, v in ipairs(all_windows) do
    if vim.api.nvim_win_get_config(v).relative == "" then
      non_relative_wins[#non_relative_wins + 1] = v
    end
  end
  return #non_relative_wins == 1 and require("nvim-tree.utils").is_nvim_tree_buf()
end

M.is_current_win_is_nvimtree = function()
  return require("nvim-tree.utils").is_nvim_tree_buf()
end

return M
