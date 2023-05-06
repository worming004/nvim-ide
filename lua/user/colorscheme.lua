local M = {
  "folke/tokyonight.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

M.name = "tokyonight-night"
function M.config()
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end

  require("tokyonight").setup {
    -- see colors here https://github.com/folke/tokyonight.nvim/blob/184377a2c240b6a90fa9087e8ade6f5289f926d3/lua/tokyonight/colors.lua#L18
    on_highlights = function(hl, colors)
      hl.LspSignatureActiveParameter = { bg = colors.dark3 }
    end,
  }
end

return M
