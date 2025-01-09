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


local function trim_git(replaced_address)
  if ends_with(replaced_address, '.git') then
    return string.sub(replaced_address, 1, -5)
  end
  return replaced_address
end


-- Bootstrap all the logic in order to discover what is the url heuristicly, and then actually open in browser.
---@param self table this is the instance of the class
M.open_current_buffer_on_web = function(self)
  self.remote = trim(vim.fn.system({ 'git', 'remote', 'get-url', 'origin' }))
  self.current_branch = gitutils:get_current_branch_name()

  ---@class result
  ---@field remote string -- initial remote address
  ---@field current_branch string -- current branch name
  ---@field remote_type remote_type -- enum like github, gitlab, azure
  ---@field url string -- result, what url to open
  ---@field replaced_address string internal field, this is a constantly updated value in order to find what is the address to return
  ---@field relative_path string internal field, this is a constantly updated value in order to find what is the path of the file
  local result

  local type = self.detect_remote_type(self.remote)
  if type[1] ~= 0 then
    error("cannot detect remote remote_type")
  end

  self.remote_type = type[2]

  self.replaced_address = self.replace_git_format_to_http(self.remote, self.remote_type)
  -- self.replaced_address = trim_git(self.replaced_address)
  self.relative_path = gitutils:get_relative_path_from_git_root()
  if not self.relative_path then
    return
  end

  self.url = self:set_relative_path_to_replace_address()

  self:open_url()
end

---Detect remote type
---@param remote string
---@return table
M.detect_remote_type = function(remote)
  if string.match(remote, "github") then
    return { 0, "github" }
  elseif string.match(remote, "gitlab") then
    return { 0, "gitlab" }
  elseif string.match(remote, "azure") then
    return { 0, "azure" }
  else
    return { 1, "unknown" }
  end
end

---detect if remote should be updated
---@param remote any
---@return boolean
M.should_make_replacement = function(remote)
  return not string.find(remote, 'http')
end

---return to https format if input is in ssh format
---@param remote string
---@param remote_type remote_type
---@return string|number
M.replace_git_format_to_http = function(remote, remote_type)
  remote = trim_git(remote)
  if string.find(remote, 'http') then
    return remote
  end

  if remote_type == "github" then
    local path = string.sub(remote, 16, -1)
    return 'https://www.github.com/' .. path
  end
  if remote_type == 'azure' then
    vim.notify('todo manage azdo and gitlab')
    return 2
  end
  return 1
end

-- if remote end with '.git' then remove it
M.trim_git = trim_git
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
