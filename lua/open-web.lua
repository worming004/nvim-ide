-- This file is shit. It have to be refactored one time

---@alias remote_type
---| 'github'
---| 'gitlab'
---| 'azure'
---| 'unknown'

---@class open_on_web -- Open on web in one shot. Do not reuse-twice
---@field remote string -- initial remote address
---@field current_branch string -- current branch name
---@field remote_type remote_type -- enum like github, gitlab, azure
---@field url string -- result, what url to open
---@field replaced_address string internal field, this is a constantly updated value in order to find what is the address to return
---@field relative_path string internal field, this is a constantly updated value in order to find what is the path of the file
local M = {}

local gitutils = require('utils.git')
local utils = require('utils')
local trim = utils.trim_whitespace

local function ends_with(str, ending)
  return ending == "" or str:sub(- #ending) == ending
end


-- Bootstrap all the logic in order to discover what is the url heuristicly, and then actually open in browser.
---@param self table this is the instance of the class
M.open_current_buffer_on_web = function(self)
  self.remote = trim(vim.fn.system({ 'git', 'remote', 'get-url', 'origin' }))
  self.current_branch = gitutils:get_current_branch_name()

  local type = self:detect_remote_type()
  if type[1] ~= 0 then
    error("cannot detect remote remote_type")
  end

  self.remote_type = type[2]

  self.replaced_address = self:replace_git_format_to_http()
  self.replaced_address = self:trim_git()
  self.relative_path = gitutils:get_relative_path_from_git_root()

  self.url = self:set_relative_path_to_replace_address()

  self:open_url()
end
M.detect_remote_type = function(self)
  if string.match(self.remote, "github") then
    return { 0, "github" }
  elseif string.match(self.remote, "gitlab") then
    return { 0, "gitlab" }
  elseif string.match(self.remote, "azure") then
    return { 0, "azure" }
  else
    return { 0, "unknown" }
  end
end

M.should_make_replacement = function(self)
  return not string.find(self.remote, 'http')
end

M.replace_git_format_to_http = function(self)
  if not self:should_make_replacement() then
    return self.remote
  end
  if not string.find(self.remote, 'git') then
    return self.remote
  end

  if self.remote_type == "github" then
    local path = string.sub(self.remote, 16, -5)
    return 'https://github.com/' .. path
  end
  if self.remote_type == 'azure' then
    vim.notify('todo manage azdo and gitlab')
  end
end

-- if remote end with '.git' then remove it
M.trim_git = function(self)
  if ends_with(self.replaced_address, '.git') then
    vim.notify('trimmed')
    return string.sub(self.replaced_address, 1, -5)
  end
  return self.replaced_address
end

M.set_relative_path_to_replace_address = function(self)
  if self.remote_type == "github" then
    return self.replaced_address .. '/blob/' .. self.current_branch .. '/' .. self.relative_path
  end
end

M.open_url = function(self)
  local url = self.url

  local exit_status = os.execute("xdg-open --version > /dev/null 2>&1")
  if exit_status == 0 then
    vim.fn.system({ 'xdg-open', url })
  else
    vim.fn.system({ 'open', url })
  end
end

return M
