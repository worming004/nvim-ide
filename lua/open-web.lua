local M = {}

local function get_git_root()
  local git_command = 'git rev-parse --show-toplevel'
  return vim.fn.system(git_command):gsub('^%s*(.-)%s*$', '%1')
end

local function get_current_branch_name()
  local git_command = 'git rev-parse --abbrev-ref HEAD'
  return vim.fn.system(git_command):gsub('^%s*(.-)%s*$', '%1')
end

local function get_relative_path_from_git_root()
  local current_buffer_path = vim.fn.expand('%:p')
  local git_root = get_git_root()

  -- Check if the current buffer is within a Git repository
  if not string.match(current_buffer_path, git_root) then
    return nil
  end

  -- Calculate relative path
  local relative_path = string.gsub(current_buffer_path, git_root, '')
  relative_path = string.gsub(relative_path, '^/', '') -- remove leading '/'
  return relative_path
end

-- This is the main method
M.open_current_buffer_on_web = function(self)
  self.remote = vim.fn.system("git remote get-url origin")
  self.current_branch = get_current_branch_name()

  local type = self:detect_remote_type()
  if type[1] ~= 0 then
    error("cannot detect remote type")
  end

  self.type = type[2]

  self.replaced_address = self:replace_git_format_to_http()
  self.relative_path = get_relative_path_from_git_root()

  local url = self:set_relative_path_to_replace_address()

  self:open_url(url)
end


M.detect_remote_type = function(self)
  if string.match(self.remote, "github") then
    return { 0, "github" }
  elseif string.match(self.remote, "gitlab") then
    return { 0, "gitlab" }
  elseif string.match(self.remote, "azure") then
    return { 0, "azure" }
  else
    return { 0, "" }
  end
end

M.should_make_replacement = function(self)
  return not string.find(self.remote, 'http')
end

M.replace_git_format_to_http = function(self)
  if not self:should_make_replacement(self.remote) then
    return self.remote
  end
  if not string.find(self.remote, 'git') then
    return self.remote
  end

  if self.type == "github" then
    path = string.sub(self.remote, 16, -1)
    return 'https://github.com/' .. path
  end
  if self.type == 'azure' then
    error('todo manage azdo and gitlab')
  end
end

M.set_relative_path_to_replace_address = function(self)
  if self.type == "github" then
    return self.replaced_address .. '/blob/' .. self.branch_name .. '/' .. self.relative_path
  end
end

M.open_url = function(self, url)
  local exit_status = os.execute("xdg-open --version > /dev/null 2>&1")
  if exit_status == 0 then
    vim.fn.system("xdg-open " .. url)
  else
    vim.fn.system("open " .. url)
  end
end

return M
