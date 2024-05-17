-- Automatically close tab/vim when nvim-tree is the last window in the tab
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  nested = true,
  callback = function()
    local all_windows = vim.api.nvim_list_wins()
    local non_relative_wins = {}
    for _, v in ipairs(all_windows) do
      if vim.api.nvim_win_get_config(v).relative == "" then
        non_relative_wins[#non_relative_wins + 1] = v
      end
    end
    if #non_relative_wins == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd "quit"
    end
  end,
})

-- Run prettier on markdown
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.md" },
  callback = function()
    if vim.g.autoformat then
      if not require("utils").check_command_exists("prettier", {}) then
        return
      end
      local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local buffer_content = vim.fn.join(buffer_lines, '\n')
      local buffer_content_escaped = vim.fn.shellescape(buffer_content)
      local cmd = string.format('echo %s | prettier --parser markdown', buffer_content_escaped)
      local result = vim.fn.system(cmd)
      local splitted_result = vim.split(result, '\n')
      vim.api.nvim_buf_set_lines(0, 0, -1, false, splitted_result)
    else
      vim.notify("Autoformat deactivated")
    end
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank {}
  end,
})
