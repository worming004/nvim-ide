vim.api.nvim_create_user_command("AutoformatEnable", function(_)
  vim.g.autoformat = true
end, {})
vim.api.nvim_create_user_command("AutoformatDisable", function(_)
  vim.g.autoformat = false
end, {})
vim.api.nvim_create_user_command("AutoformatToggle", function(_)
  vim.g.autoformat = not vim.g.autoformat
  vim.notify("autoformat : " .. tostring(vim.g.autoformat))
end, {})
