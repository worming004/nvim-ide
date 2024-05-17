return {
  "petertriho/nvim-scrollbar",
  event = "BufReadPost",
  config = function()
    local scrollbar = require "scrollbar"
    scrollbar.setup {
    }
  end,
}
