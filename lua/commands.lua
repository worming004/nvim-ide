local opts = {}
local opts_with_desc = function(o, desc)
  o.desc = desc
  return o
end

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

vim.api.nvim_create_user_command("RelativeLineToggle", function(_)
  vim.cmd "set relativenumber!"
end, opts_with_desc(opts, "Toggle relativenumber"))

vim.api.nvim_create_user_command("RemoveWindowCr", function(_)
  vim.cmd "%s/\r//g"
end, opts_with_desc(opts, "Remove all ^M from fil"))

vim.api.nvim_create_user_command("SetTab4", function(_)
  vim.cmd "set shiftwidth=4"
end, opts_with_desc(opts, "Set tab to 4"))
vim.api.nvim_create_user_command("SetTab2", function(_)
  vim.cmd "set shiftwidth=2"
end, opts_with_desc(opts, "Set tab to 2"))

vim.api.nvim_create_user_command("KubeApply", function(_)
  local filepath = vim.api.nvim_buf_get_name(0)
  local command = "!kubectl apply -f " .. filepath
  vim.cmd(command)
end, opts_with_desc(opts, "Apply current file with kubectl apply -f (be carefull about namespace)"))

vim.api.nvim_create_user_command("KubeDelete", function(_)
  local filepath = vim.api.nvim_buf_get_name(0)
  local command = "!kubectl delete -f " .. filepath
  vim.cmd(command)
end, opts_with_desc(opts, "Delete current file with kubectl apply -f (be carefull about namespace)"))
