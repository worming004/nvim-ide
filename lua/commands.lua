local utils = require "utils"
local opts = {}
local opts_with_desc = function(o, desc)
  o.desc = desc
  return o
end

-- Autoformat
vim.api.nvim_create_user_command("AutoformatEnable", function(_)
  vim.g.autoformat = true
end, opts_with_desc(opts, "Enable autoformat"))

vim.api.nvim_create_user_command("AutoformatDisable", function(_)
  vim.g.autoformat = false
end, opts_with_desc(opts, "Disable autoformat"))

vim.api.nvim_create_user_command("AutoformatToggle", function(_)
  vim.g.autoformat = not vim.g.autoformat
  vim.notify("autoformat : " .. tostring(vim.g.autoformat))
end, opts_with_desc(opts, "Toggle autoformat"))

-- Visual toggles
vim.api.nvim_create_user_command("RelativeLineToggle", function(_)
  vim.cmd "set relativenumber!"
end, opts_with_desc(opts, "Toggle relativenumber"))

-- Windowsh crlf conversion
vim.api.nvim_create_user_command("RemoveWindowCr", function(_)
  vim.cmd "%s/\r//g"
end, opts_with_desc(opts, "Remove all ^M from fil"))

-- Set tab width
vim.api.nvim_create_user_command("SetTab4", function(_)
  vim.cmd "set shiftwidth=4"
end, opts_with_desc(opts, "Set tab to 4"))
vim.api.nvim_create_user_command("SetTab2", function(_)
  vim.cmd "set shiftwidth=2"
end, opts_with_desc(opts, "Set tab to 2"))

local function default_notification_from_stdout_stderr(result)
  if not utils.is_null_or_empty(result.stderr) then
    vim.notify(result.stderr, "error")
  end
  if not utils.is_null_or_empty(result.stdout) then
    vim.notify(result.stdout)
  end
end

vim.api.nvim_create_user_command("KubeApply", function(_)
  if vim.version().minor < 10 then
    vim.notify("using compat version for neovim < 0.10.0", "warn")
    local filepath = vim.api.nvim_buf_get_name(0)
    local command = "!kubectl apply -f " .. filepath
    vim.cmd(command)
  else
    local kubefile = vim.api.nvim_buf_get_lines(0, 0, -1, true)
    local command = { 'kubectl', 'apply', '-f', '-' }
    vim.system(command, { stdin = kubefile }, default_notification_from_stdout_stderr)
  end
end, opts_with_desc(opts, "Apply current file with kubectl apply -f (be carefull about namespace)"))

vim.api.nvim_create_user_command("KubeApplyDryRun", function(_)
  if vim.version().minor < 10 then
    vim.notify("using compat version for neovim < 0.10.0", "warn")
    local filepath = vim.api.nvim_buf_get_name(0)
    local command = "!kubectl apply --dry-run=server -f " .. filepath
    vim.cmd(command)
  else
    local kubefile = vim.api.nvim_buf_get_lines(0, 0, -1, true)
    local command = { 'kubectl', 'apply', '--dry-run=server', '-f', '-' }
    vim.system(command, { stdin = kubefile }, default_notification_from_stdout_stderr)
  end
end, opts_with_desc(opts, "Apply current file with kubectl apply -f (be carefull about namespace)"))

vim.api.nvim_create_user_command("KubeDelete", function(_)
  if vim.version().minor < 10 then
    vim.notify("using compat version for neovim < 0.10.0", "warn")
    local filepath = vim.api.nvim_buf_get_name(0)
    local command = "!kubectl delete -f " .. filepath
    vim.cmd(command)
  else
    local kubefile = vim.api.nvim_buf_get_lines(0, 0, -1, true)
    local command = { 'kubectl', 'delete', '-f', '-' }
    vim.system(command, { stdin = kubefile }, default_notification_from_stdout_stderr)
  end
end, opts_with_desc(opts, "Delete current file with kubectl apply -f (be carefull about namespace)"))

vim.api.nvim_create_user_command("OpenOnAzureDevops", function(_)
  local filepath = vim.api.nvim_buf_get_name(0)
  local cmd = "git remote get-url origin | azdosshtourl | azdoaddpath -from '" .. filepath .. "'"
  local output = vim.fn.system(cmd)
  output = utils.trim_newlines(output)
  cmd = "cmd.exe /C start \"" .. output .. "\""
  vim.fn.system(cmd)
end, opts_with_desc(opts, "Open current file on Azure DevOps"))

vim.api.nvim_create_user_command("DuckCookAll", function(_)
  require("duck").cook_all()
end, opts_with_desc(opts, "Cook(=kill) all ducks"))

vim.api.nvim_create_user_command("LtexLangChangeLanguage", function(data)
  local language = data.fargs[1]
  local bufnr = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'ltex' })
  if #client == 0 then
    vim.notify("No ltex client attached")
  else
    client = client[1]
    client.config.settings = {
      ltex = {
        language = language
      }
    }
    client.notify('workspace/didChangeConfiguration', client.config.settings)
    vim.notify("Language changed to " .. language)
  end
end, {
  nargs = 1,
  force = true,
})
vim.api.nvim_create_user_command("OpenOnWeb", function(_)
  require 'open_web':open_current_buffer_on_web()
end, opts_with_desc(opts, "Open current file on Azure DevOps"))
