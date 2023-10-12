local M = {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
}

function M.config()
  require "neoscroll".setup({
    easing_function = "easeInOutQuinte"
  })
end


return M
