vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

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

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

-- Run prettier on markdown
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.md" },
  callback = function()
    if vim.g.autoformat then
      if not require("utils").check_command_exists("prettier", {}) then
        return
      end
      local file_path = vim.fn.expand "%:p"
      local cmd = "prettier " .. file_path
      local result = vim.fn.system(cmd)
      local splitted_result = vim.split(result, '\n')
      vim.api.nvim_buf_set_lines(0, 0, -1, false, splitted_result)
    else
      vim.notify("Autoformat deactivated")
    end
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function(_)
    vim.cmd "hi link illuminatedWord LspReferenceText"

    local function open_nvim_tree(data)
      local IGNORED_FT = {
        "gitcommit",
      }

      -- buffer is a real file on the disk
      local real_file = vim.fn.filereadable(data.file) == 1

      -- buffer is a [No Name]
      local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

      -- &ft
      local filetype = vim.bo[data.buf].ft

      -- only files please
      if not real_file and not no_name then
        return
      end

      -- skip ignored filetypes
      if vim.tbl_contains(IGNORED_FT, filetype) then
        return
      end

      -- open the tree but don't focus it
      require "nvim-tree.api".tree.toggle({ focus = true })
    end
    -- comment out waiting for a correction
    -- open_nvim_tree(d)
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 5000 then
      vim.cmd "IlluminatePauseBuf"
    end
  end,
})
