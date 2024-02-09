local M = {}

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

M.open_current_buffer_on_web = function(self)
  self.remote = vim.fn.system("git remote get-url origin")
  local type = self:detect_remote_type()
  if type[1] ~= 0 then
    error("cannot detect remote type")
  end

  self.type = type[2]

  local full_address
  if self:should_make_replacement(self.remote) then
    full_address = self:replace_git_format_to_http(self.remote)
  end

  vim.fn.system("open " .. full_address)
end

M.should_make_replacement = function(self, remote)
  return not string.find(remote, 'http')
end

M.replace_git_format_to_http = function(self, remote)
  if not string.find(remote, 'git') then
    return remote
  end
  if self.type == "github" then
    path = string.sub(remote, 16, -1)
    return 'https://github.com/' .. path
  end
  if self.type == 'azure' then
    error('todo manage azdo and gitlab')
  end
end

return M
