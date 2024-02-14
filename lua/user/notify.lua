return {
  "rcarriga/nvim-notify",
  commit = '7bdbe61c4714bd77017fb327e7a6a0678287da5a', -- waiting for fix in https://github.com/rcarriga/nvim-notify/pull/253
  -- enabled = false,
  opts = {
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  },
  lazy = false,
  init = function()
    vim.notify = require "notify"
  end,
}
