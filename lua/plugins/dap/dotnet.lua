local netcoredbg = vim.fn.exepath "netcoredbg"

local function dotnet_build_project()
  local default_path = vim.fn.getcwd() .. '/'
  if vim.g['dotnet_last_proj_path'] ~= nil then
    default_path = vim.g['dotnet_last_proj_path']
  end
  local path = vim.fn.input('Path to your *proj file', default_path, 'file')
  vim.g['dotnet_last_proj_path'] = path
  local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
  print('')
  print('Cmd to execute: ' .. cmd)
  local f = os.execute(cmd)
  if f == 0 then
    print('\nBuild: ✔️ ')
  else
    print('\nBuild: ❌ (code: ' .. f .. ')')
  end
end

local function get_dotnet_framework(csproj_path)
  local lines = vim.fn.readfile(csproj_path)
  local content = table.concat(lines, "\n")
  local target_framework = content:match("<TargetFramework>(.-)</TargetFramework>")
  return target_framework
end



local function dotnet_get_dll_path()
  local request = function()
    local buf_path = vim.api.nvim_buf_get_name(0)
    local dir = vim.fn.fnamemodify(buf_path, ":h")
    local csproj_files = vim.fn.globpath(dir, "*.csproj", false, true)

    if #csproj_files ~= 1 then
      return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    else
      local project_name = csproj_files[1]:match("([^/]+)%.csproj$")
      local framework = get_dotnet_framework(csproj_files[1])

      local path = vim.fn.input('Path to dll: ',
        vim.g['dotnet_last_proj_path'] .. 'bin/Debug/' .. framework .. '/' .. project_name,
        'file') .. '.dll'
      return path
    end
  end

  if vim.g['dotnet_last_dll_path'] == nil then
    vim.g['dotnet_last_dll_path'] = request()
  else
    if vim.fn.confirm('Do you want to change the path to dll? \n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
      vim.g['dotnet_last_dll_path'] = request()
    end
  end

  return vim.g['dotnet_last_dll_path']
end

return {
  adapters = {
    coreclr = {
      type = "executable",
      command = netcoredbg,
      args = { '--interpreter=vscode' }
    }
  },
  configurations = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      env = "ASPNETCORE_ENVIRONMENT=Development",
      program = function()
        if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
          dotnet_build_project()
        end
        return dotnet_get_dll_path()
      end,
    }
  },
}
