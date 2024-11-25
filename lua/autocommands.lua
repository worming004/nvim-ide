-- Automatically close tab/vim when nvim-tree is the last window in the tab
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  nested = true,
  callback = function()
    if require("utils").is_last_win_is_nvimtree() then
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
        vim.notify("Installing prettier")
        vim.fn.system { 'npm', 'install', '-g', 'prettier' }
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

-- hightligh yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank {}
  end,
})

-- when quitting qf, lspinfo, spectre_panel, close the window and move to the a window other than nvimtree
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "lspinfo", "spectre_panel" },
  callback = function()
    vim.api.nvim_buf_set_option(0, 'buflisted', false)
    vim.keymap.set('n', 'q', function()
      vim.cmd "close"
      local utils = require("utils")
      if utils.is_current_win_is_nvimtree() then
        vim.cmd "wincmd l"
      end
    end, { noremap = true, silent = true, buffer = 0 })
  end,
})

-- add linter to file
vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  callback = function(args)
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    require("lint").try_lint()
  end,
})
