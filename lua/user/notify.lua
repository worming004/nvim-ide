return {
  "rcarriga/nvim-notify",
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
