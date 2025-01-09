local M = {}

local utils = require('utils')
local trim = utils.trim_whitespace
M.get_git_root = function()
  local git_command = { 'git', 'rev-parse', '--show-toplevel' }
  local result = vim.fn.system(git_command)
  return trim(result)
end

M.get_current_branch_name = function()
  local git_command = { 'git', 'rev-parse', '--abbrev-ref', 'HEAD' }
  return trim(vim.fn.system(git_command))
end

M.get_git_root = function()
  local git_command = 'git rev-parse --show-toplevel'
  return vim.fn.system(git_command):gsub('^%s*(.-)%s*$', '%1')
end

M.get_current_branch_name = function()
  local git_command = 'git rev-parse --abbrev-ref HEAD'
  return vim.fn.system(git_command):gsub('^%s*(.-)%s*$', '%1')
end

M.get_relative_path_from_git_root = function(self)
  local current_buffer_path = vim.fn.expand('%:p')
  vim.notify(current_buffer_path)
  local git_root = self:get_git_root()
  vim.notify(git_root)

  -- Check if the current buffer is within a Git repository
  if string.find(current_buffer_path, git_root, 1, true) == nil then
    vim.notify('Not in a git repository')
    return nil
  end

  -- Calculate relative path
  local relative_path = string.gsub(current_buffer_path, git_root, '')
  relative_path = string.gsub(relative_path, '^/', '') -- remove leading '/'
  return relative_path
end

return M
