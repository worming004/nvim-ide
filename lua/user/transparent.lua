-- for unknown reason, tokyo night transparency is activated only if this configuration exists
local M = {
  "xiyaowong/transparent.nvim",
  lazy = false,
  config = function()
    require("transparent").toggle(true)
  end,
}

return M
