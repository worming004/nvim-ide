local M = {}
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
  local git_root = self:get_git_root()

  -- Check if the current buffer is within a Git repository
  if not string.match(current_buffer_path, git_root) then
    return nil
  end

  -- Calculate relative path
  local relative_path = string.gsub(current_buffer_path, git_root, '')
  relative_path = string.gsub(relative_path, '^/', '') -- remove leading '/'
  return relative_path
end

return M
