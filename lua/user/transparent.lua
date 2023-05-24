local M = {
  "xiyaowong/transparent.nvim",
  lazy = false,
  config = function()
    require("transparent").toggle(true)
  end,
}

return M
