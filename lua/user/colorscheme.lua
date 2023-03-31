require("tokyonight").setup({
  -- see colors here https://github.com/folke/tokyonight.nvim/blob/184377a2c240b6a90fa9087e8ade6f5289f926d3/lua/tokyonight/colors.lua#L18
  on_highlights = function(hl, colors)
    hl.LspSignatureActiveParameter = { bg = colors.dark3 }
  end
})

local colorscheme = "tokyonight-night"

local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
  return
end
