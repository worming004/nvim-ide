local netcoredbg = vim.fn.exepath "netcoredbg"

local function dotnet_build_project()
  local default_path = vim.fn.getcwd() .. "/"
  if vim.g["dotnet_last_proj_path"] ~= nil then
    default_path = vim.g["dotnet_last_proj_path"]
  end
  local path = vim.fn.input("Path to your *proj file", default_path, "file")
  vim.g["dotnet_last_proj_path"] = path
  local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
  print ""
  print("Cmd to execute: " .. cmd)
  local f = os.execute(cmd)
  if f then
    print "\nBuild: ✔️ "
  else
    print "\nBuild: ❌"
    print(f)
  end
end
local function dotnet_get_dll_path()
  local f = vim.fn.input("Enter path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
  vim.notify(f)
  return f
end

return {
  adapters = {
    coreclr = {
      type = "executable",
      command = netcoredbg,
      args = { '--interpreter=vscode' }
    },
    netcoredbg = {
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
      program = function()
        if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
          dotnet_build_project()
        end
        return dotnet_get_dll_path()
      end,
    }
  },
}
